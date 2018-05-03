Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECUrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:47:41 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:39790 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeECUr2 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 3 May 2018 16:47:28 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, aarcange@redhat.com
Cc: joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, dave@stgolabs.net,
        stable@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] Revert "ipc/shm: Fix shmat mmap nil-page protection"
Date: Thu,  3 May 2018 13:32:42 -0700
Message-Id: <20180503203243.15045-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180503203243.15045-1-dave@stgolabs.net>
References: <20180503203243.15045-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

95e91b831f87 (ipc/shm: Fix shmat mmap nil-page protection) worked on
the idea that we should not be mapping as root addr=0 and MAP_FIXED.
However, it was reported that this scenario is in fact valid, thus
making the patch both bogus and breaks userspace as well. For example
X11's libint10.so relies on shmat(1, SHM_RND) for lowmem initialization[1].

[1] https://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/os-support/linux/int10/linux.c#n347

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0075990338f4..b81d53c8f459 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1371,13 +1371,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 
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
-- 
2.13.6
