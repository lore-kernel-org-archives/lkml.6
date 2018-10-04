Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94080C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="jT6Zgg03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F77E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJDMnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:43:42 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:59956 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJDMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZkJaryn0oRU0mMCGuUyfFKSashwDck+vSpj30SjDcuE=; b=jT6Zgg037sxkZK5PnjxSJtEFuw
        8rT5ZcEpF0RWWG6mxh/iT0lM3B4y7GKGROWLf/nJFfI3f7kzqqz+k919uydcC+GdpY3j9N6qMOBww
        Hiezir6dkAE0+Wjxg5mzaxyQJ5RQrgzI55Zaj1rXiSrOSpSnyJqwo/GGbEDIzeS0z/U4=;
Received: from p200300ccfbcbd5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g7wYH-0003Xg-0k; Thu, 04 Oct 2018 07:51:57 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g7wYG-00060V-KL; Thu, 04 Oct 2018 07:51:56 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Date:   Thu,  4 Oct 2018 07:51:45 +0200
Message-Id: <20181004055147.23048-1-andreas@kemnade.info>
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

Since the order is first disable all autoidles, then disable selected
and then enable all, we need to either change that order or add
a usecount. Since it is done only in init, we could think about changing
order.

Andreas Kemnade (2):
  clk: ti: add a usecount for autoidle
  arm: mach-omap2: setup iclk autoidle according to flags

 arch/arm/mach-omap2/omap_hwmod.c |  8 ++++++--
 drivers/clk/ti/autoidle.c        | 20 ++++++++++++--------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.11.0

