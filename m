Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422E320871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wXGn36fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422E320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbeKLKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbeKLIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CD221731;
        Sun, 11 Nov 2018 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975245;
        bh=O/6OSDq2hPNWDbAMujHW7PrQ15PFoelAHOsQnJzyfYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXGn36fd3hxQAOG/5XIXZAypm1SvUv5JBWxKiH6+9exJWwiRtK3EenIJ6lBDGGDbO
         /bajAt0pMrz3KvazsAczhedC7h1EUOBW3RcRAWASaPeox0olgOZvtNrS2pAvmL/HN7
         /CIyus1pmN2jAcFUA/egM1MHfpyLdNI/h6iHZFYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/361] net: hns3: Fix ets validate issue
Date:   Sun, 11 Nov 2018 14:17:23 -0800
Message-Id: <20181111221633.201598990@linuxfoundation.org>
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
@@ -73,6 +73,7 @@ static int hclge_ieee_getets(struct hnae
 static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 			      u8 *tc, bool *changed)
 {
+	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
 	u8 max_tc = 0;
 	u8 i;
@@ -100,13 +101,14 @@ static int hclge_ets_validate(struct hcl
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


