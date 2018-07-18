Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ABF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL8qxa9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ABF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeGRHTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:19:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44133 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeGRHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:19:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so3416769wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g0DOXSgczu7wSClKccgqMycw+/+mjrvksb3/WAGI9Es=;
        b=FL8qxa9V799+OMFH96AMrsEgfDZYJgJTnJaUwbPGIbbR7R0oq07A7ZwMqjW/KPw0Ab
         R7zcoWB03eOTqelrjhXSroyY2u17bakhcUz18LFIuGDD1Lyj6FBLSmyMEc7sFli2nj8q
         bLb7wUPaLGJY4bAf3cVsROXNA7otESUgvCh+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g0DOXSgczu7wSClKccgqMycw+/+mjrvksb3/WAGI9Es=;
        b=CWwZ/prYf7j20Bzc2B8L/9uyoMEZcACg+/KBfX7jXhaF48bJ2fPN1zWYHwkNu4DIOs
         kyiz64npLFYMLGyoWuuuW0LToLXmZcIM8rLM/ODJtnEHMXD2rMamJYqG0BTs9oMCi74J
         4v9qZTqZMA3ezYojP4iSz4qwfUQfiyt+mF1dydk6J0grnguZ7/yTfvfzGsB6Q44UAsX1
         oc8yJARiwbnZk/h0rw654bcN2X4y4jVDzAvWaF9cYQw/YSImUjVf7JSY14TnPwfH+Llb
         shmGkFiDwCA7j8xy+xcWND66KXOG6Kqxyj2D+TC5HdBYwLEMWW1++OsqXnchFcc+bWDX
         Mv5w==
X-Gm-Message-State: AOUpUlF69tad9X4cr8jUe7rYzYG3B4eujgZ/4ux1aIps2mNyafc0mc0u
        Ln5ylsXNXeq8PtAgbqGfZC6XPqjMF50=
X-Google-Smtp-Source: AAOMgpdRTyLmO1Fc3amzXaYgtFeg/ddrNJZ+VMZCEVQPn3KCvAGWlXbuT9Zh0TGNnTb87q0OPHNbgQ==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr3483908wrg.183.1531896215506;
        Tue, 17 Jul 2018 23:43:35 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2146039wmo.21.2018.07.17.23.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:43:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v8 0/7] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Wed, 18 Jul 2018 12:13:06 +0530
Message-Id: <cover.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a repost of the series. There have been no code changes since v6,
just improving comments, patch descriptions, documentation. The series does
the following:
- Some code moves to allow code sharing between different SoCs with v2 of
  the TSENS IP,
- a generic qcom,tsens-v2 property as a fallback compatible for all v2.x.y
  platforms,
- new platform support (sdm845)
- a cleanup patch and
- a DT change to have a common way to deal with the SROT and TM registers
  despite slightly different features across the IP family and different
  register offsets.

Changes since v7:
- Fix couple of typos in spelling
- Add review tags
- Move the DT documentation patch before the code changes

Changes since v6:
- Fix comments and patch descriptions as per Doug's review
- Rename tsens to thermal-sensor in DT
- Add various review tags

Changes since v5:
- Actually fix unit addressses for the two tsens blocks as per Stephen's
  comment.

Changes since v4:
- Revert back to a single fallback bindind qcom,tsens-v2 as per Rob's
  suggestion.
- Rework how old (unsplit SROT and TM address space) DTs are handled by
  needing a 0x1000 offset but still sharing common code in tsens-v2.c
- Remove the patch to added TRDY checks while we investigate Matthias'
  reports
- Fix unit addressses for the two tsens blocks as per Stephen's comment.

Changes since v3:
- Introduce qcom,tsens-v2.4.0 property and make qcom,tsens-v2 a
  fallback, compatible property.
- Rename ops_v2 to ops_generic_v2

Changes since v2:

- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2
  property
- Added a DT patch to initialize tsens driver on sdm845, now that
  4.18-rc1 will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across
  sdm845 and 8996 due to different offsets

Amit Kucheria (7):
  thermal: tsens: Get rid of unused fields in structure
  dt: thermal: tsens: Document the fallback DT property for v2 of TSENS
    IP
  thermal: tsens: Add support to split up register address space into
    two
  arm64: dts: msm8996: thermal: Initialise via DT and add second
    controller
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add generic support for TSENS v2 IP
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 14 ++++++++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-common.c                | 12 ++++++++
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 32 ++++++++++------------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  8 ++++--
 8 files changed, 88 insertions(+), 30 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (64%)

-- 
2.7.4

