Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F5EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23B12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWS+563m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23B12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeGRIBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:01:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38888 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeGRIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:01:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so1708598wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zA+CaE4/tiyOVpJuaIGutmNkj6mJmdf4z9o8J2AptYs=;
        b=eWS+563m5830NoL9XMxYrdFWrk9p6qk/kaQDvx0Ev5KV3oJkqBSBQy5TQK9W4LXIi/
         o2J3BkFBe96nIZUPubaTYrzxv84WIV12Pr2tU7x4m+DyahkFh6sRihj3FW9ZZv2cWiJj
         ZQpP2qd1Em/r2/NlC1aMfE9wKpqHp4+L0Hk6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zA+CaE4/tiyOVpJuaIGutmNkj6mJmdf4z9o8J2AptYs=;
        b=k1RpeHO2GKFLSPTqrv5fj/ygH/jXvCaD2w66Go+B7X82gcBtmZhuwRCg4RvYaltZNT
         EaTcw5ksDjSOlFJDkWrV3uIOJ4zv0eOGfFeD+Gib1ivZX1uW+tZAkeA/LN5nBsg/vERO
         F92zZgXZsAqVsyDRJ3a5bHaTEEX645M79oOZ/Cr237MQG9sZ7HT2ccK09hdOCouAuEkT
         9qh/yp2hdfnmmC5MzQG2xcLVcOEaOp3L+priYd0f9+R5k1UwSFF7OCztB/tF2E5IY4vN
         91oTDhij55Y68bvxWJ7VjRCCZh36J4KGyOVykUUSNL/cwa112HewFslq7mqen8dtmvpm
         muZQ==
X-Gm-Message-State: AOUpUlH5DSBL8NuCRlIPOVNpbzdgedKSePvI9jxjCFLOnUklMvEWqXSl
        85PPVezdLQrH4FSdHyUF5Y82+vv+IBo=
X-Google-Smtp-Source: AAOMgpdgOJEMgasgNy3wuSxp/Ra8UtnFHIgMUCCRKfEZXz24b/7aDUHuHumSHZ00l0yTyXqi84BtKQ==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr864798wme.70.1531898717112;
        Wed, 18 Jul 2018 00:25:17 -0700 (PDT)
Received: from localhost ([49.248.170.255])
        by smtp.gmail.com with ESMTPSA id o10-v6sm2043735wrw.79.2018.07.18.00.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:25:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 0/3] thermal: tsens: bugfixes, cleanups
Date:   Wed, 18 Jul 2018 12:55:00 +0530
Message-Id: <cover.1531898088.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another series of tsens-related bugfixes and cleanups to prepare
for IRQ support, among other things. It applies on top of another series[1]
that did some code consolidation to add support for sdm845.

[1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t


Amit Kucheria (3):
  thermal: tsens: Rename variable
  thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
  thermal: tsens: Fix negative temperature reporting

 drivers/thermal/qcom/tsens-common.c | 19 ++++++++++---------
 drivers/thermal/qcom/tsens-v2.c     | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.7.4

