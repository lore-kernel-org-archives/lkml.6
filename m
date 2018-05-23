Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeEWA1M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:27:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753861AbeEWA1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:27:08 -0400
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
Subject: [PATCH v7 13/14] ima: Write modsig to the measurement list
Date: Tue, 22 May 2018 21:12:52 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-0012-0000-0000-0000164A6AF6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:27:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-0013-0000-0000-000052E41C1E
Message-Id: <20180523001253.15247-14-bauerman@linux.ibm.com>
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

Add modsig support to the "sig" template field, allowing the the contents
of the modsig to be included in the measurement list.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h              |  7 +++++++
 security/integrity/ima/ima_modsig.c       | 13 +++++++++++++
 security/integrity/ima/ima_template_lib.c | 15 ++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4ed7b0610842..33120c10a173 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -314,6 +314,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    int *xattr_len);
 int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
 			const u8 **hash, u8 *len);
+int ima_modsig_serialize_data(struct evm_ima_xattr_data **data, int *data_len);
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr);
 void ima_free_xattr_data(struct evm_ima_xattr_data *hdr);
@@ -338,6 +339,12 @@ static inline int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr,
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_modsig_serialize_data(struct evm_ima_xattr_data **data,
+					    int *data_len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ima_modsig_verify(const unsigned int keyring_id,
 				    struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 0a8b9216cfa5..105fd04d585e 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -167,6 +167,19 @@ int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
 	return pkcs7_get_digest(modsig->pkcs7_msg, hash, len);
 }
 
+int ima_modsig_serialize_data(struct evm_ima_xattr_data **data, int *data_len)
+{
+	struct modsig_hdr *modsig = (struct modsig_hdr *) *data;
+
+	if (!*data || (*data)->type != IMA_MODSIG)
+		return -EINVAL;
+
+	*data = &modsig->raw_pkcs7;
+	*data_len = modsig->raw_pkcs7_len;
+
+	return 0;
+}
+
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 36d175816894..417cd153ba60 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -411,10 +411,23 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data)
 {
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+	int xattr_len = event_data->xattr_len;
 
 	if (!is_signed(xattr_value))
 		return 0;
 
-	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
+	/*
+	 * The xattr_value for IMA_MODSIG is a runtime structure containing
+	 * pointers. Get its raw data instead.
+	 */
+	if (xattr_value->type == IMA_MODSIG) {
+		int rc;
+
+		rc = ima_modsig_serialize_data(&xattr_value, &xattr_len);
+		if (rc)
+			return rc;
+	}
+
+	return ima_write_template_field_data(xattr_value, xattr_len,
 					     DATA_FMT_HEX, field_data);
 }
