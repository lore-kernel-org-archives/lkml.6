Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76455C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD720871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zFWpb7DF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFD720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeKLIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbeKLIR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0EE223AE;
        Sun, 11 Nov 2018 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975251;
        bh=r6zEKSKxpvdbnm78YI8XWDCM+l4oXfU0b4+uoBRt/pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFWpb7DF9TLQYoquWrUAkyJqY2atAQVRafMuDTg9ngFG6/TuYIHxJJUWfznQOYkGJ
         Rq8qJF5ViW0TzN6THn2zK6HgafV6ybZ48jmeDnYFKH0wrut2VIJygQ9lt6BGYDXiEX
         XKlf2bESMZbmqMnW9JzHFQyOmA7xD3yIb0EXT+bQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/361] net: hns3: Fix for vf vlan delete failed problem
Date:   Sun, 11 Nov 2018 14:17:43 -0800
Message-Id: <20181111221636.162080513@linuxfoundation.org>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 41dafea2af781d8e3ab8626d236b52e4172905a3 ]

There are only 128 entries in vf vlan table, if user has added
more than 128 vlan, fw will ignore it and disable the vf vlan
table. So when user deletes the vlan entry that has not been
set to vf vlan table, fw will return not found result and driver
treat that as error, which will cause vlan delete failed problem.

This patch fixes it by returning ok when fw returns not found
result.

Fixes: 6c251711b37f ("net: hns3: Disable vf vlan filter when vf vlan table is full")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4693,9 +4693,17 @@ static int hclge_set_vf_vlan_common(stru
 			"Add vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
 	} else {
+#define HCLGE_VF_VLAN_DEL_NO_FOUND	1
 		if (!req0->resp_code)
 			return 0;
 
+		if (req0->resp_code == HCLGE_VF_VLAN_DEL_NO_FOUND) {
+			dev_warn(&hdev->pdev->dev,
+				 "vlan %d filter is not in vf vlan table\n",
+				 vlan);
+			return 0;
+		}
+
 		dev_err(&hdev->pdev->dev,
 			"Kill vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);


