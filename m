Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAABDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845B820675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V1iGjxke";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P9pipIqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfBVWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBVWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27E4B60988; Fri, 22 Feb 2019 22:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873946;
        bh=vZlxdQaHolHuqHIibv1w2IYPyGyce7b5TDgg6udD258=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1iGjxkesONkB/v6jhvjOasYGbJT10FO1PmiiEvjO6lr2pcknvQNx7j9dmMwD+VYp
         wL2ZCMa+DPR0deWltksIXXNfr0rwW9iucQv7gvKJaRZoo8OpTWzXzht1s8xEyZV7o6
         vcdJKxCnarfF+oyjrWcAKHrHtrUnLFqXW6GNSe/0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 641FD60909;
        Fri, 22 Feb 2019 22:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873945;
        bh=vZlxdQaHolHuqHIibv1w2IYPyGyce7b5TDgg6udD258=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9pipIqOr3HRm7dA4JU3SmCTigrHCYgSom62/iV3vPK8XIeVceidpuIrSakDPbWJx
         O5/lKj3rgybTBjoinEkRhD5y2fJi/Zm3mlG/Cq44IKWajR/WVncuPIkUo21tLjp2gm
         WvWj3FmzWk29vMcianhhWmdsOWz1Sw5JuUXHp1SE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 641FD60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 2/9] irqdomain: add bus token DOMAIN_BUS_WAKEUP
Date:   Fri, 22 Feb 2019 15:18:43 -0700
Message-Id: <20190222221850.26939-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222221850.26939-1-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new bus token to describe domains that are wakeup capable.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..05055bc992ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,6 +82,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_WAKEUP,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

