Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A79C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu8V9hz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A79C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeH2Lx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39284 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2Lx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so3581988lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3U44mP/4tqzk7kSCJX0RAmaX14j3xW0Xy2yzquNCJRQ=;
        b=eu8V9hz9ES6iPGUJKMQcjeSNZfOxYOoVuEiZ8wPZUNaXTdHf1L38b3TuFuzs3EAXNr
         7cghXi1vB+ODiC1UJ9tdbT+WHXcTdYDEHWmO+FQ1GS14ZjDZ2JqDWq948IABZjLFUjjK
         fKnLBr4UvCg5dZGpKcql2qdNPExdEljrvQab0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3U44mP/4tqzk7kSCJX0RAmaX14j3xW0Xy2yzquNCJRQ=;
        b=GlHUkYI0s1Ve2WGWNrI76iX9ANZ0UV+byoKk8DVJOQD7ixi1f/hsRbsaq4rqnZ/eeG
         uuPUFa68fTKY/6JsmSYQ/ue3qiLY6EVpIGeTIiivZYENcCgW+s1boqPqHL75kDhE0rG7
         vLRGMT2EwR5XTi6+F+LPpXLrth7DZqjdD1E+trA2RYJ/3HamOpGSvJMSf9mxTD6HJ0Ms
         qAa8S5WDJZ1ZgL87qx0tD2/qPzQc7izt2iIRy4SJ1RrMW1IEbxcVt0Cpm3SkYMBI8icM
         cC9SgCSzWHl1I6Zvcz4TNPic2+cMAnnYw671i0YnfTAEZ9/VK7NGXGDST7OwHaXSKeEL
         AueQ==
X-Gm-Message-State: APzg51BESWzpl1QQDswqcQ24cEapWOcbBFLOEbbGda1CfWMqaRx/2yJ0
        ENisvmbfQnLxIxRl2csi4zydBw==
X-Google-Smtp-Source: ANB0VdZR1JlrxcNUSSbWBNVFqXtdcqpbi85NRRCXmIoFLLEIJx1xjitdNOub8DcBDHaDeMbbM7EmxQ==
X-Received: by 2002:a2e:6e04:: with SMTP id j4-v6mr3553174ljc.61.1535529468214;
        Wed, 29 Aug 2018 00:57:48 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f7-v6sm613386lfc.4.2018.08.29.00.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:47 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
Date:   Wed, 29 Aug 2018 09:57:19 +0200
Message-Id: <20180829075724.9095-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_SMD_RPM builds perfectly fine without CONFIG_OF set.
Remove the bogus depends on OF.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7da6e67c7ea1..ac657164a136 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -114,7 +114,7 @@ config QCOM_SMEM
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM
-	depends on RPMSG && OF
+	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
-- 
2.17.1

