Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D0206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucD+hgeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751D0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI2FGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:06:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38249 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:06:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so5223868pfh.5;
        Fri, 28 Sep 2018 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeSyMQC0q6RazFDQsvjBM/cYipk/l/9tgd4ElUfYbLs=;
        b=ucD+hgeTPUf3YiMQheY9Q6fFoOk8IDYoHJbrScBo98L8iAemhL/hWGhJo+lzO1hsWr
         1MQwpvmMVN0zDQLl26jXLJVCUQHgFjm2Co+Waj4g7FnVL93MqL93fhjOfHjNWV9fgqZQ
         nKOoAdYsK+pOj2Y990bLi3Vdk/J65ji2PI/GUnNiOxbTKfEcHM/9c8lemDfmAp9aqWHK
         CJ4hCSnD3LpqD2FtYlpmVoBgH6B2BWVxhfOM7USpXck5YNJH5CBRywzbVWT/ooGOuiSp
         pfOo99+BHhHP9HnhXlyVx+K83JxKeqYc9a1ZaZOZtm5aKS2pCCKta47k5jjeqHuMxow3
         oyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeSyMQC0q6RazFDQsvjBM/cYipk/l/9tgd4ElUfYbLs=;
        b=Pzj6r8qpq1ka2M0esrzO/qsizfu33qm5tpOfii11nrGZrBjEAE8wXJHyD2I/HYLJsb
         OPmoYR6gWTjNCBLqx+N/i0QtTbr1IigRrmbE8a5KAjEBMe0gvdaFgcpQ8ZPfsJrVrG2I
         qpWj0qfYCx5gLQbEER217x5acJzxWcw0RQ/sSUeuB5vFiWABYpTb72rjPogAXrJkl+S0
         dp1SqL2d4vI8lBc5PSi2hXXrSL/V5tawkMElYECbJSlvsHttO69B6RWVzS8Uc9QmTA/f
         RPx/Pqa56yuTrzmPNQqf6oxE31yMs3JXH5/wKgM7dZnPw9UUs08HOha3Tpj/1CHvU4BZ
         Gfxg==
X-Gm-Message-State: ABuFfohv1+7J7SYghER6zaRcMpKJ1ArLVBjM4STQzPqX0F+/+/30WtJy
        McCu6ywDwSSOonS5UVAhqIw4vQM6
X-Google-Smtp-Source: ACcGV60XwiD/85bwxVy5Em0P/QbKB0xsn3KI+kcfcvwcntPBTIBbSk63TSEd528noA38bh6ozHyuaw==
X-Received: by 2002:a65:64d5:: with SMTP id t21-v6mr585085pgv.428.1538174415226;
        Fri, 28 Sep 2018 15:40:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t85-v6sm10655525pfi.73.2018.09.28.15.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:40:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kdasu.kdev@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
Subject: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date:   Fri, 28 Sep 2018 15:39:44 -0700
Message-Id: <20180928223947.20751-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
same controller, make it possible to select the STB driver and update
the Kconfig and help text a bit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/i2c/busses/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 451d4ae50e66..fc3fd987f718 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -432,12 +432,13 @@ config I2C_BCM_KONA
 	  If you do not need KONA I2C interface, say N.
 
 config I2C_BRCMSTB
-	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	tristate "BRCM Settop/DSL I2C controller"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
+		   ARCH_BCM_63XX
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Broadcom Settop SoCs.
+	  I2C interface on the Broadcom Settop/DSL SoCs.
 
 	  If you do not need I2C interface, say N.
 
-- 
2.17.1

