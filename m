Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8279C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966B7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GCfzX6GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfAPWEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:45 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55772 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbfAPWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l0OqbqymuJ1ioZUjzeMqnRiXJULUOy8uam8Qddu53Jk=; b=GCfzX6GIJBy0O8ipaXk8xEPTBq
        jMVfErVSBVmHxRr9P+UcqsROTraWXNmQw10GLwrMn/Pae8gL0BleN/UV67rLnNWFopkEQhqJWenGC
        Br3236N0F9nEZt4WBlPfbbs90e/V6bB1VQO9NLA6APmx1uYh2oChgxUDm/dAjWhvXx0w=;
Received: from p200300ccfbcc8e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIW-0006lW-07; Wed, 16 Jan 2019 23:04:32 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIV-0002PO-CF; Wed, 16 Jan 2019 23:04:31 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/3] mach-omap2: handle autoidle denial 
Date:   Wed, 16 Jan 2019 23:04:26 +0100
Message-Id: <20190116220429.9136-1-andreas@kemnade.info>
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

Changes v3:
- replace CLK_IS_BASIC

Changes v2:
- uses spinlocks instead of mutexes
- invert counter logic
- check whether clock type is basic

Depends on: clk: ti: get rid of CLK_IS_BASIC

Andreas Kemnade (3):
  clk: ti: add a usecount for autoidle
  clk: ti: check clock type before doing autoidle ops
  arm: omap_hwmod disable ick autoidling when a hwmod requires that

 arch/arm/mach-omap2/omap_hwmod.c | 16 +++++++++----
 drivers/clk/ti/autoidle.c        | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.11.0

