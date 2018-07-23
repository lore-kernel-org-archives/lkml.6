Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F067ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5B620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbeGWX7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:59:09 -0400
Received: from complete.lackof.org ([198.49.126.79]:36618 "EHLO
        complete.lackof.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGWX7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:59:09 -0400
Received: from localhost (c-73-78-137-212.hsd1.co.comcast.net [73.78.137.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by complete.lackof.org (Postfix) with ESMTPSA id 1EABE33E018A;
        Mon, 23 Jul 2018 16:55:41 -0600 (MDT)
Date:   Mon, 23 Jul 2018 16:55:40 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Zhao Chen <zhaochen6@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hinic: Link the logical network device to the pci device in
 sysfs
Message-ID: <20180723225540.GA6905@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.100.0 at complete.lackof.org
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise interfaces get exposed under /sys/devices/virtual, which
doesn't give udev the context it needs for PCI-based predictable
interface names.

Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 5b122728dcb47..09e9da10b7865 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -983,6 +983,7 @@ static int nic_dev_init(struct pci_dev *pdev)
 	hinic_hwdev_cb_register(nic_dev->hwdev, HINIC_MGMT_MSG_CMD_LINK_STATUS,
 				nic_dev, link_status_event_handler);
 
+	SET_NETDEV_DEV(netdev, &pdev->dev);
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev\n");
-- 
2.18.0

