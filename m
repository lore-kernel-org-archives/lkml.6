Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC3C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CEB2054F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544227397;
	bh=jBTDkw51DkUqeutehCqzibEpVANKtvX3W7HAKjj6dsQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JTIOiZcxNLspy9WOkUA5N6syvHdR7JjHFv9q3ojdiv9Uc8YRKngpOPEC+MuDx3ynL
	 L4wNzloJLb/Hj+VJuI0WE4VOjtwLwU9GLcH6y6wbLZHZPYaHhlf/K5BbxQJTOh58uh
	 ggZIE8+3tAIl6HHnZw1El0Avk2HkvxlEk3N4tYD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CEB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLHADQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLHADQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:03:16 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417552054F;
        Sat,  8 Dec 2018 00:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544227395;
        bh=jBTDkw51DkUqeutehCqzibEpVANKtvX3W7HAKjj6dsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=v7iSXbtFF/Ed9eSxglTCuWYLREbQwtUJPkrRJS98wJGve2yTyMrU67Bzn88/lTR38
         w2fNfOUwp6+GyoIx0+k+PeUbE8SWNo34PF0ZcW0qm36ROVEAzv2Nv0m0UXBuJuWDT0
         LdF8Fecby605Bwf3SstmO/1817kcPrtLkta2V4jA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.20-rc6
Date:   Fri,  7 Dec 2018 16:03:14 -0800
Message-Id: <20181208000314.180968-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1aefa98b010e9cc7a07046cbcb1237ddad85b708:

  clk: qcom: gcc: Fix board clock node name (2018-11-09 14:13:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 9a43be9cedd516f188e6333d3b43402386723eff:

  clk: zynqmp: Off by one in zynqmp_is_valid_clock() (2018-12-03 09:54:48 -0800)

----------------------------------------------------------------
A few clk driver fixes this time:

 - Introduce protected-clock DT binding to fix breakage on qcom sdm845-mtp
   boards where the qspi clks introduced this merge window cause the
   firmware on those boards to take down the system if we try to read
   the clk registers

 - Fix a couple off-by-one errors found by Dan Carpenter

 - Handle failure in zynq fixed factor clk driver to avoid using
   uninitialized data

----------------------------------------------------------------
Bjorn Andersson (1):
      arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks

Dan Carpenter (3):
      clk: mvebu: Off by one bugs in cp110_of_clk_get()
      clk: mmp: Off by one in mmp_clk_add()
      clk: zynqmp: Off by one in zynqmp_is_valid_clock()

Rajan Vaja (1):
      clk: zynqmp: handle fixed factor param query error

Stephen Boyd (3):
      dt-bindings: clk: Introduce 'protected-clocks' property
      clk: qcom: Support 'protected-clocks' property
      Merge branch 'clk-protected-binding' into clk-fixes

 .../devicetree/bindings/clock/clock-bindings.txt       | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                |  6 ++++++
 drivers/clk/mmp/clk.c                                  |  2 +-
 drivers/clk/mvebu/cp110-system-controller.c            |  4 ++--
 drivers/clk/qcom/common.c                              | 18 ++++++++++++++++++
 drivers/clk/zynqmp/clkc.c                              |  5 ++++-
 6 files changed, 47 insertions(+), 4 deletions(-)

-- 
Sent by a computer through tubes
