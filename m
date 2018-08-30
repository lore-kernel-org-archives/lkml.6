Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32935C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0BlnkGfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13C720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeH3TDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:03:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43272 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeH3TDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:03:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UExS5a171637;
        Thu, 30 Aug 2018 15:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=W8fdyMeKSmX92a0v4tFrDoRNqHhblE332D3juN4DitM=;
 b=0BlnkGfs5shZAl5/6nlBil7rONJnivMapk4Q54kz5vIv07IHDEqu5b7XdYS+EuBWgW2O
 +2vqMiRNN7rhHRZnHjbrZF66YqTmknNaGGaeY5CojoBTGnvedPqoFFD6ZtQ0RBPJqPW5
 B052H4zKixV5HawYDngSADFPVykcIPPY0FVZeDPTVBcOSgjHHO2ZvxWdoeHe/Pgdv7uC
 Eej6zUgucUt69ipnwiNtlQDGXQ1z4abVOyVyrulN7xAKpAQSZqRWNMOG6Xk7Hl6i9lgd
 FbZQBkN+LL4SYBQVzGxURwAXLx6Otd6/4wn1+ncMSwywYf9wKOsO0a91kJY6fDsTZoFL bw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2m2y2pw1y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UF0Lhx002644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:21 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UF0J0f015557;
        Thu, 30 Aug 2018 15:00:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 08:00:19 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 1/3] crypto: Introduce notifier for new crypto algorithms
Date:   Thu, 30 Aug 2018 11:00:14 -0400
Message-Id: <20180830150016.15661-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
References: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a facility that can be used to receive a notification
callback when a new algorithm becomes available. This can be used by
existing crypto registrations to trigger a switch from a software-only
algorithm to a hardware-accelerated version.

A new CRYPTO_MSG_ALG_LOADED state is introduced to the existing crypto
notification chain, and the register/unregister functions are exported
so they can be called by subsystems outside of crypto.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/algapi.c         |  2 ++
 crypto/algboss.c        |  2 ++
 crypto/internal.h       |  8 --------
 include/crypto/algapi.h | 10 ++++++++++
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..33522a147412 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -367,6 +367,8 @@ static void crypto_wait_for_test(struct crypto_larval *larval)
 
 	err = wait_for_completion_killable(&larval->completion);
 	WARN_ON(err);
+	if (!err)
+		crypto_probing_notify(CRYPTO_MSG_ALG_LOADED, larval);
 
 out:
 	crypto_larval_kill(&larval->alg);
diff --git a/crypto/algboss.c b/crypto/algboss.c
index 5e6df2a087fa..527b44d0af21 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -274,6 +274,8 @@ static int cryptomgr_notify(struct notifier_block *this, unsigned long msg,
 		return cryptomgr_schedule_probe(data);
 	case CRYPTO_MSG_ALG_REGISTER:
 		return cryptomgr_schedule_test(data);
+	case CRYPTO_MSG_ALG_LOADED:
+		break;
 	}
 
 	return NOTIFY_DONE;
diff --git a/crypto/internal.h b/crypto/internal.h
index 9a3f39939fba..ef769b5e8ad3 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -26,12 +26,6 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 
-/* Crypto notification events. */
-enum {
-	CRYPTO_MSG_ALG_REQUEST,
-	CRYPTO_MSG_ALG_REGISTER,
-};
-
 struct crypto_instance;
 struct crypto_template;
 
@@ -90,8 +84,6 @@ struct crypto_alg *crypto_find_alg(const char *alg_name,
 void *crypto_alloc_tfm(const char *alg_name,
 		       const struct crypto_type *frontend, u32 type, u32 mask);
 
-int crypto_register_notifier(struct notifier_block *nb);
-int crypto_unregister_notifier(struct notifier_block *nb);
 int crypto_probing_notify(unsigned long val, void *v);
 
 unsigned int crypto_alg_extsize(struct crypto_alg *alg);
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index bd5e8ccf1687..807501a4a754 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -425,4 +425,14 @@ static inline void crypto_yield(u32 flags)
 #endif
 }
 
+int crypto_register_notifier(struct notifier_block *nb);
+int crypto_unregister_notifier(struct notifier_block *nb);
+
+/* Crypto notification events. */
+enum {
+	CRYPTO_MSG_ALG_REQUEST,
+	CRYPTO_MSG_ALG_REGISTER,
+	CRYPTO_MSG_ALG_LOADED,
+};
+
 #endif	/* _CRYPTO_ALGAPI_H */
-- 
2.17.1

