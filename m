Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423147AbeE1MHT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423107AbeE1LFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 032/272] Revert "ipc/shm: Fix shmat mmap nil-page protection"
Date: Mon, 28 May 2018 12:01:05 +0200
Message-Id: <20180528100243.418439638@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit a73ab244f0dad8fffb3291b905f73e2d3eaa7c00 upstream.

Patch series "ipc/shm: shmat() fixes around nil-page".

These patches fix two issues reported[1] a while back by Joe and Andrea
around how shmat(2) behaves with nil-page.

The first reverts a commit that it was incorrectly thought that mapping
nil-page (address=0) was a no no with MAP_FIXED.  This is not the case,
with the exception of SHM_REMAP; which is address in the second patch.

I chose two patches because it is easier to backport and it explicitly
reverts bogus behaviour.  Both patches ought to be in -stable and ltp
testcases need updated (the added testcase around the cve can be
modified to just test for SHM_RND|SHM_REMAP).

[1] lkml.kernel.org/r/20180430172152.nfa564pvgpk3ut7p@linux-n805

This patch (of 2):

Commit 95e91b831f87 ("ipc/shm: Fix shmat mmap nil-page protection")
worked on the idea that we should not be mapping as root addr=0 and
MAP_FIXED.  However, it was reported that this scenario is in fact
valid, thus making the patch both bogus and breaks userspace as well.

For example X11's libint10.so relies on shmat(1, SHM_RND) for lowmem
initialization[1].

[1] https://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/os-support/linux/int10/linux.c#n347
Link: http://lkml.kernel.org/r/20180503203243.15045-2-dave@stgolabs.net
Fixes: 95e91b831f87 ("ipc/shm: Fix shmat mmap nil-page protection")
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 ipc/shm.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1320,13 +1320,8 @@ long do_shmat(int shmid, char __user *sh
 
 	if (addr) {
 		if (addr & (shmlba - 1)) {
-			/*
-			 * Round down to the nearest multiple of shmlba.
-			 * For sane do_mmap_pgoff() parameters, avoid
-			 * round downs that trigger nil-page and MAP_FIXED.
-			 */
-			if ((shmflg & SHM_RND) && addr >= shmlba)
-				addr &= ~(shmlba - 1);
+			if (shmflg & SHM_RND)
+				addr &= ~(shmlba - 1);  /* round down */
 			else
 #ifndef __ARCH_FORCE_SHMLBA
 				if (addr & ~PAGE_MASK)
