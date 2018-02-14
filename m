Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161394AbeBNRkH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161343AbeBNRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:03 -0500
Date: Wed, 14 Feb 2018 09:39:36 -0800
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
Subject: [PATCH v2 07/14] x86/crypto: aesni: Split AAD hash calculation to
 separate macro
Message-ID: <20180214173936.GA62048@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: CO2PR06CA0067.namprd06.prod.outlook.com (10.165.93.25) To
 MWHPR15MB1757.namprd15.prod.outlook.com (10.174.255.10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1554bf1d-7b7c-4816-c84d-08d573d1ec7c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1757;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;3:r22lm0ofaZdlq+s5WW5cZ2TRSTJeir8v+JI8oWKpG9JfPZkw7GeEP5RoDJpYFR5jyRmejVVIL6U+NvLoxprigTyqniCDdXsNk90tfO9MiKt71G43yCpBidZHnPqHdZOtAf0sWULVbN5zVBXuI6AdSFMWUI/uKShFjDvLtabBjBEbLsyhdoLYZh9oBaxc1paDBg89AGfL1VgifuanJXIOtx6Jy3hKFpNMj6gbChsvCQgGEbw66rBHhD6f5aWtslXZ;25:xDgsRpU3hhaQHV7rvPozZVaAT5vspjKtuz4ea+9p7P6KsDDqbOerQwuO239GY1+Mc/PC6qC+beNmzexJ0eVVWU64c5beMgJ7EwjjJ57qTVnw/pzaB1jAXjMvK8p+mqUiYsfYHlFdJG98nilwQ/OG20/2S0HiNiy9pnQXfyJqMZGlLMvVUIeMbMIRXksdEOyTWY41xUNvtL4oBHi9WCmo+9GHBVIbmBFY2nedecppDaXK9sA3Zz1uL+4cPXqMBzcEg0lV82wtCFhRpSzowjD+FZdjJ+TIZmHw0n2y5hju1kt6K+4QGfObE+OGYdsU1T1+HpXxstVbQ1s2iEkDQV9Mvg==;31:5r0AfiToRtcntWRy+zKOozgIgIoLmBloIZmAPNd78eEcFwiswCXKAqFijsGCQnJhKuPDRQaSQiWfkoC+p+lAXoa5ELjCDWd/s2qpfNiYBBv76VLFB/Kkw1mbk53uMfm98G/qrcUDLa1xfW29PDoE7noAMICjukEGF9FXxlV3hwdSsLjefiSG5Hx2SGL5ZSQJ66oqzEMztDFyxdCJuFxH3S/N9JEbcwBKL0YVrlnwgNM=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1757:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;20:SUOcUdGrBqkfjSTwyPfekwa80R6xApAH/hbfgXNEqHv7Bl201BsdjaSGYmTYvH7KheWtWjvZwnSIicTv2jxZLo+835Fk5r2uZFsRj9pwYByjArrhVWeaXhvHD/fs7hKjfSaOBoGuxNTh3agvbTos875ZLqksVCL3RU+/1yTfpo+tQl8uHV4+Uqn626pt0Ie1CMrW0qgY0/U8gtlut3JS6TiBU0mqdQvPWODdVOW/V0n0euyeLtAbD2e0erNJz2uJLe+ycMmbwMyNSa8nABEaWoBFN5or0FRshOKlV2A95wv5tpy44j0agd5tDNbIL6/U5F+ZuEyJiH2whkS89rpStHMjSTiW9LxMUkj+oMIbk6Ch6u9uf2YG3xUkei98ax0vh47UEvW2GEcYV83wXml4abZum590K5sYPodddnDrJ1G+8aS8zgxhFdaZBIAWOGEp1/prM5CPwIHGgTrOLpEU3SfyU0+sHOyzkYpSFGluV761aa3aOMJU7k8s594XOU5t;4:7OlaNFkkxQoqL/6YWIQLNLBe3biHEmgqnM78aEyRiOnDyR2VpohkMRf227yV9JWP192Pe4PFRM7juclPkVDNRtzZkA5n9/PfaZXHZDl1Tl/2k5hkkyKDXOmVwNZ9ssi1QUvMxm68qj4ORAAp40CPiQLkC+zvMeo499KhZEc4s4PG/h0EGhkihWDwQ4dF++CwFRqCUoPk/HTy3F+dr47jXuFHtaENu1NmEr71EigNRUZuTNbiAY6Uu/yLArQU9yZxakP21rI36ZnLU5mf1e2jyAxpSngqeIDEUh3tVgqRljtOAKe1OeK/IwJqd26Cc3zNSr3I43jMlzhAJEaVET3sRfx7mU7kMdQ7DY2HJenNtVY=
X-Microsoft-Antispam-PRVS: <MWHPR15MB1757EDD5438A6F402AB02620DDF50@MWHPR15MB1757.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231101)(11241501184)(944501161)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR15MB1757;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1757;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39380400002)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(54906003)(316002)(16586007)(6496006)(186003)(81156014)(8676002)(81166006)(58126008)(110136005)(7416002)(8936002)(52116002)(52396003)(16526019)(5660300001)(97736004)(68736007)(33716001)(6666003)(2950100002)(106356001)(23726003)(386003)(33656002)(33896004)(76176011)(105586002)(6116002)(1076002)(478600001)(2906002)(76506005)(25786009)(83506002)(9686003)(86362001)(53936002)(6486002)(47776003)(4326008)(305945005)(50466002)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1757;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1757;23:RjkP7Q3J+NMsMMRnmMGy+Mu6jY2ZdU0rpc8JtZThd?=
 =?us-ascii?Q?lsiylcnbg8fwSeqzO0MdjRnAVExlDGfgLAgI37yf+W86xG9e4tZ1xBNvLvSi?=
 =?us-ascii?Q?gV4qsOU1cBGPpBgAkrXyUGJrRdLs47wKVhlRNcvVePQkUYEqv0DH3uqv7cMF?=
 =?us-ascii?Q?BoEYsRv3w6AFCKoYoKvN8nxUDAxhSYQm7LgmFBgc8pJ9sEoIXg+4bQq8FcA7?=
 =?us-ascii?Q?0Lwi1wYjtRpidgSuWxI6eUL1c03OAd5mjYR9Db8CUqHw2AVHoYls1TzGFeUS?=
 =?us-ascii?Q?6qdoAGPB11OYmLcDmb4SrO31/gfNeF89FIcscGQbW5RMvw42yc6RfU6QB1ic?=
 =?us-ascii?Q?rMDCGaCC9zWe0M+mYvi7jccZ4Jwzf+E4r844xFXAq4anlKMwwDRq/D5ipzsV?=
 =?us-ascii?Q?GDOsQMwEj3I26Ex3BBKadhnMMwA+aITsXfQNA2CozI93lMydXQ0dv5VJ3cXs?=
 =?us-ascii?Q?LL44UjKrL5CEAh6p5zOpmYkRc1Abn9cCl0axvZWFoOp3vNgDi5sm8vAoz3Cc?=
 =?us-ascii?Q?WzFkt2ovwetgzRhxFK1RAw8WIxZOmVWjtgYBzWJX5GsWm+3H79xWnTDEQiS5?=
 =?us-ascii?Q?nhtKMIZqNduwt4XzKC8+4NdPCaoyVNoAePMiQqtwhnrMGV9CFUaaVOySJBWQ?=
 =?us-ascii?Q?TpK632TIrhVgb+4Nfd5H/Rd/dOb6bo4UE9+ftjmyUD2S3NWQxjOc4pEWz4CN?=
 =?us-ascii?Q?ywsoYwqQN6VK2OH4fBqbd8V8pndr+ALBgoupKHEkzFX4vzCcmqhh7yxWhxah?=
 =?us-ascii?Q?vNE6O8ucwoP2+tS/jjgMLtRWSj9bpu3vGp37WyWrwLMiD9BWMkEXp1MLb7gM?=
 =?us-ascii?Q?dTPxD4isbNFF/Iz6BdQennatEKxvAlBRraXVqWPhYbV/HSPJYrhU6zNk8jDU?=
 =?us-ascii?Q?9nwGHpA/S1eD30pv/mb/hMG2lnSaTHpD6LOxfDTLhB+Qhv/dtAMAcoNhHblk?=
 =?us-ascii?Q?Q6grRYSSj9Jc5sagbcKsIK1sffN5x/McYiJ9luA5P1IPud+6gLwMUm3pFyzs?=
 =?us-ascii?Q?Oklrj+vYic/FLRIV1m/SOyxroQIbFIA3l+3SeRE7sO3Y3xKpcjjjhdFb4uwx?=
 =?us-ascii?Q?sKVEVrmiAxxsd2YK8cOde5HhicP5/ynab5xtymbzys9oGFQXen4W1UmQJWlo?=
 =?us-ascii?Q?2enmDQ9VEXFz2T/O3kBv+lt8oLWJk8J7lr466KC0+Wxa+CgXmhNcloSp/2k3?=
 =?us-ascii?Q?LkhxqSw/Q6myT/I9UmEjVHjDhF0YfxWUke7p/KT2TM+Mz9xzlDjU/IfIlptu?=
 =?us-ascii?Q?iqQIUFcGTVcenax7RQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;6:EXE05E/N/0YMLjhkTY+4Cc/3FVeAFJDbO3LReq1jJP8fm421i7Uui4MRKeMHO6CGy9iLsiK5WpbDIPTLQIZkf5+razaKS/eW5L1P/Z0J+lfiz/gWDyWDxPPOvLKmhBzqSUVSALNIpG6Pwk+BSM6/YBz6h+qvXKOXGNMicJoTK6qjKxxervlJ0NXhuTnViJ8anxXF3aI64hK8NwBPmwKTo+0gtXmWwdg7JJBDdJhW8dQmDJHMRS8nDu6cAFSgrNdFBXZjDa53Ea+QgVo4ZiAaSQb0Wu8KhJiDQKKzVu1AuHJqMqOcVL2moF7Ej2dFpBOnOZNeVXz/hxv+oAzHE1yat40E8hcIjkXxIpeHRY2qrII=;5:T4Iyty9+Fz8Ewi/vCj5iGxK91h6ZpZlJAkrhCFWWW/8w/ShHGFqO6Z2BPP/VcA0tthLPUih+RVCvaZi50E8S6U8v9gnBbqyLVUrFYJ2Gv/7iya7mQz+PwTrTw9QA5ZI1kxGNVfuatidwB8+24OCi7P1tmwoNsneNUw+UyiAR1jg=;24:/Z1ljumC6lTzQoBLC9T2H2/AjDavSREXNjypYk6LyZYL+COqeRjGtIx+uLsrOYzY+nmF3pqII8kdCyQutXNFrP3GrVuJqfpLk1wvG79NhlM=;7:h98N4aOle7wbPkr+P5LzDoLLTH/HeCmIVA+MWlw0t6pzjebz4f1E2ufpyl5yH9kTZhYtNh8eHeY2TtQ3u8LLBFex2oSEjjDVVskkrfMzfRUNvwtBORF2ixhVPUJVgW/cg8cTh50lZpAI9TSg3TapyhJ72Kicenjmk7WFPFONOisKT5vxRkEwfL7zeAkF1bAMRCQLS72apjyNWvnz4Mf7qflCfJEIiqkgWpRk0FFfu2UJNAuFbVzHUJixY8eRsmD6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;20:HaPA2HHVQfp5GvCh7bhEtz4eZ7Br7w5mg+cHeSWnTk26Egvx4C10VcrGE4jMo0QXDBCA4kiRWsnQmJZKXFlaBX2GSkUeUi0tux+a7QzKix4XzvtmJhyKCPW3BxjHdXoaY41UlAvynrt6OcI3RXAN9VrLDQR9gX8w8d3hEIzmY3U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:39:39.4971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1554bf1d-7b7c-4816-c84d-08d573d1ec7c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
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
