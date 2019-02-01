Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B76EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC6B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549005041;
	bh=WFJwjM35Z8hCBcykzxSycLeR/qKBeOFjMr2sY0fUMhM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RILghI4j+2IimM3NiC/M1j2XlJorUKjOXUAni2iwq4oQcu5Pv2SSa9iDKPllZR08J
	 3FTgzyFjj5qfYXFgHCVkS+pLlvSYHsh5LvfoNC/Uu5i/jlOqevpVRoumesaGytpgz6
	 89p1r6CVg06BAvNEvgM1OS3WtjHis4FBJNe8nDNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfBAHKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfBAHKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:10:38 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85E920869;
        Fri,  1 Feb 2019 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549005038;
        bh=WFJwjM35Z8hCBcykzxSycLeR/qKBeOFjMr2sY0fUMhM=;
        h=From:To:Cc:Subject:Date:From;
        b=QYSl67ngUPXqoeHrUyNc9TmSob5ykmLsUfHouY3bLbPZq3vvExi2Oye7NdLmW0giC
         sy0sPGpuDZ6IRZ1TspYCHdRvmuQ9MxqRmsIOjZnE1z3SG38Ul61hQLwtU5N+Zj0dRj
         AH3/nZmsIsycgL3vurs/Rb8DME6fK5m/69UA9Pv8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.0-rc4
Date:   Thu, 31 Jan 2019 23:10:37 -0800
Message-Id: <20190201071037.215136-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b488517b28a47d16b228ce8dcf07f5cb8e5b3dc5:

  clk: socfpga: stratix10: fix naming convention for the fixed-clocks (2019-01-15 12:58:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 9ff1a3b4912528f853048ccd9757ba6a2cc75557:

  clk: qcom: gcc: Use active only source for CPUSS clocks (2019-01-24 11:41:48 -0800)

----------------------------------------------------------------
Mostly driver fixes, but there's a core framework fix in here too.

 - Revert the commits that introduce clk management for the SP
   clk on MMP2 SoCs (used for OLPC). Turns out it wasn't a good
   idea and there isn't any need to manage this clk, it just causes
   more headaches.

 - A performance regression that went unnoticed for many years where
   we would traverse the entire clk tree looking for a clk by name
   when we already have the pointer to said clk that we're looking
   for

 - A parent linkage fix for the qcom SDM845 clk driver

 - An i.MX clk driver rate miscalculation fix where order of operations
   were messed up

 - One error handling fix from the static checkers

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: Fix fractional clock set rate computation

Dan Carpenter (1):
      clk: ti: Fix error handling in ti_clk_parse_divider_data()

Derek Basehore (1):
      clk: Remove global clk traversal on fetch parent index

Lubomir Rintel (3):
      Revert "Input: olpc_apsp - enable the SP clock"
      Revert "clk: mmp2: add SP clock"
      Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"

Taniya Das (1):
      clk: qcom: gcc: Use active only source for CPUSS clocks

 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt |  4 ----
 drivers/clk/clk.c                                      | 14 ++++++++++++--
 drivers/clk/imx/clk-frac-pll.c                         |  5 +++--
 drivers/clk/mmp/clk-of-mmp2.c                          |  4 ----
 drivers/clk/qcom/gcc-sdm845.c                          | 14 ++++++++++----
 drivers/clk/ti/divider.c                               | 11 ++++++++++-
 drivers/input/serio/olpc_apsp.c                        | 14 --------------
 include/dt-bindings/clock/marvell,mmp2.h               |  1 -
 8 files changed, 35 insertions(+), 32 deletions(-)

-- 
Sent by a computer through tubes
