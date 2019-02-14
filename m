Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18FA222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anbCKvZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbfBNIby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:31:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfBNIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:31:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so5408587wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aETyhdkQkvHWXNSQya3Fc4RoQ2actTCZCaWOfp10vwA=;
        b=anbCKvZm/IP+ag09X8eJe+Ob9itm7kKokx4A+I+60wRIRJI5tbcKKXlGZyDZO2bTz5
         9qC0Zy+6BnhiwnBF4cK9TxA0oM6nzTxvwxw0X3iC5hPIHZE5Fi5zefarkf7RMCObXIim
         7ffZ18mf+myGq4RncGg4OZHd7ZdIlQKGKHZBtF2VHgIzKLBDTDGyG55VBytDjsxgsyCh
         2pGhBSF9rRqaFHX2Q4fmBDZ/OPa/3DvtJkfSy9Or7dJMnnKY7UzT8cfF3oB1jaI9JWgP
         u/OpFhg7L1eoVShSIpeP4KRcK4AugdFl76ZxBbu0zaNgFt6EH/cJLEiaP7tnKKtJyIX7
         fvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aETyhdkQkvHWXNSQya3Fc4RoQ2actTCZCaWOfp10vwA=;
        b=aJwG8cs3VdzVKFmluMYHUMspHcNvDkej34VLMNR2qQzUfizTOa84wIvWaXVAanQQpq
         w/3DnBfZf5lPzb4nZxNvpN3OFw7W7FppUmIZV8ljpwO/EFyTswjNF2m7icJt8rg+RPYo
         u++z/Q2M04LRHUYyIPRaKh39q0/1czQgKm/xI2RN02QEfW3Uxj2+qP50z1OM8eTzzZ/p
         sbepiMGRjWarBCFUA29+6RGu0gqIax4LN1xfXbGb3G6NiXAEcBpPMDBKob0F+cbPmnQG
         K3vpAFh3Q59LQiDI8LZ16qlqwJIk09Qe8YMCP/FV+lXesmfbEV1A+swhgnSeuk+wzW5t
         a57g==
X-Gm-Message-State: AHQUAuZQwNJnAetlOArCUSJUYlO1iHsnI9Sp/RiV6KPnxDcmJTxRw8Td
        oNn6yQheN12RTKz538aK3D9XmQ==
X-Google-Smtp-Source: AHgI3IZ7812mQTxIJVCEVVxJtGQDYnJ315u3RayMIzoSbYNk5JJxfsxdD/EDap23VT72W7ZwAyrpfQ==
X-Received: by 2002:adf:90af:: with SMTP id i44mr1721227wri.222.1550133109095;
        Thu, 14 Feb 2019 00:31:49 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
        by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 00:31:48 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        benjamin.gaignard@linaro.org
Subject: [PATCH v2 1/2] ARM: errata 814220-B-Cache maintenance by set/way operations can execute out of order.
Date:   Thu, 14 Feb 2019 09:31:44 +0100
Message-Id: <20190214083145.15148-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
The v7 ARM states that all cache and branch predictor maintenance operations
that do not specify an address execute, relative to each other, in program
order. However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation, this would
cause the data corruption.

This ERRATA affected the Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.

This patch is the SW workaround by adding a DSB before changing cache levels as
the ARM ERRATA: ARM/MP: 814220 told in the ARM ERRATA documentation.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
version 2:
- limite help lines to 80 columns.
- Add  Arnd Bergmann acks.

 arch/arm/Kconfig       | 12 ++++++++++++
 arch/arm/mm/cache-v7.S |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..72b6ed478d1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1227,6 +1227,18 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
+config ARM_ERRATA_814220
+	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
+	depends on CPU_V7
+	help
+	  The v7 ARM states that all cache and branch predictor maintenance
+	  operations that do not specify an address execute, relative to
+	  each other, in program order.
+	  However, because of this erratum, an L2 set/way cache maintenance
+	  operation can overtake an L1 set/way cache maintenance operation.
+	  This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
+	  r0p4, r0p5.
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 2149b47a0c5a..7ff7b4c197cc 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -163,6 +163,9 @@ loop2:
 skip:
 	add	r10, r10, #2			@ increment cache number
 	cmp	r3, r10
+#ifdef CONFIG_ARM_ERRATA_814220
+	dsb
+#endif
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ switch back to cache level 0
-- 
2.15.0

