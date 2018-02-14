Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161432AbeBNRmi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:42:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161212AbeBNRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:14 -0500
Date: Wed, 14 Feb 2018 09:39:23 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Sabrina Dubroca" <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH v2 06/14] x86/crypto: aesni: Introduce gcm_context_data
Message-ID: <20180214173923.GA61995@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: CY4PR13CA0076.namprd13.prod.outlook.com (10.171.162.14) To
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79b3e03-4556-44ec-9f89-08d573d1e67a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1756;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;3:Z8x3BwJJUTW0BIUOgwUPqMCLiJZJR/jM+Q4krVmqh6d8TTGf/j69uAdyHfsP8vTGFwLTJCVaC+jWEPVNey1uUR658qpQ36NEMJqcmIfAUJ+SjzUB7CVqoBR6nqSsj3vfGckmfvCyPqp2EMHQvhLm53LmaPsQEltEv9sm4C3MAgvB7ZqKLCMpxuKHgo7n2gbnBY63gaBOVhYgtn0sacFLivtxLtfMm/rjeIC7PXWziIbSgw1imWdr/MYMxXc9F+Ig;25:fkKcwFOdI1DgNUhwvXuXzoEfRWk24K8qwjy+KDMjLOO764HVIO7bXclWl5ALhFsIoMI0KZ5kS6o2QCeBhR8ccvSbRHhwhv1qiDDTliPAasQLcI5KAoiGQzlYiEsgYcjInoAkEe68K/Ij6bWzggE2PGNExCXT0PElaXqBe3t+2mgUUc9NVBuKCH0dqknU/zzBo2pr0F3RBNNaWr9iwf8DLMJH/JCJ5wOjiXBgP29y7Ho6PN7FtdAOIinZdksii1oWTmtZN8jrGisfWshyGGblSPvS3XIwYt8ADwY0QyUg7fkq+/a8opQNMJL41pG/elxE6UBKZoTmaFJFL51gBUw+fw==;31:pr7DgBpJbYb+Mr76rPD+1EM2U4+JzEEOwFH9yNjVMcnbjZRmXqZX2+ah+hLp97Z5azM+bWRlkMU85flmgcBBH5L9uqLfJlFJxBfqxhXjCdq5gQGTpAsH9XwQ2AWqrgB1iPacrnh5JIcmxU7oyYoBZ7EeqftWvMGz7LJb1AG63Xh74kF9msRAXSv+Jigc+2YCt8DZERzSi1OsNk8Oo84CaIGIfDM/bVaaNo+htL2USmc=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:yoTxI74f9c/9C7ZUV2Lw2HmAEjXOx6nQY31Jzn0bDMSB7Sn7IMwtZ61ECxncQPe5YAMiRwKw1f0HYh7y5bU5VJrwenkFwRvThyVTxzynB2dvs4zTq87EEWnXdIj+ZmSbaUQ6nkq/P3cknZjPb8NRbZVeHJHCnOFcai+Wqd0mUdZ8tECHpYPwE8UZIF7PLxVm92OUd6s5lZiIIVNAX00FFUoCWv/wLPh+ybwrRPdnsY4j6pzw5thafQoPH9RZZDrBuxz7prm8mEE1vHGXyoKmp3Xh1VUIGUTiZCADSv264rOCdoROI6F7yH4DfDOp3Gza7btoQCm8ZoUZu7guvxMPxSZP9MxX1KhJTM0hViij66k+iPmD8as34V+TEq4PFcpYKFyspksJmj8lf7ZSlOL/S+ROA9BTg0waDaThC/d0MLR6YMOX1QdlkhYUiyww9i4fvya4pc93qHjGkneGTA8QmdW2TPfhQO0TH+/r6wmcdvfP0e9JmdK3Q5YB0aRvZmIX;4:NWjhlA/Mp/pmDrioDaX/WwxWdFiamNJ8wO2b25mpgHfJLEgtK8XQd68jYpSRRg0G3PgQxo32f8Q5UmsMSGukcwGIOhYh0EzNDPkxY3cMX8/oDDfbmWTuGk7ntawOy/uJIx1z7QHDmzxQoBUVYpY5PG7FRhKPprAIHwfzMCSdKG6NzXC03HHQrxQ3r1g0C/Un6RQ2YgB1DZL6t7BFsR1h0rmLxc1+UYqSJbQCFgz4SfrskoBcArCoN0DS8xmSRflNtfAZ316OZ7xD3dxOKhBrDgC/CENy2XGrN8/W9VOw4ujMOZBgMOVHQ+aqD9aEX554USyNazfyIShMAn2UllMIrQQl3PvriCi21HvK2ekTcUE=
X-Microsoft-Antispam-PRVS: <DM5PR15MB17567CE5B7F31AB75DC93BE6DDF50@DM5PR15MB1756.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(68736007)(4326008)(305945005)(7736002)(25786009)(33656002)(478600001)(8936002)(6346003)(2950100002)(6666003)(7416002)(81156014)(106356001)(59450400001)(76506005)(33896004)(52116002)(386003)(81166006)(52396003)(8676002)(76176011)(5660300001)(16586007)(6496006)(50466002)(54906003)(58126008)(110136005)(186003)(105586002)(97736004)(53936002)(316002)(16526019)(9686003)(33716001)(2906002)(47776003)(86362001)(23726003)(6116002)(6486002)(83506002)(1076002)(334744003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1756;23:8xGh7LCuBvx0LX4WOQA3w6I3NKB/MA/iNoyufEUqt?=
 =?us-ascii?Q?czm2ncd98+WN8UgsOIPGxG2imydSIy/2qS+P2+2u29StGsbq4jJwQmAFTGkf?=
 =?us-ascii?Q?ca8khXk8gkBoGFIUnFEkE64lXhFnQ8rOs/IEXRI/0/nHICR6xLX3F5VMUxMC?=
 =?us-ascii?Q?kA171JP9HJSYu15ymuOsnEcmNL/bJo5Vk1SQTJSJ/ZoPzuoHRoHs8rs2ITBR?=
 =?us-ascii?Q?upI2bfHb29N38O26wPoKrjoE3F7j1TGMtSz6C4KOWg2yNct/+Od0uaOBM4qu?=
 =?us-ascii?Q?xDHWugZVF23Okb0QBiAVbUQKVAOm7h0USaI5TKe9v2RjENFtsbaTaAE73x4Z?=
 =?us-ascii?Q?WJtGPcN3hVclRqQFfhhMyr2RgY+xmWH2YBc1s8ftZLW/uBXZdm+wiUViK4uy?=
 =?us-ascii?Q?IKcYJh8eyplQmhy4q33WjQCd3hUGWqc3WCWY6vkttnvfHn5shGVSYQHIrKEr?=
 =?us-ascii?Q?0Uk2EX20UCszNbUjvH4gOQmMLL3uYWl/w28OYo2nF3sxDnBRCnewtEe4UFvI?=
 =?us-ascii?Q?IDhdFv5HX4MZxuxcd7B6WLJtvvEThYHCX9T4XQoms/HowXJ8XCtNy0GOdpWb?=
 =?us-ascii?Q?7t3juQXN21Ybp9AEl/e1MGGoSIvS+sCXtH6Dxow3jT955cfC7zVngKWfKjqa?=
 =?us-ascii?Q?dlTq7y1JHnAIgqODEtYDZckKNGw1ypsmxGLiw3WLI4xBFMcrXApQQXdbW4o+?=
 =?us-ascii?Q?PA9jcLPbu9vvxoL4LFvsyaGcd50THGV+4gM9DHLVM5rFpTgSbnKn7DhGSN4Y?=
 =?us-ascii?Q?p6p3n0MFuDmJHRI9/9jpYLyDZ1SQnJIwR7zKN27tYVCsew+5F8QFMlOgdGnR?=
 =?us-ascii?Q?siwtkyHpkD2ZP2MWKwwAujNhf1OoSDsHUI4rnXHP9G5wowyO3R4VQBxIBSqM?=
 =?us-ascii?Q?yIInmBlgxhdA5Wqt/YTfw9vafuOM9HR5YDV0Bt/7FstLicS0DQKCqck0ZvjF?=
 =?us-ascii?Q?KCRx5leOYdb3h53gnpyvC7KWDSLJJlyRsnH32V9enltEn2VCCzTp/4He4KKX?=
 =?us-ascii?Q?RIV4zN1wUOnMr3qJ/2OciTu2TkktR6klvOpRwPQ8kQfYbMmM+NSW7NHmYmXn?=
 =?us-ascii?Q?yANU1RsjaI+EgoW3FJ8l5ahYhnUx+eVnCDjEcuVWnazQir06uOUQE+SPQe4h?=
 =?us-ascii?Q?7QT5ZhLQMo74damLjFxomaF1eyhGeUPHu7r9uKZfJCfwmOvgyIiIN5YqdNxB?=
 =?us-ascii?Q?9x+kdp0FoGvAgQ4+Mr9LwLEdpvoCrYsBgnrO7Cr7LB+GrhBpkpH06jpSyZ9L?=
 =?us-ascii?Q?G23AtievameZFxow4SG7Ojs+gpzSsQdaGZjx2CiC7PQXlXF+35USCae9PKsD?=
 =?us-ascii?Q?wFe1ZcQ+3ZS+26KJ0AOPvBiL34+7IIOkPoU1Pi4Oygp?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;6:0dewSQwK0jHXopXg+VQYloeHDhfCHe06556NowvE0FByBSeQmUoXNh1ZaHEUnjojDKl0VMZuhneQS3vl5p95DFT2i3DypCvPbi4/kCpeFnbDxX8yEX5thTcPvvQjQJ+jYdy062SCwAyrDlcmFN1aWLR6NiwuFdZaaUnF4MFOxZdzmtuU6c5rI7ObZkSf8wbDaiL7aZ4uQhadkiNhvhQU4hGJXEkpFofz8dGJ/AMnsuQkZmV8UjxyLaUvu4UAMLW+L5CQSXfDiET58IAIClY9IRWB9LJ15eO4hOOjd7YidNcrhvKcpMa5MosnmT7u6v6G9s9IgCjMpPy453vcuuwuhuGkoxwbrvKUJWRs7ySvzJw=;5:zD8twaOgFgYFbSKaEqKgmPTo4tGMotNO7CMxRsTAR0ELOZ5CABm2EgEHDthM3U/XUNc/wXaw+yV84YquBnDSVcE9UzKKWt2tpRKZKI03dj6JP19CO1iRrFjp81q7QV4wnRb8Mho0MSOXWCscQ0vuClajaloy6H0a74f0fW6mlAY=;24:zXUmmKoYPHIQwD6tsSsChxgPorJTlA1M3PtE+EwcjjRnRbykGabhEpYlQyRHXCASMXj5fvQWnH68mRUJN2Wh5rlFQajO0GCNO7/gT+rdmRU=;7:AUfqgGHeefiVdISLxaG5LJ5CzaZUfTOVCzJ6PNO+ZBHqvXT7G6VmvQ2FF8EBWIYpmzgc/zLTgCfQlxfnHQPjObfzmehAX8TBYu2i0ZaQDqywnyXGNjEtSwneB1dBN/Ni5xOi1cj9s1wXf7tW7yleaHX7ZDtCkQ+bdI5iZla8MfzL7Yj3/AqZS/WtdqNP7Vj3MklrrXNqr7yYqTpRuCCDCzEZhqmlwEWJfPw/0z0UpS4l6qWiS+uAtGAH4pvECde9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:qJRHDRoO2RIuSK33g+zjn/jo2JWB5JnMHAHfBLi1bst7KFepUXEqlJXTNNmm+j7HdaGez8LDCCGP/zG45MxDen7RfTBHHTpQ+4WHkU8mL5oCKAPW9CV30BCXspSfIiEAVfYnqhogHAolmEAGNes83+f3tgvt+f76l9gKnbognBg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:39:29.2604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79b3e03-4556-44ec-9f89-08d573d1e67a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a gcm_context_data struct that will be used to pass
context data between scatter/gather update calls.  It is passed
as the second argument (after crypto keys), other args are
renumbered.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S  | 115 +++++++++++++++++++++----------------
 arch/x86/crypto/aesni-intel_glue.c |  81 ++++++++++++++++++--------
 2 files changed, 121 insertions(+), 75 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 8021fd1..6c5a80d 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -111,6 +111,14 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 				// (for Karatsuba purposes)
 #define	VARIABLE_OFFSET	16*8
 
+#define AadHash 16*0
+#define AadLen 16*1
+#define InLen (16*1)+8
+#define PBlockEncKey 16*2
+#define OrigIV 16*3
+#define CurCount 16*4
+#define PBlockLen 16*5
+
 #define arg1 rdi
 #define arg2 rsi
 #define arg3 rdx
@@ -121,6 +129,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define arg8 STACK_OFFSET+16(%r14)
 #define arg9 STACK_OFFSET+24(%r14)
 #define arg10 STACK_OFFSET+32(%r14)
+#define arg11 STACK_OFFSET+40(%r14)
 #define keysize 2*15*16(%arg1)
 #endif
 
@@ -195,9 +204,9 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
 # Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
 .macro GCM_INIT
-	mov	%arg6, %r12
+	mov	arg7, %r12
 	movdqu	(%r12), %xmm13
-	movdqa  SHUF_MASK(%rip), %xmm2
+	movdqa	SHUF_MASK(%rip), %xmm2
 	PSHUFB_XMM %xmm2, %xmm13
 
 	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
@@ -217,7 +226,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	pand	POLY(%rip), %xmm2
 	pxor	%xmm2, %xmm13
 	movdqa	%xmm13, HashKey(%rsp)
-	mov	%arg4, %r13			# %xmm13 holds HashKey<<1 (mod poly)
+	mov	%arg5, %r13		# %xmm13 holds HashKey<<1 (mod poly)
 	and	$-16, %r13
 	mov	%r13, %r12
 .endm
@@ -271,18 +280,18 @@ _four_cipher_left_\@:
 	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
 %xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
 _zero_cipher_left_\@:
-	mov	%arg4, %r13
-	and	$15, %r13			# %r13 = arg4 (mod 16)
+	mov	%arg5, %r13
+	and	$15, %r13			# %r13 = arg5 (mod 16)
 	je	_multiple_of_16_bytes_\@
 
 	# Handle the last <16 Byte block separately
 	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
-        movdqa SHUF_MASK(%rip), %xmm10
+	movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm0
 
 	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
 
-	lea (%arg3,%r11,1), %r10
+	lea (%arg4,%r11,1), %r10
 	mov %r13, %r12
 	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
 
@@ -320,13 +329,13 @@ _zero_cipher_left_\@:
 	MOVQ_R64_XMM %xmm0, %rax
 	cmp $8, %r13
 	jle _less_than_8_bytes_left_\@
-	mov %rax, (%arg2 , %r11, 1)
+	mov %rax, (%arg3 , %r11, 1)
 	add $8, %r11
 	psrldq $8, %xmm0
 	MOVQ_R64_XMM %xmm0, %rax
 	sub $8, %r13
 _less_than_8_bytes_left_\@:
-	mov %al,  (%arg2, %r11, 1)
+	mov %al,  (%arg3, %r11, 1)
 	add $1, %r11
 	shr $8, %rax
 	sub $1, %r13
@@ -338,11 +347,11 @@ _multiple_of_16_bytes_\@:
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
 .macro GCM_COMPLETE
-	mov	arg8, %r12		  # %r13 = aadLen (number of bytes)
+	mov	arg9, %r12		  # %r13 = aadLen (number of bytes)
 	shl	$3, %r12		  # convert into number of bits
 	movd	%r12d, %xmm15		  # len(A) in %xmm15
-	shl	$3, %arg4		  # len(C) in bits (*128)
-	MOVQ_R64_XMM	%arg4, %xmm1
+	shl	$3, %arg5		  # len(C) in bits (*128)
+	MOVQ_R64_XMM	%arg5, %xmm1
 	pslldq	$8, %xmm15		  # %xmm15 = len(A)||0x0000000000000000
 	pxor	%xmm1, %xmm15		  # %xmm15 = len(A)||len(C)
 	pxor	%xmm15, %xmm8
@@ -351,13 +360,13 @@ _multiple_of_16_bytes_\@:
 	movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm8
 
-	mov	%arg5, %rax		  # %rax = *Y0
+	mov	%arg6, %rax		  # %rax = *Y0
 	movdqu	(%rax), %xmm0		  # %xmm0 = Y0
 	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
 	pxor	%xmm8, %xmm0
 _return_T_\@:
-	mov	arg9, %r10                     # %r10 = authTag
-	mov	arg10, %r11                    # %r11 = auth_tag_len
+	mov	arg10, %r10                     # %r10 = authTag
+	mov	arg11, %r11                    # %r11 = auth_tag_len
 	cmp	$16, %r11
 	je	_T_16_\@
 	cmp	$8, %r11
@@ -495,15 +504,15 @@ _done_read_partial_block_\@:
 * the ciphertext
 * %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
 * are clobbered
-* arg1, %arg2, %arg3, %r14 are used as a pointer only, not modified
+* arg1, %arg3, %arg4, %r14 are used as a pointer only, not modified
 */
 
 
 .macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
 XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
         MOVADQ     SHUF_MASK(%rip), %xmm14
-	mov	   arg7, %r10           # %r10 = AAD
-	mov	   arg8, %r11           # %r11 = aadLen
+	mov	   arg8, %r10           # %r10 = AAD
+	mov	   arg9, %r11           # %r11 = aadLen
 	pxor	   %xmm\i, %xmm\i
 	pxor	   \XMM2, \XMM2
 
@@ -535,7 +544,7 @@ _get_AAD_done\@:
 	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
-	mov	   %arg5, %rax                      # %rax = *Y0
+	mov	   %arg6, %rax                      # %rax = *Y0
 	movdqu	   (%rax), \XMM0                    # XMM0 = Y0
 	PSHUFB_XMM   %xmm14, \XMM0
 
@@ -572,9 +581,9 @@ aes_loop_initial_\@:
 	AESENCLAST \TMP1, %xmm\index         # Last Round
 .endr
 .irpc index, \i_seq
-	movdqu	   (%arg3 , %r11, 1), \TMP1
+	movdqu	   (%arg4 , %r11, 1), \TMP1
 	pxor	   \TMP1, %xmm\index
-	movdqu	   %xmm\index, (%arg2 , %r11, 1)
+	movdqu	   %xmm\index, (%arg3 , %r11, 1)
 	# write back plaintext/ciphertext for num_initial_blocks
 	add	   $16, %r11
 
@@ -693,34 +702,34 @@ aes_loop_pre_done\@:
 	AESENCLAST \TMP2, \XMM2
 	AESENCLAST \TMP2, \XMM3
 	AESENCLAST \TMP2, \XMM4
-	movdqu	   16*0(%arg3 , %r11 , 1), \TMP1
+	movdqu	   16*0(%arg4 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM1
 .ifc \operation, dec
-	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
+	movdqu     \XMM1, 16*0(%arg3 , %r11 , 1)
 	movdqa     \TMP1, \XMM1
 .endif
-	movdqu	   16*1(%arg3 , %r11 , 1), \TMP1
+	movdqu	   16*1(%arg4 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM2
 .ifc \operation, dec
-	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
+	movdqu     \XMM2, 16*1(%arg3 , %r11 , 1)
 	movdqa     \TMP1, \XMM2
 .endif
-	movdqu	   16*2(%arg3 , %r11 , 1), \TMP1
+	movdqu	   16*2(%arg4 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM3
 .ifc \operation, dec
-	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
+	movdqu     \XMM3, 16*2(%arg3 , %r11 , 1)
 	movdqa     \TMP1, \XMM3
 .endif
-	movdqu	   16*3(%arg3 , %r11 , 1), \TMP1
+	movdqu	   16*3(%arg4 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM4
 .ifc \operation, dec
-	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+	movdqu     \XMM4, 16*3(%arg3 , %r11 , 1)
 	movdqa     \TMP1, \XMM4
 .else
-	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
-	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
-	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
-	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+	movdqu     \XMM1, 16*0(%arg3 , %r11 , 1)
+	movdqu     \XMM2, 16*1(%arg3 , %r11 , 1)
+	movdqu     \XMM3, 16*2(%arg3 , %r11 , 1)
+	movdqu     \XMM4, 16*3(%arg3 , %r11 , 1)
 .endif
 
 	add	   $64, %r11
@@ -738,7 +747,7 @@ _initial_blocks_done\@:
 /*
 * encrypt 4 blocks at a time
 * ghash the 4 previously encrypted ciphertext blocks
-* arg1, %arg2, %arg3 are used as pointers only, not modified
+* arg1, %arg3, %arg4 are used as pointers only, not modified
 * %r11 is the data offset value
 */
 .macro GHASH_4_ENCRYPT_4_PARALLEL_ENC TMP1 TMP2 TMP3 TMP4 TMP5 \
@@ -882,18 +891,18 @@ aes_loop_par_enc_done:
 	AESENCLAST \TMP3, \XMM4
 	movdqa    HashKey_k(%rsp), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
-	movdqu	  (%arg3,%r11,1), \TMP3
+	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
-	movdqu	  16(%arg3,%r11,1), \TMP3
+	movdqu	  16(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM2                 # Ciphertext/Plaintext XOR EK
-	movdqu	  32(%arg3,%r11,1), \TMP3
+	movdqu	  32(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM3                 # Ciphertext/Plaintext XOR EK
-	movdqu	  48(%arg3,%r11,1), \TMP3
+	movdqu	  48(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM4                 # Ciphertext/Plaintext XOR EK
-        movdqu    \XMM1, (%arg2,%r11,1)        # Write to the ciphertext buffer
-        movdqu    \XMM2, 16(%arg2,%r11,1)      # Write to the ciphertext buffer
-        movdqu    \XMM3, 32(%arg2,%r11,1)      # Write to the ciphertext buffer
-        movdqu    \XMM4, 48(%arg2,%r11,1)      # Write to the ciphertext buffer
+        movdqu    \XMM1, (%arg3,%r11,1)        # Write to the ciphertext buffer
+        movdqu    \XMM2, 16(%arg3,%r11,1)      # Write to the ciphertext buffer
+        movdqu    \XMM3, 32(%arg3,%r11,1)      # Write to the ciphertext buffer
+        movdqu    \XMM4, 48(%arg3,%r11,1)      # Write to the ciphertext buffer
 	PSHUFB_XMM %xmm15, \XMM1        # perform a 16 byte swap
 	PSHUFB_XMM %xmm15, \XMM2	# perform a 16 byte swap
 	PSHUFB_XMM %xmm15, \XMM3	# perform a 16 byte swap
@@ -946,7 +955,7 @@ aes_loop_par_enc_done:
 /*
 * decrypt 4 blocks at a time
 * ghash the 4 previously decrypted ciphertext blocks
-* arg1, %arg2, %arg3 are used as pointers only, not modified
+* arg1, %arg3, %arg4 are used as pointers only, not modified
 * %r11 is the data offset value
 */
 .macro GHASH_4_ENCRYPT_4_PARALLEL_DEC TMP1 TMP2 TMP3 TMP4 TMP5 \
@@ -1090,21 +1099,21 @@ aes_loop_par_dec_done:
 	AESENCLAST \TMP3, \XMM4
 	movdqa    HashKey_k(%rsp), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
-	movdqu	  (%arg3,%r11,1), \TMP3
+	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM1, (%arg2,%r11,1)        # Write to plaintext buffer
+	movdqu	  \XMM1, (%arg3,%r11,1)        # Write to plaintext buffer
 	movdqa    \TMP3, \XMM1
-	movdqu	  16(%arg3,%r11,1), \TMP3
+	movdqu	  16(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM2                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM2, 16(%arg2,%r11,1)      # Write to plaintext buffer
+	movdqu	  \XMM2, 16(%arg3,%r11,1)      # Write to plaintext buffer
 	movdqa    \TMP3, \XMM2
-	movdqu	  32(%arg3,%r11,1), \TMP3
+	movdqu	  32(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM3                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM3, 32(%arg2,%r11,1)      # Write to plaintext buffer
+	movdqu	  \XMM3, 32(%arg3,%r11,1)      # Write to plaintext buffer
 	movdqa    \TMP3, \XMM3
-	movdqu	  48(%arg3,%r11,1), \TMP3
+	movdqu	  48(%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM4                 # Ciphertext/Plaintext XOR EK
-	movdqu	  \XMM4, 48(%arg2,%r11,1)      # Write to plaintext buffer
+	movdqu	  \XMM4, 48(%arg3,%r11,1)      # Write to plaintext buffer
 	movdqa    \TMP3, \XMM4
 	PSHUFB_XMM %xmm15, \XMM1        # perform a 16 byte swap
 	PSHUFB_XMM %xmm15, \XMM2	# perform a 16 byte swap
@@ -1277,6 +1286,8 @@ _esb_loop_\@:
 .endm
 /*****************************************************************************
 * void aesni_gcm_dec(void *aes_ctx,    // AES Key schedule. Starts on a 16 byte boundary.
+*                   struct gcm_context_data *data
+*                                      // Context data
 *                   u8 *out,           // Plaintext output. Encrypt in-place is allowed.
 *                   const u8 *in,      // Ciphertext input
 *                   u64 plaintext_len, // Length of data in bytes for decryption.
@@ -1366,6 +1377,8 @@ ENDPROC(aesni_gcm_dec)
 
 /*****************************************************************************
 * void aesni_gcm_enc(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data
+*                                        // Context data
 *                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
 *                    const u8 *in,       // Plaintext input
 *                    u64 plaintext_len,  // Length of data in bytes for encryption.
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 34cf1c1..4dd5b9b 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -72,6 +72,21 @@ struct aesni_xts_ctx {
 	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
 };
 
+#define GCM_BLOCK_LEN 16
+
+struct gcm_context_data {
+	/* init, update and finalize context data */
+	u8 aad_hash[GCM_BLOCK_LEN];
+	u64 aad_length;
+	u64 in_length;
+	u8 partial_block_enc_key[GCM_BLOCK_LEN];
+	u8 orig_IV[GCM_BLOCK_LEN];
+	u8 current_counter[GCM_BLOCK_LEN];
+	u64 partial_block_len;
+	u64 unused;
+	u8 hash_keys[GCM_BLOCK_LEN * 8];
+};
+
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			     unsigned int key_len);
 asmlinkage void aesni_enc(struct crypto_aes_ctx *ctx, u8 *out,
@@ -105,6 +120,7 @@ asmlinkage void aesni_xts_crypt8(struct crypto_aes_ctx *ctx, u8 *out,
 
 /* asmlinkage void aesni_gcm_enc()
  * void *ctx,  AES Key schedule. Starts on a 16 byte boundary.
+ * struct gcm_context_data.  May be uninitialized.
  * u8 *out, Ciphertext output. Encrypt in-place is allowed.
  * const u8 *in, Plaintext input
  * unsigned long plaintext_len, Length of data in bytes for encryption.
@@ -117,13 +133,15 @@ asmlinkage void aesni_xts_crypt8(struct crypto_aes_ctx *ctx, u8 *out,
  * unsigned long auth_tag_len), Authenticated Tag Length in bytes.
  *          Valid values are 16 (most likely), 12 or 8.
  */
-asmlinkage void aesni_gcm_enc(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_enc(void *ctx,
+			struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long plaintext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
 
 /* asmlinkage void aesni_gcm_dec()
  * void *ctx, AES Key schedule. Starts on a 16 byte boundary.
+ * struct gcm_context_data.  May be uninitialized.
  * u8 *out, Plaintext output. Decrypt in-place is allowed.
  * const u8 *in, Ciphertext input
  * unsigned long ciphertext_len, Length of data in bytes for decryption.
@@ -137,7 +155,8 @@ asmlinkage void aesni_gcm_enc(void *ctx, u8 *out,
  * unsigned long auth_tag_len) Authenticated Tag Length in bytes.
  * Valid values are 16 (most likely), 12 or 8.
  */
-asmlinkage void aesni_gcm_dec(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_dec(void *ctx,
+			struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long ciphertext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
@@ -167,15 +186,17 @@ asmlinkage void aesni_gcm_dec_avx_gen2(void *ctx, u8 *out,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
 
-static void aesni_gcm_enc_avx(void *ctx, u8 *out,
+static void aesni_gcm_enc_avx(void *ctx,
+			struct gcm_context_data *data, u8 *out,
 			const u8 *in, unsigned long plaintext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len)
 {
         struct crypto_aes_ctx *aes_ctx = (struct crypto_aes_ctx*)ctx;
 	if ((plaintext_len < AVX_GEN2_OPTSIZE) || (aes_ctx-> key_length != AES_KEYSIZE_128)){
-		aesni_gcm_enc(ctx, out, in, plaintext_len, iv, hash_subkey, aad,
-				aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_enc(ctx, data, out, in,
+			plaintext_len, iv, hash_subkey, aad,
+			aad_len, auth_tag, auth_tag_len);
 	} else {
 		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
 		aesni_gcm_enc_avx_gen2(ctx, out, in, plaintext_len, iv, aad,
@@ -183,15 +204,17 @@ static void aesni_gcm_enc_avx(void *ctx, u8 *out,
 	}
 }
 
-static void aesni_gcm_dec_avx(void *ctx, u8 *out,
+static void aesni_gcm_dec_avx(void *ctx,
+			struct gcm_context_data *data, u8 *out,
 			const u8 *in, unsigned long ciphertext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len)
 {
         struct crypto_aes_ctx *aes_ctx = (struct crypto_aes_ctx*)ctx;
 	if ((ciphertext_len < AVX_GEN2_OPTSIZE) || (aes_ctx-> key_length != AES_KEYSIZE_128)) {
-		aesni_gcm_dec(ctx, out, in, ciphertext_len, iv, hash_subkey, aad,
-				aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_dec(ctx, data, out, in,
+			ciphertext_len, iv, hash_subkey, aad,
+			aad_len, auth_tag, auth_tag_len);
 	} else {
 		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
 		aesni_gcm_dec_avx_gen2(ctx, out, in, ciphertext_len, iv, aad,
@@ -218,15 +241,17 @@ asmlinkage void aesni_gcm_dec_avx_gen4(void *ctx, u8 *out,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
 
-static void aesni_gcm_enc_avx2(void *ctx, u8 *out,
+static void aesni_gcm_enc_avx2(void *ctx,
+			struct gcm_context_data *data, u8 *out,
 			const u8 *in, unsigned long plaintext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len)
 {
        struct crypto_aes_ctx *aes_ctx = (struct crypto_aes_ctx*)ctx;
 	if ((plaintext_len < AVX_GEN2_OPTSIZE) || (aes_ctx-> key_length != AES_KEYSIZE_128)) {
-		aesni_gcm_enc(ctx, out, in, plaintext_len, iv, hash_subkey, aad,
-				aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_enc(ctx, data, out, in,
+			      plaintext_len, iv, hash_subkey, aad,
+			      aad_len, auth_tag, auth_tag_len);
 	} else if (plaintext_len < AVX_GEN4_OPTSIZE) {
 		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
 		aesni_gcm_enc_avx_gen2(ctx, out, in, plaintext_len, iv, aad,
@@ -238,15 +263,17 @@ static void aesni_gcm_enc_avx2(void *ctx, u8 *out,
 	}
 }
 
-static void aesni_gcm_dec_avx2(void *ctx, u8 *out,
+static void aesni_gcm_dec_avx2(void *ctx,
+	struct gcm_context_data *data, u8 *out,
 			const u8 *in, unsigned long ciphertext_len, u8 *iv,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len)
 {
        struct crypto_aes_ctx *aes_ctx = (struct crypto_aes_ctx*)ctx;
 	if ((ciphertext_len < AVX_GEN2_OPTSIZE) || (aes_ctx-> key_length != AES_KEYSIZE_128)) {
-		aesni_gcm_dec(ctx, out, in, ciphertext_len, iv, hash_subkey,
-				aad, aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_dec(ctx, data, out, in,
+			      ciphertext_len, iv, hash_subkey,
+			      aad, aad_len, auth_tag, auth_tag_len);
 	} else if (ciphertext_len < AVX_GEN4_OPTSIZE) {
 		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
 		aesni_gcm_dec_avx_gen2(ctx, out, in, ciphertext_len, iv, aad,
@@ -259,15 +286,19 @@ static void aesni_gcm_dec_avx2(void *ctx, u8 *out,
 }
 #endif
 
-static void (*aesni_gcm_enc_tfm)(void *ctx, u8 *out,
-			const u8 *in, unsigned long plaintext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len);
+static void (*aesni_gcm_enc_tfm)(void *ctx,
+				 struct gcm_context_data *data, u8 *out,
+				 const u8 *in, unsigned long plaintext_len,
+				 u8 *iv, u8 *hash_subkey, const u8 *aad,
+				 unsigned long aad_len, u8 *auth_tag,
+				 unsigned long auth_tag_len);
 
-static void (*aesni_gcm_dec_tfm)(void *ctx, u8 *out,
-			const u8 *in, unsigned long ciphertext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len);
+static void (*aesni_gcm_dec_tfm)(void *ctx,
+				 struct gcm_context_data *data, u8 *out,
+				 const u8 *in, unsigned long ciphertext_len,
+				 u8 *iv, u8 *hash_subkey, const u8 *aad,
+				 unsigned long aad_len, u8 *auth_tag,
+				 unsigned long auth_tag_len);
 
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
@@ -753,6 +784,7 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
 	struct scatter_walk src_sg_walk;
 	struct scatter_walk dst_sg_walk = {};
+	struct gcm_context_data data AESNI_ALIGN_ATTR;
 
 	if (sg_is_last(req->src) &&
 	    (!PageHighMem(sg_page(req->src)) ||
@@ -782,7 +814,7 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	}
 
 	kernel_fpu_begin();
-	aesni_gcm_enc_tfm(aes_ctx, dst, src, req->cryptlen, iv,
+	aesni_gcm_enc_tfm(aes_ctx, &data, dst, src, req->cryptlen, iv,
 			  hash_subkey, assoc, assoclen,
 			  dst + req->cryptlen, auth_tag_len);
 	kernel_fpu_end();
@@ -817,6 +849,7 @@ static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 	u8 authTag[16];
 	struct scatter_walk src_sg_walk;
 	struct scatter_walk dst_sg_walk = {};
+	struct gcm_context_data data AESNI_ALIGN_ATTR;
 	int retval = 0;
 
 	tempCipherLen = (unsigned long)(req->cryptlen - auth_tag_len);
@@ -849,7 +882,7 @@ static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 
 
 	kernel_fpu_begin();
-	aesni_gcm_dec_tfm(aes_ctx, dst, src, tempCipherLen, iv,
+	aesni_gcm_dec_tfm(aes_ctx, &data, dst, src, tempCipherLen, iv,
 			  hash_subkey, assoc, assoclen,
 			  authTag, auth_tag_len);
 	kernel_fpu_end();
-- 
2.9.5
