Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC8C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AD620A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nfbQA1C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AD620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeHZGVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:21:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeHZGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:21:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7Q2d2TP002315;
        Sun, 26 Aug 2018 02:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ow6fnJM0VuZZQfNfoIOmoYSRxhdHbmkXfeDMmf91aeo=;
 b=nfbQA1C87UG9p9VNDpbhfxgIvE5fdIr979WW//TfwHMYxm57oLIfG7I/1BgGq4AWCqgV
 AMSlx7DS0ojy7Li3ZKw3expC7K48IAOu4ckrDix7pkZU6Hck+x3Zs0KFXJ3P1zicyP+4
 AYblnn7epefQoyS1oBZQHqA2XdQMeiYgRd8S+Qmv4zmxenyxHCwBeOnlIRDFNaWucQ3q
 gVUusqzqMtMCb3yRFO33NCrNIwGwbOnwSldLXSRhIj84CK2aT42l7lDCs1vkKSrqmk51
 qDfCfXwUb5ZzERG8eiDncxqkYhJoChPqWOWUxEXZb7887DKZpTh5eql2nkJLusd2ypM0 hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m2yrpsgw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7Q2eVe8031028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:31 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7Q2eT9Q015753;
        Sun, 26 Aug 2018 02:40:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Sat, 25 Aug 2018 19:40:08 -0700
MIME-Version: 1.0
Message-ID: <20180826024006.13800-2-martin.petersen@oracle.com>
Date:   Sat, 25 Aug 2018 19:40:04 -0700 (PDT)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH 2/4] crc-t10dif: Pick better transform if one becomes
 available
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com>
In-Reply-To: <20180826024006.13800-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8996 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808260028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T10 CRC library is linked into the kernel thanks to block and SCSI. The
crypto accelerators are typically loaded later as modules and are
therefore not available when the T10 CRC library is initialized.

Use the crypto notifier facility to trigger a switch to a better algorithm
if one becomes available after the initial hash has been registered. Use
RCU to protect the original transform while the new one is being set up.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/crc-t10dif.h |  1 +
 lib/crc-t10dif.c           | 46 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index 1fe0cfcdea30..6bb0c0bf357b 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -6,6 +6,7 @@
 
 #define CRC_T10DIF_DIGEST_SIZE 2
 #define CRC_T10DIF_BLOCK_SIZE 1
+#define CRC_T10DIF_STRING "crct10dif"
 
 extern __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer,
 				size_t len);
diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 1ad33e555805..72076a902df5 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -14,10 +14,47 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <crypto/hash.h>
+#include <crypto/algapi.h>
 #include <linux/static_key.h>
+#include <linux/notifier.h>
 
-static struct crypto_shash *crct10dif_tfm;
+static struct crypto_shash __rcu *crct10dif_tfm;
 static struct static_key crct10dif_fallback __read_mostly;
+DEFINE_SPINLOCK(crc_t10dif_mutex);
+
+static int crc_t10dif_rehash(struct notifier_block *self, unsigned long val, void *data)
+{
+	struct crypto_alg *alg = data;
+	struct crypto_shash *new, *old;
+
+	if (val != CRYPTO_MSG_ALG_LOADED ||
+	    static_key_false(&crct10dif_fallback) ||
+	    strncmp(alg->cra_name, CRC_T10DIF_STRING, strlen(CRC_T10DIF_STRING)))
+		return 0;
+
+	spin_lock(&crc_t10dif_mutex);
+	old = rcu_dereference_protected(crct10dif_tfm,
+					lockdep_is_held(&crc_t10dif_mutex));
+	if (!old) {
+		spin_unlock(&crc_t10dif_mutex);
+		return 0;
+	}
+	new = crypto_alloc_shash("crct10dif", 0, 0);
+	if (IS_ERR(new)) {
+		spin_unlock(&crc_t10dif_mutex);
+		return 0;
+	}
+	rcu_assign_pointer(crct10dif_tfm, new);
+	spin_unlock(&crc_t10dif_mutex);
+
+	synchronize_rcu();
+	crypto_free_shash(old);
+	return 0;
+}
+
+static struct notifier_block crc_t10dif_nb = {
+	.notifier_call = crc_t10dif_rehash,
+};
 
 __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 {
@@ -30,11 +67,14 @@ __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 	if (static_key_false(&crct10dif_fallback))
 		return crc_t10dif_generic(crc, buffer, len);
 
-	desc.shash.tfm = crct10dif_tfm;
+	rcu_read_lock();
+	desc.shash.tfm = rcu_dereference(crct10dif_tfm);
 	desc.shash.flags = 0;
 	*(__u16 *)desc.ctx = crc;
 
 	err = crypto_shash_update(&desc.shash, buffer, len);
+	rcu_read_unlock();
+
 	BUG_ON(err);
 
 	return *(__u16 *)desc.ctx;
@@ -49,6 +89,7 @@ EXPORT_SYMBOL(crc_t10dif);
 
 static int __init crc_t10dif_mod_init(void)
 {
+	crypto_register_notifier(&crc_t10dif_nb);
 	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
 	if (IS_ERR(crct10dif_tfm)) {
 		static_key_slow_inc(&crct10dif_fallback);
@@ -59,6 +100,7 @@ static int __init crc_t10dif_mod_init(void)
 
 static void __exit crc_t10dif_mod_fini(void)
 {
+	crypto_unregister_notifier(&crc_t10dif_nb);
 	crypto_free_shash(crct10dif_tfm);
 }
 
-- 
2.17.1

