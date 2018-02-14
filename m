Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161303AbeBNRio (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:38:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58668 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161207AbeBNRik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:38:40 -0500
Date: Wed, 14 Feb 2018 09:38:12 -0800
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
Subject: [PATCH v2 01/14] x86/crypto: aesni: Merge INITIAL_BLOCKS_ENC/DEC
Message-ID: <20180214173812.GA61794@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com (10.171.142.161) To
 MWHPR15MB1759.namprd15.prod.outlook.com (10.174.255.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e701e0d-1fb8-4736-ac0e-08d573d1bbf5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1759;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;3:yqITBDpHae3PsGopv9e4oivDhP2tMPIpYX8nbBxh9lOBBglSiHWTN9uO+ghCNnFnihR248w9PI0McvgQom7wys1D334KbUPcVUKQubwJlLEElPG8ebsXj77LANnaZW/SQb+3QzuVUsdING+4vvrgH3WNRoqdJkjKIU6oWLi3UH4+vLT7YlsIYmHtBbyQsBoxSet7DRqewJmBOdQTiM47DcRcRyLZALtu3iziA0pii4zovgDu3MlwtXXyx89Fl2pm;25:Gj67MD7Ar4Ym+mlUji1D4JvWLR1QKcfI9kNzMkSOCnd72+Fq9m4dGcmnnWATefr1Tv01Cpuly/aiFYCdEwKkHYbFxQMaCYOAg9XtWH1djbZZ/GgA2YgJlTvIJTazMtc6qEhd8SEApoTCBhFqGOBGBZy7n70Tlq7w88SfOO5x/mysKb1zC0R4+k4giKJBMZgEFUG18Di5yb0bKD4TCvHkRxhLzzL4Tw7kE798XYqxjpxI/2Pr7UOUNHtCpEtfGZYVwINPXkpRiKwW/DLImEBHsQ78hYr3kxMW8f6ErhzqZfbCl9eaVOQEL5UmMH8jDr8MFaQHcYdcyx2H/vkPmgFAgg==;31:Hw8XpeXFwT5sKol1bH18mix9aUcD7PEBo626PppTwnUQ1hy59e4mKI1s9PgUqOKBOXOqn6m4oqAiZoe4q+3B4hSoqNv9ACecXdUzdf0mJz+CxbAUbcidgcfpKsinnWIaf0c0eTqCLMSM7PllUJSDap/UpSvTzaxMRhbfc25aElyM3GBC0TPIDisQMrmPIWuRHtfappooQpLbemjjLlmqfrNZV0f08FniqAGCTVj0/fE=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1759:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:XY425YcOA7oWlxI7W59BKLZGg+Szm7GliH4wILCuI7mvsJYwJ7vNtqroPcm6UVf+579fSom3U2GilIeMIez3GXgnaPFAif29jNKIhoBlNsd7EkTNdq7ULQ007qX/8IgoFS+y4vqNSOHwbiy4JGFE+OqcsYXv2O/+K4scs5BNvBI/EhlyGsDwDa6fUACAdQgVk0Dvi6MtUUhhyiAl6IJKcmhjxNJM9ReqdgD9MRbD+USAruO6EzErHSOUdIlh6xz1Hr4dY/HWjxXnM7nT50lvsMdO+9YO+npnebXcpPWLC744gZK5OQfgzMvkItKPWOoqje0HhblZBiyfk2XcNt9fFr6KPtZfME4uSPUlUU8v8d1gKUS2+mXFu/272IItMfYUCUUkIiBXh7ndsqeRBQ1rbmsW0+eYBmdpHfzCf8BfKJ+HLf4PGAFUjjcloX52mjOgPCsNF4xBgvu2F1Y4k8pverimqV2rfwBki2mbN94AqdxTJoMNZNFHMgHmVSu7HAaR;4:nF2Wx5V0ETY8TPKxz5nHDd7peyE1hUGUbsVQi5CY4wE5T0wIVPdIZmoFmQ4gamw1hc0rt9M/zkWcqwtbnNqyj0PJ9232BdrLgUEb0Ar7vc3zHUJ8o+f5N+JI5/cwVZlkojLgiMVtxvmBDvnkEBTtJeznO+0x/lAX3hKqumnZnTdiULVSI9fqF83hupzLiWw5Ogk5xb6oPEkyW5eIAjJi+Prc2VTrRrbsEdi8o3Jtb6M+qcL/nRLLzmr9hqJuj9YGiTzTtUkZn9u0LizuWOQljCRM6V2RdwoSFkJU/D0s4hc4TevGkWAeKwAbJOBQuPgh8x20y8qBYUgwDr5RQsvMpoeSPwg3YFNRzB5f1KOg5ss=
X-Microsoft-Antispam-PRVS: <MWHPR15MB1759D12237233CF730419F8DDDF50@MWHPR15MB1759.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR15MB1759;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1759;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(7736002)(106356001)(33656002)(33716001)(305945005)(25786009)(4326008)(47776003)(316002)(110136005)(50466002)(58126008)(54906003)(16586007)(76506005)(186003)(16526019)(8936002)(5660300001)(68736007)(81166006)(105586002)(7416002)(6666003)(9686003)(2950100002)(81156014)(8676002)(478600001)(6116002)(52396003)(23726003)(6496006)(52116002)(1076002)(83506002)(76176011)(2906002)(6486002)(53936002)(386003)(33896004)(86362001)(97736004)(6346003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1759;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1759;23:TtxsAnfHtdMdRdujSn0ZLwH/tKPRg5JLdY1ofTXfR?=
 =?us-ascii?Q?/6XkR7HasBon2VdXNm/zuLcnvI0sblJy83oeGpeL2R1xNhlSISdrUEtCPUq8?=
 =?us-ascii?Q?C6fyiQ5PAbU5WZ+C++eKrtrelJD87tTyQytg39ckMxrcQA4k+XydBfrYjwBQ?=
 =?us-ascii?Q?31NngsAnRqkrgCZyxwKP0F7S+bqSQCKZgEUZR7KZvvHP2qcXZKWN3Cd+ljhF?=
 =?us-ascii?Q?Vw90xf4K+HefplrZMdR6YZHNVUBN0Rl33AAh5NKeN4aTuucHHO63rBH9yZq+?=
 =?us-ascii?Q?tyVRhu4cIuokmVfJbAVgxEGMKoZSqZCRdli7+ByG9+a2T4de3RyPbLZMUIzh?=
 =?us-ascii?Q?W97u66Dt2NnxVWGh7GKuLvysbjZpeUbF3kLLUxGB5/EtUAPUV2Vc7ohw04Aw?=
 =?us-ascii?Q?BqHeDWc+Fksrnt5XZUQcIO437CUDTZ9bG9Ed2LJRCe3YR8Y3oi2mLBovY/er?=
 =?us-ascii?Q?gasgxHKUtMxMSLvFXKJsC3VBix+V/azeS2Ve0ibwkUUUYFjNfue2yFj/4nS8?=
 =?us-ascii?Q?5kHd2Xe5dVr0ZVT9CMbiE3l1P90l7R3dSHHXH+iNdR5BRBm6zdiN80v41fIL?=
 =?us-ascii?Q?cB7CjNyTj3/UuEe8FlY+eEgZ+TG2mirN8R4bZSORwmY9HGLx/2OwUBamy6bM?=
 =?us-ascii?Q?eQhCUnT/FA5J1cDWIGug2eEVcn8pSxV2/xPEPwxum/fzZeMoStQ2f/0IJHeK?=
 =?us-ascii?Q?JbAJoS4AvqG1dZNAfZEsvm+iMMRME+Gxl5E+3oSuOpvJHuPApZZMgQm3wOgs?=
 =?us-ascii?Q?pFE3/JIwcxj+Au1b/CAuwY+sVziMVe+qH7EIcSrfxdWgHlq4YIARXa3Cygep?=
 =?us-ascii?Q?qliD22rvRD6m7wJR/EEgxGNGtcq9fOlhej9JC6XLgb752VHS1ZnV9uRRFAK6?=
 =?us-ascii?Q?dlgR5+9TrGmZwpv0hptHggni68RUjRJsZLJQZg005tHmwOEccW+6vG03ZaF/?=
 =?us-ascii?Q?HRzzh4kAW6J9K9AiAfrNyPf6jAawiOZXmlc4AqCfv+MQzzE+JYabeaw5jySm?=
 =?us-ascii?Q?J+9OITib6iHx9NQIIapl/phP8MK/rzJXT4gFNqIqhJ86Ig1ntiPlDnQdZMHz?=
 =?us-ascii?Q?UHG8yViDxnP99QcJPRUdt9qJ1LEBaHDYFftGt5Ejf9JVXNbGIFJmpHgcIV0R?=
 =?us-ascii?Q?PxtpfluFQQ7rZBFdSu6ArnxLmMJ6U/mxYtuQ6EZ1Q6+y/u3uzXqyMODSbxhm?=
 =?us-ascii?Q?PVrpFySgabT3oC1vOA1f/Bd86sqYV0jzSsYV7yVefGCwBzb0X9n4Q8XS0la0?=
 =?us-ascii?Q?cm3XJjjjKaX3FTbaxY9WUAjvloj3jSUQJASyLFU?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;6:ViyZJ9t5j1v13Z4tFHT4GnzTOZv5k6Gr87o5t0hHaEFdUReE3rns82j7zXGVrb0cwQAjqd2+nZ2flt6v9maR5bi7cY9wyl4ktJ7OEh5rONGgy6X9uDLfNVvWrfhudivZjQZKzwKNx2ItxUZ2SHcQHCKBp+fHfjeKu+0tiNNy39hNiap9Vu6Ftp0HM3EOEFwhxYWelmuGJnK1FHqWD+ymExO/AZlWUxJ/Fh7GXCLGkErIHZOIgKVBLOzIRXKhiH35M4ma2Z2yYZAzTU6IanBAkCP5uha/cMKHVbEGPRz0iYj9vh3eoampIJ+uQ8TsjlKjz/hc1+7Q7qLjiSRLq69PhCyBboCwe4ep+fNqOPX/anw=;5:SGiPcu4fSi6cOkB3YLadwX6bF1aL10aahvcsGxHYcBik5dadCWuTq5AB+leg5l7eG/f1wu+71bCGLQ+LcdaaRhA59FUPfrUjibtLkQkaxs4CguJmO9LfdEg4hpYS6Wyp4WRzTdC5bCW5IBDzoUJZK7ozgeEMIzLyF8GI31rMTN0=;24:hDj8W+xzAirX16YnGplND8HlITKg0cG9EJQpdfXsRCTzNKmohygMtbJ2onBujozpHoeeXlqlKFkWxGLlSTPsyLJm/Fgw9xjHi8AyXmHR6kk=;7:F2CKBhJNK5/VndcnEP0m5IthE2mKW57Fr11Pom9s2YdNHVkMfcZK3VytVtollzuWj+eMw5LnRvWWV2jqqDjFn92uLvxHhvvSfIKtpeJekKAZhaCEaszoVCR2XEUdp1+bjHsKocejOaiIw+JczO6VotHBzmPEj9FULjoVe1HV1F6CcXASTYeE2CHTsPPC4EScuD/BfmWf3a8GQ192TYX8KIGZqDD4Pv3LqLj9YM10l4nxgL/YKO3epneAXOJAilKD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:eQO0xoTHqEjK4b6hi+hCgZotKp2TXPZCsjhmhMRf1pO8Q3UiPiVWChYmHF0SwtL8ox9rTtM6rJjdfqlmcowZkicLQsCFCE8fRkzJnIXhZ+tN8EAFhPbiUTcpyrqynDVmq9lFtqmwzrhGtbvCaFgLc6vxPzSxUtugDetmFn8FW+A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:38:18.0810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e701e0d-1fb8-4736-ac0e-08d573d1bbf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro operations to merge implemetations of INITIAL_BLOCKS,
since they differ by only a small handful of lines.

Use macro counter \@ to simplify implementation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 298 ++++++--------------------------------
 1 file changed, 48 insertions(+), 250 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 76d8cd4..48911fe 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -275,234 +275,7 @@ _done_read_partial_block_\@:
 */
 
 
-.macro INITIAL_BLOCKS_DEC num_initial_blocks TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
-XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
-        MOVADQ     SHUF_MASK(%rip), %xmm14
-	mov	   arg7, %r10           # %r10 = AAD
-	mov	   arg8, %r11           # %r11 = aadLen
-	pxor	   %xmm\i, %xmm\i
-	pxor       \XMM2, \XMM2
-
-	cmp	   $16, %r11
-	jl	   _get_AAD_rest\num_initial_blocks\operation
-_get_AAD_blocks\num_initial_blocks\operation:
-	movdqu	   (%r10), %xmm\i
-	PSHUFB_XMM %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   %xmm\i, \XMM2
-	GHASH_MUL  \XMM2, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-	add	   $16, %r10
-	sub	   $16, %r11
-	cmp	   $16, %r11
-	jge	   _get_AAD_blocks\num_initial_blocks\operation
-
-	movdqu	   \XMM2, %xmm\i
-
-	/* read the last <16B of AAD */
-_get_AAD_rest\num_initial_blocks\operation:
-	cmp	   $0, %r11
-	je	   _get_AAD_done\num_initial_blocks\operation
-
-	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
-	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   \XMM2, %xmm\i
-	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-
-_get_AAD_done\num_initial_blocks\operation:
-	xor	   %r11, %r11 # initialise the data pointer offset as zero
-	# start AES for num_initial_blocks blocks
-
-	mov	   %arg5, %rax                      # %rax = *Y0
-	movdqu	   (%rax), \XMM0                    # XMM0 = Y0
-	PSHUFB_XMM   %xmm14, \XMM0
-
-.if (\i == 5) || (\i == 6) || (\i == 7)
-	MOVADQ		ONE(%RIP),\TMP1
-	MOVADQ		(%arg1),\TMP2
-.irpc index, \i_seq
-	paddd	   \TMP1, \XMM0                 # INCR Y0
-	movdqa	   \XMM0, %xmm\index
-	PSHUFB_XMM   %xmm14, %xmm\index      # perform a 16 byte swap
-	pxor	   \TMP2, %xmm\index
-.endr
-	lea	0x10(%arg1),%r10
-	mov	keysize,%eax
-	shr	$2,%eax				# 128->4, 192->6, 256->8
-	add	$5,%eax			      # 128->9, 192->11, 256->13
-
-aes_loop_initial_dec\num_initial_blocks:
-	MOVADQ	(%r10),\TMP1
-.irpc	index, \i_seq
-	AESENC	\TMP1, %xmm\index
-.endr
-	add	$16,%r10
-	sub	$1,%eax
-	jnz	aes_loop_initial_dec\num_initial_blocks
-
-	MOVADQ	(%r10), \TMP1
-.irpc index, \i_seq
-	AESENCLAST \TMP1, %xmm\index         # Last Round
-.endr
-.irpc index, \i_seq
-	movdqu	   (%arg3 , %r11, 1), \TMP1
-	pxor	   \TMP1, %xmm\index
-	movdqu	   %xmm\index, (%arg2 , %r11, 1)
-	# write back plaintext/ciphertext for num_initial_blocks
-	add	   $16, %r11
-
-	movdqa     \TMP1, %xmm\index
-	PSHUFB_XMM	   %xmm14, %xmm\index
-                # prepare plaintext/ciphertext for GHASH computation
-.endr
-.endif
-
-        # apply GHASH on num_initial_blocks blocks
-
-.if \i == 5
-        pxor       %xmm5, %xmm6
-	GHASH_MUL  %xmm6, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 6
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 7
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.endif
-	cmp	   $64, %r13
-	jl	_initial_blocks_done\num_initial_blocks\operation
-	# no need for precomputed values
-/*
-*
-* Precomputations for HashKey parallel with encryption of first 4 blocks.
-* Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-*/
-	MOVADQ	   ONE(%rip), \TMP1
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM1
-	PSHUFB_XMM  %xmm14, \XMM1        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM2
-	PSHUFB_XMM  %xmm14, \XMM2        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM3
-	PSHUFB_XMM %xmm14, \XMM3        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM4
-	PSHUFB_XMM %xmm14, \XMM4        # perform a 16 byte swap
-
-	MOVADQ	   0(%arg1),\TMP1
-	pxor	   \TMP1, \XMM1
-	pxor	   \TMP1, \XMM2
-	pxor	   \TMP1, \XMM3
-	pxor	   \TMP1, \XMM4
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
-.irpc index, 1234 # do 4 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	AESENC	   \TMP1, \XMM1
-	AESENC	   \TMP1, \XMM2
-	AESENC	   \TMP1, \XMM3
-	AESENC	   \TMP1, \XMM4
-.endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_3(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_3_k(%rsp)
-.irpc index, 56789 # do next 5 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	AESENC	   \TMP1, \XMM1
-	AESENC	   \TMP1, \XMM2
-	AESENC	   \TMP1, \XMM3
-	AESENC	   \TMP1, \XMM4
-.endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_4(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_4_k(%rsp)
-	lea	   0xa0(%arg1),%r10
-	mov	   keysize,%eax
-	shr	   $2,%eax			# 128->4, 192->6, 256->8
-	sub	   $4,%eax			# 128->0, 192->2, 256->4
-	jz	   aes_loop_pre_dec_done\num_initial_blocks
-
-aes_loop_pre_dec\num_initial_blocks:
-	MOVADQ	   (%r10),\TMP2
-.irpc	index, 1234
-	AESENC	   \TMP2, %xmm\index
-.endr
-	add	   $16,%r10
-	sub	   $1,%eax
-	jnz	   aes_loop_pre_dec\num_initial_blocks
-
-aes_loop_pre_dec_done\num_initial_blocks:
-	MOVADQ	   (%r10), \TMP2
-	AESENCLAST \TMP2, \XMM1
-	AESENCLAST \TMP2, \XMM2
-	AESENCLAST \TMP2, \XMM3
-	AESENCLAST \TMP2, \XMM4
-	movdqu	   16*0(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM1
-	movdqu	   \XMM1, 16*0(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM1
-	movdqu	   16*1(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM2
-	movdqu	   \XMM2, 16*1(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM2
-	movdqu	   16*2(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM3
-	movdqu	   \XMM3, 16*2(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM3
-	movdqu	   16*3(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM4
-	movdqu	   \XMM4, 16*3(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM4
-	add	   $64, %r11
-	PSHUFB_XMM %xmm14, \XMM1 # perform a 16 byte swap
-	pxor	   \XMMDst, \XMM1
-# combine GHASHed value with the corresponding ciphertext
-	PSHUFB_XMM %xmm14, \XMM2 # perform a 16 byte swap
-	PSHUFB_XMM %xmm14, \XMM3 # perform a 16 byte swap
-	PSHUFB_XMM %xmm14, \XMM4 # perform a 16 byte swap
-
-_initial_blocks_done\num_initial_blocks\operation:
-
-.endm
-
-
-/*
-* if a = number of total plaintext bytes
-* b = floor(a/16)
-* num_initial_blocks = b mod 4
-* encrypt the initial num_initial_blocks blocks and apply ghash on
-* the ciphertext
-* %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
-* are clobbered
-* arg1, %arg2, %arg3, %r14 are used as a pointer only, not modified
-*/
-
-
-.macro INITIAL_BLOCKS_ENC num_initial_blocks TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
+.macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
 XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
         MOVADQ     SHUF_MASK(%rip), %xmm14
 	mov	   arg7, %r10           # %r10 = AAD
@@ -511,8 +284,8 @@ XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
 	pxor	   \XMM2, \XMM2
 
 	cmp	   $16, %r11
-	jl	   _get_AAD_rest\num_initial_blocks\operation
-_get_AAD_blocks\num_initial_blocks\operation:
+	jl	   _get_AAD_rest\@
+_get_AAD_blocks\@:
 	movdqu	   (%r10), %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   %xmm\i, \XMM2
@@ -520,21 +293,21 @@ _get_AAD_blocks\num_initial_blocks\operation:
 	add	   $16, %r10
 	sub	   $16, %r11
 	cmp	   $16, %r11
-	jge	   _get_AAD_blocks\num_initial_blocks\operation
+	jge	   _get_AAD_blocks\@
 
 	movdqu	   \XMM2, %xmm\i
 
 	/* read the last <16B of AAD */
-_get_AAD_rest\num_initial_blocks\operation:
+_get_AAD_rest\@:
 	cmp	   $0, %r11
-	je	   _get_AAD_done\num_initial_blocks\operation
+	je	   _get_AAD_done\@
 
 	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   \XMM2, %xmm\i
 	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 
-_get_AAD_done\num_initial_blocks\operation:
+_get_AAD_done\@:
 	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
@@ -548,7 +321,11 @@ _get_AAD_done\num_initial_blocks\operation:
 	MOVADQ		0(%arg1),\TMP2
 .irpc index, \i_seq
 	paddd		\TMP1, \XMM0                 # INCR Y0
+.ifc \operation, dec
+        movdqa     \XMM0, %xmm\index
+.else
 	MOVADQ		\XMM0, %xmm\index
+.endif
 	PSHUFB_XMM	%xmm14, %xmm\index      # perform a 16 byte swap
 	pxor		\TMP2, %xmm\index
 .endr
@@ -557,14 +334,14 @@ _get_AAD_done\num_initial_blocks\operation:
 	shr	$2,%eax				# 128->4, 192->6, 256->8
 	add	$5,%eax			      # 128->9, 192->11, 256->13
 
-aes_loop_initial_enc\num_initial_blocks:
+aes_loop_initial_\@:
 	MOVADQ	(%r10),\TMP1
 .irpc	index, \i_seq
 	AESENC	\TMP1, %xmm\index
 .endr
 	add	$16,%r10
 	sub	$1,%eax
-	jnz	aes_loop_initial_enc\num_initial_blocks
+	jnz	aes_loop_initial_\@
 
 	MOVADQ	(%r10), \TMP1
 .irpc index, \i_seq
@@ -576,6 +353,10 @@ aes_loop_initial_enc\num_initial_blocks:
 	movdqu	   %xmm\index, (%arg2 , %r11, 1)
 	# write back plaintext/ciphertext for num_initial_blocks
 	add	   $16, %r11
+
+.ifc \operation, dec
+	movdqa     \TMP1, %xmm\index
+.endif
 	PSHUFB_XMM	   %xmm14, %xmm\index
 
 		# prepare plaintext/ciphertext for GHASH computation
@@ -601,7 +382,7 @@ aes_loop_initial_enc\num_initial_blocks:
 	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 .endif
 	cmp	   $64, %r13
-	jl	_initial_blocks_done\num_initial_blocks\operation
+	jl	_initial_blocks_done\@
 	# no need for precomputed values
 /*
 *
@@ -671,18 +452,18 @@ aes_loop_initial_enc\num_initial_blocks:
 	mov	   keysize,%eax
 	shr	   $2,%eax			# 128->4, 192->6, 256->8
 	sub	   $4,%eax			# 128->0, 192->2, 256->4
-	jz	   aes_loop_pre_enc_done\num_initial_blocks
+	jz	   aes_loop_pre_done\@
 
-aes_loop_pre_enc\num_initial_blocks:
+aes_loop_pre_\@:
 	MOVADQ	   (%r10),\TMP2
 .irpc	index, 1234
 	AESENC	   \TMP2, %xmm\index
 .endr
 	add	   $16,%r10
 	sub	   $1,%eax
-	jnz	   aes_loop_pre_enc\num_initial_blocks
+	jnz	   aes_loop_pre_\@
 
-aes_loop_pre_enc_done\num_initial_blocks:
+aes_loop_pre_done\@:
 	MOVADQ	   (%r10), \TMP2
 	AESENCLAST \TMP2, \XMM1
 	AESENCLAST \TMP2, \XMM2
@@ -690,16 +471,33 @@ aes_loop_pre_enc_done\num_initial_blocks:
 	AESENCLAST \TMP2, \XMM4
 	movdqu	   16*0(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM1
+.ifc \operation, dec
+	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM1
+.endif
 	movdqu	   16*1(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM2
+.ifc \operation, dec
+	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM2
+.endif
 	movdqu	   16*2(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM3
+.ifc \operation, dec
+	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM3
+.endif
 	movdqu	   16*3(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM4
+.ifc \operation, dec
+	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM4
+.else
 	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
 	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
 	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
 	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+.endif
 
 	add	   $64, %r11
 	PSHUFB_XMM %xmm14, \XMM1 # perform a 16 byte swap
@@ -709,7 +507,7 @@ aes_loop_pre_enc_done\num_initial_blocks:
 	PSHUFB_XMM %xmm14, \XMM3 # perform a 16 byte swap
 	PSHUFB_XMM %xmm14, \XMM4 # perform a 16 byte swap
 
-_initial_blocks_done\num_initial_blocks\operation:
+_initial_blocks_done\@:
 
 .endm
 
@@ -1378,22 +1176,22 @@ ENTRY(aesni_gcm_dec)
 	jb _initial_num_blocks_is_1_decrypt
 	je _initial_num_blocks_is_2_decrypt
 _initial_num_blocks_is_3_decrypt:
-	INITIAL_BLOCKS_DEC 3, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, dec
 	sub	$48, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_2_decrypt:
-	INITIAL_BLOCKS_DEC	2, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, dec
 	sub	$32, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_1_decrypt:
-	INITIAL_BLOCKS_DEC	1, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, dec
 	sub	$16, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_0_decrypt:
-	INITIAL_BLOCKS_DEC	0, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, dec
 _initial_blocks_decrypted:
 	cmp	$0, %r13
@@ -1640,22 +1438,22 @@ ENTRY(aesni_gcm_enc)
 	jb	_initial_num_blocks_is_1_encrypt
 	je	_initial_num_blocks_is_2_encrypt
 _initial_num_blocks_is_3_encrypt:
-	INITIAL_BLOCKS_ENC	3, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, enc
 	sub	$48, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_2_encrypt:
-	INITIAL_BLOCKS_ENC	2, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, enc
 	sub	$32, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_1_encrypt:
-	INITIAL_BLOCKS_ENC	1, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, enc
 	sub	$16, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_0_encrypt:
-	INITIAL_BLOCKS_ENC	0, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, enc
 _initial_blocks_encrypted:
 
-- 
2.9.5
