Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id klh8N0ZZGVu3BwAAmS7hNA
	; Thu, 07 Jun 2018 16:11:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D17860115; Thu,  7 Jun 2018 16:11:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F85C6063F;
	Thu,  7 Jun 2018 16:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F85C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935618AbeFGQKo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:10:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39195 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932984AbeFGOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zt-Dc; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hr-PL; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Peter Malone" <peter.malone@gmail.com>,
        "Mathieu Malaterre" <malat@debian.org>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.855726222@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 023/410] fbdev: Fixing arbitrary kernel leak in case
 FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
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

From: Peter Malone <peter.malone@gmail.com>

commit 250c6c49e3b68756b14983c076183568636e2bde upstream.

Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
sbusfb_ioctl_helper().

'index' is defined as an int in sbusfb_ioctl_helper().
We retrieve this from the user:
if (get_user(index, &c->index) ||
    __get_user(count, &c->count) ||
    __get_user(ured, &c->red) ||
    __get_user(ugreen, &c->green) ||
    __get_user(ublue, &c->blue))
       return -EFAULT;

and then we use 'index' in the following way:
red = cmap->red[index + i] >> 8;
green = cmap->green[index + i] >> 8;
blue = cmap->blue[index + i] >> 8;

This is a classic information leak vulnerability. 'index' should be
an unsigned int, given its usage above.

This patch is straight-forward; it changes 'index' to unsigned int
in two switch-cases: FBIOGETCMAP_SPARC && FBIOPUTCMAP_SPARC.

This patch fixes CVE-2018-6412.

Signed-off-by: Peter Malone <peter.malone@gmail.com>
Acked-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/sbuslib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -121,7 +121,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -160,7 +160,7 @@ int sbusfb_ioctl_helper(unsigned long cm
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
