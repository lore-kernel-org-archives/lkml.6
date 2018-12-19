Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E620879
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7ivjV5Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LK8ObdAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeLSWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44510 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeLSWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 28C08608CD; Wed, 19 Dec 2018 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257491;
        bh=obgLDAIvXAOuZpRGvS4+MNSESm3OnhCU6evGQX37lMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7ivjV5ZBpBK9P2R/86P+JCJ+KL2k1l6QH0eHBETgj1/KkwILd0JjGNKc6gcijBji
         ebV34Y/XKRMyaAGQT9lbFQGauDCYYd073JBub1R0XddMh79m8oqCUWY/YD6+V/G3fs
         Q/QLTtoogc0Qmgn4WG8Fpav1Ns2zZVMXZAFVxVrs=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC12060854;
        Wed, 19 Dec 2018 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257490;
        bh=obgLDAIvXAOuZpRGvS4+MNSESm3OnhCU6evGQX37lMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK8ObdAKDZrOk7rukCCcdj71cvFJ/c4Qr5vLl0bHvMZnfy99U16pda84cf46vG6xd
         W37rDS9FZnM2uCCG2pmKS8xLZ+pPPzo3iJuC8hhSXLMsRLFYgtAMBHULVnBYHOphTY
         0yKRFciza0yTjxb94/nsp2upXJutZBix72QhiH04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC12060854
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 2/7] irqdomain: add bus token DOMAIN_BUS_WAKEUP
Date:   Wed, 19 Dec 2018 15:11:00 -0700
Message-Id: <20181219221105.3004-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new bus token to describe domains that are wakeup capable.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 068aa46f0d55..b9ea3c3998e2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -81,6 +81,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_WAKEUP,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

