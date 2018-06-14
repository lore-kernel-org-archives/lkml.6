Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C9ED6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771AB208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSPR7S/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771AB208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935807AbeFNOF2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754907AbeFNOF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:05:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D072208DA;
        Thu, 14 Jun 2018 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985125;
        bh=FCPukCJMTP0LdhZ3IQYUrI+A0quck14wQPQPEShWi54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSPR7S/4fPnyzEIKEWKzYicgMCrDnnWwAwjFNgxsKFf6rs8yy1hevxZxkgLndcnPf
         Yq3cPWmjTbKb58fa0ywP7L98kbPaazF5j6wHKL8CB3hWPPv3druV1I3mQL8DS8fBN2
         I5Z0iDo8Ml3K0Ye1saMEne4gbq6u8R5fdBiUliqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.17 01/45] crypto: chelsio - request to HW should wrap
Date:   Thu, 14 Jun 2018 16:03:52 +0200
Message-Id: <20180614132126.866339903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atul Gupta <atul.gupta@chelsio.com>

commit 4c826fed675dfffd8485c5477b616d61d1ec9e9a upstream.

-Tx request and data is copied to HW Q in 64B desc, check for
end of queue and adjust the current position to start from
beginning before passing the additional request info.
-key context copy should check key length only
-Few reverse christmas tree correction

Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/chelsio/chcr_ipsec.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

--- a/drivers/crypto/chelsio/chcr_ipsec.c
+++ b/drivers/crypto/chelsio/chcr_ipsec.c
@@ -346,18 +346,23 @@ inline void *copy_cpltx_pktxt(struct sk_
 				struct net_device *dev,
 				void *pos)
 {
+	struct cpl_tx_pkt_core *cpl;
+	struct sge_eth_txq *q;
 	struct adapter *adap;
 	struct port_info *pi;
-	struct sge_eth_txq *q;
-	struct cpl_tx_pkt_core *cpl;
-	u64 cntrl = 0;
 	u32 ctrl0, qidx;
+	u64 cntrl = 0;
+	int left;
 
 	pi = netdev_priv(dev);
 	adap = pi->adapter;
 	qidx = skb->queue_mapping;
 	q = &adap->sge.ethtxq[qidx + pi->first_qset];
 
+	left = (void *)q->q.stat - pos;
+	if (!left)
+		pos = q->q.desc;
+
 	cpl = (struct cpl_tx_pkt_core *)pos;
 
 	cntrl = TXPKT_L4CSUM_DIS_F | TXPKT_IPCSUM_DIS_F;
@@ -382,18 +387,17 @@ inline void *copy_key_cpltx_pktxt(struct
 				void *pos,
 				struct ipsec_sa_entry *sa_entry)
 {
-	struct adapter *adap;
-	struct port_info *pi;
-	struct sge_eth_txq *q;
-	unsigned int len, qidx;
 	struct _key_ctx *key_ctx;
 	int left, eoq, key_len;
+	struct sge_eth_txq *q;
+	struct adapter *adap;
+	struct port_info *pi;
+	unsigned int qidx;
 
 	pi = netdev_priv(dev);
 	adap = pi->adapter;
 	qidx = skb->queue_mapping;
 	q = &adap->sge.ethtxq[qidx + pi->first_qset];
-	len = sa_entry->enckey_len + sizeof(struct cpl_tx_pkt_core);
 	key_len = sa_entry->kctx_len;
 
 	/* end of queue, reset pos to start of queue */
@@ -411,19 +415,14 @@ inline void *copy_key_cpltx_pktxt(struct
 	pos += sizeof(struct _key_ctx);
 	left -= sizeof(struct _key_ctx);
 
-	if (likely(len <= left)) {
+	if (likely(key_len <= left)) {
 		memcpy(key_ctx->key, sa_entry->key, key_len);
 		pos += key_len;
 	} else {
-		if (key_len <= left) {
-			memcpy(pos, sa_entry->key, key_len);
-			pos += key_len;
-		} else {
-			memcpy(pos, sa_entry->key, left);
-			memcpy(q->q.desc, sa_entry->key + left,
-			       key_len - left);
-			pos = (u8 *)q->q.desc + (key_len - left);
-		}
+		memcpy(pos, sa_entry->key, left);
+		memcpy(q->q.desc, sa_entry->key + left,
+		       key_len - left);
+		pos = (u8 *)q->q.desc + (key_len - left);
 	}
 	/* Copy CPL TX PKT XT */
 	pos = copy_cpltx_pktxt(skb, dev, pos);


