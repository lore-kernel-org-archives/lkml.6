Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeECVED (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:04:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:48744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeECVEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:04:02 -0400
Date: Thu, 3 May 2018 13:49:34 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, aarcange@redhat.com
Cc: joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@kernel.org,
        dave@stgolabs.net
Subject: [PATCH 2/2] ipc/shm: fix shmat() nil address after round-down when
 remapping
Message-ID: <20180503204934.kk63josdu6u53fbd@linux-n805>
Mail-Followup-To: akpm@linux-foundation.org, aarcange@redhat.com,
        joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@kernel.org
References: <20180503203243.15045-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180503203243.15045-1-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmat()'s SHM_REMAP option forbids passing a nil address for; this
is in fact the very first thing we check for. Andrea reported that
for SHM_RND|SHM_REMAP cases we can end up bypassing the initial
addr check, but we need to check again if the address was rounded
down to nil. As of this patch, such cases will return -EINVAL.

Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b81d53c8f459..29978ee76c2e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1371,9 +1371,17 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 
 	if (addr) {
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
-- 
2.13.6
