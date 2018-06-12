Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0555AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF32A2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5ORwR9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF32A2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbeFLQva (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934822AbeFLQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D23208B7;
        Tue, 12 Jun 2018 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822064;
        bh=8hv4T/jhNtgNKVJnyRqXbFPf3vjh/bNnL26q+ZeDdc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5ORwR9Wze83WCokFKcftdMrVtYiqbYvzOdqmLVv+wMUNqtqkQuiQ0AwpwdcTpjhf
         5Un72tbG6k/fSaEzYozMYmSp/KxL1x3H2mv5hHr1kWpm4JARZMvmkvmJBvRJjpv6xP
         RrWPmY694YaHPDEKjQgmzNW4mSfGOITxc2+W+hCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/31] vhost: synchronize IOTLB message with dev cleanup
Date:   Tue, 12 Jun 2018 18:46:25 +0200
Message-Id: <20180612164621.670127605@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 1b15ad683ab42a203f98b67045b40720e99d0e9a ]

DaeRyong Jeong reports a race between vhost_dev_cleanup() and
vhost_process_iotlb_msg():

Thread interleaving:
CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
(In the case of both VHOST_IOTLB_UPDATE and
VHOST_IOTLB_INVALIDATE)

=====						=====
						vhost_umem_clean(dev->iotlb);
if (!dev->iotlb) {
	        ret = -EFAULT;
		        break;
}
						dev->iotlb = NULL;

The reason is we don't synchronize between them, fixing by protecting
vhost_process_iotlb_msg() with dev mutex.

Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -938,6 +938,7 @@ int vhost_process_iotlb_msg(struct vhost
 {
 	int ret = 0;
 
+	mutex_lock(&dev->mutex);
 	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
@@ -967,6 +968,8 @@ int vhost_process_iotlb_msg(struct vhost
 	}
 
 	vhost_dev_unlock_vqs(dev);
+	mutex_unlock(&dev->mutex);
+
 	return ret;
 }
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,


