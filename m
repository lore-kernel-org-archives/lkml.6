Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA939222DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550161834;
	bh=S52G9GyV1XgpA2oT1wnPeJT6k66liUFjchNg5KlJcLY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sH9OC6SaoINOZjLZk99Q+h4L7uMOJjVr3BN8BtehRc04wSjUG5o3qXseDb4PEwLPA
	 mn5DK8LeiD/SFITXqYz7oPPA6DkSL/Pus2V90FkjfUJChqgimybAO/Ris8OCBRkL+H
	 45HmYXgrgriAz+hfvmMwjmrN23ayNs0dti1ROi7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407920AbfBNQac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfBNQac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:30:32 -0500
Received: from ziggy.de (unknown [37.223.146.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CD8222DA;
        Thu, 14 Feb 2019 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550161831;
        bh=S52G9GyV1XgpA2oT1wnPeJT6k66liUFjchNg5KlJcLY=;
        h=From:To:Cc:Subject:Date:From;
        b=KIpMX8tXoqM8loN0AURUMN0TmJETCCDYkT7f6QE/uOwXwUoOQEZm/iUQZW2EQkf/Q
         JdPo4C2kj6JpuCrIp6X8FvBi+AS34JK+L3qqlhBz9BAbbDtRDpcZ2eryJjp3BhuQt8
         5WDuqHwEX+q574dOrVbYL4e+5PNlUk1kDIoQHTAM=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 0/3] Mark clocks as critical for MT6797
Date:   Thu, 14 Feb 2019 17:30:23 +0100
Message-Id: <20190214163026.26073-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Changes since v3:
- add comments explaining why the clock muxer and gates are marked
  as critical

Changes since v2 (https://patchwork.kernel.org/patch/10686759/):
- axi_sel is not needed, drop CLK_IS_CRITICAL for it.
- update commit message
- add Acked-by from Mars

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
 drivers/clk/mediatek/clk-mt6797.c | 68 +++++++++++++++++++------------
 drivers/clk/mediatek/clk-mtk.c    |  2 +-
 drivers/clk/mediatek/clk-mtk.h    |  9 +++-
 5 files changed, 56 insertions(+), 30 deletions(-)

-- 
2.20.1

