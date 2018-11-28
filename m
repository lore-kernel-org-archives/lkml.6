Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D88C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D842133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggZz/co9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D842133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeK2Jhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42961 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeK2Jhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so18067926pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qk84ZQ+S1SfN7h5ep+k2Fq3wmftOXU2NZ0H05Ria/Zk=;
        b=ggZz/co9KonraI36CJeQtAZyFrxJmwM6sjKwt0Lct+qUjPyDQ1MYhyHuQSGYf0Stpu
         ZYX73r/sayiOMwKUcMQJwfMRqSZttqwcJFiN977kJajGlrlzu22C57jeiOUFEx3I8hSw
         OUuSCusN9paEULs4rTGtEzFPqu7mf5f9zemSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qk84ZQ+S1SfN7h5ep+k2Fq3wmftOXU2NZ0H05Ria/Zk=;
        b=asJGFXIRDKFIkQ6GJggsth5wfMcZKiKgUVcaRLNmWLcYtS0d19lvYC/mu3GY/IEHTj
         DNnLNwID7TIC4XLqhjmGrfCk5usNtTJtNlTR63Mw/mRD7FGUKO8uN9UVE8GzoFpBxUje
         M4deIT7ba5YwbHk18L1sQqkLs3lwZoAGpZA0bCzgdNtgIA3vEEQXYtL7SbNF6l1HMFss
         Cp2bZPxtDsZmfhLgPO81d5+ZT4K3n3Xax4m9HnjTVavN1MC6nhshMusKhkaCk0BY09/W
         Z/KLpjL1K/tgm6Ihr99nxrNwEU1gblp/k2TaehVMu0m2l5AW9ZvEtxNJBJQWw1vqMNah
         6Z/g==
X-Gm-Message-State: AA+aEWYLCGBUYpK7eZgdkRon6pOgdcBg8a0yBAbWR5w8WLB/UVYVt2ym
        Htx5/Infm52QEki5sH3tcQRjjg==
X-Google-Smtp-Source: AFSGD/XJoW1OaCz8a4Thqn8y/o+d462KdB78waezVF97alA9NeunIZrn1ggCEU1qUNlnhK4MVT9rGg==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr12354273plo.96.1543444476608;
        Wed, 28 Nov 2018 14:34:36 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y26-v6sm12364813pfi.123.2018.11.28.14.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:35 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 0/3] arm64: dts: qcom: sdm845: Add SD nodes
Date:   Wed, 28 Nov 2018 14:34:25 -0800
Message-Id: <20181128223428.177313-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the nodes for the SD host controller on SDM845, and wires it
up on the MTP.

Though I tested similar changes on another board, I was unable to actually run
this on an MTP. If someone felt like trying this out on an MTP I would be
grateful.

The original downstream nodes had sleep pinctrl states. It's not obvious to
me that all this messing with drive-strength saves non-negligible amounts of
power, so I didn't add them and figured we could add them later if needed.


Evan Green (3):
  dt-bindings: mmc: sdhci-msm: Clarify register requirements
  arm64: dts: qcom: sdm845: Add SD nodes
  arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp

 .../devicetree/bindings/mmc/sdhci-msm.txt     |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 53 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 15 ++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

-- 
2.18.1

