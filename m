Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F16C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1BB2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqO/PsOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1BB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJAQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:33:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35656 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeJAQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:33:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so4247225ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BIIerfaMuYy/H2XrI5vP0uKhy67zD6i/qSCj/DI2DTo=;
        b=YqO/PsOaGAykYhj4InPV03wo04d9miyNaf/qDAaAm1InzPCPcBZOsd7UxdWuAru27V
         fSnMBd3H/WReheoND4sCjEc59YerwQrIHd8jFIFMEGcAca43q1yx05imO/jm2kEwovhj
         Ewjh7W5Wp/mPCmbm++m//A9pJv4+kFHg52xUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BIIerfaMuYy/H2XrI5vP0uKhy67zD6i/qSCj/DI2DTo=;
        b=hYZfogy8rGjdx6bqdwi+kcV2rdSu8Xe+DAsZoAflbWqfb1+iyZ+cwpSuafc/xX7suF
         ADBJSCzYmzMUg2gawgRMHq5YqMaSJXGPZz47cVWg0A6WmoXAGAfM6eJnIwsCC7g7wp8B
         deg4eTazkBPISUrQw+pGepc/B3vPiNpBf406DDUblgtPa8f9nxb8mxZu7gBj95/OhW57
         0NpraB3/zqAJqci8o4egfJToTo4GgASayaN3JegjLrVMtjmQ3zP+azyTd+ECPrdBKNFo
         sxrzYgN/ZDidEWdWxRdNa3QFR/E5qYiJl/osTi+NaisiQgw2WJjSaTAMIhTMyir5Fvf9
         EP2Q==
X-Gm-Message-State: ABuFfogL80FRRC0WnWGv9Iei7KL/GqXZs3jc3spQYe5r02jV6yRFaiiG
        wp4umcRUk1c1dE3XYl25q466pg==
X-Google-Smtp-Source: ACcGV60CWe8JXSA6WBOlbwJtN484cuZXOXA7iQeo/1tPolRJODUrY9Oo+5rdU85Gs3+32PCPtc3eJw==
X-Received: by 2002:a2e:2b08:: with SMTP id q8-v6mr5906736lje.128.1538387771343;
        Mon, 01 Oct 2018 02:56:11 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 71-v6sm2651625lja.90.2018.10.01.02.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 02:56:10 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     bjorn.andersson@linaro.org, elder@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: Drop help text for QCOM_QMI_HELPERS
Date:   Mon,  1 Oct 2018 11:55:54 +0200
Message-Id: <20181001095554.23815-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help text is visible in menuconfig, however QCOM_QMI_HELPERS is a
hidden kconfig, so it is not selectable in menuconfig.

Remove the help text so that it is more clear that this is intentionally
a hidden kconfig.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 684cb51694d1..fcbf8a2e4080 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -75,11 +75,6 @@ config QCOM_QMI_HELPERS
 	tristate
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on NET
-	help
-	  Helper library for handling QMI encoded messages.  QMI encoded
-	  messages are used in communication between the majority of QRTR
-	  clients and this helpers provide the common functionality needed for
-	  doing this from a kernel driver.
 
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
-- 
2.17.1

