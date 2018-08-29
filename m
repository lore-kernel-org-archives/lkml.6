Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82CA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD7jWFvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82CA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeH2LxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40776 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2LxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so3520155lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtQHnawV6159KrNcAB+r9rRijDPcx3eyatNOzc6jgxU=;
        b=hD7jWFvKOXG2bg6p3bUZsSm22Yihut5Ra1DrW+Y7vyZhxq4N3kKO96yEZdxK6TSlEY
         srg4ndvygCf5Aqt6V8oKmBaDZeBC/3rfcVeAL/haKDrLwgw8jUvbnCE+3171rdva2bAU
         uE4ZgU0p/s/1cGu6OwPOCSXnbh/dh5ZYZKccQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtQHnawV6159KrNcAB+r9rRijDPcx3eyatNOzc6jgxU=;
        b=QH8iHl3YoDkeuNzkx/1KGxPqNTkq2gqWOxjWCh8JOEHknNRS3OLRBr1IFRj9AwFzBE
         6Lrx1uL2jByisIkkRrU2dhKD7P0KBtFp0Utu2+fSazNlckIQ2869ze82lYFIYM4Iq+VZ
         3ojHzH5U3FWitugA6Udz6awVvQck6ExaExVydrrRzA+UDL12JfNYkwvb02ZIYyr/5SYj
         3DbTzpYYYg+dpqTK8HEUNMmsI997e+UeRHM5F4e+BP71919bREeEJjDAxvyN7MVDropu
         pazEiQ14Sr06GmyOjGAr3E3vpTWGVNALFoHg4ZkbRDERxMk23jKL4vfNqewwowFi6LfT
         s7GA==
X-Gm-Message-State: APzg51Ba6uGqwNPe9J2maMcdJalirzx2Ul2sShgVwYWRJu/6DY3te4qs
        VBSAin9p9KKI8ywaB9JWdzcUft0fcBc=
X-Google-Smtp-Source: ANB0VdahFnvJuUI3wrX3IZx42IEDtoTH6ig2CFHHf7SyegtCgnjv4ambSYIadUVnxRRyNzfSsizRtg==
X-Received: by 2002:a19:eb10:: with SMTP id j16-v6mr3623820lfh.23.1535529465847;
        Wed, 29 Aug 2018 00:57:45 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f7-v6sm613386lfc.4.2018.08.29.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:45 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] soc: qcom: smp2p: Add select IRQ_DOMAIN
Date:   Wed, 29 Aug 2018 09:57:17 +0200
Message-Id: <20180829075724.9095-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smp2p.c: In function ‘qcom_smp2p_inbound_entry’:
drivers/soc/qcom/smp2p.c:317:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba79b609aca2..6e063202ad0b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -134,6 +134,7 @@ config QCOM_SMP2P
 	depends on MAILBOX
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory Point to Point
 	  protocol.
-- 
2.17.1

