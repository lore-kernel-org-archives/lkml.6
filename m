Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C8C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2EF2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/SKUdtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2EF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeKQEWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:22:43 -0500
Received: from ziggy.de (unknown [93.176.147.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370142086A;
        Fri, 16 Nov 2018 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542391758;
        bh=tcLau1OHiSJKal0V6BJSGEwCEp2brxMeH34csJoXRZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=L/SKUdtDMmIW6b6ZGweMqgYUwIViMpkc3YRREM/jaNiqHS5VkVuJe4vbPBEC+yue9
         DdPe5SuvngefJhpQShnuYoV/aXGhKdHTnz1leqAvjmApvf/EhHBmGbEs7HQSKaMJuO
         DCfZMmbvdGb1G9Zr3s+lvTCCjnByTG0cgKfn9ZjE=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     jasu@njomotys.info, sean.wang@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2 0/3] Mark clocks as critical for MT6797
Date:   Fri, 16 Nov 2018 19:08:58 +0100
Message-Id: <20181116180901.17737-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Jasper send this series some month ago. As there was no reaction from
his side, I'll do a friendly take-over.
I tested the patches on my Helios X20 boards and they fix the issue.
I didn't add a Tested-by tag as I added my Signed-off-by.

Changes since v1:
- add a fixes tag.

---

Currently, DRAM-related clocks and the axi_sel MUX are not marked with
CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
system is booted without clk_ignore_unused.

This patchset

1. Makes it possible to mark outputs of MUXes as critical by introducing
   a new macro, MUX_FLAGS,
2. Makes it possible to mark gates as critical by adding flags to
   mtk_gate, and
3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
   as critical.

The addition of flags to mtk_gate also exists in the patch series "Add
basic and clock support for Mediatek MT8183 SoC" [1].  The type of
flags is unsigned int in that series, but the real type is unsigned
long, so my patch differs from that patch.

[1] https://patchwork.kernel.org/patch/10549953/

Jasper Mattsson (3):
  clk: mediatek: Add MUX_FLAGS macro
  clk: mediatek: Add flags to mtk_gate
  clk: mediatek: Mark bus and DRAM related clocks as critical

 drivers/clk/mediatek/clk-gate.c   |  4 +-
 drivers/clk/mediatek/clk-gate.h   |  3 +-
 drivers/clk/mediatek/clk-mt6797.c | 64 ++++++++++++++++++-------------
 drivers/clk/mediatek/clk-mtk.c    |  2 +-
 drivers/clk/mediatek/clk-mtk.h    |  9 ++++-
 5 files changed, 50 insertions(+), 32 deletions(-)

-- 
2.19.1

