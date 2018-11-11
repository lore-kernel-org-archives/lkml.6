Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B9C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC7A208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCLkfw0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC7A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeKLIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbeKLIRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5072921508;
        Sun, 11 Nov 2018 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975266;
        bh=u0dtmCwtqTh6aExnUVqTXTdsDRvzGKEWaGODn41TVyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCLkfw0McFynI7jwYvolWuG4/NEGiVvv83zEMPcZ/GeKGvAJ8v6B6XhnhBegEgDOM
         NzQNbNhteQXbsVGZGPnghmAuhuZbx+dMpDYSb1xmPeANoDSzAQG011V6JoguxQyDj5
         VH/O7Wq5hDvIfvspB1n8cahmZo0jUhvhLx96qUmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 157/361] irqchip/pdc: Setup all edge interrupts as rising edge at GIC
Date:   Sun, 11 Nov 2018 14:18:24 -0800
Message-Id: <20181111221642.568880628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lina Iyer <ilina@codeaurora.org>

[ Upstream commit 7bae48b22c8d38c5cd50f52b6e15d134e2bb3935 ]

The PDC irqchp can convert a falling edge or level low interrupt to a
rising edge or level high interrupt at the GIC. We just need to setup
the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
as IRQ_TYPE_EDGE_RISING at the GIC.

Fixes: f55c73aef890 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")
Reported-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/qcom-pdc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -124,6 +124,7 @@ static int qcom_pdc_gic_set_type(struct
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		pdc_type = PDC_EDGE_DUAL;
+		type = IRQ_TYPE_EDGE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		pdc_type = PDC_LEVEL_HIGH;


