Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D8C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5F520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeLMCMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:12:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727069AbeLMCMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:12:05 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBD23kYr116370
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:12:04 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pb8ku75ye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:12:03 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 13 Dec 2018 02:12:03 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 02:11:58 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBD2BvxX26017986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 02:11:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09E88C605B;
        Thu, 13 Dec 2018 02:11:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCDD1C6057;
        Thu, 13 Dec 2018 02:11:52 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.227.60])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 02:11:52 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v9 12/14] ima: Add new "d-sig" template field
Date:   Thu, 13 Dec 2018 00:09:05 -0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181213020907.13601-1-bauerman@linux.ibm.com>
References: <20181213020907.13601-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121302-8235-0000-0000-00000E37DDF3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010217; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130951; UDB=6.00587714; IPR=6.00911085;
 MB=3.00024674; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 02:12:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121302-8236-0000-0000-000043AF07A4
Message-Id: <20181213020907.13601-13-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new "d-sig" template field which holds the digest that is expected
to match the one contained in the modsig.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  5 ++++
 security/integrity/ima/ima.h              |  9 +++++++
 security/integrity/ima/ima_modsig.c       | 23 ++++++++++++++++
 security/integrity/ima/ima_template.c     |  4 ++-
 security/integrity/ima/ima_template_lib.c | 32 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  2 ++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..f2a0f4225857 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -68,6 +68,11 @@ descriptors by adding their identifier to the format string
  - 'd-ng': the digest of the event, calculated with an arbitrary hash
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
+ - 'd-sig': the digest of the event for files that have an appended modsig. This
+   field is calculated without including the modsig and thus will differ from
+   the total digest of the file, but it is what should match the digest
+   contained in the modsig (if it doesn't, the signature is invalid). It is
+   shown in the same format as 'd-ng';
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature.
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 753d59352718..40a6ddfdd9ea 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -316,6 +316,8 @@ int ima_read_collect_modsig(enum ima_hooks func, const void *buf,
 			    loff_t buf_len,
 			    struct evm_ima_xattr_data **xattr_value,
 			    int *xattr_len);
+int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
+			const u8 **hash, u8 *len);
 void ima_free_xattr_data(struct evm_ima_xattr_data *hdr);
 #else
 static inline bool ima_hook_supports_modsig(enum ima_hooks func)
@@ -331,6 +333,13 @@ static inline int ima_read_collect_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr,
+				      enum hash_algo *algo, const u8 **hash,
+				      u8 *len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_free_xattr_data(struct evm_ima_xattr_data *hdr)
 {
 	kfree(hdr);
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index f228f333509d..587b79a9afef 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -167,6 +167,29 @@ int ima_read_collect_modsig(enum ima_hooks func, const void *buf,
 	return rc;
 }
 
+int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
+			const u8 **hash, u8 *len)
+{
+	struct modsig_hdr *modsig = (typeof(modsig)) hdr;
+	const struct public_key_signature *pks;
+	int i;
+
+	if (!hdr || hdr->type != IMA_MODSIG)
+		return -EINVAL;
+
+	pks = pkcs7_get_message_sig(modsig->pkcs7_msg);
+	if (!pks)
+		return -EBADMSG;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (!strcmp(hash_algo_name[i], pks->hash_algo))
+			break;
+
+	*algo = i;
+
+	return pkcs7_get_digest(modsig->pkcs7_msg, hash, len);
+}
+
 int ima_modsig_verify(struct key *keyring, const void *hdr)
 {
 	const struct modsig_hdr *modsig = (const struct modsig_hdr *) hdr;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..045ad508cbb8 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -43,8 +43,10 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "d-sig", .field_init = ima_eventdigest_sig_init,
+	 .field_show = ima_show_template_digest_ng},
 };
-#define MAX_TEMPLATE_NAME_LEN 15
+#define MAX_TEMPLATE_NAME_LEN 24
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 300912914b17..36d175816894 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -222,7 +222,8 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 	return 0;
 }
 
-static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
+static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
+				       u8 hash_algo,
 				       struct ima_field_data *field_data)
 {
 	/*
@@ -325,6 +326,35 @@ int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 					   hash_algo, field_data);
 }
 
+/*
+ * This function writes the digest of the file which is expected to match the
+ * digest contained in the file's embedded signature.
+ */
+int ima_eventdigest_sig_init(struct ima_event_data *event_data,
+			     struct ima_field_data *field_data)
+{
+	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+	enum hash_algo hash_algo = HASH_ALGO_SHA1;
+	const u8 *cur_digest = NULL;
+	u8 cur_digestsize = 0;
+	int ret;
+
+	if (!xattr_value || xattr_value->type != IMA_MODSIG)
+		return 0;
+
+	if (event_data->violation)	/* recording a violation. */
+		goto out;
+
+	ret = ima_get_modsig_hash(xattr_value, &hash_algo, &cur_digest,
+				  &cur_digestsize);
+	if (ret)
+		return ret;
+
+ out:
+	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
+					   hash_algo, field_data);
+}
+
 static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data,
 				     bool size_limit)
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..3cd353e83f73 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -38,6 +38,8 @@ int ima_eventname_init(struct ima_event_data *event_data,
 		       struct ima_field_data *field_data);
 int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventdigest_sig_init(struct ima_event_data *event_data,
+			     struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,

