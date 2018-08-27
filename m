Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2285CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C9B20858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F10bkLx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C9B20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeH0PXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:23:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41915 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeH0PXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:23:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so11665368lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtQHnawV6159KrNcAB+r9rRijDPcx3eyatNOzc6jgxU=;
        b=F10bkLx4vRVWo+LK+XQazzLWsguLXbosnjp990AklBvgmtBAStFQGiaFIjsVmAy60F
         4MJboP3MpTgszwQrw3NazpYQeg0XgNaKwRlAXzZC2a0ARp501WVNfOZOtmvzDjM+LVgi
         K/kqT6AxT2LT0uiQQYcEhGA5oAqwLcrTGTHwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtQHnawV6159KrNcAB+r9rRijDPcx3eyatNOzc6jgxU=;
        b=YOOeqh+W7As+Ule4gWXtcu1FoYz43bjWYQd233OHTb3SzK+aHOQ2KTTxSaXiGkcIG5
         BrlQ32ay9hAUjXwRujAtriOXA92YE5fOME7yuT+utG3gQMbOmMTUs82hqqmSzBUDcTK7
         8Bo3NFWoKihqbVCCewHOcvwYRy0afntxGEz0F/FdoW6WM88ymnKn+oZ7mPVhZpVtsZ1H
         6yigRD6AbEVUbeGSwxjY5pCI7R65uJBT4WagxCvrjUpg7a5qQrBJWn9/D9GoJGYcg39V
         539TgQBSC+xCcmBwGBfz0BbqwMVe142aItr3r6f5l5w5+YyyZUpiQKO6V/CqSh5tNckw
         jKZA==
X-Gm-Message-State: APzg51B25TBSXIKkS3ZbhAClazUN4Bv5YrDFjV1Nj9VsGAjiAN7SQsxH
        VmhxyGlRsrT+tP+5syAcZ8lS9Q==
X-Google-Smtp-Source: ANB0VdZq1ot8ORXiuDiW0ue576gG9TYZZXA4M2fS+zppmJDTco0FupWM9oGBPCYl1rrZf3e8kXZ1dA==
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr8658868lfd.17.1535369805738;
        Mon, 27 Aug 2018 04:36:45 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2724498ljb.33.2018.08.27.04.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:45 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] soc: qcom: smp2p: Add select IRQ_DOMAIN
Date:   Mon, 27 Aug 2018 13:36:01 +0200
Message-Id: <20180827113605.9594-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827113605.9594-1-niklas.cassel@linaro.org>
References: <20180827113605.9594-1-niklas.cassel@linaro.org>
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

