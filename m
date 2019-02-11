Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0419D20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896012;
	bh=0tUdS2koUyYzOgUVKiQnLJZYtpsi8LjvaVEWn2UpW/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDfzfrZcYmdiA2WHYcwToClBkbFVQquZirF2MWFMaz3U8aW964//4ou24nPPw5/B7
	 fSx84EpcGD1WcnP7+XEDcai8YPpur7RduwiFsPdb1EMeTAavzNu2SanJLQc4i2qqY/
	 8kw1eHaZEbpmRnVgNmpbhhhJlzCE3u6S6OZYw21Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfBKOkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732017AbfBKOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE28220838;
        Mon, 11 Feb 2019 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896007;
        bh=0tUdS2koUyYzOgUVKiQnLJZYtpsi8LjvaVEWn2UpW/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3/bpsqUkhV/7TNF+vzzVwqjWAZRtHZzcLopwiv0PeRlDjG8BagZmnlX35ha2c0Si
         /jg7q04fD+Je2uao6q2XWrlASHegFVk8Z51LHAcB2fRRCaxBiwUdpWtiJHi3ZmrlDZ
         56nRRjXDb6FUNzlxXbXmDkcRrrq/xOmFXbxQvnDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/313] ARM: OMAP2+: hwmod: Fix some section annotations
Date:   Mon, 11 Feb 2019 15:15:22 +0100
Message-Id: <20190211141856.380807840@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c10b26abeb53cabc1e6271a167d3f3d396ce0218 ]

When building the kernel with Clang, the following section mismatch
warnings appears:

WARNING: vmlinux.o(.text+0x2d398): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_iclk_autoidle()
The function _setup() references
the function __init _setup_iclk_autoidle().
This is often because _setup lacks a __init
annotation or the annotation of _setup_iclk_autoidle is wrong.

WARNING: vmlinux.o(.text+0x2d3a0): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_reset()
The function _setup() references
the function __init _setup_reset().
This is often because _setup lacks a __init
annotation or the annotation of _setup_reset is wrong.

WARNING: vmlinux.o(.text+0x2d408): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_postsetup()
The function _setup() references
the function __init _setup_postsetup().
This is often because _setup lacks a __init
annotation or the annotation of _setup_postsetup is wrong.

_setup is used in omap_hwmod_allocate_module, which isn't marked __init
and looks like it shouldn't be, meaning to fix these warnings, those
functions must be moved out of the init section, which this patch does.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cd65ea4e9c54..ec3789ba17b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2397,7 +2397,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
  * a stub; implementing this properly requires iclk autoidle usecounting in
  * the clock code.   No return value.
  */
-static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 
@@ -2428,7 +2428,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
  * reset.  Returns 0 upon success or a negative error code upon
  * failure.
  */
-static int __init _setup_reset(struct omap_hwmod *oh)
+static int _setup_reset(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -2489,7 +2489,7 @@ static int __init _setup_reset(struct omap_hwmod *oh)
  *
  * No return value.
  */
-static void __init _setup_postsetup(struct omap_hwmod *oh)
+static void _setup_postsetup(struct omap_hwmod *oh)
 {
 	u8 postsetup_state;
 
-- 
2.19.1



