Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967981AbeE1KQB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967624AbeE1KP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 012/268] ipc/shm: fix shmat() nil address after round-down when remapping
Date: Mon, 28 May 2018 11:59:46 +0200
Message-Id: <20180528100203.507229367@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit 8f89c007b6dec16a1793cb88de88fcc02117bbbc upstream.

shmat()'s SHM_REMAP option forbids passing a nil address for; this is in
fact the very first thing we check for.  Andrea reported that for
SHM_RND|SHM_REMAP cases we can end up bypassing the initial addr check,
but we need to check again if the address was rounded down to nil.  As
of this patch, such cases will return -EINVAL.

Link: http://lkml.kernel.org/r/20180503204934.kk63josdu6u53fbd@linux-n805
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 ipc/shm.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1113,9 +1113,17 @@ long do_shmat(int shmid, char __user *sh
 		goto out;
 	else if ((addr = (ulong)shmaddr)) {
 		if (addr & (shmlba - 1)) {
-			if (shmflg & SHM_RND)
+			if (shmflg & SHM_RND) {
 				addr &= ~(shmlba - 1);  /* round down */
-			else
+
+				/*
+				 * Ensure that the round-down is non-nil
+				 * when remapping. This can happen for
+				 * cases when addr < shmlba.
+				 */
+				if (!addr && (shmflg & SHM_REMAP))
+					goto out;
+			} else
 #ifndef __ARCH_FORCE_SHMLBA
 				if (addr & ~PAGE_MASK)
 #endif
