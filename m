Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11120858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="apoOolr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeH0PXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:23:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38569 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH0PXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:23:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so12078097ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IW7gPFbp3Cs/xxYQ78q60NQhn2rxDLB3vVZCg9hJpfg=;
        b=apoOolr/9TM7NmQflaNp3bpWWKcSz745g2+GqW34BVmSqNSCSIys0ljgLb+jeLP5KW
         lh7tK1UEniAdObHGYzt9H+FDNSMdp/syrGYrCijDLyxX9THu0g8CKK5WCsxqQWLJNqrj
         44pZH3fqNQ/V5/MnWtSoa6IH/Vq3FGHLVK3wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW7gPFbp3Cs/xxYQ78q60NQhn2rxDLB3vVZCg9hJpfg=;
        b=PJJBprkl8wJ0LD+U0bwWstXhc7Ua+ZyzrIDxaqSZFXkpeUmfxVX/Cp7YkDIviEhm0D
         bwTd3dp25DpgnZ73USaP3PlvFyHK5yERn/jnJYdKRehcoSdU7g6E772GqwHKttoXh+br
         gIsc1lEIGEQma4B9DTsalpnFOoC6pdO//ZFWfuSppH8M/m/dy/7h4YOZzEQDcb6Ss14h
         hdSHsK0vtMLBduM1ZbX0vTps4sJaQ8Y2BXh7urE9G0vvSKRNPwR27al32jFbcvQdRFMI
         lnuT3DsGrt48LV4qZKKF+07XoG0E4eHhJDc6sab3VNK2ZxO/heKsgxLLclIp07zObQZm
         ayDg==
X-Gm-Message-State: APzg51DD780KRpzFgzEhtqXey/VGjdg5g13gqClnPI0JXRKSdwvAS+i4
        rysYOl+kdxjdqERctN42rxGQEw==
X-Google-Smtp-Source: ANB0Vdbd27tBhxXbnG26/bCvQXkbWTYuSQyhia9WqhUpFkSKzGFWtcfIfNQk6w7w2W6ct/vbRB0w9A==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr8069666ljb.91.1535369807019;
        Mon, 27 Aug 2018 04:36:47 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2724498ljb.33.2018.08.27.04.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] soc: qcom: smsm: Add select IRQ_DOMAIN
Date:   Mon, 27 Aug 2018 13:36:02 +0200
Message-Id: <20180827113605.9594-5-niklas.cassel@linaro.org>
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

drivers/soc/qcom/smsm.c: In function ‘smsm_inbound_entry’:
drivers/soc/qcom/smsm.c:411:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 6e063202ad0b..7da6e67c7ea1 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -143,6 +143,7 @@ config QCOM_SMSM
 	tristate "Qualcomm Shared Memory State Machine"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
-- 
2.17.1

