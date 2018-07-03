Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4D1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DD22244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLMUWO2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DD22244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeGCHVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41306 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeGCHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17-v6so696158ljd.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWq0xhxWxV67no4JMINhmTpVxhvm5IS0AvGZLSvWwr4=;
        b=hLMUWO2hi1IVoqQ0tSEckaDJRp6BTrseujsGM60HdD+bMcgSD+9Ef9l34HFs1fYJ9o
         CHIE4L/m5m9pWL3ybPjaXQvpQEOQEZCoFoynZtYwVS/uc4ctq5KgRiMi0mXUmYZRTZdK
         ACuuSBDzd3o7MZfH7l9r+XIR6YjnqIGxp2Jf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWq0xhxWxV67no4JMINhmTpVxhvm5IS0AvGZLSvWwr4=;
        b=qo8R63bigQ20IdE3HLoAlQyiED0ph7ycig4pulaabzlumKoNqvkWn+oJDe07Rb6qNu
         plLofIa2DElYQSVkF56mx7uQqIT1nNYpNIcxhKQLygyQCadS7xcPD3qw/ekxzYyd+sTX
         oMUfaqtfYu1lbUGDGWzPBGE0Ang2X8LjOM0bQzwQl0BzxIYO9P8pgZQjEMV9jlBx/Y5I
         MBqlNWOfGgeM1RTHWw4O8bcZ/rk5Qa3vYXMXRtgvhOALO1cB54q/O39bY+yI3DF1fYqe
         tvzpBO/M4ZLgzqjQVnxXFnTmS7CoZOvVz1q1UIoEA1orw7uAKTBwBw+M12cZEOf4j8Kw
         pq2g==
X-Gm-Message-State: APt69E0CFliv4MDhx2NV0PDijvceMu4uafFqmlh08oJe47aOmI8nPFEo
        RTmvoUjodhtVFd43oRRDSjBDvw==
X-Google-Smtp-Source: AAOMgpftaeTqZiwy+uJlflxntnn0BAA4VdmP4pPzitPPCCOTaQNInpMrV0/Wx23RLglC334kjq8foA==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr10891848ljk.111.1530602468679;
        Tue, 03 Jul 2018 00:21:08 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id k10-v6sm70519ljh.5.2018.07.03.00.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:21:08 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] soc: qcom: smsm: Add select IRQ_DOMAIN
Date:   Tue,  3 Jul 2018 09:20:31 +0200
Message-Id: <20180703072034.20213-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
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

