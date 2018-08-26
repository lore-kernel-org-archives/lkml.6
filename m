Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2806DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AAA20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4Y8/Gx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AAA20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeHZGVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:21:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHZGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:21:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7Q2e84r002855;
        Sun, 26 Aug 2018 02:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=iR56RlvStaF7Ta0o5w14nFglBJ2ZGYnIIrO5kZN7HnI=;
 b=N4Y8/Gx0JAUn7Pu3QpwXxMFlOGoy/P4/HPkXIm/3+7pi5h8TiNHvASUxy8cxJpsGyuGX
 RDv60yl6+qpkpzU/tJARW4OarTIec3xF1Sex43KLE7JLtHlcIdOiZl1pogjb1uXV3+N7
 363VNei8WsoYYbWThZyqIW6CiW55Tvh+OEHcrFsjPnUuT4/yOXSYH6RzvRtozhBo3mwV
 PaCCm+iphY6XobVz3xjq2oR8EgnpXTU8ppnP8UIJ+bnwzQc+xQcabtlm60dy2Phqz/3H
 2akT43x0wrEzJEttRy2Unz4rhTfMvvOYsV6N59UOfRDCi52MpHFhauojXtxktRMhAG// xA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m2yrpsgw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7Q2e7Fl030700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:07 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7Q2e7k0012420;
        Sun, 26 Aug 2018 02:40:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Aug 2018 19:40:07 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH 1/4] crypto: Introduce notifier for new crypto algorithms
Date:   Sat, 25 Aug 2018 22:40:03 -0400
Message-Id: <20180826024006.13800-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8996 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808260028
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
 crypto/algapi.c         |  7 +++----
 crypto/algboss.c        |  2 ++
 crypto/internal.h       |  8 --------
 include/crypto/algapi.h | 10 ++++++++++
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..87abad3cc322 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -361,15 +361,12 @@ static void crypto_wait_for_test(struct crypto_larval *larval)
 	err = crypto_probing_notify(CRYPTO_MSG_ALG_REGISTER, larval->adult);
 	if (err != NOTIFY_STOP) {
 		if (WARN_ON(err != NOTIFY_DONE))
-			goto out;
+			return;
 		crypto_alg_tested(larval->alg.cra_driver_name, 0);
 	}
 
 	err = wait_for_completion_killable(&larval->completion);
 	WARN_ON(err);
-
-out:
-	crypto_larval_kill(&larval->alg);
 }
 
 int crypto_register_alg(struct crypto_alg *alg)
@@ -390,6 +387,8 @@ int crypto_register_alg(struct crypto_alg *alg)
 		return PTR_ERR(larval);
 
 	crypto_wait_for_test(larval);
+	crypto_probing_notify(CRYPTO_MSG_ALG_LOADED, larval);
+	crypto_larval_kill(&larval->alg);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_register_alg);
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

