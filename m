Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DCC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6BC20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6BC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeJNXj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:39:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35944 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727528AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004co-RW; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000lD-AW; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Davidlohr Bueso" <dave@stgolabs.net>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Manfred Spraul" <manfred@colorfullife.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.817272404@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 356/366] Revert "ipc/shm: Fix shmat mmap nil-page
 protection"
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/shm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1112,13 +1112,8 @@ long do_shmat(int shmid, char __user *sh
 		goto out;
 	else if ((addr = (ulong)shmaddr)) {
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

