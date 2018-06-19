Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4797C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02522075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3Iw9Q3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02522075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756803AbeFSJzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:55:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46656 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755582AbeFSJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:55:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so10658636pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/nmn65sTA/9WHHWguInPwbP/p0T6P0lQckSZaFRKFQ0=;
        b=h3Iw9Q3QExUrc2db3WRwkQ6/3aLsFyF8o6lgmcB2md0VIHqDhT3QxdwVeHuBqmFBVL
         3rOg7qqlhAj0hHLdHBEwTUDLm8T42l5NEaq23oGdasygTF4323qR/fCA11zPR3/b75k3
         FRWOzoM98vzakbosgj0lBG9GPtfn0opZmlvVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/nmn65sTA/9WHHWguInPwbP/p0T6P0lQckSZaFRKFQ0=;
        b=HNvgJOeIGMqUcZVXGKlXhaVq/6V7fiATathbkYrI36kSeBk2Zg8jiJTGKWubPEerA3
         I4PxzX3F7HSO1rO1MUxE1+11UyxLBO71oEq2cuEBxcoihivBKHo8vcjCx3M8buW2hwjM
         C65vrCR80P/iHUCWpzsO4fFaNMWWya2PZu4lSdTf5B3SY4MKRVSb+NWLGU7tyqRlLYkV
         ih0B355zx6puvoWaebJvRiTpRkACFMIV6h/jWA21MrigWE10WWi23hg8XjAfS38OaZKl
         m2sFS6vFVuRf3YjqDXgul5zS9UyQALtSjqnkxEZ8Vi2DOBknbN9PnCIgYmA3EhX23PN5
         VNfA==
X-Gm-Message-State: APt69E0POT3eWA1QcTbQv+YRDqNoq5DrF2ITtuhD/zzgXqMzHdTBcTYE
        EHMvrLAycb+EvW3yBdnbjGwWsw==
X-Google-Smtp-Source: ADUXVKLrikJGCs8GqZubOcGh4acBbILukR7Rgj7Crj6EebcCPs+A5+2CTSLjUFLRhDg7IeKMkb1WrA==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr18453637pln.290.1529402106091;
        Tue, 19 Jun 2018 02:55:06 -0700 (PDT)
Received: from localhost.localdomain ([106.200.222.147])
        by smtp.gmail.com with ESMTPSA id c17-v6sm21182034pgw.11.2018.06.19.02.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:55:05 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        vinod.koul@linaro.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 0/2] hwrng: Add support for qcpm v2 hwrng
Date:   Tue, 19 Jun 2018 15:24:28 +0530
Message-Id: <20180619095430.26358-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for newer version of hwrng as found in
Qualcomm SoCs. To do that add new v2 compatible string and driver_data
values for v2.

Changes in v2:
 - remove table based approach and set the init/cleanup routine based on
   driver data value

Vinod Koul (2):
  dt-bindings: rng: Add new compatible qcom,prng-v2
  hwrng: msm - Add support for prng v2

 Documentation/devicetree/bindings/rng/qcom,prng.txt |  3 ++-
 drivers/char/hw_random/msm-rng.c                    | 14 ++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.14.4

