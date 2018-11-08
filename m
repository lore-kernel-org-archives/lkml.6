Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F72DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A47214F0
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC2LI74z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A47214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKIHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbeKIHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F4721019;
        Thu,  8 Nov 2018 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714092;
        bh=lWWY8GPcTJuC98u2z/ke4H9dZZnjNt007Do03LgRWx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mC2LI74zxRiYE19jDI21LWd5yS9sNGblcwfiUik5OHsTI2zTgGEXFxVTBQEfLKKEc
         ZyK6oi1F7kcva8Z/1MfrYu7ha1H6p/SOdyb8AzHO6ZV5np6LdFTR4N6hYd/EqNZIkh
         rlFUQqdGFvdqbAOpJYK29FwdPKut0qTmNo1WFtlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 053/144] ARM: OMAP2+: Fix n900 board name for legacy user space
Date:   Thu,  8 Nov 2018 13:50:24 -0800
Message-Id: <20181108215058.676426973@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 71c4f6027da75c6c1fd92e05b63108a09ec2b109 ]

N900 legacy user space apps need the board name in
/proc/cpuinfo to work properly for the Hardware entry.

For other boards this should not be an issues and they
can use the generic Hardware entry.

Let's fix the issue by adding a custom DT_MACHINE_START
for n900.

Tested-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/board-generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 608079a1aba6..b61c049f92d6 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -77,6 +77,24 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+/* Some boards need board name for legacy userspace in /proc/cpuinfo */
+static const char *const n900_boards_compat[] __initconst = {
+	"nokia,omap3-n900",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3430_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_sync32k_timer_init,
+	.dt_compat	= n900_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
+/* Generic omap3 boards, most boards can use these */
 static const char *const omap3_boards_compat[] __initconst = {
 	"ti,omap3430",
 	"ti,omap3",
-- 
2.17.1



