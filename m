Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD06D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC0/QIG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfAQEaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:30:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40176 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfAQEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:30:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so4102859plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SSaMUaBQ0F2OC2XsU1BccePKuZ2cfIUNF45/G9oxnZQ=;
        b=EC0/QIG9o4Vv71S5C2Z3RS5Z0l3lzTq8FFQpvmkmnt5EvzDriFKXOq7pHq27EmkroG
         I59z+vabjYH6VklsGrUhiVLP650zbf4UoQoeX46qKERA1b2v//n3OODDnYlByr21Pea8
         mgi8EVC57zcSnta/nzD66q5khfAn1pEVMOXoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SSaMUaBQ0F2OC2XsU1BccePKuZ2cfIUNF45/G9oxnZQ=;
        b=nxeLGdpXC5tDaOnDKpGEO4GFVTkGgTypRb7n6xlmiAAeyNQ8TAH2hJHsYCLC1lJJtr
         7qtiQvqxsUMqhdsy6pFop7p45cVIPE29wasHNyxgzsk4LrbwQahsglsF1C3ZSIeqJFbz
         yqcVAz1i/LfKgKvI6LDYueCQkpJ5OV69sjWPJepyeKAsLe7IhoyEeJZsit6y1QB4C51h
         57IBUEL8Ia9igE53++PxUMdeRxL/idfJc8ma3mFkGOvA4gfLqfi9HCXlgJ86cb26iMpj
         /Da9jEDEQukGxuZ2a+qiJ4FOeXPrcNzjNWvUilZLe/eSpr0OIWuoxsqzKn4UW+xn0186
         Ghng==
X-Gm-Message-State: AJcUukeyU0rFD1gIqaGdXSUOnT3JhXeK55C6Cu4DMMyiM176FwR0E8PA
        p7GGPVKQbPIjvCSkOVXJT1WNQg==
X-Google-Smtp-Source: ALg8bN4ACvJahH/XTMwNKPCEQuAT3vRdZCg+S62H5QIVvzwrfvYHofudpA/l9W99VNKO/+qggO9pjA==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr13581186plo.210.1547699421933;
        Wed, 16 Jan 2019 20:30:21 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm361574pgc.89.2019.01.16.20.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:30:21 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] arm64: dts: qcom: sdm845: Fix DMA allocations for devices with IOMMU
Date:   Wed, 16 Jan 2019 20:29:38 -0800
Message-Id: <20190117042940.25487-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches extends the size cells of the soc bus and define the dma-ranges,
so that DMA allocations for devices with IOMMU attached will get valid IOVAs.

Changes since v3:
- Split patch in two
- Rewrote commit message from scratch

Bjorn Andersson (2):
  arm64: dts: qcom: sdm845: Increase address and size cells for soc
  arm64: dts: qcom: sdm845: Extend ranges and describe DMA space

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 301 ++++++++++++++-------------
 1 file changed, 151 insertions(+), 150 deletions(-)

-- 
2.18.0

