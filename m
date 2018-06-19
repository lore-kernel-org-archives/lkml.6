Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55192C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D0C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pIl/770u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D0C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937691AbeFSNlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:41:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35003 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937635AbeFSNlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:41:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so565595wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BbgokXtJGDozTTd+Fk8mX44LvySHxUpDGzkdC0ZqN90=;
        b=pIl/770uM+0iLWbzWd9GIY9rV+c5mMp3vXOS5DCy7OOm/I+/cNlM8aDXH3ahsZDbhU
         /7EHAFgiCmud7GG73Ga58AFkhfyqLb3pruYBqzHmdL5o5eYjusM9V+PFNuXi9RRAsK2b
         Rt3oJtdOj8/1GWdJcRLpPxQ3zi958YfVHuqbbM6J+kG5I49VdwvxwOlu79OBuYFWRxPu
         KhlAbaeg/lTeJgANTrhxFZq7kwZ3xdmlK02UMnz80ivCNd6OP4j/d6+8DkZPl8x6sYLS
         wA7nIKMhU3ZBaAnXAdfdReKmtN6LfpZ89mP5G3YS4zuMqO6eGBHb8BxX/mj2e1wgPbfe
         gcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BbgokXtJGDozTTd+Fk8mX44LvySHxUpDGzkdC0ZqN90=;
        b=OVYbgsJeAkqT5nuGLnKMvq74gFdPw9+YvxmxcTqPOphNh4+gCtdZNB0YTT3HNxZUnL
         cv5Xl2puDs1nGkfQC9+PNxyNMEjXG/Wio3WGyNgkf/bqSh57bnt5PHNyDlpenFa8otl7
         8jj5wWJtrAVQBx7tUGROPRvmImGwy1VBYdroAxJYdfP35XdMwzPeb/YyRDrAGDWZY4zS
         I+rohT6+PAKskrwhxRuJFkoOpi7m6E4KQEfITZVallYsC51NJRM2vq91lq31Cg3kSfGd
         JVJSPqmGp8bLG5ilF//bS3Q6n9LIfxLElK83UkZrXsEvcKqSG6bzy9zEOwVAWpPN+izo
         +mdQ==
X-Gm-Message-State: APt69E2ehKSLnoIiWgphWkA5uATeFVCg5fQdqlQs3VByZvi1L5iBxTNK
        9SiiZ6bbr3xHurUGZnrKEeslBDG2
X-Google-Smtp-Source: ADUXVKJ0IVeK8ZrgBCbT9gqRsCoSu7tfk3rUbE5KFxKLlDW5l2qKzM1+TKP3HEUOuKYhCrLHhkMPIw==
X-Received: by 2002:a1c:4a06:: with SMTP id x6-v6mr7665924wma.89.1529415660432;
        Tue, 19 Jun 2018 06:41:00 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm17196154wrq.74.2018.06.19.06.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 06:40:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 0/2] clk: enforce CLK_SET_RATE_GATE along the tree
Date:   Tue, 19 Jun 2018 15:40:49 +0200
Message-Id: <20180619134051.16726-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the last unmerged patch of the clock protect v5 [0]
patchset. It makes use of the clock protection mechanism to fix and
enforce CLK_SET_RATE_GATE flag.

With this flag set, any operation resulting in a rate change or glitch
should be prevented. This might be useful when, for example, a PLL can't
safely relock while in use.

ATM, this is enforced only on the leaf clock of the operation (the clock
on which clk_set_rate() is called). It is ignored otherwise. It means
that, if:
 * clock A has CLK_SET_RATE_PARENT and is a child on clock B
 * clock B has CLK_SET_RATE_GATE set
it is possible to:
 * call clk_prepare_enable on clock A (clock B also gets enabled)
 * call clk_set_rate() on clock A,
  => with rate propagation clock B (or its parents) might change while
     enabled

Patch 2 of this series fixes this problem.

Some platform may have been relying on the broken implementation of
CLK_SET_RATE_GATE but, since the platform actually bypassed
CLK_SET_RATE_GATE, we can drop the flag without changing anything.

This is the case for qcom SDC clock and mmci driver, which does the
following sequence:
 * clk_get()
 * clk_prepare_enable()
 * clk_get_rate()
 * clk_set_rate()
This is obviously not possible when CLK_SET_RATE_GATE is set.
Patch 1 drops the CLK_SET_RATE_GATE from qcom sdc clocks. Other qcom's
clocks are using the same scheme, so maybe there something worth
checking here.

This case was detected using kernelCI but some other platforms might be
doing the same. Maintainers of the platforms using this flag have been
warned ... but please test!

[0]: https://lkml.kernel.org/r/20171201215200.23523-1-jbrunet@baylibre.com

Jerome Brunet (2):
  clk: qcom: drop CLK_SET_RATE_GATE from sdc clocks
  clk: fix CLK_SET_RATE_GATE with clock rate protection

 drivers/clk/clk.c              | 16 +++++++++++++---
 drivers/clk/qcom/gcc-ipq806x.c |  3 ---
 drivers/clk/qcom/gcc-mdm9615.c |  2 --
 drivers/clk/qcom/gcc-msm8660.c |  5 -----
 drivers/clk/qcom/gcc-msm8960.c |  5 -----
 5 files changed, 13 insertions(+), 18 deletions(-)

-- 
2.14.3

