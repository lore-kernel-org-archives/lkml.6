Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F150F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD9nvuJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F150F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbeKZV4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbeKZV4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AD22089F;
        Mon, 26 Nov 2018 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230187;
        bh=bmRdhKk1QDyz67zDspBTbyiyAoF6XhprrJrgHJq4NMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hD9nvuJckwPoGKA8QP9gqfJGwtK9Akk17W8e1X6OksgFetHSfr7TYw1m26SL6HCuf
         J/7L42xjiw/Zd6kidX3IYa4qe6wI4UMydt1ZEGCfcWzBVkLvbnuBFCVyi1n0mT0Ysv
         qWmFxtUIYqCq6rfQ1Qbtj+rgU1zZCrbC8v6ilLpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/118] net: hns3: bugfix for rtnl_locks range in the hclgevf_reset()
Date:   Mon, 26 Nov 2018 11:50:01 +0100
Message-Id: <20181126105100.132235886@linuxfoundation.org>
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

[ Upstream commit 29118ab962d5476fdc65fae312ac38db68092d78 ]

Since hclgevf_reset_wait() is used to wait for the hardware to complete
the reset, it is not necessary to hold the rtnl_lock during
hclgevf_reset_wait(). So this patch releases the lock for the duration
of hclgevf_reset_wait().

Fixes: 6988eb2a9b77 ("net: hns3: Add support to reset the enet/ring mgmt layer")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 320043e87fc6..5570fb5dc2eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1065,6 +1065,8 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 	/* bring down the nic to stop any ongoing TX/RX */
 	hclgevf_notify_client(hdev, HNAE3_DOWN_CLIENT);
 
+	rtnl_unlock();
+
 	/* check if VF could successfully fetch the hardware reset completion
 	 * status from the hardware
 	 */
@@ -1076,12 +1078,15 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 			ret);
 
 		dev_warn(&hdev->pdev->dev, "VF reset failed, disabling VF!\n");
+		rtnl_lock();
 		hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 
 		rtnl_unlock();
 		return ret;
 	}
 
+	rtnl_lock();
+
 	/* now, re-initialize the nic client and ae device*/
 	ret = hclgevf_reset_stack(hdev);
 	if (ret)
-- 
2.17.1



