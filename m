Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A79C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA8C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438942AbeKWIDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:03:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40139 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeKWIDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:03:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C3C7920DA7; Thu, 22 Nov 2018 22:22:21 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D5412072F;
        Thu, 22 Nov 2018 22:22:21 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] Link consumer with clock driver
Date:   Thu, 22 Nov 2018 22:22:10 +0100
Message-Id: <20181122212212.16039-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While working on suspend to RAM feature, I ran into troubles multiple
times when clocks where not suspending/resuming at the desired time. I
had a look at the core and I think the same logic as in the
regulator's core may be applied here to (very easily) fix this issue:
using device links.

The only additional change I had to do was to always (when available)
populate the device entry of the core clock structure so that it could
be used later. This is the purpose of patch 1. Patch 2 actually adds
support for device links.

As I am not used to hack into the clock subsystem I might have missed
something big preventing such change but so far I could not see
anything wrong with it. As this touches core code, I am of course
entirely open to suggestions.

Thanks,
Miquèl


Miquel Raynal (2):
  clk: core: clarify the check for runtime PM
  clk: core: link consumer with clock driver

 drivers/clk/clk.c            | 31 +++++++++++++++++++++++++------
 drivers/clk/clkdev.c         | 13 ++++++++++---
 include/linux/clk-provider.h |  2 ++
 3 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.19.1

