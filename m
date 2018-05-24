Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpanWnNOBBhYZKF5P/sEI0G0PFzQFPM9EGVuK30wD4pc8K+QA9DZEzv8M4DZn5e5bbRJs5/
ARC-Seal: i=1; a=rsa-sha256; t=1527156179; cv=none;
        d=google.com; s=arc-20160816;
        b=cShqrRtn6tN53E/XFnf1bi7KQRloW688M9KG4KntnAnjACKflCGSZCPNuTeivZriFY
         HtTyvjw0CVoDRcUUdxywdDm6JNvzUid0VYh6UA2/4wqpbEaAiTgYiAllURAKLMwMApXk
         tLKYjRaK+pdcKOMeHug/fkoJdEVrGwqSq2EwpBZ4gBoAOsJ67Wc3ZtWUt/FU4mX3E506
         N5Q13fNMBxFWMfmT/qXAvuQCI6W9o9n4KhJbzYtDwcWv4YEL3dSka+b+qfbv/KvEY/+M
         nNpKOZ49akAf53g2mOOq3ax74yBVZsCFaOUTONA9l5V2s7wjMrRGkhLhfvtpkkSzB83m
         jumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KZ6WNtoq2dvRUmITo/WuysIGOFatUaLnUwl2NOKmEuQ=;
        b=xtYsLZpYuW/vgWt4/xYYgucZYuKGOgVe4gxvdlHlupYZZ5W6didbAtuWfOsc0PBwZu
         kKb03mx6JsA+SXRHsUlj1bp7EF1BesnGIbNG79vrrCk+21KK0+EwBAsoJHvuAlNVtrmD
         j+l4R3VHIPyI9Ip/1+KeVHIh7XQpK7mQisMvvovQlusbX/FwcVN+usIFoksagngF8zGo
         QiBFKPsm4TxpG7Vjk/wqiTK33bQznXlWgtkua7sVmealmfZe9qZLay8FTxpW27bO0ZbH
         RPXAbh27reZB8YAwXv/dRhLTFjJur1udDIMcrzE7s3jutlxzqObd9BJZv54cLDxP0YPi
         BUlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=g8DuDWQl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=g8DuDWQl;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.16 091/161] staging: fsl-dpaa2/eth: Fix incorrect kfree
Date: Thu, 24 May 2018 11:38:36 +0200
Message-Id: <20180524093029.308672095@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339318281511093?=
X-GMAIL-MSGID: =?utf-8?q?1601339318281511093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 6a9bbe53db9a5aa0be9788aa8a2c250dee55444b ]

Use netdev_alloc_frag() instead of kmalloc to allocate space for
the S/G table of egress multi-buffer frames.

This fixes a bug where an unaligned pointer received from the
allocator would be overwritten with the 64B aligned value,
leading to a wrong address being later passed to kfree.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -374,12 +374,14 @@ static int build_sg_fd(struct dpaa2_eth_
 	/* Prepare the HW SGT structure */
 	sgt_buf_size = priv->tx_data_offset +
 		       sizeof(struct dpaa2_sg_entry) * (1 + num_dma_bufs);
-	sgt_buf = kzalloc(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN, GFP_ATOMIC);
+	sgt_buf = netdev_alloc_frag(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN);
 	if (unlikely(!sgt_buf)) {
 		err = -ENOMEM;
 		goto sgt_buf_alloc_failed;
 	}
 	sgt_buf = PTR_ALIGN(sgt_buf, DPAA2_ETH_TX_BUF_ALIGN);
+	memset(sgt_buf, 0, sgt_buf_size);
+
 	sgt = (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
 
 	/* Fill in the HW SGT structure.
@@ -421,7 +423,7 @@ static int build_sg_fd(struct dpaa2_eth_
 	return 0;
 
 dma_map_single_failed:
-	kfree(sgt_buf);
+	skb_free_frag(sgt_buf);
 sgt_buf_alloc_failed:
 	dma_unmap_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
 dma_map_sg_failed:
@@ -525,9 +527,9 @@ static void free_tx_fd(const struct dpaa
 		return;
 	}
 
-	/* Free SGT buffer kmalloc'ed on tx */
+	/* Free SGT buffer allocated on tx */
 	if (fd_format != dpaa2_fd_single)
-		kfree(skbh);
+		skb_free_frag(skbh);
 
 	/* Move on with skb release */
 	dev_kfree_skb(skb);
