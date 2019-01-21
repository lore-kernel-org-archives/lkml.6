Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE7C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5726520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079910;
	bh=evjhtVAGbIqSUtM+NkMLNXmwxBbpRSW3LR6rVig5HaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUwA4SnRm/4EfN2TQwuDYUAKeQHQ+mmS4wGhM+8OwRhD0XhiR/5FPkDpGrGzWnQe6
	 8XS8Cmow2Dk1UINoXkCLkgx+xqC98vsKXT3gcvs04qdjjkcVErS9ywRh6MW/vRGHqB
	 wYdOw131o7zv8RztB/1xnvGvZNRLNUjxktOdQiN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfAUOLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfAUNyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9261B20861;
        Mon, 21 Jan 2019 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078845;
        bh=evjhtVAGbIqSUtM+NkMLNXmwxBbpRSW3LR6rVig5HaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHWDXFmYHuQL2++H3Z25rfPoJt7lb8NvryxxMAzVIydtpVyXBbnZFCQjPSw11Fmac
         CGfJwvbQ1Jb/Vib0+v8T9e0JcXcoxwbtpurlf1Pu1OAbh9q4HmEaU7sbTabLwPtBKr
         T0SHa3v5tN/n4N6q0ZFYqh/Rwtp97ppKm3fHj2w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Kees Cook <keescook@chromium.org>, security@kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.14 37/59] omap2fb: Fix stack memory disclosure
Date:   Mon, 21 Jan 2019 14:44:02 +0100
Message-Id: <20190121122500.880982197@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -609,6 +609,8 @@ int omapfb_ioctl(struct fb_info *fbi, un
 
 	int r = 0;
 
+	memset(&p, 0, sizeof(p));
+
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");


