Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i7smALBFGVvIIwAAmS7hNA
	; Thu, 07 Jun 2018 14:49:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E374C608B8; Thu,  7 Jun 2018 14:49:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C90A601C3;
	Thu,  7 Jun 2018 14:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C90A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935151AbeFGOtK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:49:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40865 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934860AbeFGOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:49:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zo-G1; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-0002zc-0I; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "Willy Tarreau" <w@1wt.eu>, "Al Viro" <viro@zeniv.linux.org.uk>,
        "" <socketpair@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.918958464@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 202/410] pipe: fix limit checking in pipe_set_size()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>

commit b0b91d18e2e97b741b294af9333824ecc3fadfd8 upstream.

The limit checking in pipe_set_size() (used by fcntl(F_SETPIPE_SZ))
has the following problems:

(1) When increasing the pipe capacity, the checks against the limits in
    /proc/sys/fs/pipe-user-pages-{soft,hard} are made against existing
    consumption, and exclude the memory required for the increased pipe
    capacity. The new increase in pipe capacity can then push the total
    memory used by the user for pipes (possibly far) over a limit. This
    can also trigger the problem described next.

(2) The limit checks are performed even when the new pipe capacity is
    less than the existing pipe capacity. This can lead to problems if a
    user sets a large pipe capacity, and then the limits are lowered,
    with the result that the user will no longer be able to decrease the
    pipe capacity.

(3) As currently implemented, accounting and checking against the
    limits is done as follows:

    (a) Test whether the user has exceeded the limit.
    (b) Make new pipe buffer allocation.
    (c) Account new allocation against the limits.

    This is racey. Multiple processes may pass point (a)
    simultaneously, and then allocate pipe buffers that are accounted
    for only in step (c).  The race means that the user's pipe buffer
    allocation could be pushed over the limit (by an arbitrary amount,
    depending on how unlucky we were in the race). [Thanks to Vegard
    Nossum for spotting this point, which I had missed.]

This patch addresses the above problems as follows:

* Perform checks against the limits only when increasing a pipe's
  capacity; an unprivileged user can always decrease a pipe's capacity.
* Alter the checks against limits to include the memory required for
  the new pipe capacity.
* Re-order the accounting step so that it precedes the buffer
  allocation. If the accounting step determines that a limit has
  been reached, revert the accounting and cause the operation to fail.

The program below can be used to demonstrate problems 1 and 2, and the
effect of the fix. The program takes one or more command-line arguments.
The first argument specifies the number of pipes that the program should
create. The remaining arguments are, alternately, pipe capacities that
should be set using fcntl(F_SETPIPE_SZ), and sleep intervals (in
seconds) between the fcntl() operations. (The sleep intervals allow the
possibility to change the limits between fcntl() operations.)

Problem 1
=========

Using the test program on an unpatched kernel, we first set some
limits:

    # echo 0 > /proc/sys/fs/pipe-user-pages-soft
    # echo 1000000000 > /proc/sys/fs/pipe-max-size
    # echo 10000 > /proc/sys/fs/pipe-user-pages-hard    # 40.96 MB

Then show that we can set a pipe with capacity (100MB) that is
over the hard limit

    # sudo -u mtk ./test_F_SETPIPE_SZ 1 100000000
    Initial pipe capacity: 65536
        Loop 1: set pipe capacity to 100000000 bytes
            F_SETPIPE_SZ returned 134217728

Now set the capacity to 100MB twice. The second call fails (which is
probably surprising to most users, since it seems like a no-op):

    # sudo -u mtk ./test_F_SETPIPE_SZ 1 100000000 0 100000000
    Initial pipe capacity: 65536
        Loop 1: set pipe capacity to 100000000 bytes
            F_SETPIPE_SZ returned 134217728
        Loop 2: set pipe capacity to 100000000 bytes
            Loop 2, pipe 0: F_SETPIPE_SZ failed: fcntl: Operation not permitted

With a patched kernel, setting a capacity over the limit fails at the
first attempt:

    # echo 0 > /proc/sys/fs/pipe-user-pages-soft
    # echo 1000000000 > /proc/sys/fs/pipe-max-size
    # echo 10000 > /proc/sys/fs/pipe-user-pages-hard
    # sudo -u mtk ./test_F_SETPIPE_SZ 1 100000000
    Initial pipe capacity: 65536
        Loop 1: set pipe capacity to 100000000 bytes
            Loop 1, pipe 0: F_SETPIPE_SZ failed: fcntl: Operation not permitted

There is a small chance that the change to fix this problem could
break user-space, since there are cases where fcntl(F_SETPIPE_SZ)
calls that previously succeeded might fail. However, the chances are
small, since (a) the pipe-user-pages-{soft,hard} limits are new (in
4.5), and the default soft/hard limits are high/unlimited.  Therefore,
it seems warranted to make these limits operate more precisely (and
behave more like what users probably expect).

Problem 2
=========

Running the test program on an unpatched kernel, we first set some limits:

    # getconf PAGESIZE
    4096
    # echo 0 > /proc/sys/fs/pipe-user-pages-soft
    # echo 1000000000 > /proc/sys/fs/pipe-max-size
    # echo 10000 > /proc/sys/fs/pipe-user-pages-hard    # 40.96 MB

Now perform two fcntl(F_SETPIPE_SZ) operations on a single pipe,
first setting a pipe capacity (10MB), sleeping for a few seconds,
during which time the hard limit is lowered, and then set pipe
capacity to a smaller amount (5MB):

    # sudo -u mtk ./test_F_SETPIPE_SZ 1 10000000 15 5000000 &
    [1] 748
    # Initial pipe capacity: 65536
        Loop 1: set pipe capacity to 10000000 bytes
            F_SETPIPE_SZ returned 16777216
            Sleeping 15 seconds

    # echo 1000 > /proc/sys/fs/pipe-user-pages-hard      # 4.096 MB
    #     Loop 2: set pipe capacity to 5000000 bytes
            Loop 2, pipe 0: F_SETPIPE_SZ failed: fcntl: Operation not permitted

In this case, the user should be able to lower the limit.

With a kernel that has the patch below, the second fcntl()
succeeds:

    # echo 0 > /proc/sys/fs/pipe-user-pages-soft
    # echo 1000000000 > /proc/sys/fs/pipe-max-size
    # echo 10000 > /proc/sys/fs/pipe-user-pages-hard
    # sudo -u mtk ./test_F_SETPIPE_SZ 1 10000000 15 5000000 &
    [1] 3215
    # Initial pipe capacity: 65536
    #     Loop 1: set pipe capacity to 10000000 bytes
            F_SETPIPE_SZ returned 16777216
            Sleeping 15 seconds

    # echo 1000 > /proc/sys/fs/pipe-user-pages-hard

    #     Loop 2: set pipe capacity to 5000000 bytes
            F_SETPIPE_SZ returned 8388608

8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---

/* test_F_SETPIPE_SZ.c

   (C) 2016, Michael Kerrisk; licensed under GNU GPL version 2 or later

   Test operation of fcntl(F_SETPIPE_SZ) for setting pipe capacity
   and interactions with limits defined by /proc/sys/fs/pipe-* files.
*/

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int
main(int argc, char *argv[])
{
    int (*pfd)[2];
    int npipes;
    int pcap, rcap;
    int j, p, s, stime, loop;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s num-pipes "
                "[pipe-capacity sleep-time]...\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    npipes = atoi(argv[1]);

    pfd = calloc(npipes, sizeof (int [2]));
    if (pfd == NULL) {
        perror("calloc");
        exit(EXIT_FAILURE);
    }

    for (j = 0; j < npipes; j++) {
        if (pipe(pfd[j]) == -1) {
            fprintf(stderr, "Loop %d: pipe() failed: ", j);
            perror("pipe");
            exit(EXIT_FAILURE);
        }
    }

    printf("Initial pipe capacity: %d\n", fcntl(pfd[0][0], F_GETPIPE_SZ));

    for (j = 2; j < argc; j += 2 ) {
        loop = j / 2;
        pcap = atoi(argv[j]);
        printf("    Loop %d: set pipe capacity to %d bytes\n", loop, pcap);

        for (p = 0; p < npipes; p++) {
            s = fcntl(pfd[p][0], F_SETPIPE_SZ, pcap);
            if (s == -1) {
                fprintf(stderr, "        Loop %d, pipe %d: F_SETPIPE_SZ "
                        "failed: ", loop, p);
                perror("fcntl");
                exit(EXIT_FAILURE);
            }

            if (p == 0) {
                printf("        F_SETPIPE_SZ returned %d\n", s);
                rcap = s;
            } else {
                if (s != rcap) {
                    fprintf(stderr, "        Loop %d, pipe %d: F_SETPIPE_SZ "
                            "unexpected return: %d\n", loop, p, s);
                    exit(EXIT_FAILURE);
                }
            }

            stime = (j + 1 < argc) ? atoi(argv[j + 1]) : 0;
            if (stime > 0) {
                printf("        Sleeping %d seconds\n", stime);
                sleep(stime);
            }
        }
    }

    exit(EXIT_SUCCESS);
}

8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---

Patch history:

v2
   * Switch order of test in 'if' statement to avoid function call
      (to capability()) in normal path. [This is a fix to a preexisting
      wart in the code. Thanks to Willy Tarreau]
    * Perform (size > pipe_max_size) check before calling
      account_pipe_buffers().  [Thanks to Vegard Nossum]
      Quoting Vegard:

        The potential problem happens if the user passes a very large number
        which will overflow pipe->user->pipe_bufs.

        On 32-bit, sizeof(int) == sizeof(long), so if they pass arg = INT_MAX
        then round_pipe_size() returns INT_MAX. Although it's true that the
        accounting is done in terms of pages and not bytes, so you'd need on
        the order of (1 << 13) = 8192 processes hitting the limit at the same
        time in order to make it overflow, which seems a bit unlikely.

        (See https://lkml.org/lkml/2016/8/12/215 for another discussion on the
        limit checking)

Link: http://lkml.kernel.org/r/1e464945-536b-2420-798b-e77b9c7e8593@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1013,6 +1013,7 @@ static long pipe_set_size(struct pipe_in
 {
 	struct pipe_buffer *bufs;
 	unsigned int size, nr_pages;
+	long ret = 0;
 
 	size = round_pipe_size(arg);
 	nr_pages = size >> PAGE_SHIFT;
@@ -1020,13 +1021,26 @@ static long pipe_set_size(struct pipe_in
 	if (!nr_pages)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_RESOURCE) && size > pipe_max_size)
+	/*
+	 * If trying to increase the pipe capacity, check that an
+	 * unprivileged user is not trying to exceed various limits
+	 * (soft limit check here, hard limit check just below).
+	 * Decreasing the pipe capacity is always permitted, even
+	 * if the user is currently over a limit.
+	 */
+	if (nr_pages > pipe->buffers &&
+			size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
-	if ((too_many_pipe_buffers_hard(pipe->user) ||
-			too_many_pipe_buffers_soft(pipe->user)) &&
-			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
+
+	if (nr_pages > pipe->buffers &&
+			(too_many_pipe_buffers_hard(pipe->user) ||
+			 too_many_pipe_buffers_soft(pipe->user)) &&
+			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+		ret = -EPERM;
+		goto out_revert_acct;
+	}
 
 	/*
 	 * We can shrink the pipe, if arg >= pipe->nrbufs. Since we don't
@@ -1034,12 +1048,16 @@ static long pipe_set_size(struct pipe_in
 	 * again like we would do for growing. If the pipe currently
 	 * contains more buffers than arg, then return busy.
 	 */
-	if (nr_pages < pipe->nrbufs)
-		return -EBUSY;
+	if (nr_pages < pipe->nrbufs) {
+		ret = -EBUSY;
+		goto out_revert_acct;
+	}
 
 	bufs = kcalloc(nr_pages, sizeof(*bufs), GFP_KERNEL | __GFP_NOWARN);
-	if (unlikely(!bufs))
-		return -ENOMEM;
+	if (unlikely(!bufs)) {
+		ret = -ENOMEM;
+		goto out_revert_acct;
+	}
 
 	/*
 	 * The pipe array wraps around, so just start the new one at zero
@@ -1062,12 +1080,15 @@ static long pipe_set_size(struct pipe_in
 			memcpy(bufs + head, pipe->bufs, tail * sizeof(struct pipe_buffer));
 	}
 
-	account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
 	pipe->curbuf = 0;
 	kfree(pipe->bufs);
 	pipe->bufs = bufs;
 	pipe->buffers = nr_pages;
 	return nr_pages * PAGE_SIZE;
+
+out_revert_acct:
+	account_pipe_buffers(pipe->user, nr_pages, pipe->buffers);
+	return ret;
 }
 
 /*
