Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C7920846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtihZ/8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C7920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeGZLti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:49:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeGZLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:49:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so1188909wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DI/wSPD7F+AcJW70vQ+seGId4F7K4t/PGOtffhZLKfE=;
        b=XtihZ/8mhmMsaTRuX1zP9Obyp8o6avRh+h8hI/m+sDi5c5sydUEIBRnl055JUVTJfD
         9IvI5w43TUckrUUzF2iGQRHbC8kLqgN47z/9qtGXPaJsDmPwAI0SofAajlc7qPCxKyn3
         wAOuvhjIPaEs27pnnT0DWS2msFhwdOqJ4DpDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DI/wSPD7F+AcJW70vQ+seGId4F7K4t/PGOtffhZLKfE=;
        b=fNaBHJeiUuV8S0QqnjgjYfmGYYFZ9yiL5oVD3LcH6V45Vk04PsuxkzCSykw+0P3IgE
         kNtZi7D8V7NXj/QmX3MmLSuly8OpF9wk1UNQ8kipX+Lkm3cMFRC7d32Hrv8Px1MuM8Fk
         +5JxIhBWVJhhc8G2zMtUmohq4ZHZ0vdI7K/NihQHa0s85LbY67DVXV/oAglJexujbZmt
         6aK/ampuRcA9yMNsNbxM29v7EczB/jgMPfrI+UgnXf6Soxxxiks0QSTcbWsTYt68Empk
         rcMcPvdVz2wcRoJLpgtSzlvzTywRd/RRZPHWQBqf139JfYsUnhxi7GyaBD5JhnXUqMTa
         NUWg==
X-Gm-Message-State: AOUpUlH+tl5TE5ORVcjWOesDBC5nP36egXGq4y0puuNEZ8jzyhjCBJDG
        1bCyhmhIFJqxNsAUJAu2QtJYBW4P6Gg=
X-Google-Smtp-Source: AAOMgpdU0G4Xke6uhadZ97I4II+wZG1sC2LDMJMUbDvjew4rBQv0vGQcppVR2RkKtxyAEkoNzHfuAQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14-v6mr1063747wro.241.1532601203947;
        Thu, 26 Jul 2018 03:33:23 -0700 (PDT)
Received: from localhost ([49.248.197.57])
        by smtp.gmail.com with ESMTPSA id a11-v6sm739473wrr.81.2018.07.26.03.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:33:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] thermal: tsens: bugfixes, cleanups
Date:   Thu, 26 Jul 2018 16:03:07 +0530
Message-Id: <cover.1532600791.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.GIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another series of tsens-related bugfixes and cleanups to prepare
for IRQ support, among other things. It applies on top of another series[1]
that did some code consolidation to add support for sdm845.

[1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t

Changes since v1:
- Fixup a couple of typos
- Add review tag

Amit Kucheria (3):
  thermal: tsens: Rename variable
  thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
  thermal: tsens: Fix negative temperature reporting

 drivers/thermal/qcom/tsens-common.c | 19 ++++++++++---------
 drivers/thermal/qcom/tsens-v2.c     | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.17.GIT

