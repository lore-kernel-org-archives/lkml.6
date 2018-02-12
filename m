Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeBLTuU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:50:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751208AbeBLTuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:50:14 -0500
Date: Mon, 12 Feb 2018 11:49:42 -0800
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
Subject: [PATCH 07/14] x86/crypto: aesni: Split AAD hash calculation to
 separate macro
Message-ID: <20180212194942.GA60838@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: CY4PR18CA0047.namprd18.prod.outlook.com (10.173.177.33) To
 DM5PR15MB1755.namprd15.prod.outlook.com (10.174.246.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d4dcdd-5fba-4b4d-1b6d-08d57251c699
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1755;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;3:fgZ0kf1/vGtxj9mc92NNsEJF9VolPL/JiCPCrIQLozXTNS9Ampv7JQpp4YzJUVqBIDVp1WshMjjQqMecKFjQpYn9GR70A2NGSXX2874TeKn5DK+2WIBBvFv8i1+8QW/ey0w/vkAlGKMemW64V3TZFtz5TOdra3/l8ZAzPWU4ABnxJP7TYZMwmr+ln4WC9w0RlH50noWFI1X1mpORWpyU+a/OuJB23Y6ptTSHBab1CQpTn3v708vE4wEgyOOirmXU;25:iQsfdex3vDd2HgRN8e+9DMymvLEuociqiIZhQ1qH+c7J3Hbw6NBqyYiXPeWMgDXzA5TKUTdw+OibZxlmEcPCf9f3YASBeF/V6ZGmm964HDwaiJ708qYT9UZCqdOn1ZxIjbObl7U8zfd+7pHGq5v//BZ2OY9cgSMRn0Rm7X48MMvHEvRNKvLA2/TCkR41o5umkcQyazss7McUVJ3RAjRuDP25VlBPKf8dEAY8VvVDNNDdwyWND+frwKTRnwAgFL71JO2KPdGt3dcN03UJeoYAI2djE6UohVRl0QzF8IrgbJaYCBAzYWRoP9heWyC21DDg0INVryNzoCkQcI3olzsO5g==;31:vjl6Gk6sxu/UROXrob1e2/r2tkf6BMlmRHV870q/Ir/WtblsHotIGdgsTvLKx+Kl+3YeRhjZi5mkp3Z+pypOvV0GqbtEMSjbfBEccKkljuL3HbjO+Bwx+e8/ouavAJBstJnd4uAqeKdHbETaJ7TwX5LQ41KruPXzmwplIepesu4eMF73eSRmPoy4Eh/4YEL6Z0MUSJmd6SJ0wedRaxLldZGg2UFBvJ4a2aLlrkgvKCA=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1755:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:2pI8INVd2hMKSJa+wsKH00y9mwPxFih2RqcHGv5zyO7cw4Ip/Ya22uaAMXTTUSbqPPTYiIB4cXh5jMSo5xJ94yeKEzNU89vequkAskzM6iJ0X+tKbbpH0s0GvGiSXHPCz1yjj0vCpmlbVH4PYhkl1dnwVnAGOzKy3lRTgrkaHLk4o5OwC40EYsyUJuLSjOgzg0EfOjEPtudUHtjKPq8EprjapuS4NyNo8LstmGvWdTAfgxK1JAvo0479y34O77Dqw7UdwGNtnGxBTYKVtDLqHwzERcL/3tZkmYYwdKWC8rlxbOaersqKThsCB5+ksMqPrzCxxb6YoTy/wp+V3w0ZALmcTMhi1kf3VubfrPt/vaVBIIZovu/nJ5XHGq/jfn6LsUKtHFxqhUltdMIpWPfFaIy6egP29Gi1gPnix1hJ85GfopO/XpNVadrUlLxyx6rc+v4dxjZKE7UOwHRyY9MLaQmXOqWpee13GgzN7NN+gYVXac4Hvn/5GGBUnVN/3sUZ;4:2mDrrxAuZm928ntnyxUoPhFOGilWJwwfXklqxxgM3HhshCHDSPmRxeRdhKUOu/AYMnnfVNl2ZTHq9+xX3hWkIQfgVtLtFM6efnAOsEX0tl9BekpcgpP2jBXwzB8XDcpVndzqq33+iZzUsrF4RMVoIknOP2tRSVsJVev3sUFhHP4SV2+/MHnRPYE0k2hwRbavccLFLl4iDKDnOoPhzpkUys6SU/MHLshgKlQ5dLQ0NUK3G4KPgywPaC8heogZtdc7XGkF+4PVwTuh4nlh2mRyaufhjqxXGeU7Q/FSJE3SJL3qjUeJMxMCoMBe7YNYKiwbhBhtK3CyhNpYhe0WXr/InYF6rOBTa0RpB2e39+p5ZGE=
X-Microsoft-Antispam-PRVS: <DM5PR15MB17553FE35BD9736FC63954F1DDF70@DM5PR15MB1755.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1755;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(39860400002)(366004)(39380400002)(346002)(199004)(189003)(23726003)(6116002)(1076002)(8936002)(9686003)(50466002)(81156014)(81166006)(8676002)(186003)(16526019)(86362001)(2906002)(98436002)(33656002)(478600001)(33896004)(97736004)(52396003)(6496006)(106356001)(386003)(68736007)(105586002)(5660300001)(76176011)(47776003)(6486002)(58126008)(110136005)(6666003)(7736002)(316002)(16586007)(54906003)(52116002)(76506005)(4326008)(25786009)(305945005)(2950100002)(7416002)(83506002)(53936002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1755;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1755;23:K5zXaj9LQuC+7Q9ZJWCoXLmUZ+8rtHC3w1Y0Jzv9J?=
 =?us-ascii?Q?5nc+d5AuEB1gscnuacWqyykLo/Xl25C0TOM2ySKhsnKve0M3R1PnQSEsAKVz?=
 =?us-ascii?Q?4wT1TuADTtB4Mnnew7KihZzvZJaQ4taSGNYg+XHqpywoH1VyDa8lErrK6hRk?=
 =?us-ascii?Q?WXPArG8vXT6u2aKx9Z+phXa7DU7NGbCxRBejR65++S8gzNPPZbWo+c6tbQgH?=
 =?us-ascii?Q?//mgNKEoo5Dt32YmaKjwyLpOCeSrAlEG1c7a8yca3jSfrp8dUmZ5ym6d71Yi?=
 =?us-ascii?Q?7/Yau5J4cZUeLKl7N5ILqnAZWD6dBmvqtvD7kdjrs/8uCM1sCGNY+UqLs0gm?=
 =?us-ascii?Q?bfluVxrW4+X4HCerU7ygZP49XKgPWQT3Yz1Qkd/t+jeuePs3kNj9clwLQgJz?=
 =?us-ascii?Q?TNK0KY2N6ayXTC64RjY/j07w5J5R+Lnl/Y5eOcn8lSCtWuzTXxem3vDmr3Ub?=
 =?us-ascii?Q?z5QUnaHhA8wCJ2PF1qi6bSMIKgMMIooGmfA7TBP//KJLcri3/re+8yQ/dauQ?=
 =?us-ascii?Q?JPC+D3sGBaAe5XxTJOQiAwzJslbjvMfkrpjO8t+sqXjL361WF5FFk7FgC9nE?=
 =?us-ascii?Q?WWWBUF6V4NquxKSNrdMIXVgds7l1lNFsbEvqaPkJJ99Pyiv2/vLL028tTg4x?=
 =?us-ascii?Q?GgHiJaLK/O4bRC16kEL/4ocLVhmIcyGASG1s/q2mtrFDNM7bGdbj22JdPgi5?=
 =?us-ascii?Q?mwmFP8OvAMw0hIIXnzUygR47WYVGRKirZTGyKBisyZxXvOglWN+PaEtkHNhJ?=
 =?us-ascii?Q?9W9qUoG2j34TUKUZfFZTu6mSrXXY+QfakYX0bRun76wCt0ytIFXXUWQlq81K?=
 =?us-ascii?Q?c3jZVcHO97tY89o3paC/cAkWqFAPMQt/p6liiiAjyiU1u94dpU0OsptVeNHc?=
 =?us-ascii?Q?jm1pcpKOxYQ83LC9SvvTDgwCRSZ8Wmn+mRHZOduaTN+rHeu413F1mMGcWHYd?=
 =?us-ascii?Q?mgLkvCF5bBUn84mc1DC4aQFmEUUBW0YfILaa5QZgcqDj4xfMgBKYQH8Kx0s4?=
 =?us-ascii?Q?8d71wphWnSF2Aae0ap1doc8x1TGjmhn2dQBQiuKkOVzhfeeYVNbiwCbFrd2+?=
 =?us-ascii?Q?iSx0o4q3lx33gYzwj5PZdgyafirfFhUw+dJrgjMh8/bzGdm5PTVh8FT7MjIa?=
 =?us-ascii?Q?3/AXsAr/GYFbP3h9y44Rd3OqDR6NuuTBLGDIejDt5HhvQCtQCRhDA3IsCT27?=
 =?us-ascii?Q?347cBzPisqC9noJD2jEAWpqnBfF9F2M1xf8uAlYHBB7Oax6SwC+oYMWpn6kn?=
 =?us-ascii?Q?/9uN8Zn0jfrg4pLmws=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;6:6rGzwyVkYZFEbIoM+UvvEVVwvZdDtCqE3J7cnntwk/fnwpkz0afvsM2lr1rzOo53Z9JfcIyTesrcyKicyCTrn7h7FUcED5watze/XUBmhKiHEV7m4vRM/CxERz+h3Zz+FubLAiPC1uj1K5CqFjZvtdi2N6Wk4/gUgBMlzrQM51xXmqa72yeQ9DPnuQFynaUoyQihcRV76i8K7vO1pMDmgR1Q+xEsic9xipOlUvatd2tiFu7A/0A2SGnZKU6zobRHtCHIdWtY07P38HJti8kXMfZhtUbXaNA6AlyiiOpGZgKGTv7COHu6V7roclu7cJa3rLFgBTiFD9ZjHBcIEBcndGuicLmkGK04ecEsJHV+M5o=;5:C3LCmvl3FnYHcSjPpBy66tMMRI6xjYs/hY3pR+RFmJEfwKKsTErn71u2Mr5GqS9vlk6nhAlMQCtDPHHSTUr4jBoYkhTVNiwdlk8WPokkv7WDLVCuzajTRQv2kcdepm71/FlazwghC0YvFZC9bZN0B/G8sFhNGr+lsZD0keac2nk=;24:mmgZVx3lrMuPja2SjpyLYzwYhRHd6gWxLWiEnbmBqmtxXpL3qVAgM5sS1gJnqiUR6D2kkJsCS9VP2U6xDrvSv/A6OczjR8qt5uWfdf2bjgA=;7:n70imhvTbqf88ijLSOGWGnkLaykgnHORNTwWP+J+M7V1iTGKnE1mVxTl9ynfKWhNAL2BrGrcMdopvZaG5pTKOEFI1PAL+PLcDturDxXu3MbAoFPYcoznj5pJXdlNv1kn5NRl3H7hudA2IU9R0FReY2feVWb4uAXN6Etb3VGkWdVV/uNi3ntqGOvecbeSTgvNwmitsEemGWlsyjwRzotSOJnt75OyhXEcl4D9pEA+xGu+P1zzrBnngEiC+NMyriVI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:+jWammbjKVVHBNSWQbnQjYEbbsW6oIcHU4wt/JrzXl49Iz4yOqGoI4QCf8IEkCwK4IULS0WG8cidd1yoNtXEbteVFku2k/MjZSE62OcbcKonlDRUD4XuWPyxHp5IA8lPMAdXAYV9cUcSUyC3VRJQlk/d1DHNRcV1a4I7HEgN4P8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:49:49.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d4dcdd-5fba-4b4d-1b6d-08d57251c699
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1755
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AAD hash only needs to be calculated once for each scatter/gather operation.
Move it to its own macro, and call it from GCM_INIT instead of
INITIAL_BLOCKS.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 71 ++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 6c5a80d..58bbfac 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -229,6 +229,10 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	mov	%arg5, %r13		# %xmm13 holds HashKey<<1 (mod poly)
 	and	$-16, %r13
 	mov	%r13, %r12
+
+	CALC_AAD_HASH %xmm13 %xmm0 %xmm1 %xmm2 %xmm3 %xmm4 \
+	%xmm5 %xmm6
+	mov %r13, %r12
 .endm
 
 # GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
@@ -496,51 +500,62 @@ _read_next_byte_lt8_\@:
 _done_read_partial_block_\@:
 .endm
 
-/*
-* if a = number of total plaintext bytes
-* b = floor(a/16)
-* num_initial_blocks = b mod 4
-* encrypt the initial num_initial_blocks blocks and apply ghash on
-* the ciphertext
-* %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
-* are clobbered
-* arg1, %arg3, %arg4, %r14 are used as a pointer only, not modified
-*/
-
-
-.macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
-XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
-        MOVADQ     SHUF_MASK(%rip), %xmm14
-	mov	   arg8, %r10           # %r10 = AAD
-	mov	   arg9, %r11           # %r11 = aadLen
-	pxor	   %xmm\i, %xmm\i
-	pxor	   \XMM2, \XMM2
+# CALC_AAD_HASH: Calculates the hash of the data which will not be encrypted.
+# clobbers r10-11, xmm14
+.macro CALC_AAD_HASH HASHKEY TMP1 TMP2 TMP3 TMP4 TMP5 \
+	TMP6 TMP7
+	MOVADQ	   SHUF_MASK(%rip), %xmm14
+	mov	   arg8, %r10		# %r10 = AAD
+	mov	   arg9, %r11		# %r11 = aadLen
+	pxor	   \TMP7, \TMP7
+	pxor	   \TMP6, \TMP6
 
 	cmp	   $16, %r11
 	jl	   _get_AAD_rest\@
 _get_AAD_blocks\@:
-	movdqu	   (%r10), %xmm\i
-	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   %xmm\i, \XMM2
-	GHASH_MUL  \XMM2, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
+	movdqu	   (%r10), \TMP7
+	PSHUFB_XMM   %xmm14, \TMP7 # byte-reflect the AAD data
+	pxor	   \TMP7, \TMP6
+	GHASH_MUL  \TMP6, \HASHKEY, \TMP1, \TMP2, \TMP3, \TMP4, \TMP5
 	add	   $16, %r10
 	sub	   $16, %r11
 	cmp	   $16, %r11
 	jge	   _get_AAD_blocks\@
 
-	movdqu	   \XMM2, %xmm\i
+	movdqu	   \TMP6, \TMP7
 
 	/* read the last <16B of AAD */
 _get_AAD_rest\@:
 	cmp	   $0, %r11
 	je	   _get_AAD_done\@
 
-	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
-	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   \XMM2, %xmm\i
-	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
+	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, \TMP7
+	PSHUFB_XMM   %xmm14, \TMP7 # byte-reflect the AAD data
+	pxor	   \TMP6, \TMP7
+	GHASH_MUL  \TMP7, \HASHKEY, \TMP1, \TMP2, \TMP3, \TMP4, \TMP5
+	movdqu \TMP7, \TMP6
 
 _get_AAD_done\@:
+	movdqu \TMP6, AadHash(%arg2)
+.endm
+
+/*
+* if a = number of total plaintext bytes
+* b = floor(a/16)
+* num_initial_blocks = b mod 4
+* encrypt the initial num_initial_blocks blocks and apply ghash on
+* the ciphertext
+* %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
+* are clobbered
+* arg1, %arg2, %arg3, %r14 are used as a pointer only, not modified
+*/
+
+
+.macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
+	XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
+
+	movdqu AadHash(%arg2), %xmm\i		    # XMM0 = Y0
+
 	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
-- 
2.9.5
