Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeBLTwL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:52:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751208AbeBLTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:51:57 -0500
Date: Mon, 12 Feb 2018 11:51:28 -0800
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
Subject: [PATCH 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
Message-ID: <20180212195128.GA61087@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: DM5PR19CA0040.namprd19.prod.outlook.com (10.173.167.154) To
 CY4PR15MB1751.namprd15.prod.outlook.com (10.174.53.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bbdf3a2-cdc2-4154-f3eb-08d572520652
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1751;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1751;3:/DKnvTSyII+C5PlaxULNjBUZ5Y1qBtn6N5MgMql49iE8s4JX8X5GSqP+shjY7IE7Uz7Twii9+QBHFW0iudk/XDIirfdmFhwKmeR60aFCfa19lQCCqIqh3Ebd+wqkr/6xMxrgKfvH9s39KmtD9884wzWnnZy7d/UQ+Pi7h6RMMdIFMYDq1u3JWzlcBDMn/UbTExZulfMWCAIAN9KSKRh2w8bv2rIm5fP0ZdEY6F5KT3gM+IbWw+ts/u3HQfBLEqcl;25:TJKzV2mf/rAoi6IJDams7P9h+IouGHVgcp28CAP7jU6iO335zT7jbb4oZQmxP5gaBaIXY0rfBe0eEXQOQrdDH/mSzBd3ECeNelUOyoNIxkxBbGxXoiXrQl/vFed/B4xq7W4pOowTPg10PXcX1VHvMBAx4wP9N/eMEqc+bvX1CbSvh6uPUfjaAFheTNa8oner4qCggUJTDqg1LxZaVJ4/YqzEWGTOFW0Y/c6C8Skt9qMKzC7/LisU+JeJ6UUj7k8v/4HHdMT/Np493a4MrJU9Rd3BKFZWfErxZ5xIn8v8PnF6mHcKj+gHkjA9+qI5vL2450e6gMLTFXudTOdUr2yHgA==;31:gtkrVujWpob2+0QRrpsqcLIjKnLNaDZwEFUMnkK6GCM2aSw7q3W9q4vSdk9HqyA4hrSGaD7QRgya2E7corhO9wTasRRiV4os78X19AMm4XyU7bA/hMnpyKEGNsQ6ofnbjG2tw2VimZ+2U923ZERKal2TH27G63LknV8vV6oKTb8qg6VN9jyiLffcbDiU4JCfeGoG5mA16iqWSROpFoHojHhZy/TP3Nc8do2BI2b0Voc=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1751:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1751;20:WlUGgxN2Jvg7+WkwnQZ/+OdkvRnVrMzaZxOvXWatQ2VOZbrwqsd9fsFcbFrBtfyfZqPOBbgNl6lVWW9vL3Gh4eyPaz1dzHC4SOw/pW7dMagW9tFJQjk5kXNKp+qYVYGV0neQeHo2ZNXOwqZMPsRLzVxyV0u/0Nm1VHc1UlU3irQYAtFz0i3fMIOQ4nLyPcR6RVjFUU8gKYceHlSIVg+EPyciEd/hdwfduosgZlGCzx1cXkiTSR8n9Z7lXGfxOSjCCLl1YF0Tq4RQkuVgv6Hmq1XDH3Z480CY6LbgwLR19S1x17KCi1FonqXJfM+RryQ31A0j8vGMlHLyEDMtZI+wuUMGJQIwsRkn6h4YBQdNw2KYOHfCjQVHfEA+n8aYaT86vF83a116TS2Ite8DfVU1ZW99TB6MYXAsb11WpmwO1MX61HDamcT1ih1c/StR8zCmGtsDtYA2WqbOdR96fdREmTx1jd0dLkaPWuHGPiLJUMC5PoWyOZh51z9Nd+aAc4tA;4:2Uxa6JIMyPqwDhzFMNpxBStSRInolDM9W4pNyy1rbhbenQqHkTmUagD0cvfTNjaMMMdCDpTec28IYVIrxjx5TmWrw63/IwVVudzgiNA/Ejy/wdiUyHcaraBkLFu9LA0BdJCWwufxo0sUecAx3A1GexkH9ZOwETY/3cRxnXgmJhGyZ1TFC44KWMtOQURL2N2ECnAIzfys/M8JMjsMDy3P/HJ8oIm9VxykUFOi50agsIGkNcUJ3Z9obP7TCpoSvVlDHBMK2FC/E6r1lshfTGLvu59jaJGukBD/OET4VVTaON4ZFRg+1uO4PgVUQWtrbW1n9qCjsxtFBi/vzUpZSOadZGbJbaaNfp3w4eopZjlLkXI=
X-Microsoft-Antispam-PRVS: <CY4PR15MB175154A1D595E05693F4B813DDF70@CY4PR15MB1751.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(10201501046)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR15MB1751;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1751;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(199004)(189003)(68736007)(33656002)(23726003)(6496006)(33896004)(106356001)(6116002)(54906003)(86362001)(316002)(15650500001)(7416002)(52396003)(9686003)(110136005)(58126008)(47776003)(1076002)(16586007)(50466002)(59450400001)(7736002)(305945005)(76506005)(83506002)(98436002)(76176011)(53936002)(386003)(25786009)(186003)(105586002)(16526019)(8936002)(2950100002)(6666003)(97736004)(8676002)(478600001)(4326008)(6486002)(81156014)(2906002)(81166006)(52116002)(5660300001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1751;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1751;23:qORhojCMzgiJ2QHsScSv+jsX8rC7DF00vcD9sNAct?=
 =?us-ascii?Q?jxa3oMloPc9k/gDCWiQKVx8S2ANts6ziVEyawE9Kt0oMKDYbeVQtuRccUYoc?=
 =?us-ascii?Q?3KUV8AUKG/wQQSHYp2XrEzooFgozm5255i81l9zyFETZ8mpOWqjZVww9H756?=
 =?us-ascii?Q?OVr3YxkulZGL5eGUPvqtsLVtDHkcRgHbVnMq9l1KESStpLmdII8BBW7S9E9M?=
 =?us-ascii?Q?v98KOCrlKvM0BeN8TKT6aXXpjMErUFW+hp2NntFUDtWbE9Ob5gm24MbVZvat?=
 =?us-ascii?Q?vXDxbm7dm8a3z83cVip/GepjzFTaZNNsOT3Qn+zUrHT1IEkHRm0wdSUOUu7v?=
 =?us-ascii?Q?qlW2517U/sqNHIroPzqSuLwhAWWI0Yh4aEhssz/OixreD3FcdUcXgXEAFUuf?=
 =?us-ascii?Q?QqQi350iF9qQk5sAfLn2wdGN+SqQT+zN8DSnKD5z2H0OqE2fCmpWl0NoR5GY?=
 =?us-ascii?Q?ey/z8n+qu6MARtaHKEPfh75+ZDaMJ1zjBEAqwnybZULjp4k3tDWcPW8lqUAK?=
 =?us-ascii?Q?dHR75f2bhSbePazdNBHcVObmCqr7bltPyx1EczCRW7maMSCDxdcEPW1qtrRY?=
 =?us-ascii?Q?GOFWyW3K49RrwDJN91x/C8xXe44xMXRPUNLomfKo9/taud8IBZ30NY05oaKy?=
 =?us-ascii?Q?0aQ57lg5h2y7gYTkEBt+aLaginsdZ/tD0QTgIyPFXn8gISwgEeK9laWOdC6l?=
 =?us-ascii?Q?1N1WjbXXQV4GE8I8pNLpLZC+ZDlzR6ZFqyVNGUUoHvud6RNiJ/wFzqYZmJ5U?=
 =?us-ascii?Q?qhPK5di/xDUY/WZA81BdjGdOvDswhBaLCEDqfVJzblqZ133Ddp6YRDFTqZTh?=
 =?us-ascii?Q?vt5vWJ5HcaXsWL0ttY8kN6UDXrD9h8CZBCQjocvADMnZEe/hNYxgzQ0gU7KI?=
 =?us-ascii?Q?9bWSgb6BzgXTyidBfi/aZFhRyhnrNtgRsjVmSaopkHzuB/4OKkoi0gDzQs5E?=
 =?us-ascii?Q?YhFSfy95zyN6jWD+/MtlkcCr8/PyUIvcOuREpZxW1uh9YD/Zy092XydKtM8w?=
 =?us-ascii?Q?AT8E6o2rJXIiYZPHgF1k1PwcbD1deuF0plQwp14mwgHJlPO1B+lprI2KeBjW?=
 =?us-ascii?Q?7dNvrGXgPh+u90tkLd4HZ8StZ9Sh8LNmrB8iAxWdb9vX4hOmPVPxGVFCrFSl?=
 =?us-ascii?Q?JWfv1dIRj2lfaLFyAsKuswNrpg4y37OCdNrfmY0/95kkXN3SAOYYvaWUlvRe?=
 =?us-ascii?Q?fjA91yI2VpjGPa8LD7+fs1xxxKTFDWsu67FbCltYMYCsMYbVCvAuiPGTXqep?=
 =?us-ascii?Q?QChJuLYJ3tES77XmJMOhi++U1m/DDOBT38tlvgYg9SzpVWFmfuKhIfNlkEkJ?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1751;6:0MmFJ0xF4nyNgEZTxzVlQtcAeQ2300+dK8zCfgzW0PpFp6QLvsQXK95AI7lBdpIR7gTe/r2vXzSw8+JFsOUpmIYIi6sj9iPzE961lNiZ8hEm1DZYh4icZo6Acrm5C15fA2yvNxWj6iY6VdSpMItTjmn8wYyVi8uYGnXLAh4dHLu0IH9iVPAdEEGUovfVlPf9ipki+6ssQuHFqaEqU7bWau0H/OoV24ICEAgy9wf5TBRaofUIk8tUrFnDCTtGvCYDnqtEcyr749XsjBshsw5fVjWxme0+ksdnZbE7SVzNPIMTDaa740cHDryGvRMC1qnNB2p04hj7CA2sO1jn2gPu/taSxWN9PlkbY/OIcfl5J/s=;5:4dgboxe9vxIH6Og5dVudQ1nba7+IXMs9VSRHYNLJ4IMo8p+4HLTMxrMX29E0mnnxVfH4LvA2OIOXjtvhxS5h3u1Crh1tqDpv+ezVJFFOKLB+zubFs6O34OlnsvoNIOvoyUgkmdJ8kMq+e38esNPMJFEoU3nZ0YbpaEoftat3WTc=;24:+4N3ff/m31SafJB4omRxWmRLKnmFLD+1UPZxQUmv4iILTbDM5yFsmLjKHjM1grfyz/RKIQtD+2xvWle9wQbzKlpp9xV8f5H4Fz1D9KbKin0=;7:UvyRnkxNl3OuAGKyOFLtuBDT0g6IPERo9fR6KuGJ0KjQQK5bKw+77zNwIV/Cv4BIKxaaakm0IzZBb5ZY2ESkQik2zSBFkH41EQ0gW7IIe4U0bqy67UDdNxwF++SxiojdG21g/QIvEZjeJXi3DSZps4tBC9tLgApxyOLGpoeYmplv1B49Gnyrw8z2kWrYiWsQFvkjXHDBR52sHbfZBzDnWIue4YQkwhEXAQ1Ts9G/FzuPPPHdmpFv0jGrNTl3EzE3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1751;20:S+iI0XoewMGtOqso/TpGmy2Kw0vjJTwA1O/0hWcr+JT9DQKJWViMHjb6sDv2buFWH0itphfM5ww4LIXjVhkKrw+Q/8BLRxdDzTAWX+U6iagHkrjkvr++zUGBOBabGJiwsH0h6gymzJuuCsHnTIlLBmKtzwkTxzCO3sWmTBGd/YA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:51:35.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbdf3a2-cdc2-4154-f3eb-08d572520652
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1751
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcmaes_en/decrypt_sg routines, that will do scatter/gather
by sg. Either src or dst may contain multiple buffers, so
iterate over both at the same time if they are different.
If the input is the same as the output, iterate only over one.

Currently both the AAD and TAG must be linear, so copy them out
with scatterlist_map_and_copy. 

Only the SSE routines are updated so far, so leave the previous
gcmaes_en/decrypt routines, and branch to the sg ones if the
keysize is inappropriate for avx, or we are SSE only.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 166 +++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index de986f9..1e32fbe 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -791,6 +791,82 @@ static int generic_gcmaes_set_authsize(struct crypto_aead *tfm,
 	return 0;
 }
 
+static int gcmaes_encrypt_sg(struct aead_request *req, unsigned int assoclen,
+			u8 *hash_subkey, u8 *iv, void *aes_ctx)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
+	struct gcm_context_data data AESNI_ALIGN_ATTR;
+	struct scatter_walk dst_sg_walk = {};
+	unsigned long left = req->cryptlen;
+	unsigned long len, srclen, dstlen;
+	struct scatter_walk src_sg_walk;
+	struct scatterlist src_start[2];
+	struct scatterlist dst_start[2];
+	struct scatterlist *src_sg;
+	struct scatterlist *dst_sg;
+	u8 *src, *dst, *assoc;
+	u8 authTag[16];
+
+	assoc = kmalloc(assoclen, GFP_ATOMIC);
+	if (unlikely(!assoc))
+		return -ENOMEM;
+	scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
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
+			if (len)
+				aesni_gcm_enc_update(aes_ctx, &data,
+						     dst, src, len);
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
+			if (len)
+				aesni_gcm_enc_update(aes_ctx, &data,
+						     src, src, len);
+			left -= len;
+			scatterwalk_unmap(src);
+			scatterwalk_advance(&src_sg_walk, len);
+			scatterwalk_done(&src_sg_walk, 1, left);
+		}
+	}
+	aesni_gcm_finalize(aes_ctx, &data, authTag, auth_tag_len);
+	kernel_fpu_end();
+
+	kfree(assoc);
+
+	/* Copy in the authTag */
+	scatterwalk_map_and_copy(authTag, req->dst,
+				req->assoclen + req->cryptlen,
+				auth_tag_len, 1);
+	return 0;
+}
+
 static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
@@ -802,6 +878,11 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	struct scatter_walk dst_sg_walk = {};
 	struct gcm_context_data data AESNI_ALIGN_ATTR;
 
+	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
+		aesni_gcm_enc_tfm == aesni_gcm_enc) {
+		return gcmaes_encrypt_sg(req, assoclen, hash_subkey, iv,
+					aes_ctx);
+	}
 	if (sg_is_last(req->src) &&
 	    (!PageHighMem(sg_page(req->src)) ||
 	    req->src->offset + req->src->length <= PAGE_SIZE) &&
@@ -854,6 +935,86 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	return 0;
 }
 
+static int gcmaes_decrypt_sg(struct aead_request *req, unsigned int assoclen,
+			u8 *hash_subkey, u8 *iv, void *aes_ctx)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
+	unsigned long left = req->cryptlen - auth_tag_len;
+	struct gcm_context_data data AESNI_ALIGN_ATTR;
+	struct scatter_walk dst_sg_walk = {};
+	unsigned long len, srclen, dstlen;
+	struct scatter_walk src_sg_walk;
+	struct scatterlist src_start[2];
+	struct scatterlist dst_start[2];
+	struct scatterlist *src_sg;
+	struct scatterlist *dst_sg;
+	u8 *src, *dst, *assoc;
+	u8 authTagGen[16];
+	u8 authTag[16];
+
+	assoc = kmalloc(assoclen, GFP_ATOMIC);
+	if (unlikely(!assoc))
+		return -ENOMEM;
+	scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
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
+			if (len)
+				aesni_gcm_dec_update(aes_ctx, &data,
+						     dst, src, len);
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
+			if (len)
+				aesni_gcm_dec_update(aes_ctx, &data,
+						     src, src, len);
+			left -= len;
+			scatterwalk_unmap(src);
+			scatterwalk_advance(&src_sg_walk, len);
+			scatterwalk_done(&src_sg_walk, 1, left);
+		}
+	}
+	aesni_gcm_finalize(aes_ctx, &data, authTagGen, auth_tag_len);
+	kernel_fpu_end();
+
+	kfree(assoc);
+
+	/* Copy out original authTag */
+	scatterwalk_map_and_copy(authTag, req->src,
+				req->assoclen + req->cryptlen - auth_tag_len,
+				auth_tag_len, 0);
+
+	/* Compare generated tag with passed in tag. */
+	return crypto_memneq(authTagGen, authTag, auth_tag_len) ?
+		-EBADMSG : 0;
+}
+
 static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
@@ -868,6 +1029,11 @@ static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 	struct gcm_context_data data AESNI_ALIGN_ATTR;
 	int retval = 0;
 
+	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
+		aesni_gcm_enc_tfm == aesni_gcm_enc) {
+		return gcmaes_decrypt_sg(req, assoclen, hash_subkey, iv,
+					aes_ctx);
+	}
 	tempCipherLen = (unsigned long)(req->cryptlen - auth_tag_len);
 
 	if (sg_is_last(req->src) &&
-- 
2.9.5
