Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A90C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35A208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HuxDfr/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB35A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeKFFB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:01:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39992 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeKFFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:01:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so1950816pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79FFXPDXxKn+tLiOm0w09aLQfe6HmuIjKtK4WiHzhAc=;
        b=HuxDfr/6N5+hMA8YlFnIkbIzDbho9GbyRNB6aKE9hG+8DE81tfD1LsdNmz2ullarGY
         dQvAzYt69d3CIOnq5j4UHQZuSj+sLMf0AQGUUD61mlQ5foFZbjvHAWF77ArDg8f7eV0z
         zoRJYxVUS958ZtAqj9sjVEzyGqU70eYpfbEjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79FFXPDXxKn+tLiOm0w09aLQfe6HmuIjKtK4WiHzhAc=;
        b=IA9uClx0N7g2TU2O0HN1IKBv6pRDf99XiCrM/Se6wBEbUs4w8gc804l7Acr88qt/lD
         0i7qVthXxN15B/tdvjxaWXzD4ShT8OBJW7WfYOWZ7POK0cNht4fMuQpcAG/8zFMFcT+G
         tRnG4llWCZR2QvsFHA5l3ZK25hSk2SkRHCIhzTSwX1w+z/zWGdi9d8oAVhMPNJt8Yh9T
         dglJ28ow3XOUApT9aiR7voDD1Aw8g96p1ZMt7/VZ5MjTNxFmS4MMgVLSHshzOOu2tyRZ
         Z1rts+psVkld1fR8vSh5YTESYuqKBhQDCNB4IUkVIQDUH7tSs2+dp8G5+YCPdk2t+h59
         gKmQ==
X-Gm-Message-State: AGRZ1gLgqn3WR9M8/5mTkIKRjSJXDgbLJbXONhvahHUsJTvJ9HdbfXIH
        PTbX/DSz8iPQl0245Rqs7ldPcA==
X-Google-Smtp-Source: AJdET5cmjOi5l9vpnYTJZLc2ES4JXomHv+ClejuLsc3UIYQe9e9ERJ3V1fM2o9hK1W9Q0N2eo+IMPQ==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10-v6mr23549692plb.294.1541446814432;
        Mon, 05 Nov 2018 11:40:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id q25sm700728pgb.2.2018.11.05.11.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:40:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 0/2] Introduce a 'protected-clocks' property
Date:   Mon,  5 Nov 2018 11:40:09 -0800
Message-Id: <20181105194011.43770-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See full explanation in patch #1. It looks like on qcom platforms
we're increasing the number of situations where we need to have
a set of clks that aren't touched by the OS because firmware
wants them for itself. This series introduces a method to do that
by specifying in DT what clks shouldn't be read or written and
then having the qcom clk driver neve register the ones that 
are protected.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>

Stephen Boyd (2):
  dt-bindings: clk: Introduce 'protected-clocks' property
  clk: qcom: Support 'protected-clocks' property

 .../bindings/clock/clock-bindings.txt          | 16 ++++++++++++++++
 drivers/clk/qcom/common.c                      | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
Sent by a computer through tubes

