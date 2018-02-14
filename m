Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161493AbeBNRlU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:41:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161447AbeBNRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:41:15 -0500
Date: Wed, 14 Feb 2018 09:40:47 -0800
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
Subject: [PATCH v2 13/14] x86/crypto: aesni: Introduce scatter/gather asm
 function stubs
Message-ID: <20180214174047.GA62219@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: DM5PR0102CA0031.prod.exchangelabs.com (52.132.136.44) To
 BN6PR15MB1745.namprd15.prod.outlook.com (10.174.238.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e6beb6b-be8f-4a4d-8d69-08d573d217af
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1745;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;3:pXJ7upthD67rkdbBcFkm6lE1nCazGrKhLcavHSxFopz50f0xKzKmnlkwa+S3VUv788BecYwNfsAd49quOYuQrmfPsCSMNPJrHuZuJ2w6g3Rj/AoB1k9AFiOBruQaA+w9Jy4mfyYNAonCkjlCQrgOF/k7vZ83zLJn2bPwT51nnpGAsV3cFI5k5R4bID0hAxjPYVHmw+OFuUM6YIBrLMjhd5+muhCEGjwpIwTCWVfpBJ8bV/UWWFXvUYlbKmTP+c/8;25:jdDxtcT9wuPTzgTyb46CsOrbVtzbo60csEqeJMSgkoaQPnsPcPt5QMe8eLvkjZuMbK8NtLekGWjOoxWT8qqBFVyYU6+ZjxUmP7KuU7g7wqcpzH7tc5LuC4RWKs217QkvQYAFlQY/wPsOBLsAVRt/vslkWp60t6PrS9sXicK5VJNF+DAvhXx1bVkBAsyhR7ZPVkELJ5D8nSiHUwS2zMzsm9hByj1QhigXdX4RV+UxiFxYaNasH82KJp2ZgLSXVD5JQimHhO9zQzKOzi6Jsno85skxrXRSqOJgQFd1jdTGoaEyZLwlUlk1vilaPOJ2DsedXz87trpRK30Sy2P/RAaX8Q==;31:/zDrGceu4BFeROzY5ooSTtOq1AOUu5sbQeCbz4roJcxXHaQbN+ketOA0JvIImDoT4/WqqLAPBmgpTbXoVVR5q1rN9c5Hwn6DOKvw36TQYQmotPy+TEb8y4jO7GKZpCugI5WJG+IIoKHRgTYt7NcHau0x0IZH0tiUNZGqHhpN+giV1Sf4uRn/23gOIGppGPZsDJqcve1WvPkEjhbq66CndgJ0VremsZGJp0Wd2gq4m0g=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1745:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;20:SSAFV2K9YkLzvD3OoJ2+fg/n7s5UgLJaQtwLHBoC3eSSh+dik/CMLRM1n/W6qy4y0fxh6iakvJWBZ3wOnRNJfAtCLE8RVoIwXKowCBpeHFQchHkLAa0EuQd8GvmisXE4NpWJGCjnIsp12KnDFQsO49xEE5epTyW5wk8JRzAB9ADD/mq9xG3qPx6enQFxMn2reST2bxcim5mEAOIUWn17CegETxDcWrk0Wn0G3/MVNh5LCeGuxHN1Gh/Ig1dXUH9qbj+bwATfQ8epvZ6cxs35+n3lCyj5frvFTWPOTlJ4teBIxOZuMa8Udd5FKdvOJSbBJ8sn8Wi0JMHdZyJs5bbbUt1IEXILnopIhnhUYK4VyXiVwtXkVnTjq4Oc4JGb/p+tz3plbuU9P8iEWe5yX0/+hGCxP/n7qxqIlJEJ8NtRj+c0rq9CLCX0VWx0OxNikHkhvmNnUHPspkFP6vRCVOKY26pY9UjFdzZqql8/kXCHOL4ZMXNFr67ps8mVXrUd4B8e;4:pk24eWGZSVvZmYPcGlxDqMwdCmJ22Ikq63aSMrGvA42EMEvLvz8+CSibOHSBx4XfH3QLchCLE+jfFazB9J+pGmWOyKGzcmQ+P7nnnCU6xoFecqAJbsRf3Uz2ZRxM7vrqVmNhb7Wfakvw/24lLexx/Bv6T3X/6dp3w0ql4ao9ON2etLEEMPNR8A8tmt4QAe9aRG4yFAXEutQKHs2vUswUb4iSdsHgePqzoAF8hG47y77+L+MLNXTXGfilXNGJ4N0RXid+w+LWEYH1ETV95d3tdEP2TOWk/g5moEIEacXS76S8oVW0TAgFWH9ChFO0PzGSbKptyGni3mmE0XRhNHdN95Una1OMc1FxXHXTl23Ud9nSeLRO83GN57QyflsMa8RX
X-Microsoft-Antispam-PRVS: <BN6PR15MB1745F6A39CB8DDE37B9F12A2DDF50@BN6PR15MB1745.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(11241501184)(944501161)(10201501046)(3002001)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1745;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1745;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(189003)(199004)(16526019)(6666003)(186003)(6116002)(54906003)(106356001)(386003)(33656002)(47776003)(25786009)(5660300001)(2906002)(23726003)(33716001)(97736004)(8676002)(316002)(81156014)(4326008)(33896004)(81166006)(478600001)(50466002)(76506005)(110136005)(1076002)(2950100002)(76176011)(8936002)(16586007)(58126008)(6486002)(105586002)(86362001)(53936002)(68736007)(52396003)(6496006)(9686003)(59450400001)(7416002)(83506002)(52116002)(305945005)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1745;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1745;23:JNqEflq9HxCb0toRUJ9QO0RlJYegy4blrcrR24pMj?=
 =?us-ascii?Q?APlKmzBDn6ZD7E3F/iZN2YGXsLlJDThSXNZh3j9njWAdPq1WbhoxmEtWdevZ?=
 =?us-ascii?Q?RPkfqhA3fMvc5+wLj4rSufI5LGp0qL/XzEzgpNLZMjaGaAXykZoWL3FyxRz4?=
 =?us-ascii?Q?KbELCbSE5KejhxfAE9cm+Tb0J8A5+fNiOWBNRgV+EnNaHe7Ywxiu69TFBHpX?=
 =?us-ascii?Q?nRPe0X9kvENiU0JOmrqzMc15+jMl+TjKBiMvd8PJcOIT0Rp944suEBE3e4Uw?=
 =?us-ascii?Q?OJMfBpLeKZXZ1nH7Zaaeuk6EKvnPy75y15qXruX/8+BtXNup519K0+kKZaxz?=
 =?us-ascii?Q?jr96kOhCIIwe7ePLwwxjw73vzfcxuvN+Njeascrze/Z+YlUtByivehb5cmNW?=
 =?us-ascii?Q?HaUeXt0KwCDKF0tyeHXTsWEnuVMKG9iTInlpxh8Ab9zo5c6jaiKHN4FHcAeI?=
 =?us-ascii?Q?U2GOyALfvvML2r7rGaRwja8otgmk3k0KnPXLC/HkV8GoEBdsttvpqNYjgGep?=
 =?us-ascii?Q?19Sr9/Gq2uB4ryHgE//eYytDVG7xBsrrjLADR8mTqr8PHjB6WTyzK2lPYWi2?=
 =?us-ascii?Q?tgY7MSNJ98p1gVhga2c+kudQ8s8vVXyo6mreP87DrHuCL3KvQ9Gjkp8XW4+X?=
 =?us-ascii?Q?7Ii3AUOKnJ5w3UiIG4UxPcc4k3bnYlzgO7WMsvasd2N5nsivGgD6Vn8ISmKS?=
 =?us-ascii?Q?6TzJNkxUUFGtOLKE6EN3ZzA3ctE7cZoVNHlfKt59g1qD2cubSPObmNG/BFU1?=
 =?us-ascii?Q?rcK5UT6sVEpSouswCtvEWfC5jWMTiNuEMtugsoKb1YRZqxK6yGfCAzOp0Kwe?=
 =?us-ascii?Q?9ENwSG0sxTzmQjJvv10GJl53W0AOWRTntG49sKhaCm5DCVhvwbhISUiLcDNE?=
 =?us-ascii?Q?+ABAY4ALTlEklM/Z0mbKt99R/umhaQVYGCUtakexO7jluKfX/90ViETjskts?=
 =?us-ascii?Q?ZVc91Y7eLBL78QoU1SLyzWWoRBIRtwx4pJKegNJ/HonJ8C+HhQeooU2oQISS?=
 =?us-ascii?Q?qfV0j5WACfH8Yfc28Ko0ojvsmIxsmNBWa5jUXoN7RHucDrLwJ1Ojmp05Oojc?=
 =?us-ascii?Q?E600pvWFoQ4eWH9w2MR1XLwjfh2ptYuKi236bY/YlYPipmUVQmUodUbJFP21?=
 =?us-ascii?Q?hWIuvOM2qEyYLvLtySBDh0xoudGH7rBUUTSaWljgGJsFxB6+sOtp+OfW7k4R?=
 =?us-ascii?Q?3h66mPNHIhEbkjlgVQBJdHPu3m/Zp9UBvU1A5mDpZV1yU6wIVGRhQvKZW2B/?=
 =?us-ascii?Q?rZ2RCVAhXtYTrPe6liRARJmoDXeMeTXhQf93GMbMOT3FMyluD8dI1UfxH83J?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;6:vMhRFC1F7lUXazm6hDdvmkH+QYk3XvSLvdAzEAg30FR1bt8ZUZ/cmPujXDovaI6CD4bwUrakuWyX8ff+IpSfZ2gyfGE6EDCix8vsITBws2T8LD7XJny8mn5zGg9LabqHYV9DV4LZ+ExjB6x3WtqveivgIQAFLIrqSfUMN95Gxky38k6L/xCIhuRDHh17BxidkGlQw6TYLHCJazBAzSbrUCWPRYiCFMAGtUKiW5TYzfnswjS5BELfVi4gy54rz2Of1UsVtSaN33ywwgAWh6D0NXUnZszuOs1yI5EcGZY3+25Z2pwlJkStLhfReKl8qeBEkEtLmj1dw96+Zfu5UnQ4TbEXg7hiYf4OSqPBJ2Qvojc=;5:foj+oVeVDKwb7LZzZh2EQRFcE2Ei7KKQVC40ydUyRjgqnKNoaBPNF34VkCUnBzvbYEpsGufUYPFandu4xuCSiJa3f46w6CnW3jADfYjSDUc/EjPiYkvLM7oLjHqLSZtbcpi2Y7t/9wzG3CU0PHMeIxI3TEOtYpxAR1nl/kko4m4=;24:UuLN71czhn9X0B886jU1nnzqFJCGswZeUpqpQV7qng3unoB+2ZzUgsY7BhnXIriG5LsTuVWO2gVlpd+u205FHvl2Fjhz2SXqsOoE5PThAio=;7:SxIbLSjWzBrr+sO/C+NMRUFj68sp34ozpmkgXMzI4ycclu3k8QWwk5Tew11budfDL6P072uIvuIxb+tsue24zNgLwbLn83T/zdIpGFwIa5RNa5qvplraJ9cw1FaNJ6a19s46nEZNUfOQCC7FZHtdkr8eGOlfY98paAxTUwe0WE2mTWqom6iU934wS81YsrXAVDlJtjXhG+CYQ1DldDP+f9DfJelNGVQTzJAwbIUxuok+iIWfczWmJpu8zIKgajti
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;20:9BjmwXqygw8noARotvXlwlQy6ERXVAMX7yEM19SqrMLYGYEEFY944Ntgarl/UTRUwA+rJk6+3KK+0FoFnKMY3tO4khLqUWknv+tPc3k9YJ15UNd6GBo3qsV8U6z9YBV6RI9bB1EEwRTnRX9jLzhw9zKth/IckHNDY9C6px8ngq0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:40:51.8156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6beb6b-be8f-4a4d-8d69-08d573d217af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1745
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm macros are all set up now, introduce entry points.

GCM_INIT and GCM_COMPLETE have arguments supplied, so that
the new scatter/gather entry points don't have to take all the
arguments, and only the ones they need.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S  | 116 ++++++++++++++++++++++++++++---------
 arch/x86/crypto/aesni-intel_glue.c |  16 +++++
 2 files changed, 106 insertions(+), 26 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index b941952..311b2de 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -200,8 +200,8 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # Output: HashKeys stored in gcm_context_data.  Only needs to be called
 # once per key.
 # clobbers r12, and tmp xmm registers.
-.macro PRECOMPUTE TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
-	mov	arg7, %r12
+.macro PRECOMPUTE SUBKEY TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
+	mov	\SUBKEY, %r12
 	movdqu	(%r12), \TMP3
 	movdqa	SHUF_MASK(%rip), \TMP2
 	PSHUFB_XMM \TMP2, \TMP3
@@ -254,14 +254,14 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
 # Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
-.macro GCM_INIT
-	mov arg9, %r11
+.macro GCM_INIT Iv SUBKEY AAD AADLEN
+	mov \AADLEN, %r11
 	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
 	xor %r11, %r11
 	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
 	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
 	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
-	mov %arg6, %rax
+	mov \Iv, %rax
 	movdqu (%rax), %xmm0
 	movdqu %xmm0, OrigIV(%arg2) # ctx_data.orig_IV = iv
 
@@ -269,11 +269,11 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	PSHUFB_XMM %xmm2, %xmm0
 	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
 
-	PRECOMPUTE %xmm1 %xmm2 %xmm3 %xmm4 %xmm5 %xmm6 %xmm7
+	PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 	movdqa HashKey(%arg2), %xmm13
 
-	CALC_AAD_HASH %xmm13 %xmm0 %xmm1 %xmm2 %xmm3 %xmm4 \
-	%xmm5 %xmm6
+	CALC_AAD_HASH %xmm13, \AAD, \AADLEN, %xmm0, %xmm1, %xmm2, %xmm3, \
+	%xmm4, %xmm5, %xmm6
 .endm
 
 # GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
@@ -435,7 +435,7 @@ _multiple_of_16_bytes_\@:
 # GCM_COMPLETE Finishes update of tag of last partial block
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
-.macro GCM_COMPLETE
+.macro GCM_COMPLETE AUTHTAG AUTHTAGLEN
 	movdqu AadHash(%arg2), %xmm8
 	movdqu HashKey(%arg2), %xmm13
 
@@ -466,8 +466,8 @@ _partial_done\@:
 	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
 	pxor	%xmm8, %xmm0
 _return_T_\@:
-	mov	arg10, %r10                     # %r10 = authTag
-	mov	arg11, %r11                    # %r11 = auth_tag_len
+	mov	\AUTHTAG, %r10                     # %r10 = authTag
+	mov	\AUTHTAGLEN, %r11                    # %r11 = auth_tag_len
 	cmp	$16, %r11
 	je	_T_16_\@
 	cmp	$8, %r11
@@ -599,11 +599,11 @@ _done_read_partial_block_\@:
 
 # CALC_AAD_HASH: Calculates the hash of the data which will not be encrypted.
 # clobbers r10-11, xmm14
-.macro CALC_AAD_HASH HASHKEY TMP1 TMP2 TMP3 TMP4 TMP5 \
+.macro CALC_AAD_HASH HASHKEY AAD AADLEN TMP1 TMP2 TMP3 TMP4 TMP5 \
 	TMP6 TMP7
 	MOVADQ	   SHUF_MASK(%rip), %xmm14
-	mov	   arg8, %r10		# %r10 = AAD
-	mov	   arg9, %r11		# %r11 = aadLen
+	mov	   \AAD, %r10		# %r10 = AAD
+	mov	   \AADLEN, %r11		# %r11 = aadLen
 	pxor	   \TMP7, \TMP7
 	pxor	   \TMP6, \TMP6
 
@@ -1103,18 +1103,18 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	mov	  keysize,%eax
 	shr	  $2,%eax			# 128->4, 192->6, 256->8
 	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  aes_loop_par_enc_done
+	jz	  aes_loop_par_enc_done\@
 
-aes_loop_par_enc:
+aes_loop_par_enc\@:
 	MOVADQ	  (%r10),\TMP3
 .irpc	index, 1234
 	AESENC	  \TMP3, %xmm\index
 .endr
 	add	  $16,%r10
 	sub	  $1,%eax
-	jnz	  aes_loop_par_enc
+	jnz	  aes_loop_par_enc\@
 
-aes_loop_par_enc_done:
+aes_loop_par_enc_done\@:
 	MOVADQ	  (%r10), \TMP3
 	AESENCLAST \TMP3, \XMM1           # Round 10
 	AESENCLAST \TMP3, \XMM2
@@ -1311,18 +1311,18 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	mov	  keysize,%eax
 	shr	  $2,%eax		        # 128->4, 192->6, 256->8
 	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  aes_loop_par_dec_done
+	jz	  aes_loop_par_dec_done\@
 
-aes_loop_par_dec:
+aes_loop_par_dec\@:
 	MOVADQ	  (%r10),\TMP3
 .irpc	index, 1234
 	AESENC	  \TMP3, %xmm\index
 .endr
 	add	  $16,%r10
 	sub	  $1,%eax
-	jnz	  aes_loop_par_dec
+	jnz	  aes_loop_par_dec\@
 
-aes_loop_par_dec_done:
+aes_loop_par_dec_done\@:
 	MOVADQ	  (%r10), \TMP3
 	AESENCLAST \TMP3, \XMM1           # last round
 	AESENCLAST \TMP3, \XMM2
@@ -1598,9 +1598,9 @@ _esb_loop_\@:
 ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
 
-	GCM_INIT
+	GCM_INIT %arg6, arg7, arg8, arg9
 	GCM_ENC_DEC dec
-	GCM_COMPLETE
+	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec)
@@ -1686,13 +1686,77 @@ ENDPROC(aesni_gcm_dec)
 ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
 
-	GCM_INIT
+	GCM_INIT %arg6, arg7, arg8, arg9
 	GCM_ENC_DEC enc
-	GCM_COMPLETE
+
+	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc)
 
+/*****************************************************************************
+* void aesni_gcm_init(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                     struct gcm_context_data *data,
+*                                         // context data
+*                     u8 *iv,             // Pre-counter block j0: 4 byte salt (from Security Association)
+*                                         // concatenated with 8 byte Initialisation Vector (from IPSec ESP Payload)
+*                                         // concatenated with 0x00000001. 16-byte aligned pointer.
+*                     u8 *hash_subkey,    // H, the Hash sub key input. Data starts on a 16-byte boundary.
+*                     const u8 *aad,      // Additional Authentication Data (AAD)
+*                     u64 aad_len)        // Length of AAD in bytes.
+*/
+ENTRY(aesni_gcm_init)
+	FUNC_SAVE
+	GCM_INIT %arg3, %arg4,%arg5, %arg6
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_init)
+
+/*****************************************************************************
+* void aesni_gcm_enc_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
+*                    const u8 *in,       // Plaintext input
+*                    u64 plaintext_len,  // Length of data in bytes for encryption.
+*/
+ENTRY(aesni_gcm_enc_update)
+	FUNC_SAVE
+	GCM_ENC_DEC enc
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_enc_update)
+
+/*****************************************************************************
+* void aesni_gcm_dec_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
+*                    const u8 *in,       // Plaintext input
+*                    u64 plaintext_len,  // Length of data in bytes for encryption.
+*/
+ENTRY(aesni_gcm_dec_update)
+	FUNC_SAVE
+	GCM_ENC_DEC dec
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_dec_update)
+
+/*****************************************************************************
+* void aesni_gcm_finalize(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *auth_tag,       // Authenticated Tag output.
+*                    u64 auth_tag_len);  // Authenticated Tag Length in bytes. Valid values are 16 (most likely),
+*                                        // 12 or 8.
+*/
+ENTRY(aesni_gcm_finalize)
+	FUNC_SAVE
+	GCM_COMPLETE %arg3 %arg4
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_finalize)
+
 #endif
 
 
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 4dd5b9b..de986f9 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -161,6 +161,22 @@ asmlinkage void aesni_gcm_dec(void *ctx,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
 
+/* Scatter / Gather routines, with args similar to above */
+asmlinkage void aesni_gcm_init(void *ctx,
+			       struct gcm_context_data *gdata,
+			       u8 *iv,
+			       u8 *hash_subkey, const u8 *aad,
+			       unsigned long aad_len);
+asmlinkage void aesni_gcm_enc_update(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in, unsigned long plaintext_len);
+asmlinkage void aesni_gcm_dec_update(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in,
+				     unsigned long ciphertext_len);
+asmlinkage void aesni_gcm_finalize(void *ctx,
+				   struct gcm_context_data *gdata,
+				   u8 *auth_tag, unsigned long auth_tag_len);
 
 #ifdef CONFIG_AS_AVX
 asmlinkage void aes_ctr_enc_128_avx_by8(const u8 *in, u8 *iv,
-- 
2.9.5
