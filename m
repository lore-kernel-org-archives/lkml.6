Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeEWA1B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:27:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753841AbeEWA0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:26:55 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 12/14] ima: Add new "d-sig" template field
Date: Tue, 22 May 2018 21:12:51 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-0020-0000-0000-00000DFD5315
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:26:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-0021-0000-0000-00006182BF12
Message-Id: <20180523001253.15247-13-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new "d-sig" template field which holds the digest that is expected
to match the one contained in the modsig.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  5 +++++
 security/integrity/ima/ima.h              |  9 +++++++++
 security/integrity/ima/ima_modsig.c       | 23 ++++++++++++++++++++++
 security/integrity/ima/ima_template.c     |  4 +++-
 security/integrity/ima/ima_template_lib.c | 32 ++++++++++++++++++++++++++++++-
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
index 0fa8d89c8bd4..4ed7b0610842 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -312,6 +312,8 @@ bool ima_hook_supports_modsig(enum ima_hooks func);
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct evm_ima_xattr_data **xattr_value,
 		    int *xattr_len);
+int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
+			const u8 **hash, u8 *len);
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr);
 void ima_free_xattr_data(struct evm_ima_xattr_data *hdr);
@@ -329,6 +331,13 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr,
+				      enum hash_algo *algo, const u8 **hash,
+				      u8 *len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ima_modsig_verify(const unsigned int keyring_id,
 				    struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index aa6b91c3745b..0a8b9216cfa5 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -144,6 +144,29 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
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
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 30db39b23804..36fc32f538b5 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -43,8 +43,10 @@ static struct ima_template_field supported_fields[] = {
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
