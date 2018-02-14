Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161370AbeBNRlu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:41:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161361AbeBNRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:41:45 -0500
Date: Wed, 14 Feb 2018 09:40:58 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH v2 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
Message-ID: <20180214174058.GA62239@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: BN6PR06CA0007.namprd06.prod.outlook.com (10.175.123.145) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be7f7d12-edb5-46b0-8687-08d573d21f63
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:8Q8EgfPTXSKOan4G8AgrDDjRisbj6e/7yNpUAcnpDL4O3nq4axzgYb/TqAARTrbnd37caN/bhOTsAMTYVSBZIWKVoMvKwf8DGnVU7fctYp8CX+4I34RU4nt3bBewsfko9VYZXK44fmv/swcXH/gMHvLs8bSr2ay3cvB37uMC03gMYB0wDJ3vyfY+LeqlZj0unS9GGqz90DpudzyAa/gjUvvUmAwmOlLmXh9LVEIIMgrq2+1NtBWxv264SP3vHp3L;25:RS8sKCeiCS4Fl1DoZzjwEjMhpCL8ATk+0UEfjB0zR7s1gdsnY72RAH/rbgCMw+B12bDTcK+sS8G/i9gRWtu9BX4n2DWv+6pdAuOvr+sTiFecglocxm6gBjA47G59urE/N8vYYSf16lULnUEfgSthSiZjnnHDPlP8DmCSnhoWMR/802b9Zf7zqF1GNIyvnoGHW8UJFNBK6oyf6xNqRqShjXQwMRpcPwZc8p9DQfPInkJ3vmBHl7K9LeLueWLyTVF00tX16CIHJPlj4wq+IutfNwojbrsOhEkTQVFNUBF42yHwU+wXwGSrW7osf5fxwjZRX8EghqZgbabuA3f+me9agQ==;31:7pDmlLqjweGpS41/+Rp25NSNeQVRYcg9yrQap6FO5kU23Pzaen7bTmIn1KBTsQH6AsDb9O5aWecd4lcnFrrCyqg2DIBseNhOAJWhaX/PEL4rHpDYHJJ2R9SozPkMLewhUqCRLmb5vYIw3rXgbnRMUkJw3bdGS8SioMUkyAhGssAtYCjNBPS88VUkhu975dnCUMxqIwK4XxtUdhb1lxcMLzs/zGuJiqwOHQQMNK/igRc=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:SRpnof48FYfRxjE7Xx/+vQpwMhxbi/18U9Xd5Q0BmH/w5mOdkDEnLxnLu6kFrG0yHni0tewZhmjGkoXCX4RmAnyR1qjWZagFRc3tQj3PMLQ0Ganh0d0rIeVrWZhyKVWdBvRMMheFwx9soUunv47VEWHmBjsg3OnMJXCyW4qgyXoU1Rn+avVSuj1mWrjecSRbo1KBtYjzZJe5xOVaQjHykLx4Ksy2KR/2x5S80P3DBnrrmSCS+LdnH5qVd/iNoXJhFt3tZyxlX+0V9+ztxWfpkReBclmYVUZfUK9qA7xRaatmDocq9i1oCma8RnWNdlVMsQPqwwcmFJhpuhIKPhVcjf24QIxK4xx0F8vfLQh4lBNdBx/ohY9frhUKFH2RwCHqtrflaiDzGK3a341+qEWE8L48LCqtuNuPD+GVRv2HD0hEBeIfgIbFF7qUBVwfPd51M89NpLGILHuHSz/PX7XJqMWsK874f971Um+ktqRp5yreufhmz2vHk9l4ESCVthS1;4:+ALW4UteA4kfOdSgECybaQetdPgrjNzc+Dl6z9+fTCPdJnuNATUx5kcPcZfSjq8/GLb5e4/Fo8N7EefKKmjS/88WdmWEbc0iLFsTIFAQP8Y4CSROt3kWsSiTfANhKpckLM/jph4KWOvW8aHg92fMUnpRlZlODuHzsZJ5YuAWF0IDJHRLoqmYq9Yc/hn4Jx3w03zFTjrHJm2uKDLKKRpllegKQZUCSAjijIeRiWzSCq+dq0MbrRqWcGLwIP46kahi4Z2uc2YynPQeAF7TJ/KsRjf9uTA4rFeGVr4H7eLaJhjNpFSJuy+TShntS6NRO8JOutccmic7JRYBWL8N8BlQ6clQPFMIEmigDkcfwccaGq8=
X-Microsoft-Antispam-PRVS: <CY4PR15MB17525E10A81FF8DBCD24B43EDDF50@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(305945005)(59450400001)(6496006)(52116002)(9686003)(52396003)(83506002)(54906003)(16586007)(58126008)(76176011)(386003)(33896004)(86362001)(16526019)(6486002)(8936002)(316002)(50466002)(97736004)(76506005)(7416002)(110136005)(81166006)(105586002)(53936002)(186003)(68736007)(4326008)(47776003)(1076002)(2950100002)(8676002)(33716001)(6666003)(81156014)(106356001)(2906002)(25786009)(23726003)(33656002)(15650500001)(5660300001)(6116002)(478600001)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:f5VwGq6kMeGNBn1HJRNDkigTgSt0sE8fmGNRg+BIU?=
 =?us-ascii?Q?+BXLWumAd/K9EtkPubA6fBnYa/ltTpHghwoW/QmIWG/dUoUN/Ki/THRs0j0p?=
 =?us-ascii?Q?ncMrS7Wy+iFoVN8fRurOY2Agn4gzpzVP3V3qFouqkeiUfj5WAoYK779RkrxS?=
 =?us-ascii?Q?fLXRoRb+whp32jo83t5AnSlsUPgU9YaIqcRGT6OHsfmnEo11LXLA4jHvCRdk?=
 =?us-ascii?Q?q/vA2lqEZD/9e3y0qgzSDNOCWlPh8ddrbvqlNBAaXcsCvAeKUYXOBpqX8ph6?=
 =?us-ascii?Q?B+PU6X3wAQG0BDO7zi+kUxeT3uT1Tm/n+jfRMLX7kawyLkGH4J0FibGN4MiP?=
 =?us-ascii?Q?u+uPhUVn7t6YYHEOHnJsF6KVYQPCJCZff0C6eLOWHmTQxkEek5QncQW89z/w?=
 =?us-ascii?Q?08nYuH8LNWO5P5YbrxbelBbdJ/NHOcPHfv+aPBr9Y91Yd3rR5EDi2pyPnhHa?=
 =?us-ascii?Q?PmY1+iODRW6GJHujrMKqy1mAOkpVlkl5sNtRI5KkE+kTvMkF5Em+Olecq0JZ?=
 =?us-ascii?Q?+MSaI3onJQJrhcf6pckphYJ9hzBIvBF7uPPjnwEaoaeknGzsEn+1GNzeI4F5?=
 =?us-ascii?Q?t66v3JmVdyaCIv6V0k5JNUVms/AmRh3b52Pz0I2ZutmuM3P6vAydq9nQkHMS?=
 =?us-ascii?Q?5HNNqrBVWp4Zp2j6GefXcXjgJ763F9ohWu/fSCUicSd0/5oJnESFEvoP/LHK?=
 =?us-ascii?Q?jwUa8AjHtWtAFsB8r8HZJyDcJkorUZQQDfiQ+b2PUkWtFyiYu7SYgQsL6kDo?=
 =?us-ascii?Q?a/s9WrbwqNsRo6D8W0+bMKFkOhbSb+oddpCQ535RSuyxapA7TbytSZ7pQACO?=
 =?us-ascii?Q?CvzbqRjiIuxMM3zVOE6sM724ypfVU01YcxBPlzO4Kza7shDnZTerWfHFd8he?=
 =?us-ascii?Q?0WtDwOeKvCJ8G2yPZHq72Yhzlw7oDtK3s/zC5q8C8TW/bhEgXHNZdtmLLt+W?=
 =?us-ascii?Q?aNXz+5pieRerFVL5WCcSiEG9y54Q0tEzuaGvasMX6raBnUcGogAT+RXg+Bn5?=
 =?us-ascii?Q?fOTnBEtLjJHBgegrh9NjCkr324hv51vS3mBUcEoUf/7KGpZHkel9H1wA9YD/?=
 =?us-ascii?Q?LEiVshyRcmjpEoDOHBx9m7jGOKqsoFCOlvWGN/4sb3TOeS4b73h9DD/tOd7A?=
 =?us-ascii?Q?YtkeF/WMQARXykYixo2CKTHFb15dHXRFu8B1736z6aoL+MMk6CHeDd1mW1dT?=
 =?us-ascii?Q?0VAeXoFW8a96LORW5D5Z7BzzuZjSPNJV8KruygT0FQGVS9LHYLIpCDzupO5j?=
 =?us-ascii?Q?Ujb1UwR+OChmKZZnO/x2nw//8rOcXSQa4kRwTEh5IAoznVCbSgKrk2Tso8AF?=
 =?us-ascii?Q?gwiOfjuAI8oYHUwEbQIkJM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:umROWAHybiin1EIbvku5+mSPfhUU3IChgw9Au0IVPbMwWPQJEGZtSvwERSe0n/G2VEPsWu0NR91DuSiQAhSQ5gqaPn6tDehaNMyHV0MIKwQphLMetBD3pHYHWWin2IOW+nearaMRm/ds5oHbC+Om8/mhPuM5yzjObjvm8MWdfDNmPYgvNZDJw0yWQUWkch7Zm9tLIw+nRN1inOuson5zu4PpviEIi/PmgQWEwZ0ac1vwoqR8EbHOEdMBSVGCYk3Q4LZvRg4ZPBhIOsQ5vpQBkFvcSBHbmXE7GMnvQn7wihGJqPKbau29JFqjjl/X4m0EshHJe0gMuGauVnftto4PVZ5VipnQwWUkDN7LlYR6rH0=;5:C+D8/DzGpcpYZils9ZYWjOKzijcbKaERnVgIBXKmUte/s3kGjonB857F2U28g7A5ZOu7ZMfV+hWUkf/Sn/PZInFje4hPMh7r0trp3jBKcMQsK8FXsgOjObc3ux+uhy6vI4Zk7Dhr1FNs1H5vqduYY448QHnAvYl2VdgC/5Ik0uU=;24:sSteVed0s3ljaqB/5FJ4cNVWQv1Mo0u7K6jvZER0gJQBp6lB4RlHvFT9Zeh/xH23hP20NocSVRHhUvrt5QcOXT7/fF1taDmD3cCKDZ/Zj3M=;7:JemAm4QrybYxBIDMLw7krvkGGsQMusIAclJFaIWEu0Ndv4ogMrRkrEYJrGS2SbdbNnwxalKZbMRYtre7u8GAlaKYyt0i/o61yOU98DEIE61D4RAiJqUTI9LE2ui+CQ0cUB3ToahnQ2NGtT+FZ1NiZC5dBkm82JYHJdzUJxPRAUowzFnmadGyogqknZ7xMfbLqXlzv29ZqA3FBp2w30tNunQQyFl7y6OQm5f3r4uv8vltyDGqin9dMehRfBMvLRPF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:FJJpBEIrJqaO1Gmm8toLAYBLfzMfWUBloKNGohGA0rAGvBDYJsxd52hvztnyIUlgphE4qR58KSDR1KGFlfS/6p3ywVTA1rNT9/6d/OFwcTInK3EpZZw0oR1ouqqNd1amNL0f8NEHPdCz9pzrXwI51ydnOlz05Ss0ubkNT5dkbnw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:41:04.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7f7d12-edb5-46b0-8687-08d573d21f63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcmaes_crypt_by_sg routine, that will do scatter/gather
by sg. Either src or dst may contain multiple buffers, so
iterate over both at the same time if they are different.
If the input is the same as the output, iterate only over one.

Currently both the AAD and TAG must be linear, so copy them out
with scatterlist_map_and_copy.  If first buffer contains the
entire AAD, we can optimize and not copy.   Since the AAD
can be any size, if copied it must be on the heap.  TAG can
be on the stack since it is always < 16 bytes.

Only the SSE routines are updated so far, so leave the previous
gcmaes_en/decrypt routines, and branch to the sg ones if the
keysize is inappropriate for avx, or we are SSE only.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 133 +++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index de986f9..acbe7e8 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -791,6 +791,127 @@ static int generic_gcmaes_set_authsize(struct crypto_aead *tfm,
 	return 0;
 }
 
+static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
+			      unsigned int assoclen, u8 *hash_subkey,
+			      u8 *iv, void *aes_ctx)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
+	struct gcm_context_data data AESNI_ALIGN_ATTR;
+	struct scatter_walk dst_sg_walk = {};
+	unsigned long left = req->cryptlen;
+	unsigned long len, srclen, dstlen;
+	struct scatter_walk assoc_sg_walk;
+	struct scatter_walk src_sg_walk;
+	struct scatterlist src_start[2];
+	struct scatterlist dst_start[2];
+	struct scatterlist *src_sg;
+	struct scatterlist *dst_sg;
+	u8 *src, *dst, *assoc;
+	u8 *assocmem = NULL;
+	u8 authTag[16];
+
+	if (!enc)
+		left -= auth_tag_len;
+
+	/* Linearize assoc, if not already linear */
+	if (req->src->length >= assoclen && req->src->length &&
+		(!PageHighMem(sg_page(req->src)) ||
+			req->src->offset + req->src->length < PAGE_SIZE)) {
+		scatterwalk_start(&assoc_sg_walk, req->src);
+		assoc = scatterwalk_map(&assoc_sg_walk);
+	} else {
+		/* assoc can be any length, so must be on heap */
+		assocmem = kmalloc(assoclen, GFP_ATOMIC);
+		if (unlikely(!assocmem))
+			return -ENOMEM;
+		assoc = assocmem;
+
+		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
+	}
+
+	src_sg = scatterwalk_ffwd(src_start, req->src, req->assoclen);
+	scatterwalk_start(&src_sg_walk, src_sg);
+	if (req->src != req->dst) {
+		dst_sg = scatterwalk_ffwd(dst_start, req->dst, req->assoclen);
+		scatterwalk_start(&dst_sg_walk, dst_sg);
+	}
+
+	kernel_fpu_begin();
+	aesni_gcm_init(aes_ctx, &data, iv,
+		hash_subkey, assoc, assoclen);
+	if (req->src != req->dst) {
+		while (left) {
+			src = scatterwalk_map(&src_sg_walk);
+			dst = scatterwalk_map(&dst_sg_walk);
+			srclen = scatterwalk_clamp(&src_sg_walk, left);
+			dstlen = scatterwalk_clamp(&dst_sg_walk, left);
+			len = min(srclen, dstlen);
+			if (len) {
+				if (enc)
+					aesni_gcm_enc_update(aes_ctx, &data,
+							     dst, src, len);
+				else
+					aesni_gcm_dec_update(aes_ctx, &data,
+							     dst, src, len);
+			}
+			left -= len;
+
+			scatterwalk_unmap(src);
+			scatterwalk_unmap(dst);
+			scatterwalk_advance(&src_sg_walk, len);
+			scatterwalk_advance(&dst_sg_walk, len);
+			scatterwalk_done(&src_sg_walk, 0, left);
+			scatterwalk_done(&dst_sg_walk, 1, left);
+		}
+	} else {
+		while (left) {
+			dst = src = scatterwalk_map(&src_sg_walk);
+			len = scatterwalk_clamp(&src_sg_walk, left);
+			if (len) {
+				if (enc)
+					aesni_gcm_enc_update(aes_ctx, &data,
+							     src, src, len);
+				else
+					aesni_gcm_dec_update(aes_ctx, &data,
+							     src, src, len);
+			}
+			left -= len;
+			scatterwalk_unmap(src);
+			scatterwalk_advance(&src_sg_walk, len);
+			scatterwalk_done(&src_sg_walk, 1, left);
+		}
+	}
+	aesni_gcm_finalize(aes_ctx, &data, authTag, auth_tag_len);
+	kernel_fpu_end();
+
+	if (!assocmem)
+		scatterwalk_unmap(assoc);
+	else
+		kfree(assocmem);
+
+	if (!enc) {
+		u8 authTagMsg[16];
+
+		/* Copy out original authTag */
+		scatterwalk_map_and_copy(authTagMsg, req->src,
+					 req->assoclen + req->cryptlen -
+					 auth_tag_len,
+					 auth_tag_len, 0);
+
+		/* Compare generated tag with passed in tag. */
+		return crypto_memneq(authTagMsg, authTag, auth_tag_len) ?
+			-EBADMSG : 0;
+	}
+
+	/* Copy in the authTag */
+	scatterwalk_map_and_copy(authTag, req->dst,
+				 req->assoclen + req->cryptlen,
+				 auth_tag_len, 1);
+
+	return 0;
+}
+
 static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
@@ -802,6 +923,12 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	struct scatter_walk dst_sg_walk = {};
 	struct gcm_context_data data AESNI_ALIGN_ATTR;
 
+	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
+		aesni_gcm_enc_tfm == aesni_gcm_enc ||
+		req->cryptlen < AVX_GEN2_OPTSIZE) {
+		return gcmaes_crypt_by_sg(true, req, assoclen, hash_subkey, iv,
+					  aes_ctx);
+	}
 	if (sg_is_last(req->src) &&
 	    (!PageHighMem(sg_page(req->src)) ||
 	    req->src->offset + req->src->length <= PAGE_SIZE) &&
@@ -868,6 +995,12 @@ static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 	struct gcm_context_data data AESNI_ALIGN_ATTR;
 	int retval = 0;
 
+	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
+		aesni_gcm_enc_tfm == aesni_gcm_enc ||
+		req->cryptlen < AVX_GEN2_OPTSIZE) {
+		return gcmaes_crypt_by_sg(false, req, assoclen, hash_subkey, iv,
+					  aes_ctx);
+	}
 	tempCipherLen = (unsigned long)(req->cryptlen - auth_tag_len);
 
 	if (sg_is_last(req->src) &&
-- 
2.9.5
