Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E48C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93782218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220505;
	bh=IboUflHxCb359juQMeyLW3Xltd178tmZn/LHDEiDD5I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WXyNOhYGtQvNNwwPTv6STlQrTIl2ls06gGnGkoPrl3ETpMj9T3IOX1wNz7ATAMrIM
	 YId5iKmKdCUqQbKqNeAiuRVmnGs5nwHXVUnebZUzg32HImyBCzHIfGrU8X9pmS2q5H
	 o8ui6bmVBMMYUm7N/z70cHcvqtB9OrY4lUQKZY38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfBZWec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfBZWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:32 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790B22186A;
        Tue, 26 Feb 2019 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220470;
        bh=IboUflHxCb359juQMeyLW3Xltd178tmZn/LHDEiDD5I=;
        h=From:To:Cc:Subject:Date:From;
        b=1skYq4eVlxwP3y/fcDP3kXomRCGS9hrDMg+M4F1NYTeBkGVDhqKMW5xPLSuY9D+uX
         42xL86wuTd77Jg/zFHDSbIy4hOMfDrpdt0YZeAFC+B2d0xLY5IF6cx9SD7NM4W6v6Z
         MeMDJBBG7QxRoy5swUxavewxslaop9xQoe9JQVPs=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 0/8] Rewrite clk parent handling
Date:   Tue, 26 Feb 2019 14:34:21 -0800
Message-Id: <20190226223429.193873-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple warts with clk parent handling in the common clk
framework. This patch series addresses one of those warts, parent-child
linkages. We use strings for all parent-child linkages, and this leads
to poorly written code that extracts clk names from struct clk pointers
and makes clk provider drivers use clk consumer APIs. 

Also, clkdev.c has a collection of DT parsing logic in it that is only
used when the common clk framework is present but we want to use that
same logic for describing parent-child linkages of clk providers via DT.
This code should all be moved into the common clk framework and used
from there as well as from clkdev.c, so this series changes the way
clkdev interacts with the clk framework by having clkdev get struct
clk_hw pointers out of DT clk specifiers and then convert those into clk
pointers with clk_hw_create_clk(). Splitting the API this way lets us
get struct clk_hw pointers for clk providers and skip the struct clk
pointer creation phase that we don't need to do when describing
parent-child linkages.

And finally, we have a few patches in here that lay the groundwork for
supporting device links in the common clk framework. We do that by
pushing the consuming device pointer through to the clk pointer creation
in clk_hw_create_clk(). This wasn't always easy to do when we had
__clk_create_clk() called from multiple places, some being deep in the
clk registration path. This series simplifies that logic so that we can
always attach a consumer device to a clk that we create in one place,
instead of making that linkage in multiple places near where we create
struct clk pointers.

I plan to at least merge the early patches in this series into clk-next
so we can clear the way for the later patches. I don't think anything is
too controversial until we get to the new way of specifying parents
at the end and of course, the sdm845 patch is incomplete so it's not
going to be merged.

Changes from v1:
 * Dropped new get_parent_hw, we'll pick it up in a later series
 * Rebased to v5.0-rc6 to avoid conflicts with clk-fixes
 * Renamed 'fallback' to 'name' and 'name' to 'fw_name' in parent map
 * Made sure that clk_hw_get_parent_by_index() never sees an error pointer
   so that we don't mistakenly try to defer an error pointer
 * Fixed index passing mistake on of_clk_get_hw_from_clkspec()
 * Copy over all the data from parent maps and free it correctly too

Miquel Raynal (1):
  clk: core: clarify the check for runtime PM

Stephen Boyd (7):
  clk: Combine __clk_get() and __clk_create_clk()
  clk: Introduce of_clk_get_hw_from_clkspec()
  clk: Inform the core about consumer devices
  clk: Move of_clk_*() APIs into clk.c from clkdev.c
  clk: Allow parents to be specified without string names
  clk: qcom: gcc-sdm845: Migrate to DT parent mapping
  arm64: dts: qcom: Specify XO clk as input to GCC node

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   2 +
 drivers/clk/clk.c                    | 512 +++++++++++++++++++++------
 drivers/clk/clk.h                    |  23 +-
 drivers/clk/clkdev.c                 | 120 +------
 drivers/clk/qcom/gcc-sdm845.c        | 180 +++++-----
 include/linux/clk-provider.h         |  19 +
 6 files changed, 532 insertions(+), 324 deletions(-)


base-commit: d13937116f1e82bf508a6325111b322c30c85eb9
-- 
Sent by a computer through tubes

