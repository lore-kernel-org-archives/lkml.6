Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeBLTv6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:51:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47774 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752277AbeBLTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:51:54 -0500
Date: Mon, 12 Feb 2018 11:49:02 -0800
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
Subject: [PATCH 05/14] x86/crypto: aesni: Merge encode and decode to
 GCM_ENC_DEC macro
Message-ID: <20180212194902.GA60735@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: CY4PR22CA0069.namprd22.prod.outlook.com (10.173.187.31) To
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620b2a4c-84a1-4589-4f0d-08d57251aee6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1756;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;3:zp7VfaLoeDBjWML/QxK0UsbXZvrsbplszd0wl58TnjFWvd7LibisqrKetgg0DnVeFh0uYx+KVnpJhLdVzzyD42qgppH0YUSLeUx5dxQRZZyAALq1WIxluHoc74e5KshoJzekS6qUPu4wRsisgiisfjmfn6Ecb2r6X7RhsLrFfTR5xlyFCBSZPCYLdVNntnB46nGycJ8J8iS9LAl6gGnxCbYIk3mfM/Qe0AwNYSSlFebe6AWAdJNcsvchwGl/JQTz;25:ys6XW9zm6yOT0a+Jaxokc0QGz9ePqB+f4C9RCvjhkzZqt8fzajGZpCS+2UcYXSjg/gzzHoMLxoybJ/j12lfP1c1RNaEnxFBLs2RecBisEI6ujMuvupBDSlI1hJ5YzMvAkdJzENR9GEYRL/L2adGV/+XGiN/xihAFpTjfAFEcBlGvC/Bbfo81U9r3jRVSbHN2fPpdP4Q30pXajo4OPzwptwh5LIoId9TOL8APX+8C9ba1jxOlHKDCNWqO19tDzGVrlTYi00rfR0GaI4JSIzxID4BjBzP8nwg7xnnjnGgFj4rKO8ZkG/BqSapVIj59nzKYxnwfQYAiXLoagq3Bdf184A==;31:smIOqBD8xoxSo3i89n35dyywRcECgyvWW5+mBrIxe5NWqtOuNrV8kewu3Q9i9hALR/d0SEAnOiaC6mShYikvFlIl3VkJZxBZawaPuyuBDLZRp8XgZC1TUrY+OsQ+IHeVVJuN5a80+ZAbYqQdNdJMWPMPiwfhq2If7i+6PCvWWHVlvNJcmNKIRBmKHcVFcN6SQaLB4J/ADZMrMo9l7ALbOsXnh1SeFhktm8n7S+y9+uM=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:gZjl1eBa5LBARDr2glzpjKiVFo/+brJ72XtE0CGP8y93k0CGgsjrQS5IIJ9nmZVnESFdWBwGi2SIkzLhNALB+H7RAGk6g903+iyyEWPdquTpLIlTCU813M/QkTeXEwfTNh5ctTgBd/DQqnZdx7E4jy1lRq/UTFTUuMBqevjMnMu9Xq8xYc8O/sQiMvHyLumDyOaE0Ou5ty2ixPJfmr99UVnSA9q63G3mwZ6nmjCxtrClBfJHLj3+627OlZgOObjwo3jwMpdx/v7iYMj2z8zH4kiKypQ1cj2It0zmma6WfwNNrBUdpYf2xzeYH6zOh8wcv1tVzQQqRqCIbNGzAOnCPDwFvLdvPgaW8rCYSVxMsTwgb0I6bR1bvZplM1RSUbURIbWYfmRetGyeEhCUXT2PGZvWo9ENO3JyG4Gryfn/uiCJY3ZTVTj20LiOGTxcmn1ZfxGIVgNxJ0O32SKDTBEH0eCHSN3F056vhuh0OnPkO7m2RhjuJE1p0qUscGwCJWGh;4:IjcAr1o5/+HnyH7e10eSADIm2vzEfDBgQlPWTXlEoj7nh64/IsWSoQZZo3vDp6A3ocQy1Vd9ShKuMIHnr7fvegFOylidn35jI4pw7m/d72+7/SpiDQceJYYHbUZPK7IogPRGm8kvOSZoNoMY7icWbi6XhZlcExqJYDKY6+2I5v+2KH40H6ceggonp7AHCdPhN0XzZMjGSIbHvd4zJyvH1u9UOFMpvpVLlK3PFPu/KEbGztaWE1eSQvdETqdd8cjVfOGKnIpfY5mp2CJukZp9/F3+ox/FopriEvFP+1EPM//SSqxcLFy546gT775fWZtE42pJo/kABMD19Q7IIIRHrYNoM2l8Uxxhg2/MYFHLWvM=
X-Microsoft-Antispam-PRVS: <DM5PR15MB17568EF98E5956097961CE3DDDF70@DM5PR15MB1756.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(199004)(189003)(16586007)(97736004)(316002)(7416002)(186003)(23726003)(16526019)(5660300001)(59450400001)(1076002)(50466002)(6116002)(33896004)(7736002)(110136005)(54906003)(386003)(305945005)(86362001)(25786009)(58126008)(83506002)(2906002)(33656002)(6666003)(8676002)(6346003)(478600001)(2950100002)(106356001)(68736007)(8936002)(81166006)(81156014)(98436002)(105586002)(76506005)(76176011)(4326008)(9686003)(53936002)(52116002)(52396003)(47776003)(6486002)(6496006)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1756;23:Daav5UQsClKFxS1YZI2XEMdkUySLDHpx/J8n9HYxU?=
 =?us-ascii?Q?gkg2XTMXf4PEwImpwzaTuV+h0OiaIlaNWBXYuTIziE5rbZ8Q8fCYbxtfb59u?=
 =?us-ascii?Q?XngE669K9E/4Iv20rluA+OM2PdzYdhjuGHYcIJC47AyWYwGqc5Yc/7cnsjuJ?=
 =?us-ascii?Q?dg5GDCvFYVbenWRn+R9Jk2U8GjRfJzKXk1LEQooKU78xQ8/bvJ4ppjHSiKCP?=
 =?us-ascii?Q?xilLTY2nEnIuW4pzJhx9w23Zmg4+7aoS8YwP3up6o8WtNWg2dSLUHkdeqNyM?=
 =?us-ascii?Q?NhsMDPPSetArD3lKHAW02pLLx08zPYP8EGPOquT2Xcq7greIzrCA4fDYOT9T?=
 =?us-ascii?Q?hrTMPgf4mQPt2uCdYqOa06uZDi0ax/oFxWVKSr2N+NVyWy8Cgr9vJTBBWb9J?=
 =?us-ascii?Q?Xv/tj2ZkFEhhVcGruIaijNkn5rL/HZxRYT3Baw0cVaW43VOPVBwZcRED25qh?=
 =?us-ascii?Q?ZluX6xqMaKLt1Yg7C9vMWH+cB9bw77KGJ4/W4E3hf7lTDtamyK6K/RA+CAfx?=
 =?us-ascii?Q?6P5qSUuU20IF7WCeFFYh/X0qmicLW6uKgFcOwdJeWT8Q4Zy6BNDJ5UsoNkfR?=
 =?us-ascii?Q?GHN1InigGdxdqfso3uf4qH9h5LkYqzxBIMMsJKHFV0ghci/Ecfs+54JFvALF?=
 =?us-ascii?Q?DmaqCQ1RDx06CBRK1P0Ypt7k2B7NVmcz8u+YOOrK2RP3FEFt6zsxFNw7KOcP?=
 =?us-ascii?Q?HY1yBysZe/soCtH6/ksfG4GmxGkzl4p4vtENzpYjpmn3+JPUDDfZzEQlcuo6?=
 =?us-ascii?Q?HAdbivUVtMLC9aE8/GkBKLzz9FZl2vRvyHiIIIVMMNMPult/QvzPStWLPo2E?=
 =?us-ascii?Q?RYELCUQ8We0pUitBS5bvCqZ6rAkBpTYs6dwSxOgvmO+LuropBnyQ/2iGnvJa?=
 =?us-ascii?Q?wOnRUT3+KXWb3MFpYr8phmkPZxvQmlsYpwuINomTb8KnpNsNcjA4WU2zSL53?=
 =?us-ascii?Q?hwOlYw4cKScB4epdy4aQFnRd+JAktzExGEgvLvJAnSCG5+cr4zvkXjMlychI?=
 =?us-ascii?Q?zxEJpA24ksAKS6SunGDveAmteNOBzMoGL+h+VHqoeFCZ0mQQyXri/+j9zy2d?=
 =?us-ascii?Q?Am+hxWK/f2fD74zJiGreiXeMAxIACLddtIDJEIfP2P/+aFnSj67HXFEQcUrh?=
 =?us-ascii?Q?bhhiwSE/L26SZMHvibwx+N7R2UxD/GjDOTyAyQC8zbSjDaWBsb5DQyZNErqD?=
 =?us-ascii?Q?EMAHght5EZUd/9+LcojZsX6CLPD7J+Puta+4ZWVv+dtM2SwjzWWFXrprjpFE?=
 =?us-ascii?Q?pR6yZv/z1662wWcg+EhNSdra9lcE1SNEExoLz+XFFbKupu6z5wu9NykAIna1?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;6:hiIl6u1toTXY53jtzKz50Ge6/WYVxo5i5PxH5e9p29UGkFgugAWRJJJ7vksbKK849GEuZDUWZOl0dtTuc00AGDvziFoiEndtbJs+5o7KMLq/n5r+uqml1tLgMJ53j3L5ROCcPGU3Lx1kP3A5FzoXSTvUjm9n5ByABmh6U9V2aqnIscClbD2FC6hHrZhiURVYUrcBBM9FgVvdOGYjgl4d3bln5JrJc/sPHFrDynpRAJstlq//b3JEjyWgTPetHxtXUsEzgCyQ7QdtabSYuQ2Fb8HvuIXFr1vbmk4xA3UBNC2F+8xEVcjgyFvBUuHurWDA0BpIgC0CFMjNqKWpLemfPLEy+ZRjDdVvYjBG4MQtrVk=;5:yGfvr2D3MUXhOzvXCB5nXTPDcxqe60VzjqIJ/GptGdsvYV3MCnk92Kx228dm1xcTw8HQn9RS8swl5wCBfS7YWoOCZkrrSc5Q63lvnsEx8hOf0is8iRC6ObT+19FGf+xkYE0We5AxJCiTYUvbJ2qIUpXDoNt0BR1gaVE4gJEsI1Y=;24:DsNg17dQEDN5WxePYag18XkjN0E1WzPfx4lPqavBYnhHchjtdMRFxUrPfRtkVuPPxF8m9sXCYKSjfR/WBHBJ0o14PDw4YY2GPZLFBggoRJA=;7:OjqMn9VV8dsav/Z5+V8tUSZWJ4SPAKTSZLjnNuCv6FxDZ/yge0rDFBtybKPfd4rwBm1HMOzPHBdWIilNXfwvz1daQw+vWklsFPovquMx8bUFs4sT/x84hePEL/yv7tYNExgG9LD67d4xVJa/ymcS9lSUNcefxFJiB/7+uTiodOvhamLfPoP/NHwaS1XCy9T14MnSvKD3bVSIO46HczIF5EDJe8u8nQWSpFgdseLKF2JtGZvtVaiewTFIjdwwOpzS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:D3m3fjXki4fsoKO6Mq93xfxX2AC6Z0wMsKLORBhnyq7X7h3r1cPUlgL0yRF9VTsswktuz/B56oIkxNAPXUN9KKW5frCfMH/gE3Bcw/1/A6bAI2iwt3Le+a8R3X8IplNlbpAlLxMBiiiZXgwdvxlYyBbqIKoLRGP0ozjOcdQFngg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:49:09.3164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b2a4c-84a1-4589-4f0d-08d57251aee6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a macro for the main encode/decode routine.  Only a small handful
of lines differ for enc and dec.   This will also become the main
scatter/gather update routine.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 293 +++++++++++++++-----------------------
 1 file changed, 114 insertions(+), 179 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 529c542..8021fd1 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -222,6 +222,118 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	mov	%r13, %r12
 .endm
 
+# GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
+# struct has been initialized by GCM_INIT.
+# Requires the input data be at least 1 byte long because of READ_PARTIAL_BLOCK
+# Clobbers rax, r10-r13, and xmm0-xmm15
+.macro GCM_ENC_DEC operation
+	# Encrypt/Decrypt first few blocks
+
+	and	$(3<<4), %r12
+	jz	_initial_num_blocks_is_0_\@
+	cmp	$(2<<4), %r12
+	jb	_initial_num_blocks_is_1_\@
+	je	_initial_num_blocks_is_2_\@
+_initial_num_blocks_is_3_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, \operation
+	sub	$48, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_2_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, \operation
+	sub	$32, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_1_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, \operation
+	sub	$16, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_0_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, \operation
+_initial_blocks_\@:
+
+	# Main loop - Encrypt/Decrypt remaining blocks
+
+	cmp	$0, %r13
+	je	_zero_cipher_left_\@
+	sub	$64, %r13
+	je	_four_cipher_left_\@
+_crypt_by_4_\@:
+	GHASH_4_ENCRYPT_4_PARALLEL_\operation	%xmm9, %xmm10, %xmm11, %xmm12, \
+	%xmm13, %xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, \
+	%xmm7, %xmm8, enc
+	add	$64, %r11
+	sub	$64, %r13
+	jne	_crypt_by_4_\@
+_four_cipher_left_\@:
+	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
+%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
+_zero_cipher_left_\@:
+	mov	%arg4, %r13
+	and	$15, %r13			# %r13 = arg4 (mod 16)
+	je	_multiple_of_16_bytes_\@
+
+	# Handle the last <16 Byte block separately
+	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
+        movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10, %xmm0
+
+	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
+
+	lea (%arg3,%r11,1), %r10
+	mov %r13, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
+
+	lea ALL_F+16(%rip), %r12
+	sub %r13, %r12
+.ifc \operation, dec
+	movdqa  %xmm1, %xmm2
+.endif
+	pxor	%xmm1, %xmm0            # XOR Encrypt(K, Yn)
+	movdqu	(%r12), %xmm1
+	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
+	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
+.ifc \operation, dec
+	pand    %xmm1, %xmm2
+	movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10 ,%xmm2
+
+	pxor %xmm2, %xmm8
+.else
+	movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10,%xmm0
+
+	pxor	%xmm0, %xmm8
+.endif
+
+	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
+.ifc \operation, enc
+	# GHASH computation for the last <16 byte block
+	movdqa SHUF_MASK(%rip), %xmm10
+	# shuffle xmm0 back to output as ciphertext
+	PSHUFB_XMM %xmm10, %xmm0
+.endif
+
+	# Output %r13 bytes
+	MOVQ_R64_XMM %xmm0, %rax
+	cmp $8, %r13
+	jle _less_than_8_bytes_left_\@
+	mov %rax, (%arg2 , %r11, 1)
+	add $8, %r11
+	psrldq $8, %xmm0
+	MOVQ_R64_XMM %xmm0, %rax
+	sub $8, %r13
+_less_than_8_bytes_left_\@:
+	mov %al,  (%arg2, %r11, 1)
+	add $1, %r11
+	shr $8, %rax
+	sub $1, %r13
+	jne _less_than_8_bytes_left_\@
+_multiple_of_16_bytes_\@:
+.endm
+
 # GCM_COMPLETE Finishes update of tag of last partial block
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
@@ -1245,93 +1357,7 @@ ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
 
 	GCM_INIT
-
-        # Decrypt first few blocks
-
-	and $(3<<4), %r12
-	jz _initial_num_blocks_is_0_decrypt
-	cmp $(2<<4), %r12
-	jb _initial_num_blocks_is_1_decrypt
-	je _initial_num_blocks_is_2_decrypt
-_initial_num_blocks_is_3_decrypt:
-	INITIAL_BLOCKS_ENC_DEC %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, dec
-	sub	$48, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_2_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, dec
-	sub	$32, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_1_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, dec
-	sub	$16, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_0_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, dec
-_initial_blocks_decrypted:
-	cmp	$0, %r13
-	je	_zero_cipher_left_decrypt
-	sub	$64, %r13
-	je	_four_cipher_left_decrypt
-_decrypt_by_4:
-	GHASH_4_ENCRYPT_4_PARALLEL_DEC	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, \
-%xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, dec
-	add	$64, %r11
-	sub	$64, %r13
-	jne	_decrypt_by_4
-_four_cipher_left_decrypt:
-	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
-%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
-_zero_cipher_left_decrypt:
-	mov	%arg4, %r13
-	and	$15, %r13				# %r13 = arg4 (mod 16)
-	je	_multiple_of_16_bytes_decrypt
-
-        # Handle the last <16 byte block separately
-
-	paddd ONE(%rip), %xmm0         # increment CNT to get Yn
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	ENCRYPT_SINGLE_BLOCK  %xmm0, %xmm1    # E(K, Yn)
-
-	lea (%arg3,%r11,1), %r10
-	mov %r13, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
-
-	lea ALL_F+16(%rip), %r12
-	sub %r13, %r12
-	movdqa  %xmm1, %xmm2
-	pxor %xmm1, %xmm0            # Ciphertext XOR E(K, Yn)
-	movdqu (%r12), %xmm1
-	# get the appropriate mask to mask out top 16-%r13 bytes of %xmm0
-	pand %xmm1, %xmm0            # mask out top 16-%r13 bytes of %xmm0
-	pand    %xmm1, %xmm2
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10 ,%xmm2
-
-	pxor %xmm2, %xmm8
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-
-        # output %r13 bytes
-	MOVQ_R64_XMM	%xmm0, %rax
-	cmp	$8, %r13
-	jle	_less_than_8_bytes_left_decrypt
-	mov	%rax, (%arg2 , %r11, 1)
-	add	$8, %r11
-	psrldq	$8, %xmm0
-	MOVQ_R64_XMM	%xmm0, %rax
-	sub	$8, %r13
-_less_than_8_bytes_left_decrypt:
-	mov	%al,  (%arg2, %r11, 1)
-	add	$1, %r11
-	shr	$8, %rax
-	sub	$1, %r13
-	jne	_less_than_8_bytes_left_decrypt
-_multiple_of_16_bytes_decrypt:
+	GCM_ENC_DEC dec
 	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
@@ -1417,98 +1443,7 @@ ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
 
 	GCM_INIT
-        # Encrypt first few blocks
-
-	and	$(3<<4), %r12
-	jz	_initial_num_blocks_is_0_encrypt
-	cmp	$(2<<4), %r12
-	jb	_initial_num_blocks_is_1_encrypt
-	je	_initial_num_blocks_is_2_encrypt
-_initial_num_blocks_is_3_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, enc
-	sub	$48, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_2_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, enc
-	sub	$32, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_1_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, enc
-	sub	$16, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_0_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, enc
-_initial_blocks_encrypted:
-
-        # Main loop - Encrypt remaining blocks
-
-	cmp	$0, %r13
-	je	_zero_cipher_left_encrypt
-	sub	$64, %r13
-	je	_four_cipher_left_encrypt
-_encrypt_by_4_encrypt:
-	GHASH_4_ENCRYPT_4_PARALLEL_ENC	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, \
-%xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, enc
-	add	$64, %r11
-	sub	$64, %r13
-	jne	_encrypt_by_4_encrypt
-_four_cipher_left_encrypt:
-	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
-%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
-_zero_cipher_left_encrypt:
-	mov	%arg4, %r13
-	and	$15, %r13			# %r13 = arg4 (mod 16)
-	je	_multiple_of_16_bytes_encrypt
-
-         # Handle the last <16 Byte block separately
-	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
-
-	lea (%arg3,%r11,1), %r10
-	mov %r13, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
-
-	lea ALL_F+16(%rip), %r12
-	sub %r13, %r12
-	pxor	%xmm1, %xmm0            # Plaintext XOR Encrypt(K, Yn)
-	movdqu	(%r12), %xmm1
-	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
-	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10,%xmm0
-
-	pxor	%xmm0, %xmm8
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	# GHASH computation for the last <16 byte block
-	movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	# shuffle xmm0 back to output as ciphertext
-
-        # Output %r13 bytes
-	MOVQ_R64_XMM %xmm0, %rax
-	cmp $8, %r13
-	jle _less_than_8_bytes_left_encrypt
-	mov %rax, (%arg2 , %r11, 1)
-	add $8, %r11
-	psrldq $8, %xmm0
-	MOVQ_R64_XMM %xmm0, %rax
-	sub $8, %r13
-_less_than_8_bytes_left_encrypt:
-	mov %al,  (%arg2, %r11, 1)
-	add $1, %r11
-	shr $8, %rax
-	sub $1, %r13
-	jne _less_than_8_bytes_left_encrypt
-_multiple_of_16_bytes_encrypt:
-_return_T_encrypt:
+	GCM_ENC_DEC enc
 	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
-- 
2.9.5
