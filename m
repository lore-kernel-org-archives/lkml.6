Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0DB2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvPEi0u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0DB2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeJAQtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:49:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbeJAQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:49:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so11583386ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vAd+1H4xQMsX9APMcf4ukpBD4M8j9+3QVW6By2Li820=;
        b=YvPEi0u8CY+VCJleEOco3cm3nJU1fGOHxEgg4dlbzCjdDLQox4frQ284XsU2pmE/xk
         q/dIrYgytLwFTs/dOKIfBkclVf/9P2Kk4rQrcaH88Jc+dqinHmj6rwICMepApF+P9zWy
         eKyK84Tvw/gF6hhp3hNgWsd065sk7gSixk7hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vAd+1H4xQMsX9APMcf4ukpBD4M8j9+3QVW6By2Li820=;
        b=KDfd3EVhz/40d8QvLOe58Hk6Al8bZrg7D0ntYzuldmKrhhTaGFfgV7Vj5JmxvgxujT
         q7WuhQZZclnY3N+LJHEYq71ztaQB7rWuMmEzjceBEt/6kHbw5HtLsYZS+SjrHppBXUKI
         03JnOHQA16XFgfl/eV4ac+ZV1d6uIYPHFcSMXRshug1ooCAYzXXZ9vH097uTt9mhynyt
         23Gfugs+vnV7dZ9sWwZEoCzNI1B+k+TmNuG7H8z5k0D+/JFjRtVH/ph2x5Br1lI8jzDM
         gfiNVmpJrD/oe+ZGUTRoSCtOHIKOKoUrYyaahEmieUPlro0wSKbO5SLgUaPFvxInotCY
         c4bw==
X-Gm-Message-State: ABuFfojavOp+/Zcp42G88qWRrab6vyv7MGh8E/0xILrZE29RBVFxwo6Y
        syhqXsfh31J7OagINePgbAmBlkp511Y=
X-Google-Smtp-Source: ACcGV61c7IjeNXmvbRgn/LMczGwpShTN5iFDrYiLLhtoRD2480zKKZVjxLGZxBVTxOhpz2rQ056hBA==
X-Received: by 2002:a2e:301:: with SMTP id 1-v6mr5920278ljd.62.1538388721024;
        Mon, 01 Oct 2018 03:12:01 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r6-v6sm2480307lff.0.2018.10.01.03.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 03:12:00 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, elder@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Date:   Mon,  1 Oct 2018 12:11:16 +0200
Message-Id: <20181001101116.27281-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
to select it, not depend upon it.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/slimbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 9d73ad806698..9cca2c3559f2 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on QCOM_QMI_HELPERS
 	depends on HAS_IOMEM && DMA_ENGINE
+	select QCOM_QMI_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
-- 
2.17.1

