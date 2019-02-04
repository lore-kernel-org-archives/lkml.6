Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07F3217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277382;
	bh=1TsZmDEfPdZBlAbLgVpDfDjnyTbA3ZylLR6LM/4S8uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lG9aVeLKFY0kcThpizF3zAKELjup8tLq6xCO4BK3fj1fbK2oEeb0tWV7+ilsPZkaJ
	 vk85LAaPou/VI5owkOzxFzvSM3S4YeNfcEacFq+jAObAD0LYsaXXSAZ5OwqOkMrZi5
	 YzYxmtWY+z/B5jr5BLF0dcxyhUDvSD3MHkLdL5GM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfBDKtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730942AbfBDKti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07006217D6;
        Mon,  4 Feb 2019 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277377;
        bh=1TsZmDEfPdZBlAbLgVpDfDjnyTbA3ZylLR6LM/4S8uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytipxeaV6VPGW8ZuQY63zfpiQhwolrq9pYLeHElN5RNKsiVYnLORBQU+TJgm1fqmV
         MSGTxBpvcySQ7+2+YIlj6ROJNrU+g6m7rv5INhxayZJBOBmVbpM0kZM7p78/CEWZB9
         5KDU7L9X/4gr5SsoOxtqpjXvvyChYG6gYu+anUiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neo Hou <neo.hou@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 49/74] gpio: sprd: Fix incorrect irq type setting for the async EIC
Date:   Mon,  4 Feb 2019 11:37:02 +0100
Message-Id: <20190204103626.062513052@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neo Hou <neo.hou@unisoc.com>

commit f785ffb61605734b518afa766d1b5445e9f38c8d upstream.

When setting async EIC as IRQ_TYPE_EDGE_BOTH type, we missed to set the
SPRD_EIC_ASYNC_INTMODE register to 0, which means detecting edge signals.

Thus this patch fixes the issue.

Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-eic-sprd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -379,6 +379,7 @@ static int sprd_eic_irq_set_type(struct
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;


