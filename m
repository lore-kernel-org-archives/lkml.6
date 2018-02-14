Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161435AbeBNRkh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38354 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161237AbeBNRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:33 -0500
Date: Wed, 14 Feb 2018 09:40:10 -0800
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
Subject: [PATCH v2 10/14] x86/crypto: aesni: Move HashKey computation from
 stack to gcm_context
Message-ID: <20180214174010.GA62134@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR14CA0031.namprd14.prod.outlook.com (10.171.142.145) To
 BN6PR15MB1745.namprd15.prod.outlook.com (10.174.238.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6628cfd2-920c-4a43-a598-08d573d200c1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1745;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;3:HfO8di4R5lGpvqxinBcNnGEOEP7HHTOkdCYRQ819M7F/lOPKPMKJyN796QKW3gzCq8wOgNe8Wm0nlBp6St4Akh+TZLvQhvPUneMg9IG5P0UJKhNsj7QDEiKdU+feyDNBXSVJVGTcUuISaQrX+UUl/vcDXcw3lQFyMUUvzCeLf45MKxiSr4bXgaiLklFhGex85iCdkXNsPBs2u6vFROitLnE0H0D1kmsyHfEbHuxriq+6z3sPQdmuOqXQDqyWHpCa;25:EQp/WFoaZ4iB8HUhQddcMO7s4GQSl8YQBdLiZJPtt+nUa61p0TE0ommpbexrE/MLsk1/DvrTJNwkQlszHzdIIr4yCFYHbBfaS09wWgN/Y8hi7WyVXABiRvlt1RhM4DlGWhW3Y170bA1bV2i39K/eI3AW6RKLoH0SRYxH9AKvtf+tgz9t3ZPWl8EgnYDOaxzpAhJAg6LdvzuNx2v62URFYeiOoPJaWKlQXVliHykD8kx81z+Carx3XTq98/21j0YR74IJZUr5IZgVAwwnudz1+3TTLqmnSXq2SsFzOJ0u0AE4bdWnrqP3yZ/v9jWlrOHgUHSaWwdfRj01qaV40yqcsw==;31:07nWf7qEHVDVHSjDnsv+hjUi1ZShn0MH1pxi0x7j8AlWbGuboaFearTnWU9QAXuf8HxvBzuyDvrDwNh9xoWSX0Ss+8KVIuRnLLrSupdQDjE2y9fq5ZDnj8sUhmqnFnSBeqtAzp8QU8Wq3Oe3xJTr0mXXt1YKAwOYREdxwhQjv+lzF8qk5YJdqM5kjihrE9ACguGTkvFbkH5YexnkhFOps5trLsg0AiXQtHuqPY2xFtY=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1745:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;20:P30TBtpbM0NHNFGSispPMCb5H31he0dVUwBvCb2s7hmmcW5cDyPoMygCZ/bcqANiT3nc/DHGXcASfGuBU6+rR6RslSIW+Fsf+nPwQzTaPWvGVISrFdt/napZvplNQQY2fjWdQZ/eg9OSSt2ANZAxt04uzg11AemGDc4f7YXwFZnGnk9iZv/A0CBOh9+c0afOODNMdxEGHRzernL+oK1ICNF/iyes2Cuiv4AA2q4Wmd6SOFrXhAYoq6CEoI8y04zcRK8acLV1N1Gb77VRYk5/jQzQrLXLAdYSmleIk+uQY62nwIS8C7K8i/LTeTWCgVxV4ckCTb2HkEj+vnQmntf/Y2bgdQUuxCTuC6IuLXKauq4llwJYZaON5D7Kid29+nzPAVP4/GQf+T9r2h3BCUOaNUTCGung16tZyJzqeLqcxOuQn9dRENXmGyLPOpKmEpLHF5EXYIVGQizpZ1GaPfZ1dwBpiFsYZpkYpdFY/cy8dxJFc3XtffBiD3G/qImfnNze;4:Qo0GDhEZvEhJCfz4JoIiP55rX1TMKEFAAVNg11FYxk0lHCStdPQqyaBZLUHu7P+aGazxNPehD0CMX5AZUgpAxIAAI+fEc0SxELEXft/nsaZ58pqasO3sd0w9XmWGFKZK8JlKCV3FN0joIBV8sRLyFCXX7m4rua6ih4UdnRtlqJdCm42YkLBukRkjv9CpG7laRSzPCslg6G7kFV6pYAk/KwG+1RyA/dGrCBFhiNqWPo3moU3YyFQxYWN6CFRbCZLXIwA7A6ybb8UFrAkNeUchu2lwnbA6Tq/S+Mn1yf4eTe3ziHOsduQcjN2K9YnfktDwuXX4JulBIfvB/b3WY3p5tPXZNrN18XsZbgG8oPsRpOo=
X-Microsoft-Antispam-PRVS: <BN6PR15MB1745FA6165AB50407E5109A4DDF50@BN6PR15MB1745.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(11241501184)(944501161)(10201501046)(3002001)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1745;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1745;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(189003)(199004)(16526019)(186003)(6116002)(54906003)(106356001)(386003)(33656002)(47776003)(25786009)(5660300001)(2906002)(23726003)(33716001)(97736004)(8676002)(316002)(81156014)(4326008)(33896004)(81166006)(478600001)(50466002)(76506005)(110136005)(1076002)(2950100002)(76176011)(8936002)(16586007)(58126008)(6486002)(105586002)(86362001)(53936002)(68736007)(52396003)(6496006)(9686003)(59450400001)(7416002)(83506002)(52116002)(305945005)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1745;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1745;23:i1HRvWOTtxq5YhuyW1jiitklPM8oab7TKHrMiq72Z?=
 =?us-ascii?Q?5NHOkn0yKyNqNe14fsRJVnZxsR/a0B1A+jG//aDdeEjdTBdUmBi86ntK8+ZS?=
 =?us-ascii?Q?yOkN75l66YQooBwKDIcDT6IuofW9rbUMfG9QlfuN0X6hdaKY4sAZDmqCX+so?=
 =?us-ascii?Q?973AuLL7JPrVk7liEPxGu2RdV81o2anMeBnGm3ipSroyW/oPbbvmuw+Qj3kf?=
 =?us-ascii?Q?XXxSV+IZmWb6f2s0vo5jIKq8TyYj8vMXI+DDkIJ6fuHxSFSN5aalj5rYOv35?=
 =?us-ascii?Q?bIjQ7+KgybZe5bI9nfA37lriSjg4BjohWRITPDKeQEMXE5DgiiUgNZ3jYWYF?=
 =?us-ascii?Q?2GzXv15SKjKhyZ6loA93ezECuZ4rnxlO6QGA3Zu7ksJMczxstGjFpn4clQJy?=
 =?us-ascii?Q?Gk2yESnrP1z8yRVNmNGw8Lf3AwvfpXylYa8S/FiDfbECjfGoNcT4Ez1QSvDG?=
 =?us-ascii?Q?QChvSFEq3erB8oICn1JhpVMaXUmWDUJDsI1b9Ft2Ke7hXBdEUZeA/2p+vdF/?=
 =?us-ascii?Q?PS0fJKcQwnWqE20oPQsNP2EWNEyIVUwFBPq3fCeeKAtkcxTOV00FPaVdLNo3?=
 =?us-ascii?Q?IVc2No8+rOhXiEyRjho4/bT3PtDqBEDKS8yAfHFkqENpY+Vf93TQC2r7To1H?=
 =?us-ascii?Q?gVOIghUAHxLvB6Dv/+iJk6r6oMpDIkSL2zWG6mC8AUz2p6BLeUmGDVomm3il?=
 =?us-ascii?Q?hzENH/j/T/4ejHltOt5yD/nIGyc608Aia3J4hG7wyAwMhP6YtLx+DvrCZwxy?=
 =?us-ascii?Q?sJHTfU77y11Ac0naIyEnh1/38efgqN+95yOzSmiKYQoyyn26YXTmg6dTFLzW?=
 =?us-ascii?Q?88MZ8fSa03y8s+cOeyBasAwUgXKHTSmYwQzNSiuxYyh/AI1WrQaOVYJhiNWt?=
 =?us-ascii?Q?lHgPjyxohF52/+EQQuziJfC7SIPoK4fIuEgJsAvEDSG5tJmiagrftWUlXNoo?=
 =?us-ascii?Q?+PR8AxFpmEEz8VUi6VKQ1lU7La/MvC8pTLvd1AC+Rox3bZcJqJweBdu8iv5o?=
 =?us-ascii?Q?yNdYgIUlA5c1/UGvjuKh8kNqZXVlTappfqaBRei624ICo4yY4HlWZu43tl2U?=
 =?us-ascii?Q?bhTmpcOUeb1WyVkaSYWQXl/3NG3nKuF0FRU2klokMj+RufLmSFpVMOynVXze?=
 =?us-ascii?Q?SdmGTXe84Rf89d6SnPCzVPjd88bGVPZXXxmNRWJcALDmTnN3RsOlXoShLr/w?=
 =?us-ascii?Q?TV5Pv8nMj4/JlTPnmi8xD8OY7nAbKHMjQ0mD2Mvh3EQdowp8eicGeOXgZmBp?=
 =?us-ascii?Q?kgqczkKLFZUiUfYCfKigLNx2kFEeHaR0nugne5i?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;6:Xm36Ki0mnYSloL9azKJ+JXso4U0pHdzCzl246ZhCP3ZT5K4Gah5/F2kzlc7majkeMntNbMuo1Hq4ab5hqak8kx8RPmk68z2jpR4FrLg88ayqm5lHsFG/eDNv8hNmdUn6uufFqKtBse//alVvdMzfj32qLJ06Oqbcv0kZAM4LK46cV/KeQ4hpdkMBV6bc/Fe4R7R8hmYTEFrWa4j9OLOONmCrgl6Ut29ymfRuqGAMy4M+e7sp/IoDpxazxVa57d0eh33GCPZkgb/Vqd+zZlLfR8ymoqaEmZSzEzAnk+Mo+OyBjvZzZI/tj5wWn+vKPPnJz8i3grZdI9BnB4jAgxhkb5EnYXdL6UGcnYyCIpX5wxE=;5:eh2l3nXI9FeJ1KyAr0X0Zt84c8PmG9LYXOUNUqjrqYt0WWSvj38rW95GWvCBOHPH2N6AWPWIehdbkNbFaJF6X8Xeg4mrDkQhwB4YwKLMf0KvC8XdtT4uWqTHpsWFqZvSvHPcH7tut/FqXqDqDGLWCXwnjDyFq0/3X3gxHlWVjzo=;24:ZebpXk08As+woUPpKMG0JMIM+OWAGwGxFiG6NKbrDNGZHD8i9dzl1seaCPjlCf5P67ktcYe5EyCX6+wJdEXCoKbIQVTJl1clZmuxtyqAb1Q=;7:q7GLIx4I58fwav/ZQ9bIraOw3FGf59wD6nbLi40oHQD28eWh5p/oROl+76QdqyBOZwOrm42qzlAMu81cvQlAjZMHPLx7+s1a0Lsx7lLtMx3H+i8RjInGMY8mdl7ncN7QOFcnWuU7polvs3JSbxaiZR7QGWXcGs6Q+g7Y5wZy6BYc6F2zLwnSKyKDvu87aNd1UTZobyIN3Sm/MlMUrCvhVJvclfkS92wtRlC8101W66g/BubLFtaZQSFipWpDPaUm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1745;20:j1BvnoI9F2BjzNVGSe89Y5vVxQaGwK+aZG2YmGAoI2o5LvxP0K9f3astRoiZM87fzCvWtTaneX7SyZXf4ka48W6Z1DPS7LwHi24DobQYuGy8U8Q59+cNaPvpGZ/HBwVJ/O6jmVQ5PH5Nv3N6Bem1cbeBN/V3bXfe1ljQnj8+k9o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:40:13.3310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628cfd2-920c-4a43-a598-08d573d200c1
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

HashKey computation only needs to happen once per scatter/gather operation,
save it between calls in gcm_context struct instead of on the stack.
Since the asm no longer stores anything on the stack, we can use
%rsp directly, and clean up the frame save/restore macros a bit.

Hashkeys actually only need to be calculated once per key and could
be moved to when set_key is called, however, the current glue code
falls back to generic aes code if fpu is disabled.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 205 ++++++++++++++++++++------------------
 1 file changed, 106 insertions(+), 99 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 37b1cee..3ada06b 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -93,23 +93,6 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 
 
 #define	STACK_OFFSET    8*3
-#define	HashKey		16*0	// store HashKey <<1 mod poly here
-#define	HashKey_2	16*1	// store HashKey^2 <<1 mod poly here
-#define	HashKey_3	16*2	// store HashKey^3 <<1 mod poly here
-#define	HashKey_4	16*3	// store HashKey^4 <<1 mod poly here
-#define	HashKey_k	16*4	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey <<1 mod poly here
-				//(for Karatsuba purposes)
-#define	HashKey_2_k	16*5	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^2 <<1 mod poly here
-				// (for Karatsuba purposes)
-#define	HashKey_3_k	16*6	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^3 <<1 mod poly here
-				// (for Karatsuba purposes)
-#define	HashKey_4_k	16*7	// store XOR of High 64 bits and Low 64
-				// bits of  HashKey^4 <<1 mod poly here
-				// (for Karatsuba purposes)
-#define	VARIABLE_OFFSET	16*8
 
 #define AadHash 16*0
 #define AadLen 16*1
@@ -118,6 +101,22 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define OrigIV 16*3
 #define CurCount 16*4
 #define PBlockLen 16*5
+#define	HashKey		16*6	// store HashKey <<1 mod poly here
+#define	HashKey_2	16*7	// store HashKey^2 <<1 mod poly here
+#define	HashKey_3	16*8	// store HashKey^3 <<1 mod poly here
+#define	HashKey_4	16*9	// store HashKey^4 <<1 mod poly here
+#define	HashKey_k	16*10	// store XOR of High 64 bits and Low 64
+				// bits of  HashKey <<1 mod poly here
+				//(for Karatsuba purposes)
+#define	HashKey_2_k	16*11	// store XOR of High 64 bits and Low 64
+				// bits of  HashKey^2 <<1 mod poly here
+				// (for Karatsuba purposes)
+#define	HashKey_3_k	16*12	// store XOR of High 64 bits and Low 64
+				// bits of  HashKey^3 <<1 mod poly here
+				// (for Karatsuba purposes)
+#define	HashKey_4_k	16*13	// store XOR of High 64 bits and Low 64
+				// bits of  HashKey^4 <<1 mod poly here
+				// (for Karatsuba purposes)
 
 #define arg1 rdi
 #define arg2 rsi
@@ -125,11 +124,11 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define arg4 rcx
 #define arg5 r8
 #define arg6 r9
-#define arg7 STACK_OFFSET+8(%r14)
-#define arg8 STACK_OFFSET+16(%r14)
-#define arg9 STACK_OFFSET+24(%r14)
-#define arg10 STACK_OFFSET+32(%r14)
-#define arg11 STACK_OFFSET+40(%r14)
+#define arg7 STACK_OFFSET+8(%rsp)
+#define arg8 STACK_OFFSET+16(%rsp)
+#define arg9 STACK_OFFSET+24(%rsp)
+#define arg10 STACK_OFFSET+32(%rsp)
+#define arg11 STACK_OFFSET+40(%rsp)
 #define keysize 2*15*16(%arg1)
 #endif
 
@@ -183,28 +182,79 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	push	%r12
 	push	%r13
 	push	%r14
-	mov	%rsp, %r14
 #
 # states of %xmm registers %xmm6:%xmm15 not saved
 # all %xmm registers are clobbered
 #
-	sub	$VARIABLE_OFFSET, %rsp
-	and	$~63, %rsp
 .endm
 
 
 .macro FUNC_RESTORE
-	mov	%r14, %rsp
 	pop	%r14
 	pop	%r13
 	pop	%r12
 .endm
 
+# Precompute hashkeys.
+# Input: Hash subkey.
+# Output: HashKeys stored in gcm_context_data.  Only needs to be called
+# once per key.
+# clobbers r12, and tmp xmm registers.
+.macro PRECOMPUTE TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
+	mov	arg7, %r12
+	movdqu	(%r12), \TMP3
+	movdqa	SHUF_MASK(%rip), \TMP2
+	PSHUFB_XMM \TMP2, \TMP3
+
+	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
+
+	movdqa	\TMP3, \TMP2
+	psllq	$1, \TMP3
+	psrlq	$63, \TMP2
+	movdqa	\TMP2, \TMP1
+	pslldq	$8, \TMP2
+	psrldq	$8, \TMP1
+	por	\TMP2, \TMP3
+
+	# reduce HashKey<<1
+
+	pshufd	$0x24, \TMP1, \TMP2
+	pcmpeqd TWOONE(%rip), \TMP2
+	pand	POLY(%rip), \TMP2
+	pxor	\TMP2, \TMP3
+	movdqa	\TMP3, HashKey(%arg2)
+
+	movdqa	   \TMP3, \TMP5
+	pshufd	   $78, \TMP3, \TMP1
+	pxor	   \TMP3, \TMP1
+	movdqa	   \TMP1, HashKey_k(%arg2)
+
+	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
+# TMP5 = HashKey^2<<1 (mod poly)
+	movdqa	   \TMP5, HashKey_2(%arg2)
+# HashKey_2 = HashKey^2<<1 (mod poly)
+	pshufd	   $78, \TMP5, \TMP1
+	pxor	   \TMP5, \TMP1
+	movdqa	   \TMP1, HashKey_2_k(%arg2)
+
+	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
+# TMP5 = HashKey^3<<1 (mod poly)
+	movdqa	   \TMP5, HashKey_3(%arg2)
+	pshufd	   $78, \TMP5, \TMP1
+	pxor	   \TMP5, \TMP1
+	movdqa	   \TMP1, HashKey_3_k(%arg2)
+
+	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
+# TMP5 = HashKey^3<<1 (mod poly)
+	movdqa	   \TMP5, HashKey_4(%arg2)
+	pshufd	   $78, \TMP5, \TMP1
+	pxor	   \TMP5, \TMP1
+	movdqa	   \TMP1, HashKey_4_k(%arg2)
+.endm
 
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
 # Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
 .macro GCM_INIT
-
 	mov arg9, %r11
 	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
 	xor %r11, %r11
@@ -219,28 +269,8 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	PSHUFB_XMM %xmm2, %xmm0
 	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
 
-	mov	arg7, %r12
-	movdqu	(%r12), %xmm13
-	movdqa	SHUF_MASK(%rip), %xmm2
-	PSHUFB_XMM %xmm2, %xmm13
-
-	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
-
-	movdqa	%xmm13, %xmm2
-	psllq	$1, %xmm13
-	psrlq	$63, %xmm2
-	movdqa	%xmm2, %xmm1
-	pslldq	$8, %xmm2
-	psrldq	$8, %xmm1
-	por	%xmm2, %xmm13
-
-	# reduce HashKey<<1
-
-	pshufd	$0x24, %xmm1, %xmm2
-	pcmpeqd TWOONE(%rip), %xmm2
-	pand	POLY(%rip), %xmm2
-	pxor	%xmm2, %xmm13
-	movdqa	%xmm13, HashKey(%rsp)
+	PRECOMPUTE %xmm1 %xmm2 %xmm3 %xmm4 %xmm5 %xmm6 %xmm7
+	movdqa HashKey(%arg2), %xmm13
 
 	CALC_AAD_HASH %xmm13 %xmm0 %xmm1 %xmm2 %xmm3 %xmm4 \
 	%xmm5 %xmm6
@@ -252,7 +282,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # Clobbers rax, r10-r13, and xmm0-xmm15
 .macro GCM_ENC_DEC operation
 	movdqu AadHash(%arg2), %xmm8
-	movdqu HashKey(%rsp), %xmm13
+	movdqu HashKey(%arg2), %xmm13
 	add %arg5, InLen(%arg2)
 	mov %arg5, %r13		# save the number of bytes
 	and $-16, %r13		# %r13 = %r13 - (%r13 mod 16)
@@ -376,7 +406,7 @@ _multiple_of_16_bytes_\@:
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
 .macro GCM_COMPLETE
 	movdqu AadHash(%arg2), %xmm8
-	movdqu HashKey(%rsp), %xmm13
+	movdqu HashKey(%arg2), %xmm13
 
 	mov PBlockLen(%arg2), %r12
 
@@ -583,7 +613,7 @@ _get_AAD_done\@:
 * the ciphertext
 * %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
 * are clobbered
-* arg1, %arg2, %arg3, %r14 are used as a pointer only, not modified
+* arg1, %arg2, %arg3 are used as a pointer only, not modified
 */
 
 
@@ -694,17 +724,6 @@ aes_loop_initial_\@:
 	pxor	   \TMP1, \XMM2
 	pxor	   \TMP1, \XMM3
 	pxor	   \TMP1, \XMM4
-	movdqa	   \TMP3, \TMP5
-	pshufd	   $78, \TMP3, \TMP1
-	pxor	   \TMP3, \TMP1
-	movdqa	   \TMP1, HashKey_k(%rsp)
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^2<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_2(%rsp)
-# HashKey_2 = HashKey^2<<1 (mod poly)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_2_k(%rsp)
 .irpc index, 1234 # do 4 rounds
 	movaps 0x10*\index(%arg1), \TMP1
 	AESENC	   \TMP1, \XMM1
@@ -712,12 +731,6 @@ aes_loop_initial_\@:
 	AESENC	   \TMP1, \XMM3
 	AESENC	   \TMP1, \XMM4
 .endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_3(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_3_k(%rsp)
 .irpc index, 56789 # do next 5 rounds
 	movaps 0x10*\index(%arg1), \TMP1
 	AESENC	   \TMP1, \XMM1
@@ -725,12 +738,6 @@ aes_loop_initial_\@:
 	AESENC	   \TMP1, \XMM3
 	AESENC	   \TMP1, \XMM4
 .endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_4(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_4_k(%rsp)
 	lea	   0xa0(%arg1),%r10
 	mov	   keysize,%eax
 	shr	   $2,%eax			# 128->4, 192->6, 256->8
@@ -815,7 +822,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pshufd	  $78, \XMM5, \TMP6
 	pxor	  \XMM5, \TMP6
 	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa	  HashKey_4(%rsp), \TMP5
+	movdqa	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP4           # TMP4 = a1*b1
 	movdqa    \XMM0, \XMM1
 	paddd     ONE(%rip), \XMM0		# INCR CNT
@@ -834,7 +841,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pxor	  (%arg1), \XMM2
 	pxor	  (%arg1), \XMM3
 	pxor	  (%arg1), \XMM4
-	movdqa	  HashKey_4_k(%rsp), \TMP5
+	movdqa	  HashKey_4_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP6           # TMP6 = (a1+a0)*(b1+b0)
 	movaps 0x10(%arg1), \TMP1
 	AESENC	  \TMP1, \XMM1              # Round 1
@@ -849,7 +856,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM6, \TMP1
 	pshufd	  $78, \XMM6, \TMP2
 	pxor	  \XMM6, \TMP2
-	movdqa	  HashKey_3(%rsp), \TMP5
+	movdqa	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1           # TMP1 = a1 * b1
 	movaps 0x30(%arg1), \TMP3
 	AESENC    \TMP3, \XMM1              # Round 3
@@ -862,7 +869,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_3_k(%rsp), \TMP5
+	movdqa	  HashKey_3_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x50(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1              # Round 5
@@ -876,7 +883,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM7, \TMP1
 	pshufd	  $78, \XMM7, \TMP2
 	pxor	  \XMM7, \TMP2
-	movdqa	  HashKey_2(%rsp ), \TMP5
+	movdqa	  HashKey_2(%arg2), \TMP5
 
         # Multiply TMP5 * HashKey using karatsuba
 
@@ -892,7 +899,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_2_k(%rsp), \TMP5
+	movdqa	  HashKey_2_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x80(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1             # Round 8
@@ -910,7 +917,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM8, \TMP1
 	pshufd	  $78, \XMM8, \TMP2
 	pxor	  \XMM8, \TMP2
-	movdqa	  HashKey(%rsp), \TMP5
+	movdqa	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1          # TMP1 = a1*b1
 	movaps 0x90(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1            # Round 9
@@ -939,7 +946,7 @@ aes_loop_par_enc_done:
 	AESENCLAST \TMP3, \XMM2
 	AESENCLAST \TMP3, \XMM3
 	AESENCLAST \TMP3, \XMM4
-	movdqa    HashKey_k(%rsp), \TMP5
+	movdqa    HashKey_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
 	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
@@ -1023,7 +1030,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pshufd	  $78, \XMM5, \TMP6
 	pxor	  \XMM5, \TMP6
 	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa	  HashKey_4(%rsp), \TMP5
+	movdqa	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP4           # TMP4 = a1*b1
 	movdqa    \XMM0, \XMM1
 	paddd     ONE(%rip), \XMM0		# INCR CNT
@@ -1042,7 +1049,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pxor	  (%arg1), \XMM2
 	pxor	  (%arg1), \XMM3
 	pxor	  (%arg1), \XMM4
-	movdqa	  HashKey_4_k(%rsp), \TMP5
+	movdqa	  HashKey_4_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP6           # TMP6 = (a1+a0)*(b1+b0)
 	movaps 0x10(%arg1), \TMP1
 	AESENC	  \TMP1, \XMM1              # Round 1
@@ -1057,7 +1064,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM6, \TMP1
 	pshufd	  $78, \XMM6, \TMP2
 	pxor	  \XMM6, \TMP2
-	movdqa	  HashKey_3(%rsp), \TMP5
+	movdqa	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1           # TMP1 = a1 * b1
 	movaps 0x30(%arg1), \TMP3
 	AESENC    \TMP3, \XMM1              # Round 3
@@ -1070,7 +1077,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_3_k(%rsp), \TMP5
+	movdqa	  HashKey_3_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x50(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1              # Round 5
@@ -1084,7 +1091,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM7, \TMP1
 	pshufd	  $78, \XMM7, \TMP2
 	pxor	  \XMM7, \TMP2
-	movdqa	  HashKey_2(%rsp ), \TMP5
+	movdqa	  HashKey_2(%arg2), \TMP5
 
         # Multiply TMP5 * HashKey using karatsuba
 
@@ -1100,7 +1107,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_2_k(%rsp), \TMP5
+	movdqa	  HashKey_2_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x80(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1             # Round 8
@@ -1118,7 +1125,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM8, \TMP1
 	pshufd	  $78, \XMM8, \TMP2
 	pxor	  \XMM8, \TMP2
-	movdqa	  HashKey(%rsp), \TMP5
+	movdqa	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1          # TMP1 = a1*b1
 	movaps 0x90(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1            # Round 9
@@ -1147,7 +1154,7 @@ aes_loop_par_dec_done:
 	AESENCLAST \TMP3, \XMM2
 	AESENCLAST \TMP3, \XMM3
 	AESENCLAST \TMP3, \XMM4
-	movdqa    HashKey_k(%rsp), \TMP5
+	movdqa    HashKey_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
 	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
@@ -1223,10 +1230,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM1, \TMP6
 	pshufd	  $78, \XMM1, \TMP2
 	pxor	  \XMM1, \TMP2
-	movdqa	  HashKey_4(%rsp), \TMP5
+	movdqa	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP6       # TMP6 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM1       # XMM1 = a0*b0
-	movdqa	  HashKey_4_k(%rsp), \TMP4
+	movdqa	  HashKey_4_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	movdqa	  \XMM1, \XMMDst
 	movdqa	  \TMP2, \XMM1              # result in TMP6, XMMDst, XMM1
@@ -1236,10 +1243,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM2, \TMP1
 	pshufd	  $78, \XMM2, \TMP2
 	pxor	  \XMM2, \TMP2
-	movdqa	  HashKey_3(%rsp), \TMP5
+	movdqa	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1       # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM2       # XMM2 = a0*b0
-	movdqa	  HashKey_3_k(%rsp), \TMP4
+	movdqa	  HashKey_3_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM2, \XMMDst
@@ -1251,10 +1258,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM3, \TMP1
 	pshufd	  $78, \XMM3, \TMP2
 	pxor	  \XMM3, \TMP2
-	movdqa	  HashKey_2(%rsp), \TMP5
+	movdqa	  HashKey_2(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1       # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM3       # XMM3 = a0*b0
-	movdqa	  HashKey_2_k(%rsp), \TMP4
+	movdqa	  HashKey_2_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM3, \XMMDst
@@ -1264,10 +1271,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM4, \TMP1
 	pshufd	  $78, \XMM4, \TMP2
 	pxor	  \XMM4, \TMP2
-	movdqa	  HashKey(%rsp), \TMP5
+	movdqa	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1	    # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM4       # XMM4 = a0*b0
-	movdqa	  HashKey_k(%rsp), \TMP4
+	movdqa	  HashKey_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM4, \XMMDst
-- 
2.9.5
