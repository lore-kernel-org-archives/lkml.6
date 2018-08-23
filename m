Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD27BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819A621473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeHWL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:27:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeHWL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:27:46 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25000BB6;
        Thu, 23 Aug 2018 07:59:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vikas Gupta <vikas.gupta@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 51/79] bnxt_en: Fix for system hang if request_irq fails
Date:   Thu, 23 Aug 2018 09:53:27 +0200
Message-Id: <20180823074922.442947994@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikas Gupta <vikas.gupta@broadcom.com>

[ Upstream commit c58387ab1614f6d7fb9e244f214b61e7631421fc ]

Fix bug in the error code path when bnxt_request_irq() returns failure.
bnxt_disable_napi() should not be called in this error path because
NAPI has not been enabled yet.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4591,7 +4591,7 @@ static int __bnxt_open_nic(struct bnxt *
 		rc = bnxt_request_irq(bp);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
-			goto open_err;
+			goto open_err_irq;
 		}
 	}
 
@@ -4629,6 +4629,8 @@ static int __bnxt_open_nic(struct bnxt *
 
 open_err:
 	bnxt_disable_napi(bp);
+
+open_err_irq:
 	bnxt_del_napi(bp);
 
 open_err_free_mem:


