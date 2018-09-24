Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B09C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7326208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7326208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeIXRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:40:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeIXRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:40:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 557C1106D;
        Mon, 24 Sep 2018 11:38:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 042/105] uio: potential double frees if __uio_register_device() fails
Date:   Mon, 24 Sep 2018 13:33:28 +0200
Message-Id: <20180924113118.230580090@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f019f07ecf6a6b8bd6d7853bce70925d90af02d1 ]

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -832,8 +832,6 @@ int __uio_register_device(struct module
 	if (ret)
 		goto err_uio_dev_add_attributes;
 
-	info->uio_dev = idev;
-
 	if (info->irq && (info->irq != UIO_IRQ_CUSTOM)) {
 		ret = devm_request_irq(idev->dev, info->irq, uio_interrupt,
 				  info->irq_flags, info->name, idev);
@@ -841,6 +839,7 @@ int __uio_register_device(struct module
 			goto err_request_irq;
 	}
 
+	info->uio_dev = idev;
 	return 0;
 
 err_request_irq:


