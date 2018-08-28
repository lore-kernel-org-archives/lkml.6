Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D69C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE760208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyY8Fs/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE760208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH1IyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:54:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38723 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeH1IyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:54:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id e2-v6so217035pgv.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VCgU+/yDuu4VQ9VhH+ONTtDXvBFJpH7AlkV7NWEQW4w=;
        b=DyY8Fs/YVYf/DOtPUAJTbyN2nX9bROf+CcMs4eAe800pUzLcUJHOGiPLCxi1ToiKsT
         oXr3Aq08Z3FH8rwac8uFA0HY1hMZvPtgp48eDimLfQ7FaFZPmL7kVGM3E7WvfrS4ZG1Z
         GxKMQgkmeA7sVoiNuDZ/zFZAsyPZvW6LCCV3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VCgU+/yDuu4VQ9VhH+ONTtDXvBFJpH7AlkV7NWEQW4w=;
        b=LqlV2AthtKE7aM6Aa0Ce/zgWWqGoc/1aY02zzsJfd40ZLijrfocMSm+++KnF96jszN
         gjuzUG9ksTkjV8xcq05gtyH0BzaeS6giuS0Sow1KaFZWuaLGvqGi0NOGQp+/0hMT8mzl
         e/zagrzqRhJ7I6r67T5fUbMmRaiO6JVeJ6HAu5DYQDWe5w5p/cc52ayXVRofi1PpixQ+
         LdEmJiQDTJNUtxU8rZNlP7u8H+FpU/Wf8oJY0QwMtS9XSjWpin6gjlfQF+WNHQM2wsJk
         nP0mawU1sfTNdUMuCHyAL2w4/LIMRTXs81mAcSQeaxWhhHMq/ltuk6nzA7NIn0VPzqiG
         9XSA==
X-Gm-Message-State: APzg51BLGcx1oXqIlLEiLVuMxT/tPmsmpiDWi/b/vxWbCtWySzsRlvSJ
        BNUg87zT8S1Z5c58mKUZFUWIMw==
X-Google-Smtp-Source: ANB0Vdafgef/iASisH/evnGaKGF3peo2uBVKylKhpHZ9Wr7NEjz8cW/tbvkwtV8/5PaPwCfdZAxBOQ==
X-Received: by 2002:a63:40c7:: with SMTP id n190-v6mr13127976pga.116.1535432651731;
        Mon, 27 Aug 2018 22:04:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11-v6sm46064pfd.117.2018.08.27.22.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:04:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] soc: qcom: rmtfs-mem: Validate that scm is available
Date:   Mon, 27 Aug 2018 22:05:48 -0700
Message-Id: <20180828050548.15796-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scm device must be present in order for the rmtfs driver to
configure memory permissions for the rmtfs memory region, so check that
it is probed before continuing.

Cc: stable@vger.kernel.org
Fixes: fa65f8045137 ("soc: qcom: rmtfs-mem: Add support for assigning memory to remote")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 8a3678c2e83c..97bb5989aa21 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -212,6 +212,11 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
 		goto remove_cdev;
 	} else if (!ret) {
+		if (!qcom_scm_is_available()) {
+			ret = -EPROBE_DEFER;
+			goto remove_cdev;
+		}
+
 		perms[0].vmid = QCOM_SCM_VMID_HLOS;
 		perms[0].perm = QCOM_SCM_PERM_RW;
 		perms[1].vmid = vmid;
-- 
2.18.0

