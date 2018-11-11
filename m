Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DEC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE322443
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdzPZPnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FE322443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbeKLIUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeKLIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB9522503;
        Sun, 11 Nov 2018 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975403;
        bh=gbcb2AHqd3b77dULjUivCYPIJPZUeaK+/t3rtNOzYmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdzPZPnLPRxX56qNTerlEOOz7ese5MK1tyC2xi62Q6uk1NXscUdasrcBdPTfPpJF1
         +jweXVLvS8RVwnUVnRsi9uQJUb3HFrcZIe7JOtFPMHj44J/IGYuayqCoYfX8/5Loag
         YfxuOMwHDSO/5RrXAZKX1IUk4EOAlPqvuFdi8D4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 104/350] net: hns3: Fix ets validate issue
Date:   Sun, 11 Nov 2018 14:19:28 -0800
Message-Id: <20181111221711.444890560@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit adefc0a2ff465f4ac4a88450fe69d336c8b074c5 ]

There is a defect in hclge_ets_validate(). If each member of tc_tsa is
not IEEE_8021QAZ_TSA_ETS, the variable total_ets_bw won't be updated.
In this case, the check for value of total_ets_bw will fail. This patch
fixes it by checking total_ets_bw only after it has been updated.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -79,6 +79,7 @@ static int hclge_ieee_getets(struct hnae
 static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 			      u8 *tc, bool *changed)
 {
+	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
 	u8 max_tc = 0;
 	u8 i;
@@ -106,13 +107,14 @@ static int hclge_ets_validate(struct hcl
 				*changed = true;
 
 			total_ets_bw += ets->tc_tx_bw[i];
-		break;
+			has_ets_tc = true;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
-	if (total_ets_bw != BW_PERCENT)
+	if (has_ets_tc && total_ets_bw != BW_PERCENT)
 		return -EINVAL;
 
 	*tc = max_tc + 1;


