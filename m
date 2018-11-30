Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A365C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C220868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNfo2gVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6C220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeLAFxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38167 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so2867142pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vzhe1k+4Sg0ipa3ln5fdFCWCmxq09KTUkxbptlEwH0o=;
        b=MNfo2gVn4M21WigIT/e+iaNN9ezDzgUXXWXSfwDo6u8q7wl0e60KnDGwCVXDsPm4hw
         vGgJ6SDizOsZu+A7J39csL3PzLfeo7a8ZE2fACs5tsPKjnE7IciTWbA3BpmortyQr5Zv
         0CwpP4AXmrzSuXAd+4YgQQMaw597TfE0vRN+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vzhe1k+4Sg0ipa3ln5fdFCWCmxq09KTUkxbptlEwH0o=;
        b=cmOd9C4jOv9733vSgxrIYqgmp8Eiobb5Stm07/gooLWPg4DeBvcTN6hTebKSzhhhot
         mrn1e1iu8SwehJoL0oREHrubLUsoFr/a5joWDChKk2sTBPEk422SpNyhB5DiGG573qB8
         dfWzlZz/LQFDkcFAJqSlHfMc4MPjKgiJ+B3nwR3qUnB3LsviJIeAPwtDDBQTccTd75fU
         p5ZgbW4MZ3ijyDzy339wm6YLZFTgsnpHeB/X3nSlc/kP1AE2PTJaqu2Id/MxVtcoMrtn
         5V2sKJTii1CXABXlSRriCHknsotLzyiwYI07gsojtldtrQXuPmoly6u80tTK76nVEvqt
         nheA==
X-Gm-Message-State: AA+aEWab1YjS7MhjIzbvCE6Iz5di2t50eGP5ZW3kXdcAtJMEBmZAmag8
        u1gM00waNwu7yQfn5ctY/vkc+49Qsqw=
X-Google-Smtp-Source: AFSGD/W3ekytdVJf2nhR+dvTK42U7K/Xnadujo5YqyNEAmBTMNMTRtiirtvTtCqBqMduV3Ba7VgQyw==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr6786256pfp.117.1543603392931;
        Fri, 30 Nov 2018 10:43:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:12 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] coresight: etm3x: Deal with CLAIM tag before and after accessing HW
Date:   Fri, 30 Nov 2018 11:43:05 -0700
Message-Id: <1543603387-32645-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves access to the CLAIM tag so that no modification to the HW
happens before and after the CLAIM operation has been carried.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..6f30d52da9e4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
+
 	/* Turn engine on */
 	etm_clr_pwrdwn(drvdata);
 	/* Apply power to trace registers */
 	etm_set_pwrup(drvdata);
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
-	rc = coresight_claim_device_unlocked(drvdata->base);
-	if (rc)
-		goto done;
 
 	etm_set_prog(drvdata);
 
@@ -422,8 +423,6 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_clr_prog(drvdata);
 
 done:
-	if (rc)
-		etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
@@ -577,9 +576,9 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(drvdata->base);
 
-	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4

