Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B8C46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B042085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsOtfgvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B042085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeKFHsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:48:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbeKFHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:48:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so4849955pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kbp0i0noSt5NS9yHP1ZXGvz/6q60ME6LEo2FEAmuylE=;
        b=QsOtfgvS2Rsn5IcjKaOBwNBUMSEQ2nNCSl9poPHNXc53jPjaFfva3JOeUkoVXs3Ezt
         xNTccmekK6m24ej7sEm+pEsnVADixWtuIYkHwOnWRtYCJO1ZzNWo2tz4PiO8BuCTcI7c
         sktIFH352p1/Pk1hg9K9zwZy3UgvOFCC3gwmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kbp0i0noSt5NS9yHP1ZXGvz/6q60ME6LEo2FEAmuylE=;
        b=IVckuM3UgDFL2x5kdp1ARIINZEMu8HqCzN62wcpr628t4KUWr55SNq6jVL8b40s2U8
         +CB5ThrvrlRTt+aHZ4R67YcOo0NoFxI6Y6ORa5sZvnLtfRxgMDOrJ+Rc0LWll/TWkXKd
         inn4huA4VrMKVDUzf+7BbKECBIKXjrw6WbWXZGaICLXv0IvqnbcYT1IQQ/v59r5O+aj4
         HSG5R6BziCaH/ulcCfCeQKPmeciM2RWQl5Gmfp/2Uo8OEwvvQVosFwIE/cv/0AcYkZ7d
         2JqpvOrIRpf3Mi7RB8aVOcetPkMglBiKFvmYmmjsKfb75eupt36/FDVNcRjqQVpCev4t
         2Ecg==
X-Gm-Message-State: AGRZ1gJEPTLWKZ477BkNMpTpXeWi4/HAbrMo3XiF35xXs2ljbe6h6GAN
        2E1Ab27PiubbBDGZNTSwyRzakw==
X-Google-Smtp-Source: AJdET5fEZD9XCLslAfD41sfD8HBUwQhLoukQ7ws5GPMnuVVHyDqyXpzLd3l/hQmPvKKbgRBeSWfIrA==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr19262077pgh.129.1541456796798;
        Mon, 05 Nov 2018 14:26:36 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q26-v6sm58669804pfi.165.2018.11.05.14.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 14:26:35 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] coresight: etf: Release CLAIM tag after disabling the HW
Date:   Mon,  5 Nov 2018 15:26:29 -0700
Message-Id: <1541456790-28282-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rectifies the sequence of events in function
tmc_etb_disable_hw() by disabling the HW first and then releasing the
CLAIM tag.  Otherwise we could be corrupting the configuration done by an
external agent that would have claimed the device after we have released
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5864ac55e275..a5f053f2db2c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.7.4

