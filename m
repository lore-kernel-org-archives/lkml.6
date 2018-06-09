Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k/YFLbHzG1sRZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0D0F608C8; Sat,  9 Jun 2018 15:35:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRRNlHpU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 144BF606FA;
	Sat,  9 Jun 2018 15:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 144BF606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeFIPfZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbeFIPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:20 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0147208A3;
        Sat,  9 Jun 2018 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558519;
        bh=BLyaWLQk7TLQjI/2EbevoVZ4H7Lt6HDmVSPFNc7TT/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRRNlHpURyzoXAFRSF2XG99seblXq9cJg2A61KtbgbnxQB75v8AFO3j0DlnksNWlx
         dFUvMXlYaf18Ra5Akf2xNdFNeOxws7/gJh1teIMR/ISLPC9aSFP5gsIHFbYXr80To3
         kJwDwdBGAUhYUSIycLuquu92QUXJ0iEWTho10XeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 28/41] vhost: synchronize IOTLB message with dev cleanup
Date: Sat,  9 Jun 2018 17:30:00 +0200
Message-Id: <20180609152927.953792954@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -993,6 +993,7 @@ static int vhost_process_iotlb_msg(struc
 {
 	int ret = 0;
 
+	mutex_lock(&dev->mutex);
 	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
@@ -1024,6 +1025,8 @@ static int vhost_process_iotlb_msg(struc
 	}
 
 	vhost_dev_unlock_vqs(dev);
+	mutex_unlock(&dev->mutex);
+
 	return ret;
 }
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
