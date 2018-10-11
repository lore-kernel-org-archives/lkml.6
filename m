Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33BA21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H09awd26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33BA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeJKXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98B320652;
        Thu, 11 Oct 2018 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272602;
        bh=F9Mb1g/uawE0SGZi1lMpNziRYj/b+ROjwKjHkdLJPLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H09awd26th8pr3JRINOQVzAt83m2o4Fqro+rLfJqdg4p147ePmqqipqGBk3r5VPAX
         9mMYUsIoQdG1lNThovks2wPgNW6geQopiY00ET8dgLGK5RJO7IG0+asd6w8jVM1mYw
         I6I5wkSsOyMb8hoo84ULLKYKTB3doq7zBY51/inQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jann Horn <jannh@google.com>, security@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.9 02/35] fbdev/omapfb: fix omapfb_memory_read infoleak
Date:   Thu, 11 Oct 2018 17:35:04 +0200
Message-Id: <20181011152520.267713425@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

commit 1bafcbf59fed92af58955024452f45430d3898c5 upstream.

OMAPFB_MEMORY_READ ioctl reads pixels from the LCD's memory and copies
them to a userspace buffer. The code has two issues:

- The user provided width and height could be large enough to overflow
  the calculations
- The copy_to_user() can copy uninitialized memory to the userspace,
  which might contain sensitive kernel information.

Fix these by limiting the width & height parameters, and only copying
the amount of data that we actually received from the LCD.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Cc: security@kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -496,6 +496,9 @@ static int omapfb_memory_read(struct fb_
 	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
 		return -EFAULT;
 
+	if (mr->w > 4096 || mr->h > 4096)
+		return -EINVAL;
+
 	if (mr->w * mr->h * 3 > mr->buffer_size)
 		return -EINVAL;
 
@@ -509,7 +512,7 @@ static int omapfb_memory_read(struct fb_
 			mr->x, mr->y, mr->w, mr->h);
 
 	if (r > 0) {
-		if (copy_to_user(mr->buffer, buf, mr->buffer_size))
+		if (copy_to_user(mr->buffer, buf, r))
 			r = -EFAULT;
 	}
 


