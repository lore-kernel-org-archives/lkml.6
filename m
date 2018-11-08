Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7BC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D020844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOxMqe5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0D020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeKIIOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeKIHgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:21 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B177208E3;
        Thu,  8 Nov 2018 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714333;
        bh=JiExSbJHa+4VZiIuOy7BqecqQIec1j1QS4bTv1l1FeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOxMqe5LS1xcu1rha+ITxbFuEwBoihwCL5sU6VX4tZqLtIi5+Yaz0yh+uIjLnMeKA
         RFjRGuwl2ZsdDgpn+hjp8+enLTRbChy4EsWOU7SPdtHBIv7dzJzjXSoiYKAWCw6PzG
         vSPYZ+J8ummp58aOIedeZkU82DOF8fLqeaDAaUjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 009/114] pxa168fb: prepare the clock
Date:   Thu,  8 Nov 2018 13:50:24 -0800
Message-Id: <20181108215059.770967037@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d85536cde91fcfed6fb8d983783bd2b92c843939 ]

Add missing prepare/unprepare operations for fbi->clk,
this fixes following kernel warning:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:874 clk_core_enable+0x2c/0x1b0
  Enabling unprepared disp0_clk
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc8-00032-g02b43ddd4f21-dirty #25
  Hardware name: Marvell MMP2 (Device Tree Support)
  [<c010f7cc>] (unwind_backtrace) from [<c010cc6c>] (show_stack+0x10/0x14)
  [<c010cc6c>] (show_stack) from [<c011dab4>] (__warn+0xd8/0xf0)
  [<c011dab4>] (__warn) from [<c011db10>] (warn_slowpath_fmt+0x44/0x6c)
  [<c011db10>] (warn_slowpath_fmt) from [<c043898c>] (clk_core_enable+0x2c/0x1b0)
  [<c043898c>] (clk_core_enable) from [<c0439ec8>] (clk_core_enable_lock+0x18/0x2c)
  [<c0439ec8>] (clk_core_enable_lock) from [<c0436698>] (pxa168fb_probe+0x464/0x6ac)
  [<c0436698>] (pxa168fb_probe) from [<c04779a0>] (platform_drv_probe+0x48/0x94)
  [<c04779a0>] (platform_drv_probe) from [<c0475bec>] (driver_probe_device+0x328/0x470)
  [<c0475bec>] (driver_probe_device) from [<c0475de4>] (__driver_attach+0xb0/0x124)
  [<c0475de4>] (__driver_attach) from [<c0473c38>] (bus_for_each_dev+0x64/0xa0)
  [<c0473c38>] (bus_for_each_dev) from [<c0474ee0>] (bus_add_driver+0x1b8/0x230)
  [<c0474ee0>] (bus_add_driver) from [<c0476a20>] (driver_register+0xac/0xf0)
  [<c0476a20>] (driver_register) from [<c0102dd4>] (do_one_initcall+0xb8/0x1f0)
  [<c0102dd4>] (do_one_initcall) from [<c0b010a0>] (kernel_init_freeable+0x294/0x2e0)
  [<c0b010a0>] (kernel_init_freeable) from [<c07e9eb8>] (kernel_init+0x8/0x10c)
  [<c07e9eb8>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
  Exception stack(0xd008bfb0 to 0xd008bff8)
  bfa0:                                     00000000 00000000 00000000 00000000
  bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
  ---[ end trace c0af40f9e2ed7cb4 ]---

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
[b.zolnierkie: enhance patch description a bit]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pxa168fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index efb57c059997..5190b1749e2a 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * enable controller clock
 	 */
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	pxa168fb_set_par(info);
 
@@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 failed_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 failed_free_clk:
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 failed_free_fbmem:
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
@@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
 				info->screen_base, info->fix.smem_start);
 
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 
 	framebuffer_release(info);
 
-- 
2.17.1



