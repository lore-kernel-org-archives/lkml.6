Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4UhZCFLUGltuJQAAmS7hNA
	; Fri, 08 Jun 2018 19:09:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 55A85607E4; Fri,  8 Jun 2018 19:09:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D3EC601D2;
	Fri,  8 Jun 2018 19:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D3EC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeFHTJM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:09:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752754AbeFHTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:08:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58J5IbB065795
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 15:08:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfwjkcr1s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:08:53 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Fri, 8 Jun 2018 15:08:53 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 15:08:49 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58J8m4i4522420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 19:08:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2890E2805C;
        Fri,  8 Jun 2018 15:08:34 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D96128060;
        Fri,  8 Jun 2018 15:08:34 -0400 (EDT)
Received: from alifm-ThinkPad-T470p.pok.ibm.com (unknown [9.56.58.93])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Jun 2018 15:08:34 -0400 (EDT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, alifm@linux.ibm.com
Subject: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's supported
Date: Fri,  8 Jun 2018 15:08:47 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060819-0060-0000-0000-0000027A86ED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009153; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044097; UDB=6.00534600; IPR=6.00823135;
 MB=3.00021536; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 19:08:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060819-0061-0000-0000-00004562B81E
Message-Id: <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Register a crypto algo with the Linux crypto layer only if
the algorithm is supported by the backend virtio-crypto
device.

Also route crypto requests to a virtio-crypto
device, only if it can support the requested service and
algorithm.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c   | 110 ++++++++++++++++++---------
 drivers/crypto/virtio/virtio_crypto_common.h |  11 ++-
 drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
 3 files changed, 158 insertions(+), 44 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index ba190cf..fef112a 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -49,12 +49,18 @@ struct virtio_crypto_sym_request {
 	bool encrypt;
 };
 
+struct virtio_crypto_algo {
+	uint32_t algonum;
+	uint32_t service;
+	unsigned int active_devs;
+	struct crypto_alg algo;
+};
+
 /*
  * The algs_lock protects the below global virtio_crypto_active_devs
  * and crypto algorithms registion.
  */
 static DEFINE_MUTEX(algs_lock);
-static unsigned int virtio_crypto_active_devs;
 static void virtio_crypto_ablkcipher_finalize_req(
 	struct virtio_crypto_sym_request *vc_sym_req,
 	struct ablkcipher_request *req,
@@ -312,13 +318,19 @@ static int virtio_crypto_ablkcipher_setkey(struct crypto_ablkcipher *tfm,
 					 unsigned int keylen)
 {
 	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	uint32_t alg;
 	int ret;
 
+	ret = virtio_crypto_alg_validate_key(keylen, &alg);
+	if (ret)
+		return ret;
+
 	if (!ctx->vcrypto) {
 		/* New key */
 		int node = virtio_crypto_get_current_node();
 		struct virtio_crypto *vcrypto =
-				      virtcrypto_get_dev_node(node);
+				      virtcrypto_get_dev_node(node,
+				      VIRTIO_CRYPTO_SERVICE_CIPHER, alg);
 		if (!vcrypto) {
 			pr_err("virtio_crypto: Could not find a virtio device in the system\n");
 			return -ENODEV;
@@ -571,57 +583,85 @@ static void virtio_crypto_ablkcipher_finalize_req(
 	virtcrypto_clear_request(&vc_sym_req->base);
 }
 
-static struct crypto_alg virtio_crypto_algs[] = { {
-	.cra_name = "cbc(aes)",
-	.cra_driver_name = "virtio_crypto_aes_cbc",
-	.cra_priority = 150,
-	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize = AES_BLOCK_SIZE,
-	.cra_ctxsize  = sizeof(struct virtio_crypto_ablkcipher_ctx),
-	.cra_alignmask = 0,
-	.cra_module = THIS_MODULE,
-	.cra_type = &crypto_ablkcipher_type,
-	.cra_init = virtio_crypto_ablkcipher_init,
-	.cra_exit = virtio_crypto_ablkcipher_exit,
-	.cra_u = {
-	   .ablkcipher = {
-			.setkey = virtio_crypto_ablkcipher_setkey,
-			.decrypt = virtio_crypto_ablkcipher_decrypt,
-			.encrypt = virtio_crypto_ablkcipher_encrypt,
-			.min_keysize = AES_MIN_KEY_SIZE,
-			.max_keysize = AES_MAX_KEY_SIZE,
-			.ivsize = AES_BLOCK_SIZE,
+static struct virtio_crypto_algo virtio_crypto_algs[] = { {
+	.algonum = VIRTIO_CRYPTO_CIPHER_AES_CBC,
+	.service = VIRTIO_CRYPTO_SERVICE_CIPHER,
+	.algo = {
+		.cra_name = "cbc(aes)",
+		.cra_driver_name = "virtio_crypto_aes_cbc",
+		.cra_priority = 150,
+		.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_ctxsize  = sizeof(struct virtio_crypto_ablkcipher_ctx),
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+		.cra_type = &crypto_ablkcipher_type,
+		.cra_init = virtio_crypto_ablkcipher_init,
+		.cra_exit = virtio_crypto_ablkcipher_exit,
+		.cra_u = {
+			.ablkcipher = {
+				.setkey = virtio_crypto_ablkcipher_setkey,
+				.decrypt = virtio_crypto_ablkcipher_decrypt,
+				.encrypt = virtio_crypto_ablkcipher_encrypt,
+				.min_keysize = AES_MIN_KEY_SIZE,
+				.max_keysize = AES_MAX_KEY_SIZE,
+				.ivsize = AES_BLOCK_SIZE,
+			},
 		},
 	},
 } };
 
-int virtio_crypto_algs_register(void)
+int virtio_crypto_algs_register(struct virtio_crypto *vcrypto)
 {
 	int ret = 0;
+	int i = 0;
 
 	mutex_lock(&algs_lock);
-	if (++virtio_crypto_active_devs != 1)
-		goto unlock;
 
-	ret = crypto_register_algs(virtio_crypto_algs,
-			ARRAY_SIZE(virtio_crypto_algs));
-	if (ret)
-		virtio_crypto_active_devs--;
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_algs); i++) {
+
+		uint32_t service = virtio_crypto_algs[i].service;
+		uint32_t algonum = virtio_crypto_algs[i].algonum;
+
+		if (!virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_algs[i].active_devs == 0) {
+			ret = crypto_register_alg(&virtio_crypto_algs[i].algo);
+			if (ret)
+				goto unlock;
+		}
+
+		virtio_crypto_algs[i].active_devs++;
+		dev_info(&vcrypto->vdev->dev, "Registered algo %s\n",
+			 virtio_crypto_algs[i].algo.cra_name);
+	}
 
 unlock:
 	mutex_unlock(&algs_lock);
 	return ret;
 }
 
-void virtio_crypto_algs_unregister(void)
+void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto)
 {
+	int i = 0;
+
 	mutex_lock(&algs_lock);
-	if (--virtio_crypto_active_devs != 0)
-		goto unlock;
 
-	crypto_unregister_algs(virtio_crypto_algs,
-			ARRAY_SIZE(virtio_crypto_algs));
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_algs); i++) {
+
+		uint32_t service = virtio_crypto_algs[i].service;
+		uint32_t algonum = virtio_crypto_algs[i].algonum;
+
+		if (virtio_crypto_algs[i].active_devs == 0 ||
+		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_algs[i].active_devs == 1)
+			crypto_unregister_alg(&virtio_crypto_algs[i].algo);
+
+		virtio_crypto_algs[i].active_devs--;
+	}
 
-unlock:
 	mutex_unlock(&algs_lock);
 }
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 05eca12e..76d49ec 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -116,7 +116,12 @@ int virtcrypto_dev_in_use(struct virtio_crypto *vcrypto_dev);
 int virtcrypto_dev_get(struct virtio_crypto *vcrypto_dev);
 void virtcrypto_dev_put(struct virtio_crypto *vcrypto_dev);
 int virtcrypto_dev_started(struct virtio_crypto *vcrypto_dev);
-struct virtio_crypto *virtcrypto_get_dev_node(int node);
+bool virtcrypto_algo_is_supported(struct virtio_crypto *vcrypto_dev,
+				  uint32_t service,
+				  uint32_t algo);
+struct virtio_crypto *virtcrypto_get_dev_node(int node,
+					      uint32_t service,
+					      uint32_t algo);
 int virtcrypto_dev_start(struct virtio_crypto *vcrypto);
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto);
 int virtio_crypto_ablkcipher_crypt_req(
@@ -136,7 +141,7 @@ static inline int virtio_crypto_get_current_node(void)
 	return node;
 }
 
-int virtio_crypto_algs_register(void);
-void virtio_crypto_algs_unregister(void);
+int virtio_crypto_algs_register(struct virtio_crypto *vcrypto);
+void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index a69ff71..d70de3a 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -181,14 +181,20 @@ int virtcrypto_dev_started(struct virtio_crypto *vcrypto_dev)
 /*
  * virtcrypto_get_dev_node() - Get vcrypto_dev on the node.
  * @node:  Node id the driver works.
+ * @service: Crypto service that needs to be supported by the
+ *	      dev
+ * @algo: The algorithm number that needs to be supported by the
+ *	  dev
  *
- * Function returns the virtio crypto device used fewest on the node.
+ * Function returns the virtio crypto device used fewest on the node,
+ * and supports the given crypto service and algorithm.
  *
  * To be used by virtio crypto device specific drivers.
  *
  * Return: pointer to vcrypto_dev or NULL if not found.
  */
-struct virtio_crypto *virtcrypto_get_dev_node(int node)
+struct virtio_crypto *virtcrypto_get_dev_node(int node, uint32_t service,
+					      uint32_t algo)
 {
 	struct virtio_crypto *vcrypto_dev = NULL, *tmp_dev;
 	unsigned long best = ~0;
@@ -199,7 +205,8 @@ struct virtio_crypto *virtcrypto_get_dev_node(int node)
 
 		if ((node == dev_to_node(&tmp_dev->vdev->dev) ||
 		     dev_to_node(&tmp_dev->vdev->dev) < 0) &&
-		    virtcrypto_dev_started(tmp_dev)) {
+		    virtcrypto_dev_started(tmp_dev) &&
+		    virtcrypto_algo_is_supported(tmp_dev, service, algo)) {
 			ctr = atomic_read(&tmp_dev->ref_count);
 			if (best > ctr) {
 				vcrypto_dev = tmp_dev;
@@ -214,7 +221,9 @@ struct virtio_crypto *virtcrypto_get_dev_node(int node)
 		/* Get any started device */
 		list_for_each_entry(tmp_dev,
 				virtcrypto_devmgr_get_head(), list) {
-			if (virtcrypto_dev_started(tmp_dev)) {
+			if (virtcrypto_dev_started(tmp_dev) &&
+			    virtcrypto_algo_is_supported(tmp_dev,
+			    service, algo)) {
 				vcrypto_dev = tmp_dev;
 				break;
 			}
@@ -240,7 +249,7 @@ struct virtio_crypto *virtcrypto_get_dev_node(int node)
  */
 int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 {
-	if (virtio_crypto_algs_register()) {
+	if (virtio_crypto_algs_register(vcrypto)) {
 		pr_err("virtio_crypto: Failed to register crypto algs\n");
 		return -EFAULT;
 	}
@@ -260,5 +269,65 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
  */
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
 {
-	virtio_crypto_algs_unregister();
+	virtio_crypto_algs_unregister(vcrypto);
+}
+
+/*
+ * vcrypto_algo_is_supported()
+ * @vcrypto: Pointer to virtio crypto device.
+ * @service: The bit number for service validate.
+ *	      See VIRTIO_CRYPTO_SERVICE_*
+ * @algo : The bit number for the algorithm to validate.
+ *
+ *
+ * Validate if the virtio crypto device supports a service and
+ * algo.
+ *
+ * Return true if device supports a service and algo.
+ */
+
+bool virtcrypto_algo_is_supported(struct virtio_crypto *vcrypto,
+				  uint32_t service,
+				  uint32_t algo)
+{
+	uint32_t service_mask = 1u << service;
+	uint32_t algo_mask = 0;
+	bool low = true;
+
+	if (algo > 31) {
+		algo -= 32;
+		low = false;
+	}
+
+	if (!(vcrypto->crypto_services & service_mask))
+		return false;
+
+	switch (service) {
+	case VIRTIO_CRYPTO_SERVICE_CIPHER:
+		if (low)
+			algo_mask = vcrypto->cipher_algo_l;
+		else
+			algo_mask = vcrypto->cipher_algo_h;
+		break;
+
+	case VIRTIO_CRYPTO_SERVICE_HASH:
+		algo_mask = vcrypto->hash_algo;
+		break;
+
+	case VIRTIO_CRYPTO_SERVICE_MAC:
+		if (low)
+			algo_mask = vcrypto->mac_algo_l;
+		else
+			algo_mask = vcrypto->mac_algo_h;
+		break;
+
+	case VIRTIO_CRYPTO_SERVICE_AEAD:
+		algo_mask = vcrypto->aead_algo;
+		break;
+	}
+
+	if (!(algo_mask & (1u << algo)))
+		return false;
+
+	return true;
 }
-- 
2.7.4
