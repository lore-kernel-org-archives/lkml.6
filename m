Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256FECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417221477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZLKR7yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F417221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJRBUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:20:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39980 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRBUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:20:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so13008318plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S2FpMLZoHUMa2GZshyU+c/vFbXH0SffbkUEfrv9YvyQ=;
        b=VZLKR7yVMmmLzqM5SaDMrgLRK+ZSzt4GDNhgBOVfSH5ve17StyUh+NjKX41lGgphEl
         GAQEbBUutChdjKLU0YxeebqXV4S56RHOOFAKkt8O/lyIfn82Hsd8A8xE5U29pmXTbORI
         XjLuanEhMzrHFr2LWvp52lOV73QY4V23TsMgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S2FpMLZoHUMa2GZshyU+c/vFbXH0SffbkUEfrv9YvyQ=;
        b=exiCuPAfvUtP6+YHAZSOXJ+ITOgj6fexeSiaOCnFfihEjPwi3VolWq4xxJrQ6E0KOx
         jFGyALiqVJ1uGyC7ZCE2agHlnNnFB6QGN4rUgrGQ962jojbIAD/hunHu1pEZhqCqhboo
         1K9+Leu6awz6vxYucN1Di47a1TYyqAgQtT+9Ty2ahWq53TPJzoCYfYYv0gLpftA4zOv5
         RdWWQ90IzQHhJTJ4F//98OXZVAQ/2tNEvvmQr58OJSPJYcvSEE0N5KEe1UySqg1GaQBa
         xiTkSk4eA+ZQAn4L11SDOad5MLfP1o5DoqJlzB140iGitq4mEFqTCp8Fa2JZN9LSvBCL
         5bwQ==
X-Gm-Message-State: ABuFfogsmAjtIWVj3qP+L9nFZxxGrbmVZ/3VZxtQPTjwOilmYkxrmCup
        nATYKMus/6b3nxuMyXH5M0LaHA==
X-Google-Smtp-Source: ACcGV61u3njFlio/YWICsNuwNnHCQ1RlUC/RHh9Epe+pyefQPyVNtOwB7yh2C4c1xgGh+kC4sIwqXw==
X-Received: by 2002:a17:902:9004:: with SMTP id a4-v6mr26274277plp.166.1539797019875;
        Wed, 17 Oct 2018 10:23:39 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id h75-v6sm19760141pfe.146.2018.10.17.10.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 10:23:38 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Wed, 17 Oct 2018 10:23:10 -0700
Message-Id: <20181017172312.194281-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the DT nodes for the Universal Flash Storage controller
present on the SDM845, and activates it for the MTP reference platform.

This series applies atop the for-next branch of:
https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
because it needs the regulator names.

Can Guo (1):
  arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

Evan Green (1):
  arm64: dts: qcom: sdm845: add UFS controller

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 11 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 66 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

-- 
2.19.1.331.ge82ca0e54c-goog

