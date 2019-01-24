Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF31218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357848;
	bh=ywRLR8CGI6P/wVOvFUHyNdPufQF0y7LeDpfIl2BFqw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6lUVq48UoMLoxhg+Ln69cHbWTHkpnJKejBC9UCiAXSkgkAW/O2QXfrokQAIHO8gZ
	 vQRjWhf1Vk1lzo5nknx8psLWtiHNs6B/GC1uxYByV+QKt2YAzGpKtdHmrdX5qNbJK2
	 CACIjGxDIlOEBb8ATNwbfOmzWwWiGeO17M6suPPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfAXTYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbfAXTYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E04218EA;
        Thu, 24 Jan 2019 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357843;
        bh=ywRLR8CGI6P/wVOvFUHyNdPufQF0y7LeDpfIl2BFqw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0my7aXyX5OiT+kUxxai6pJglFtCPRdgFHI6yikh7OEN40fB9/RGtTcXVsLum+lwWS
         lkMSD2EUsVLgRE5KxQmxusK1vwGdw5zIxUEIX/gy2+XeCLGpGPOuwCWzbdsWZv8QEq
         4bbuEPJq4ToZxG4hnzaE3NeCTELTnmNWYR+cVN9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Kees Cook <keescook@chromium.org>, security@kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3.18 24/52] omap2fb: Fix stack memory disclosure
Date:   Thu, 24 Jan 2019 20:19:48 +0100
Message-Id: <20190124190145.908747506@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Tsyrklevich <vlad@tsyrklevich.net>

commit a01421e4484327fe44f8e126793ed5a48a221e24 upstream.

Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
cases could all leak uninitialized stack memory--either due to
uninitialized padding or 'reserved' fields.

Fix them by clearing the shared union used to store copied out data.

[1] https://github.com/vlad902/kernel-uninitialized-memory-checker

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
Cc: security@kernel.org
[b.zolnierkie: prefix patch subject with "omap2fb: "]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -606,6 +606,8 @@ int omapfb_ioctl(struct fb_info *fbi, un
 
 	int r = 0;
 
+	memset(&p, 0, sizeof(p));
+
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");


