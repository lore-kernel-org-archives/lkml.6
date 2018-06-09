Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qk53A+DzG1uFaAAAmS7hNA
	; Sat, 09 Jun 2018 15:36:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 242CE608C1; Sat,  9 Jun 2018 15:36:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmJ/tKLn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94004606FA;
	Sat,  9 Jun 2018 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94004606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeFIPgU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933206AbeFIPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:16 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106D5208A3;
        Sat,  9 Jun 2018 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558575;
        bh=mrdyaNWR2xxUG4uDqCpw6UTqJBuSjh6+0qwK2le9bhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmJ/tKLnSkyaaEyVNsuvwq42qA5rJ7puuvYRzA2xDZ43ht5NnB2BZ18yd0K6kJZO1
         WPDX855mS7H9kY5dl+Ed04188k0KizgDjxgfCXr5fc1Zh7d6x6obhehhOVu48mLsx9
         opZM7p+MLz3h3HWKzIyOcDCj56EbWUSjdGEDZRBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 36/41] virtio-net: correctly check num_buf during err path
Date: Sat,  9 Jun 2018 17:30:08 +0200
Message-Id: <20180609152928.397880125@linuxfoundation.org>
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

[ Upstream commit 850e088d5bbb333342fd4def08d0a4035f2b7126 ]

If we successfully linearize the packet, num_buf will be set to zero
which may confuse error handling path which assumes num_buf is at
least 1 and this can lead the code tries to pop the descriptor of next
buffer. Fixing this by checking num_buf against 1 before decreasing.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -777,7 +777,7 @@ err_xdp:
 	rcu_read_unlock();
 err_skb:
 	put_page(page);
-	while (--num_buf) {
+	while (num_buf-- > 1) {
 		buf = virtqueue_get_buf(rq->vq, &len);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
