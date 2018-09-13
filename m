Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA2C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B4B204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B4B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeIMTFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeIMTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEC99D10;
        Thu, 13 Sep 2018 13:55:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <wangxi11@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 081/197] net: hns3: Fix for command format parsing error in hclge_is_all_function_id_zero
Date:   Thu, 13 Sep 2018 15:30:30 +0200
Message-Id: <20180913131844.765806146@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit 6c39d5278e62956238a681e4cfc69fae5507fc57 ]

According to the functional specification of hardware, the first
descriptor of response from command 'lookup vlan talbe' is not valid.
Currently, the first descriptor is parsed as normal value, which will
cause an expected error.

This patch fixes this problem by skipping the first descriptor.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3911,7 +3911,7 @@ static bool hclge_is_all_function_id_zer
 #define HCLGE_FUNC_NUMBER_PER_DESC 6
 	int i, j;
 
-	for (i = 0; i < HCLGE_DESC_NUMBER; i++)
+	for (i = 1; i < HCLGE_DESC_NUMBER; i++)
 		for (j = 0; j < HCLGE_FUNC_NUMBER_PER_DESC; j++)
 			if (desc[i].data[j])
 				return false;


