Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E961C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D5214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXjkE/5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6D5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeKMTtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:49:15 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:32843 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeKMTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:49:15 -0500
Received: by mail-wr1-f46.google.com with SMTP id u9-v6so12542987wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j3IWhqTdCei0mMsvFYCXlQcZEgy5UWilcxCSoGPiDas=;
        b=ZXjkE/5cyyG9DtNGqtvwvsNjSv96aDnSN/OVXnHtwIGFbBDsvVCA1F6QC3LhMcdZd6
         2aZ0TXGK0uDxEJkhWh5yBX69xAR8LAw2YhWxJBAypBWgbzR9Ftu9h7DjpVNFIMD+T8/e
         rmttRAQYe9CZww7DTLesOuUyTz3y87mWxkr5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3IWhqTdCei0mMsvFYCXlQcZEgy5UWilcxCSoGPiDas=;
        b=EAIGSrYsReB5QU6J56aGiclEAg7z0S/fHrgqoo0MNffDSKkIb6iTlr5DPlGn/33B2A
         6EgBgj103zI/DjfvWYWpoCLnfCOY7MbQJT3pGMsL9S6tjcyq9Zl9R+ldT3kxHY5EM9NL
         KMnA5QOIlghlfbO2kKo08XVQY3WAwJMIMjbp0PsEcayqkFf3yfVk3ZEpuiEeII4efZMw
         2VxWcpKWdbENvuucjcfWdcRZRcxd/twzButN1GpiJG0Q4xfQNjeBjOfoSFY/iISZRP++
         rk4OVdIF7acL8uSpmY76ro0iIcAG5XYKlnjBaN9Bf25+naBiqUsY6KRZiAc0AY0KK6NI
         ptOA==
X-Gm-Message-State: AGRZ1gK2+9SbR0cY7Xq0tYcimoKFnV/+Y7PLWraai1urnpUMh0PgErBm
        gCZiyq5yHn8ENqO4gIZ5AJ3IHw==
X-Google-Smtp-Source: AJdET5cwcdAgVV7Jhq5zTxRLS+FVbTzhwXoOKwqZIUZJj+niOpbsv7ulUfIa1ryCFzGsuv1SxRxRBw==
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr4146853wrx.302.1542102715450;
        Tue, 13 Nov 2018 01:51:55 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id d4sm6044279wrp.89.2018.11.13.01.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:51:54 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] make pin-controller use hwspinlock
Date:   Tue, 13 Nov 2018 10:51:39 +0100
Message-Id: <20181113095142.32015-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allow to protect pin controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors.

Benjamin Gaignard (3):
  dt-bindings: pinctrl: stm32: Document hwlocks properties
  pinctrl: stm32: protect configuration registers with a hwspinlock
  ARM: dts: stm32: Add hwlock for pinctrl

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 71 +++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.15.0

