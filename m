Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18138C65BA7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42CC20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Gx8sWVnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42CC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJEDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:33:30 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:33928 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJEDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f5vN4Nr+Jqz2KJe3rLSHRYJR6SIZV4zzrcuUPCuhVa8=; b=Gx8sWVnp0VsBowr3guNIawi4bN
        UjoIiwKGKVZQ2waB3WB80Du7iXL/JPS0b/TiYS9FXT5l54mKLOAhejPqdpMxTzQLUrUa78jS2lPLR
        sYgFab5dbRHuucHjIZFUUvTibINCaqunUsBdeqnPPvDNzH0MTT+EjmBzVloHc0sjd3o0=;
Received: from p200300ccfbcbd5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AO7-0007GT-Pf; Thu, 04 Oct 2018 22:38:23 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AO7-0005m8-CU; Thu, 04 Oct 2018 22:38:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] mach-omap2: handle autoidle denial
Date:   Thu,  4 Oct 2018 22:38:15 +0200
Message-Id: <20181004203817.22101-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the gta04 with a dm3730 omap_hdq does not work properly when the
device enters lower power states. Idling uart1 and 2 is enough
to show up that problem, if there are no other things enabled.
Further research reveals that hdq iclk must not be turned off during
transfers, also according to the TRM. That fact is also correctly described
in the flags but the code to handle that is incomplete.

To handle multiple users of a single ick, autoidle is disabled
when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))

Changes since the RFC version:
- mutex lock for autoidle changes
- deny_idle/allow_idle calls moved to clock enable/disable of the
  individual modules

Andreas Kemnade (2):
  clk: ti: add a usecount for autoidle
  arm: omap_hwmod disable ick autoidling when a hwmod requires that

 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 drivers/clk/ti/autoidle.c        | 32 ++++++++++++++++++++++++--------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.11.0

