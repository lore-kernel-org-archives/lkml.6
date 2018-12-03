Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F29C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3831E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeUCHp8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3831E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeLCSfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:35:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37052 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLCSfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:35:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so6816885pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kh0fVXYl0uHGp0nKw8Mfn/C9mTAQmR0796MZesOAna0=;
        b=DeUCHp8sIAe3b1W7p3CMbvgp72cOzSmNcZOJpBRdmnJqb99cWDa1+o1Rgci2GdSSUo
         rQnYent2j58szRwEyyklCTY8NKRT92adaDQFEEBGxvZod8Vu/rPai+Asm61OCFXs9rmW
         DopsrBxB8ijZK/EQlxdfUvkzdFIRVRF2atRRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kh0fVXYl0uHGp0nKw8Mfn/C9mTAQmR0796MZesOAna0=;
        b=Xx2DyykGq1iN1qMrtv7U+4O0Mn8nU/21PZ67zvsY7xuEj+7nefj0pGgvzRBhoPIlBK
         GhqXPP3NjiZp78IPSgdgNBwVmQKgqkKDBQwH/aWZt1tBZDhy7sHS0qOpIZgRKYRTPcQB
         H0NyFW2RYp2Ib7d6wAp0rAjF2HPJIo851cMmt1Pqw0CVydfCnwujRVXq9zDhUDGtyXVJ
         IpZ9EuQYcPASwWHbFe0zJObO3+oubpvMZzEDAIN6NglIlqw60OHB5Yg3mOaXMwt2YCPQ
         Jp8lYiFUEW5P4jAHuTIEuLWUr6dh+jSET3kv79wRW0WI6hPGldyAJMqoyFsgWHXleWWk
         fSjQ==
X-Gm-Message-State: AA+aEWYbSJVBZVLJ4KCyUxQQF/5mFO3+bMKJ0FVL3e8pzK3kRfpiqDMk
        Wrj7E5h5SXf5yNF0kjZOIAhr1w==
X-Google-Smtp-Source: AFSGD/W1KV3F6v5QHy1oPloMmBL2E+MBpsem5NeJTblvu+i0ii4iBl/wsmFv4vs1uX1C53LfvtLZ6w==
X-Received: by 2002:a63:e40c:: with SMTP id a12mr14266019pgi.28.1543862133346;
        Mon, 03 Dec 2018 10:35:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f6sm20180969pfg.188.2018.12.03.10.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:35:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 0/3] clk: qcom: gcc-msm8998: Fixes and clkref clocks
Date:   Mon,  3 Dec 2018 10:33:27 -0800
Message-Id: <20181203183330.2073-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop clocks preventing the platform from booting, don't halt-check UFS clocks
and add clkref branches.

Bjorn Andersson (3):
  clk: qcom: gcc-msm8998: Drop hmss_dvm and lpass_at
  clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
  clk: qcom: gcc-msm8998: Add clkref clocks

 drivers/clk/qcom/gcc-msm8998.c               | 109 +++++++++++++------
 include/dt-bindings/clock/qcom,gcc-msm8998.h |   5 +
 2 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.18.0

