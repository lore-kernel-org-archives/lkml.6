Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A8020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsESchzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A8020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeICQ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:57:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeICQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:57:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so498334wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZVnuh9gFYa4yk0/FnKl5UxODP7+cUhaNKWpIy0gn4is=;
        b=DsESchzHZsbYaAN1j1Q/gDRigh/wgsge6JtbJkhSNBeiBn0gXsoqx4UG+2llXAW/2R
         hUpMna0sF2h1k4UMGUy/uQQkdyLb/Q+G8pnMYkNKAKnZoaYX6JeMv9yuy8U29C0i8SQa
         YlEu6dMbuTypyRw2TnSwozN5/kizlwvGY7h4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZVnuh9gFYa4yk0/FnKl5UxODP7+cUhaNKWpIy0gn4is=;
        b=a2utr97eU4RlS45YF7/mIw3T3/3YWX5if1J5NJZnmc8TjAaPlmeUVjlIIOzk5KEbS6
         FZKvcw0luZq94UY1usH7iB/+2kqRx9z/HPWQ7oMqkTV8VEor9bL2hApRONAMr1F35dRY
         8Wn79rHjwU5bkyjE2OeO0IczEHUJx9oYdbLR2A4xYgyy4AZPQnXZfy927MDHApZsmcWt
         ulixyBDBGYxbX9B6ZVAYI5dkAWscA6QV89JvVHC24sHA+niHM245hMIAm09rXZfvHFTO
         4WYT6BSpKDO5nln9Iq8eWHknNDqX17UqN1O+qP2AHG/7L7A4sWJpo/5XoKo4IKfN3S96
         xZGw==
X-Gm-Message-State: APzg51DTzaIGDiYzto5vGG2VlY8FbyaFpGXv9eOUcAzui1qcjellDwJL
        u2hKFMI396aWmY9fEHEAeetOEg==
X-Google-Smtp-Source: ANB0VdZj8BB7BXcmJBVhJ/4gvvjFNny7roZ6WjUqd2pP0WJVPSemhOz42XZbzmGulwwZJJPWZMdGww==
X-Received: by 2002:adf:9e93:: with SMTP id a19-v6mr19575033wrf.70.1535978251833;
        Mon, 03 Sep 2018 05:37:31 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id j44-v6sm27481099wre.40.2018.09.03.05.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 05:37:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: qdsp6: add compress offload support
Date:   Mon,  3 Sep 2018 13:34:52 +0100
Message-Id: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to very basic MP3 playback compress offload
support via QDSP ASM module.

Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
tinycompress library.

Adding other codec support should be trivial w.r.t qdsp6 side, however
there are other dependencies like compress UAPI header changes and
FastRPC which are being worked in parallel. Once ready will post them!

thanks,
srini

Srinivas Kandagatla (3):
  ASoC: q6asm-dai: dt-bindings: Add support to compress dais
  ASoC: qdsp6: q6asm: add support to MP3 format
  ASoC: qdsp6: q6asm-dai: Add support to compress offload

 .../devicetree/bindings/sound/qcom,q6asm.txt  |  27 ++
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 418 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 4 files changed, 450 insertions(+), 1 deletion(-)

-- 
2.18.0

