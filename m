Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45669C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D121B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NRZW4Smx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L7FB5rjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbfBKS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:57:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfBKS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:57:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8670060234; Mon, 11 Feb 2019 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549911477;
        bh=JvGYztoXLvuVElAAlq9woBWMPegyKGnIGFKVWvfZY7g=;
        h=From:To:Cc:Subject:Date:From;
        b=NRZW4SmxauL7ZNW52dUT1C6UX8TUlaGnPbqiMr+4fwLqZLZaUKnXWdqYtgZIolYj2
         UUJpFsI6VGmQT0MYlRPucWPRdaRFi1oRhx7XMF5hA9Y925I+K1relbxl2VxS9Txis8
         vA075uwRK3igsm99FgNOBcXSerwGRG+07Rqw++us=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A0B160234;
        Mon, 11 Feb 2019 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549911476;
        bh=JvGYztoXLvuVElAAlq9woBWMPegyKGnIGFKVWvfZY7g=;
        h=From:To:Cc:Subject:Date:From;
        b=L7FB5rjfEpHpNS/zmqQ+4gN4uznZr6hHijoh3f1ZlGtDSUdGYEtb9lcsnTExI99xv
         PMLEibiHyTdMS3QXp4EzKshBTzRT3kJn0ltRUGnPVkCFskLnauPU1FDQq4kbCVCsYk
         2NAI22toe5lRM3/alr628HNqBt7ak1AzIK9+ugAc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A0B160234
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1] clk: Probe defer clk_get() on orphans
Date:   Mon, 11 Feb 2019 11:57:47 -0700
Message-Id: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a parent to a clock comes from outside that clock's provider, the parent
may not be present at the time the clock is registered (ie the parent comes
from another driver that has not yet probed).  The clock can still be
registered, and a reference to it obtained, however that clock may not be
fully functional - ie get_rate might return an invalid value.

This has been a problem that has resulted in the UART console breaking on
some Qualcomm SoCs, as the UART baud rate is based on a clock that is the
child of XO.  Due to the large chain of dependencies, its possible that the
RPM has not provided XO by the time that the UART driver probes, gets the
baud rate clock, and calls get_rate - which returns 0 and results in a bad
configuration.

An orphan clock is a clock that is missing a parent or some other ancestor.
Since the parent is defined, we can assume that it is expected to appear at
some point in a properly configured system (all bets are off if a required
driver is not compiled, etc), and it is unlikely that the clock can be
properly consumed during the time the clock is an orphan.  Therefore,
return EPROBE_DEFER for orphan clocks so that consumers wait until the
parent chain is established, and proper clock operation can occur.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

This is based upon the "Rewrite clk parent handling" series at [1], and assumes
that the suspected missing line commented on at [2] is added.

The idea for this solution came from [3] and [4].

[1] https://lore.kernel.org/lkml/20190129061021.94775-1-sboyd@kernel.org/T/#u
[2] https://lkml.org/lkml/2019/2/11/1634
[3] https://lkml.org/lkml/2019/2/6/382
[4] https://lkml.org/lkml/2015/12/27/209

 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 34e9524ea25d..cf71e0614282 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3405,6 +3405,10 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 		return ERR_CAST(hw);
 
 	core = hw->core;
+
+	if (core->orphan)
+		return ERR_PTR(-EPROBE_DEFER);
+
 	clk = alloc_clk(core, dev_id, con_id);
 	if (IS_ERR(clk))
 		return clk;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

