Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D67C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2539D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4tQTpKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2539D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIYPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeIYPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so22451966wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=03mTYERafDqarsYCV3hfz4wlnFf+CbGZWEgUdjGls6k=;
        b=N4tQTpKjaPVrQ5EuYF9NBVhnvdphpnWRWaBqe3LTEId3ePsmTnv0+BUqC3sRxJGJO+
         FXTOxupZ6TAK9v96nX6owlGqLzybbqJkX2/WNRq+YNl+FPUDEPgmjDKGd8FIBHkUpouI
         hggeDtlNHZnyZAh3+S015tCoSlJcFVjT4j3ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=03mTYERafDqarsYCV3hfz4wlnFf+CbGZWEgUdjGls6k=;
        b=Xag+xio2+gHokUq4kSIC8BnCpmhb6UODpTdikAwZmEyhze7d0wTYVilSFKhhmnHNdl
         gHL/Ste1FtekcC0eu87lTnMKG7P1gjxIMAIy2osb97hbOFjSrjV94GNOoQ7n6aZ8HFaC
         NNNHyIaJoxz1r0Xu8/5IlYRUlXXEDR2Fu2h+srcGOTmysAlmYM+QjJ92InSDTogxPIKo
         cr/Etx2Xxv1ka9n0u0/5HP2VbAhL2BVuYpj5Zxi8G8ophHcfhb3aQ580p8YHxNFqsZW5
         zZ/yNNEn117+xn7wzWzp+yGduUEQcD1w4t25fmpdtlIw2A+EmnfvrX39JTMXS8psHIMs
         vGqg==
X-Gm-Message-State: ABuFfojnP+o77Qin87894/TYHm4rO4kvXmkGfvT/6C9h5Hxuf0GvxYju
        xQHfWHDxVgy+8mfBrYP912HYpA==
X-Google-Smtp-Source: ACcGV62qmbSV7z2Csd56M3ixjBh/M2eqgmuy2QpgAOkrEHaKQggrDIBM7pDtA3oyPp5yN2ZQqu7EYQ==
X-Received: by 2002:adf:a925:: with SMTP id u34-v6mr9761wrc.175.1537866212172;
        Tue, 25 Sep 2018 02:03:32 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:03:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org
Subject: [PATCH 00/14] thermal/drivers/hi3660: Dual cluster sensors support
Date:   Tue, 25 Sep 2018 11:02:58 +0200
Message-Id: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides the changes to support the dual clusters sensor on
the hikey960 board.

Most of the patches set the scene for the addition of other sensors which comes
at the end of the series.

Daniel Lezcano (14):
  thermal/drivers/hisi: Change the platform data pointer to sensor ops
  thermal/drivers/hisi: Change the driver to be sensor oriented
  thermal/drivers/hisi: Set the thermal zone private data to the sensor
    pointer
  thermal/drivers/hisi: Factor out the probe functions
  thermal/drivers/hisi: Prepare to support multiple sensors
  thermal/drivers/hisi: Add multiple sensors support
  thermal/drivers/hisi: Replace macro name with relevant sensor location
  ARM64: dts: hisilicon: Add tsensor interrupt name
  thermal/drivers/hisi: Use platform_get_irq_byname
  ARM64: dts: hisilicon: Add interrupt names for the tsensors
  thermal/drivers/hisi: Remove pointless irq field
  thermal/drivers/hisi: Add more sensors channel
  ARM64: dts: hisilicon: Add dual clusters thermal zones for hi3660
  thermal/drivers/hisi: Add the dual clusters sensors for hi3660

 .../bindings/thermal/hisilicon-thermal.txt         |   9 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  60 +++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   1 +
 drivers/thermal/hisi_thermal.c                     | 249 ++++++++++++---------
 4 files changed, 204 insertions(+), 115 deletions(-)

-- 
2.7.4

