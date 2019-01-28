Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2DFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEEB2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691295;
	bh=58a/mh7h6uXWGum6EsvIrvrfg7G1if/9GayQ/Pd1ips=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4tpGhhiu+Zxd4TD64UzcXrB3Q7vEFdYZdefI20Mq5GZ3Mo4np0YyLZHYCLB7aQAf
	 kfmIm+tm3Hy8vieNUmwv9UCjb4LNoDu5SG89B4mdh+yBk7TU8foauSWDn2EYXbc6aD
	 9KcaIT6i1AvaYVmXlGpIMTCEVINLbkUsJUtZKUhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfA1QBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfA1QB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78AF321917;
        Mon, 28 Jan 2019 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691288;
        bh=58a/mh7h6uXWGum6EsvIrvrfg7G1if/9GayQ/Pd1ips=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X78bB0lzE3qFXN020YSBkCda/bm8KU16y2FzpaClwVm7YGiE0yYHbuHIDvpdSL+L+
         nn+mJz1vxNnFYgMmNUL9kPTIgzFS7X9qHyEpCKO/6gW/F7f3WR11eFvKE+bJzPd2MQ
         vUN1f8W1Ys4hN4whLQS8LLQAsslgNA2pxnKOxuso=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 047/258] ARM: OMAP2+: hwmod: Fix some section annotations
Date:   Mon, 28 Jan 2019 10:55:53 -0500
Message-Id: <20190128155924.51521-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

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

