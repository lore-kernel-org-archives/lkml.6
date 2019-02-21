Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB192083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfBUTCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:02:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:46506 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfBUTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:02:37 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 84B17740;
        Thu, 21 Feb 2019 19:02:36 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        axboe@kernel.dk, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: Add struct file refcounting and SCM_RIGHTS mess info
Date:   Thu, 21 Feb 2019 12:02:30 -0700
Message-Id: <20190221190230.17985-3-corbet@lwn.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221190230.17985-1-corbet@lwn.net>
References: <20190221190230.17985-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work up some text posted by Al and add it to the filesystem manual.

Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/index.rst      |   1 +
 Documentation/filesystems/lifecycles.rst | 357 +++++++++++++++++++++++
 2 files changed, 358 insertions(+)
 create mode 100644 Documentation/filesystems/lifecycles.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1131c34d77f6..44ff355e0be6 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -16,6 +16,7 @@ algorithms work.
 .. toctree::
    :maxdepth: 2
 
+   lifecycles
    path-lookup.rst
    api-summary
    splice
diff --git a/Documentation/filesystems/lifecycles.rst b/Documentation/filesystems/lifecycles.rst
new file mode 100644
index 000000000000..b30f566cfe0d
--- /dev/null
+++ b/Documentation/filesystems/lifecycles.rst
@@ -0,0 +1,357 @@
+======================
+Lifecycles and locking
+======================
+
+This manual aspires to cover the lifecycles of VFS objects and the locking
+that protects them.
+
+Reference counting for file structures
+======================================
+
+(The following text derives from `this email from Al Viro
+<https://lwn.net/ml/linux-fsdevel/20190207040058.GW2217@ZenIV.linux.org.uk/>`_).
+
+The :c:type:`struct file` type represents an open file in the kernel.  Its
+lifetime is controlled by a simple reference count (f_count) in that
+structure.  References are obtained with functions like fget(), fdget(),
+and fget_raw(); they are returned with fput().
+
+.. FIXME we should have kerneldoc comments for those functions
+
+The struct file destructor (__fput() and the filesystem-specific
+->release() function called from it) is called once the counter hits zero.
+Each file descriptor counts as a reference.  Thus, dup() will increment
+the refcount by 1, close() will decrement it, fork() will increment it
+by the number of descriptors in your descriptor table refering to this
+struct file, destruction of the descriptor table on exit() will decrement
+by the same amount, etc.
+
+Syscalls like read() and friends turn descriptors into struct file
+references.  If the descriptor table is shared, that counts as a new
+reference that must be dropped in the end of the syscall; otherwise we are
+guaranteed that the reference in the descriptor table will stay around
+until the end of the syscall, so we may use it without bumping the file
+refcount.  That's the difference between fget() and fdget() - the former
+will bump the refcount, while the latter will try to avoid that.  Of
+course, if we do not intend to drop the reference we'd acquired by the end
+of the syscall, we want fget(); fdget() is for transient references only.
+
+Descriptor tables
+-----------------
+
+Descriptor tables (:c:type:`struct files_struct`) *can* be shared; several
+processes (usually threads that share address spaces as well, but that's
+not necessary) may be working with the same set of struct files so, for
+example, an open() call in one of them is seen by the others.  The same
+goes for close(), dup(), dup2(), etc.
+
+That makes for an interesting corner case: what if two threads happen to
+share a descriptor table, and one of them closes a file descriptor while
+another is in the middle of a read() call on that same descriptor?  That's
+one area where Unices differ; one variant is to abort the read() call,
+another would have close() wait for the read() call to finish, etc.  What
+we do is:
+
+  * close() succeeds immediately; the reference is removed from
+    the descriptor table and dropped.
+
+  * If the close() call happens before read(fd, ...) has converted the file
+    descriptor to a struct file reference, read() will fail with -EBADF.
+
+  * Otherwise, read() proceeds unmolested.  The reference it has acquired
+    is dropped at the end of the syscall.  If that's the last reference to
+    the file, the file structure will get shut down at that point.
+
+A call to clone() will result in the child sharing the parent's descriptor
+table if CLONE_FILES is in the flags.  Note that, in this case, struct file
+refcounts are not modified at all, since no new references to files are
+created.  Without CLONE_FILES, it's the same as fork(): an independent copy
+of the descriptor table is created and populated by copies of references to
+files, each bumping file's refcount.
+
+Calling unshare() with CLONE_FILES in the flags will create a copy of the
+descriptor table (same as done on fork(), etc.) and switch to using it; the
+old reference will be dropped (note: it'll only bother with that if
+descriptor table used to be shared in the first place; if we hold the only
+reference to descriptor table, we'll just keep using it).
+
+execve() does almost the same thing: if the pre-exec descriptor table is
+shared, it will switch to a new copy first.  In case of success the
+reference to the original table is dropped, in case of failure we revert to
+the original and drop the copy.  Note that handling of close-on-exec is
+done in the *copy*; the original is unaffected, so failing in execve() does
+not disrupt the descriptor table.
+
+exit() will drop the reference to the descriptor table.  When the last
+reference is dropped, all file references are removed from it (and dropped).
+
+The thread's pointer to its descriptor table (current->files) is never
+modified by other threads; something like::
+
+  ls /proc/<pid>/fd 
+
+will fetch it, so stores need to be protected (by task_lock(current)), but
+the only the thread itself can do them.
+
+Note that, while extra references to the descriptor table can appear at any
+time (/proc/<pid>/fd accesses, for example), such references may not be
+used for modifications.  In particular, you can't switch to another
+thread's descriptor table, unless it had been yours at some earlier point
+*and* you've kept a reference to it.
+
+That's about it for descriptor tables; that, by far, is the main source of
+persistently held struct file references.  Transient references are grabbed
+by syscalls when they resolve a descriptor to a struct file pointer, which
+ought to be done once per syscall *and* reasonably early in it.
+Unfortunately, that's not all; there are other persistent struct file
+references.
+
+Other persistent references
+---------------------------
+
+A key point so far is that references to file structures are not held
+(directly or indirectly) in other file structures.  If that were
+universally true, life would be simpler, since we would never have to worry
+about reference-count loops.  Unfortunately, there are some more
+complicated cases that the kernel has to worry about.
+
+Some things, such as the case of a LOOP_SET_FD ioctl() call grabbing a
+reference to a file structure and stashing it in the lo_backing_file field
+of a loop_device structure, are reasonably simple.  The struct file
+reference will be dropped later, either directly by a LOOP_CLR_FD operation
+(if nothing else holds the thing open at the time) or later in
+lo_release().
+
+Note that, in the latter case, things can get a bit more complicated.  A
+process closing /dev/loop might drop the last reference to it, triggering a
+call to bdput() that releases the last reference holding a block device
+open.  That will trigger a call to lo_release(), which will drop the
+reference on the underlying file structure, which is almost certainly the
+last one at that point.  This case is still not a problem; while we do have
+the underlying struct file pinned by something held by another struct file,
+the dependency graph is acyclic, so the plain refcounts we are using work
+fine.
+
+The same goes for the things like e.g. ecryptfs opening an underlying
+(encrypted) file on open() and dropping it when the last reference to
+ecryptfs file is dropped; the only difference here is that the underlying
+struct file never appears in anyone's descriptor tables.
+
+However, in a couple of cases we do have something trickier.
+
+File references and SCM_RIGHTS
+------------------------------
+
+The SCM_RIGHTS datagram option with Unix-domain sockets can be used to
+transfer a file descriptor, and its associated struct file reference, to
+the receiving process.  That brings about a couple of situations where
+things can go wrong.
+
+Case 1: an SCM_RIGHTS datagram can be sent to an AF_UNIX socket.  That
+converts the caller-supplied array of descriptors into an array of struct
+file references, which gets attached to the packet we queue.  When the
+datagram is received, the struct file references are moved into the
+descriptor table of the recepient or, in case of error, dropped.  Note that
+sending some descriptors in an SCM_RIGHTS datagram and closing them
+immediately is perfectly legitimate: as soon as sendmsg() returns you can
+go ahead and close the descriptors you've sent.  The references for the
+recipient are already acquired, so you don't need to wait for the packet to
+be received.
+
+That would still be simple, if not for the fact that there's nothing to
+stop you from passing AF_UNIX sockets themselves around in the same way.
+In fact, that has legitimate uses and, most of the time, doesn't cause any
+complications at all.  However, it is possible to get the situation when
+the following happens:
+
+  * struct file instances A and B are both AF_UNIX sockets.
+  * The only reference to A is in the SCM_RIGHTS packet that sits in the
+    receiving queue of B.
+  * The only reference to B is in the SCM_RIGHTS packet that sits in the
+    receiving queue of A.
+
+That, of course, is where pure refcounting of any kind will break.
+
+The SCM_RIGHTS datagram that contains the sole reference to A can't be
+received without the recepient getting hold of a reference to B.  That
+cannot happen until somebody manages to receive the SCM_RIGHTS datagram
+containing the sole reference to B.  But that cannot happen until that
+somebody manages to get hold of a reference to A, which cannot happen until
+the first SCM_RIGHTS datagram is received.
+
+Dropping the last reference to A would have discarded everything in its
+receiving queue, including the SCM_RIGHTS datagram that contains the
+reference to B; however, that can't happen either; the other SCM_RIGHTS
+datagram would have to be either received or discarded first, etc.
+
+Case 2: similar, with a bit of a twist.  An AF_UNIX socket used for
+descriptor passing is normally set up by socket(), followed by connect().
+As soon as connect() returns, one can start sending.  Note that connect()
+does *NOT* wait for the recepient to call accept(); it creates the object
+that will serve as the low-level part of the other end of connection
+(complete with received packet queue) and stashes that object into the
+queue of the *listener's* socket.  A subsequent accept() call fetches it
+from there and attaches it to a new socket, completing the setup; in the
+meanwhile, sending packets works fine.  Once accept() is done, it'll see
+the stuff you'd sent already in the queue of the new socket and everything
+works fine.
+
+If the listening socket gets closed without accept() having been called,
+its queue is flushed, discarding all pending connection attempts, complete
+with *their* queues.  Which is the same effect as accept() + close(), so
+again, normally everything just works.  However, consider the case when we
+have:
+
+  * struct file instances A and B being AF_UNIX sockets.
+  * A is a listener
+  * B is an established connection, with the other end yet to be accepted
+    on A 
+  * The only references to A and B are in an SCM_RIGHTS datagram sent over
+    to A by B.
+
+That SCM_RIGHTS datagram could have been received if somebody had managed
+to call accept() on A and recvmsg() on the socket created by that accept()
+call.  But that can't happen without that somebody getting hold of a
+reference to A in the first place, which can't happen without having
+received that SCM_RIGHTS datagram.  It can't be discarded either, since
+that can't happen without dropping the last reference to A, which sits
+right in it.
+
+The difference from the previous case is that there we had:
+
+  * A holds unix_sock of A
+  * unix_sock of A holds SCM_RIGHTS with reference to B
+  * B holds unix_sock of B
+  * unix_sock of B holds SCM_RIGHTS with reference to A
+
+and here we have:
+
+  * A holds unix_sock of A
+  * unix_sock of A holds the packet with reference to embryonic unix_sock
+    created by connect() 
+  * that embryionic unix_sock holds SCM_RIGHTS with references to A and B.
+
+The dependency graph is different, but the problem is the same; there are
+unreachable loops in it.  Note that neither class of situations
+would occur normally; in the best case it's "somebody had been
+doing rather convoluted descriptor passing, but everyone involved
+got hit with kill -9 at the wrong time; please, make sure nothing
+leaks".  That can happen, but a userland race (e.g. botched protocol
+handling of some sort) or a deliberate abuse are much more likely.
+
+Catching the loop creation is hard and paying for that every time we do
+descriptor-passing would be a bad idea.  Besides, the loop per se is not
+fatal; if, for example, in the second case the descriptor for A had been
+kept around, close(accept()) would've cleaned everything up.  Which means
+that we need a garbage collector to deal with the (rare) leaks.
+
+Note that, in both cases, the leaks are caused by loops passing through
+some SCM_RIGHTS datagrams that can never be received.  So locating those,
+removing them from the queues they sit in and then discarding the suckers,
+is enough to resolve the situation. Furthermore, in both cases the loop
+passes through the unix_sock of something that got sent over in an
+SCM_RIGHTS datagram.  So we can do the following:
+
+  1) Keep the count of references to file structures of AF_UNIX sockets
+     held by SCM_RIGHTS; this value is kept in unix_sock->inflight.  Any
+     struct unix_sock instance without such references is not a part of
+     unreachable loop.  Maintain the set of unix_sock that are not excluded
+     by that (i.e. the ones that have some of references from SCM_RIGHTS
+     instances).  Note that we don't need to maintain those counts in
+     struct file; we care only about unix_sock here.
+
+  2) Any struct file of an AF_UNIX socket with some references *NOT* from
+     SCM_RIGHTS datagrams is also not a part of unreachable loop.
+
+  3) For each unix_sock, consider the following set of SCM_RIGHTS
+     datagrams: everything in the queue of that unix_sock if it's a
+     non-listener, and everything in queues of *all* embryonic unix_sock
+     structs in the queue of a listener.  Let's call those the SCM_RIGHTS
+     associated with our unix_sock.
+
+  4) All SCM_RIGHTS associated with a reachable unix_sock are themselves
+     reachable.
+
+  5) if some references to the struct file of a unix_sock are in reachable
+     SCM_RIGHTS, that struct file is reachable.
+
+The garbage collector starts with calculating the set of potentially
+unreachable unix_socks:  the ones not excluded by (1, 2).  No unix_sock
+instances outside of that set need to be considered.
+
+If some unix_sock in that set has a counter that is *not* entirely covered
+by SCM_RIGHTS associated with the elements of the set, we can conclude that
+there are references to it in SCM_RIGHTS associated with something outside
+of our set and therefore it is reachable and can be removed from the set.
+
+If that process converges to a non-empty set, we know that everything left
+in that set is unreachable - all references to their struct file come from
+some SCM_RIGHTS datagrams, and all those SCM_RIGHTS datagrams are among
+those that can't be received or discarded without getting hold of a
+reference to struct file of something in our set.
+
+Everything outside of that set is reachable, so taking the SCM_RIGHTS with
+references to stuff in our set (all of them to be found among those
+associated with elements of our set) out of the queues they are in will
+break all unreachable loops.  Discarding the collected datagrams will do
+the rest - the file references in those will be dropped, etc.
+
+One thing to keep in mind here is the locking.  What the garbage
+collector relies upon is:
+
+  * Changes to ->inflight are serialized with respect to it (on
+    unix_gc_lock; increments are done by unix_inflight(), decrements by
+    unix_notinflight()).
+
+  * Any references extracted from SCM_RIGHTS during the garbage collector
+    run will not be actually used until the end of garbage collection.  For
+    a normal recvmsg() call, this behavior is guaranteed by having
+    unix_notinflight() called between the extraction of scm_fp_list from
+    the packet and doing anything else with the references extracted.  For
+    a MSG_PEEK recvmsg() call, it's actually broken and lacks
+    synchronization; Miklos has proposed to grab and release unix_gc_lock
+    in those, between scm_fp_dup() and doing anything else with the
+    references copied.
+
+.. FIXME: The above should be updates when the fix happens.
+
+  * adding SCM_RIGHTS in the middle of garbage collection is possible, but
+    in that case it will contain no references to anything in the initial
+    candidate set.
+
+The last one is delicate.  SCM_RIGHTS creation has unix_inflight() called
+for each reference we put there, so it's serialized with respect to
+unix_gc(); however, insertion into the queue is *NOT* covered by that.
+Queue rescans are covered, but each queue has a lock of its own and they
+are definitely not going to be held throughout the whole thing.
+
+So in theory it would be possible to have:
+
+  * thread A: sendmsg() has SCM_RIGHTS created and populated, complete with
+    file refcount and ->inflight increments implied, at which point it gets
+    preempted and loses the timeslice.
+
+  * thread B: gets to run and removes all references from descriptor table
+    it shares with thread A.
+
+  * on another CPU we have the garbage collector triggered; it determines
+    the set of potentially unreachable unix_sock and everything in our
+    SCM_RIGHTS _is_ in that set, now that no other references remain.
+
+  * on the first CPU, thread A regains the timeslice and inserts its
+    SCM_RIGHTS into queue.  And it does contain references to sockets from
+    the candidate set of running garbage collector, confusing the hell out
+    of it.
+
+That is avoided by a convoluted dance around the SCM_RIGHTS creation
+and insertion - we use fget() to obtain struct file references,
+then _duplicate_ them in SCM_RIGHTS (bumping a refcount for each, so
+we are holding *two* references), do unix_inflight() on them, then
+queue the damn thing, then drop each reference we got from fget().
+
+That way everything referred to in that SCM_RIGHTS is going to have
+extra struct file references (and thus be excluded from the initial
+candidate set) until after it gets inserted into queue.  In other
+words, if it does appear in a queue between two passes, it's
+guaranteed to contain no references to anything in the initial
+canidate set.
-- 
2.20.1

