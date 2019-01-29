Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F59C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E892175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742260;
	bh=CDbiA01wIj3YJh2W5ajCbcvfWbn6X5JCqFTrTrXKrXA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=blMNiIs6YqOg7N4MqU9xrW3KBf7oFt9hDduwUROK7lA55NI3vIyKyaqQv6TAZPuyN
	 a/R8zLiy+AsKZ2+h4tPC7uesrzaVByGLjsgpwKvDMuo52l/JDLT2ppdZEpntrzbXSP
	 pZOx/2G5jUSWhqQBnEVb/VkqNtulp8fvhbFZCOLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfA2GKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfA2GKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:24 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD822175B;
        Tue, 29 Jan 2019 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742222;
        bh=CDbiA01wIj3YJh2W5ajCbcvfWbn6X5JCqFTrTrXKrXA=;
        h=From:To:Cc:Subject:Date:From;
        b=eudWBhKHIpQf0aF82qOD6jkMoI7eB0v32bY/JGjGuST3/6CsnFuJaOjSsZV5LQ4Q/
         Vsd4bRCqSsJkKXzRSIHu54n9TEyKmJby4pHmJso75tqngWGc5ihFvwAHYwe/477d14
         yGFXDVqmpmCeCob1UzGkFlxpeEVZbISH7WcZYK70=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/9] Rewrite clk parent handling
Date:   Mon, 28 Jan 2019 22:10:12 -0800
Message-Id: <20190129061021.94775-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple problems with clk parent handling in the common clk
framework. This patch series combines a few different topics together as
all this code is closely related.

First off, we don't do well at determining parents of clks at clk
registration time because the return type of the clk_ops::get_parent()
op is a u8 which isn't expressive enough to cover all our use-cases.

Secondly, we use strings for all parent-child linkages, and this leads
to poorly written code that extracts clk names from struct clk pointers
and makes clk provider drivers use clk consumer APIs. 

Thirdly, clkdev.c has a collection of DT parsing logic in it that is
only used when the common clk framework is present but we want to use
that same logic for describing parent-child linkages of clk providers
via in DT. This should all be moved into the common clk framework and
used from there as well as from clkdev.c, so this series changes the way
clkdev interacts with the clk framework by having clkdev get clk_hw
pointers out of DT clk specifiers and then convert those into clk
pointers with clk_hw_create_clk(). Splitting the API this way lets us
get clk_hw pointers for clk providers and skip the struct clk pointer
creation phase that we don't need to do when describing parent-child
linkages.

And finally, we have a few patches in here that lay the groundwork for
supporting device links in the common clk framework. We do that by
pushing the consuming device pointer through to the clk pointer creation
in clk_hw_create_clk(). This wasn't always easy to do when we had
__clk_create_clk() called from multiple places, some being deep in the
clk registration path. This series simplifies that logic so that we can
always attach a consumer device to a clk that we create in one place,
instead of making that linkage in multiple places near where we create
struct clk pointers.

Miquel Raynal (1):
  clk: core: clarify the check for runtime PM

Stephen Boyd (8):
  clk: Combine __clk_get() and __clk_create_clk()
  clk: Introduce get_parent_hw clk op
  clk: Introduce of_clk_get_hw_from_clkspec()
  clk: Inform the core about consumer devices
  clk: Move of_clk_*() APIs into clk.c from clkdev.c
  clk: Allow parents to be specified without string names
  clk: qcom: gcc-sdm845: Migrate to DT parent mapping
  arm64: dts: qcom: Specify XO clk as input to GCC node

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   2 +
 drivers/clk/clk.c                    | 584 ++++++++++++++++++++-------
 drivers/clk/clk.h                    |  23 +-
 drivers/clk/clkdev.c                 | 120 +-----
 drivers/clk/qcom/gcc-sdm845.c        | 180 ++++-----
 include/linux/clk-provider.h         |  26 +-
 6 files changed, 583 insertions(+), 352 deletions(-)


base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a
-- 
Sent by a computer through tubes

