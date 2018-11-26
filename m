Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1FF20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrlvsGd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1FF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeKZV46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeKZV45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B9120817;
        Mon, 26 Nov 2018 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230192;
        bh=kqOHyUYiKbTMgpfmeihfN78e8vvOcaR/IoaL3w0F3Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrlvsGd81ie+N/HNMtHWvkWFVodgfEoYufofNKW4SOwiZ+J+LDCZ7gBO0jRxTuwVA
         jrRVnnvsS5QKE65mkgVN0C/8N1j5Bse076AcYmh0dmnT6epYcHCrDxmv+7hBA72pK+
         NTRdPtOGmPMwUyEIW2q28632aVz2KtbXaWOcu3Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 009/118] net: hns3: bugfix for handling mailbox while the command queue reinitialized
Date:   Mon, 26 Nov 2018 11:50:03 +0100
Message-Id: <20181126105100.212270897@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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

[ Upstream commit 3c88ed1d798da355859ca083d3884a16ce0841f2 ]

In a multi-core machine, the mailbox service and reset service
will be executed at the same time. The reset service will re-initialize
the command queue, before that, the mailbox handler can only get some
invalid messages.

The HCLGE_STATE_CMD_DISABLE flag means that the command queue is not
available and needs to be reinitialized. Therefore, when the mailbox
handler recognizes this flag, it should not process the command.

Fixes: dde1a86e93ca ("net: hns3: Add mailbox support to PF driver")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index f34851c91eb3..e08e82020402 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -458,6 +458,12 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 
 	/* handle all the mailbox requests in the queue */
 	while (!hclge_cmd_crq_empty(&hdev->hw)) {
+		if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
+			dev_warn(&hdev->pdev->dev,
+				 "command queue needs re-initializing\n");
+			return;
+		}
+
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
-- 
2.17.1



