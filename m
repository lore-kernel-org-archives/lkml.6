Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2A21868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C2A21868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeHQLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:03:12 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:56055 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:03:12 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 07:03:06 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b767e838a6-362be; Fri, 17 Aug 2018 15:51:32 +0800 (CST)
X-RM-TRANSID: 2ee45b767e838a6-362be
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95b767e83dda-71e84;
        Fri, 17 Aug 2018 15:51:32 +0800 (CST)
X-RM-TRANSID: 2ee95b767e83dda-71e84
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net-next] esp: remove redundant define esph
Date:   Fri, 17 Aug 2018 15:51:00 +0800
Message-Id: <1534492260-2639-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer 'esph' is defined but is never used hence it is redundant
and canbe removed.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv4/esp4.c | 7 +++----
 net/ipv6/esp6.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 9768901..211caaf 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -683,12 +683,11 @@ static void esp_input_done_esn(struct crypto_async_request *base, int err)
  */
 static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 {
-	struct ip_esp_hdr *esph;
 	struct crypto_aead *aead = x->data;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	int ivlen = crypto_aead_ivsize(aead);
-	int elen = skb->len - sizeof(*esph) - ivlen;
+	int elen = skb->len - sizeof(struct ip_esp_hdr) - ivlen;
 	int nfrags;
 	int assoclen;
 	int seqhilen;
@@ -698,13 +697,13 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 	struct scatterlist *sg;
 	int err = -EINVAL;
 
-	if (!pskb_may_pull(skb, sizeof(*esph) + ivlen))
+	if (!pskb_may_pull(skb, sizeof(struct ip_esp_hdr) + ivlen))
 		goto out;
 
 	if (elen <= 0)
 		goto out;
 
-	assoclen = sizeof(*esph);
+	assoclen = sizeof(struct ip_esp_hdr);
 	seqhilen = 0;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 88a7579..63b2b66 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -601,12 +601,11 @@ static void esp_input_done_esn(struct crypto_async_request *base, int err)
 
 static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 {
-	struct ip_esp_hdr *esph;
 	struct crypto_aead *aead = x->data;
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	int ivlen = crypto_aead_ivsize(aead);
-	int elen = skb->len - sizeof(*esph) - ivlen;
+	int elen = skb->len - sizeof(struct ip_esp_hdr) - ivlen;
 	int nfrags;
 	int assoclen;
 	int seqhilen;
@@ -616,7 +615,7 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 	u8 *iv;
 	struct scatterlist *sg;
 
-	if (!pskb_may_pull(skb, sizeof(*esph) + ivlen)) {
+	if (!pskb_may_pull(skb, sizeof(struct ip_esp_hdr) + ivlen)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -626,7 +625,7 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 		goto out;
 	}
 
-	assoclen = sizeof(*esph);
+	assoclen = sizeof(struct ip_esp_hdr);
 	seqhilen = 0;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
-- 
1.8.3.1



