Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFEFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09102073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ige6I2N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09102073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeH3TDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:03:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeH3TDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:03:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UExSLP126924;
        Thu, 30 Aug 2018 15:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1e1K3MhBNY2jDkcLVndaw3WNWPGoBINwHiPtsrd6t3A=;
 b=Ige6I2N7EzpULqSen9FrFV/JzU9wGdXItB0z0NLx9taWEc15T25qJSYhTTTqQnMWn6x3
 soVMbdBfoo4pE7MzaN+l2IVkz36YdSCz1ycfCUHJdyjtuNxprHUUiQp01xs7Kdvj5ehy
 krvNlTL3Fkcd67g4ei5V4JDwgf+UNBdUbRPpya6beDV6Zg7i6AcKnjvXQSNN7+Vyw/d8
 3BPzL2Q+KcQlMzrOpbCg7t9TBT6SJnPpekc0TDudvrcTxnDf27SrkTS/Oq32imtMzmuu
 /QHiHMIAOAdRN/MdAwK1DezNABN6ySiq8GwwoPfu3oaxN7laDX3iaBJL+vN8QcV/siLc 5g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m2yrqmxsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UF0LH0002541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:21 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UF0KmM015577;
        Thu, 30 Aug 2018 15:00:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 08:00:20 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 2/3] crc-t10dif: Pick better transform if one becomes available
Date:   Thu, 30 Aug 2018 11:00:15 -0400
Message-Id: <20180830150016.15661-2-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830150016.15661-1-martin.petersen@oracle.com>
References: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
 <20180830150016.15661-1-martin.petersen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300155
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
index 1ad33e555805..52f577a3868d 100644
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
+DEFINE_MUTEX(crc_t10dif_mutex);
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
+	mutex_lock(&crc_t10dif_mutex);
+	old = rcu_dereference_protected(crct10dif_tfm,
+					lockdep_is_held(&crc_t10dif_mutex));
+	if (!old) {
+		mutex_unlock(&crc_t10dif_mutex);
+		return 0;
+	}
+	new = crypto_alloc_shash("crct10dif", 0, 0);
+	if (IS_ERR(new)) {
+		mutex_unlock(&crc_t10dif_mutex);
+		return 0;
+	}
+	rcu_assign_pointer(crct10dif_tfm, new);
+	mutex_unlock(&crc_t10dif_mutex);
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

