Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E25C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16B32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL4gPNQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16B32089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeJQBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE05320866;
        Tue, 16 Oct 2018 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709956;
        bh=Dki2Phb1Zd9Wt21oMwb21Da2c56Gf0RZ5NH6C3fP+p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DL4gPNQDRfsZ0e+LC2qT0UI7sHef5fPGbpFsMmCkWbf9xISHRynFlLXiFjzbrBo6R
         qwqpScJMndGekk4tV6LgH+oQMS5vodXKFcRaa4i8DEWB97VwFLRVyqBy5cXDGYi4gH
         UkiDJC9y6kipebzha6S2WFtmZ6lVZgk18nYe+KGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 055/135] bnxt_en: get the reduced max_irqs by the ones used by RDMA
Date:   Tue, 16 Oct 2018 19:04:45 +0200
Message-Id: <20181016170518.355137729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit c78fe058879bdea919d44f23e21da26f603e9166 ]

When getting the max rings supported, get the reduced max_irqs
by the ones used by RDMA.

If the number MSIX is the limiting factor, this bug may cause the
max ring count to be higher than it should be when RDMA driver is
loaded and may result in ring allocation failures.

Fixes: 30f529473ec9 ("bnxt_en: Do not modify max IRQ count after RDMA driver requests/frees IRQs.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8501,7 +8501,7 @@ static void _bnxt_get_max_rings(struct b
 	*max_tx = hw_resc->max_tx_rings;
 	*max_rx = hw_resc->max_rx_rings;
 	*max_cp = min_t(int, bnxt_get_max_func_cp_rings_for_en(bp),
-			hw_resc->max_irqs);
+			hw_resc->max_irqs - bnxt_get_ulp_msix_num(bp));
 	*max_cp = min_t(int, *max_cp, hw_resc->max_stat_ctxs);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && BNXT_PF(bp)) {


