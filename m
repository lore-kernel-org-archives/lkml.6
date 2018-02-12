Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeBLTvC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:51:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbeBLTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:50:58 -0500
Date: Mon, 12 Feb 2018 11:50:30 -0800
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
Subject: [PATCH 10/14] x86/crypto: aesni: Move HashKey computation from stack
 to gcm_context
Message-ID: <20180212195030.GA60955@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: SN4PR0401CA0022.namprd04.prod.outlook.com (10.171.32.32) To
 MWHPR15MB1759.namprd15.prod.outlook.com (10.174.255.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b03e170-63f2-4759-c011-08d57251e1a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1759;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;3:UHJKrXwWyy6khX8/aO31+r3ywEaqlW5OvJhbfp1025NxnqUjaNtelLw7SQuAK4jK789qInsT43WdCZdjjYkTX0sTJt2MHm6eEcS5TppvTY7heArtlKiup4WGvCWqWO8nTh1QSi+FzURVxDfyyog5XdD/LomhDzMBSYqZSoJr3RRZRYJ8sWIo9zWh6doCU45GdaOcO10er41cNeGuwQyF8H9vNU5MWRqMHpTam9eKDiA+/trOfwN6lzErmc1q/mpK;25:pAOW+U6PM1sJwYJHbCBUHtYd3xcloxzbk4eqWQLV+qtPb5lCGCkCyYx87OiSNCn/PYj1UIOihT91pwvug8lHGENM2+eyWWECqN/nX2kr3gubOZsg5vK7EpjsvdHfdhDM7oCC5tA0U/fAScO9d4QJu9wOgswzJC7Rg9F0yaHxyi5qvC9m4LNH7hGtNRoGH99lzI40eRe76Fb0lTtFLkOJX3nXqkbOA43E57+nhhkvZ4tVgURuiZQxo3H/YLfFk+A8AQVYeigPRRQH8X4C3K4cYUcpEr72sro5MzUQPcECp5+sLQ178aUfXbAZsd6NXb0hn3ZM+bkL1IMu/JWqm4sNmw==;31:VNSNXmg1n02wmZ0FShXzk0ZAOxxGwdGZC5MGiBbQl2NiXWEDusAQ+KsBwWnsLc2jRKTnQ4vk2z8i85G5ZNyKz63B+LOX0CVXOEWzrrXuYKKa30/uW2CQyNrBEW3+zxZCDl3YMinETDCbJwi3/UA2hpRLg3txwwoXLcJOH8Jd+uclNxCjkGpW9O9sRjambWlir7jPARTopbkExH81RDM5CdwKoAsoRy4ITPJLHpMEOXs=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1759:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:mugPHcICLajrsIGgezqr1flBhhm78X4Wk9DfrFLArCn8WJMH/EY9b352iBiQWcMDTX55XOhiUD41Nkla3P86DKaTSjz+17koiyDv/eN8fZ9ahvyxYl9Ai3RiceWipJD/UixgHi3GVBeU2WVo4WQT8F9BtNVCIJ5egmFSyCGgg06iMmAnkhNrVcNDgkO+x0mQ7AITY6yf70al9j/lKm1pp+mPucwDNmCiuDiK/PXYZS5ty7UDh5yEuIMmoUJM6Sx6/PlAznzwaSGkrbYOOyrOmie4DBHBykiIXEhsoi3RNBn5xo1Hd8ROF43H31yMsre38LOORWSNK7HakR/1m8CPzoM06YDZLQSKAn9JtwgElQiZ7AvRMGSF8uIqGuhOhRR5WzrnAm7Dl6KMPW5zpL8jbUjYReozRqvOfCNkXFThh8xd4exFSfqmG6lWGYUbSaoF2bRbS5+3l28D1dAJjxo9NqdizxVubxeOoKGATD1ELgdcirRGMjR6JE7pp5iY4+cA;4:df+HbWsJWMJHDVEi/hmqGU/elX+tah8pYl7XX41p+FnPETqh7cvFYlLcI9NW6kiHyfsC2XSZpDi1N9XywkYrSSFPxOB+kFO125QTWn40hXaaOjGHiUdr3enY7jNEVW6nu5ZAIrpqXFIZ0ebJxYd7h6bUYePnjp7rezY8GiqMmMddQHa5T/zJWVYwL3VpnNyxu/TGhzh3jRLE5ydD9eQFvMqO4X5bUJ+cXepRq/JkIfXl3uMPXURAD79/vNbWRDUVOUq/oTpRmyDr8ajU4HD5DZ39+3hG73Qpc18JlAVOoKrpF7GMIqNvsGCU2S6dkkJv1xl55pyX/ss45yzkRA0ZR+CLFzYWLU3hTcOQO4V4l8Q=
X-Microsoft-Antispam-PRVS: <MWHPR15MB1759E87CA227E419D63704A8DDF70@MWHPR15MB1759.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(11241501184)(2400082)(944501161)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR15MB1759;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1759;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(6496006)(25786009)(4326008)(59450400001)(50466002)(1076002)(7416002)(52116002)(52396003)(8936002)(76506005)(98436002)(83506002)(316002)(33656002)(386003)(68736007)(2906002)(6666003)(86362001)(16586007)(105586002)(2950100002)(76176011)(110136005)(47776003)(58126008)(53936002)(33896004)(106356001)(7736002)(81166006)(478600001)(8676002)(6116002)(16526019)(186003)(81156014)(305945005)(23726003)(97736004)(5660300001)(54906003)(6346003)(9686003)(6486002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1759;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1759;23:0NG4AiBRi0ViSX+qEpOxK4Vnwu22Yt2hItfb9CnNU?=
 =?us-ascii?Q?HctlDH5r0yaOHPSZigc/XhVE3R8gKI3XmPkqvKhT2yKSQSDUjYE4gA5+eSn6?=
 =?us-ascii?Q?ZvzUbvIy0Tau+MQKAWq4Fy96mpN/SRgHzZ09uAHvMjW1pTbofJywb7alNiAN?=
 =?us-ascii?Q?gGm/k7ATrszJPD9ct5wCbMNCVkzyXGBF4POrqsTn5jMKXlFQxGi+QvNaXk1R?=
 =?us-ascii?Q?tm1ix51//c98mZIQ6zDMKE3Hd4eKfBdbF7qdDyXQJmoZNjkHvnDIzEY6KREk?=
 =?us-ascii?Q?t4Gb/Tqsgz6ZnGX+N62mNRMp7pqiDx8tloExnQuGRB2ga5g/nc+0rzo+L30X?=
 =?us-ascii?Q?TsEoXUWo0FY6LoKz0ywMgJ0J+kqTYrZe/UwUWojxIJ5noZaZC9sb96GnUkWX?=
 =?us-ascii?Q?p4UB0gBDQwd5JY7BubzL85En3kv6vmEIlDXBjs3mp6+zN16Ymd8N7L2XWPrM?=
 =?us-ascii?Q?GhFPoY6eyROcVKA3fRPcuHJ6ojXRvIgfehZfltijgeaNnuDlhL9sVhBZwK23?=
 =?us-ascii?Q?j9IGJtmgBSkW3b+0Rnw7V5PMikpWTAnIIjZ5uNImpql47jKF17uvvH8qMTZ6?=
 =?us-ascii?Q?2fskV0azUbnKwejie4SiB/EwyoWfxM6CkXeA06RPdnOEkZmsc7Kxg++JZFZ9?=
 =?us-ascii?Q?m/pP59cH0dCSJ6YXV1pLD7v5XMC2pzwkAob+ZNK9ksXaH/lyeU5GCWwfE6k1?=
 =?us-ascii?Q?j94GoScyuVuM57hui+BJNhwGD5Nqy3zvAKvhTWdG60nJggyXuCBZHD6PGzxa?=
 =?us-ascii?Q?/tmqhNKmgzDsUZh1CN4OOTJZzV3aP5r13RUv7uulKORn1N9N3R1aGjq+B4zB?=
 =?us-ascii?Q?sCTjEVhNsb6Fia77cI5MKU/FR9AqCGgOcEFFz82VqhMy+QkCMQT/EKinQBUb?=
 =?us-ascii?Q?M9y/NAZMjsOJ5M+I+gVB7X3NAYUiwAvw6dXx5HwqQxr6+iY4CzTujFQ/5uoJ?=
 =?us-ascii?Q?FmYcqWPGWCCq52tiaYMG5Pr11JOWBlDhhuL8XoHe3/Ss3xM+HOaU2rKRul2L?=
 =?us-ascii?Q?zvyt43Iz4m1jG8FrGKvfOEcMw3kkTAgs9lhu+keWkXhhu7y8nnPws5y52P9z?=
 =?us-ascii?Q?8dA7YU6IUx26yzPQo20avsaeo9Was8hiEdLvnYYXsfehvfc60j+MAoXPaBUN?=
 =?us-ascii?Q?AR2sEfGvS0OwMzi6+3MB0YT38hzvcfBWe5OBlzX1j4ERixOnq/18XtLhWcsA?=
 =?us-ascii?Q?/fwLVaF4x6sjwrA8NAUX3gJA0zc+raVgrdOLxr86a0w6sCttyzcrCFEHuOrL?=
 =?us-ascii?Q?2BXjNVMJuic5AP3qaXt2wTTpNs1e5UqADAWs7967L6rZnGFM8QYBdVD2KSR2?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;6:pE46oGCMfUYx/yq/mC6ohAjOUctcOHQRMbKxskW/DEJG0aVEC/xbYDvPCrZA45OK8TRgVOfNvSzRDie3DHRRk/WpeETpfE/mtvgC56UqoGd3RSGvjXcvp3S5Pcic1W9jNLULx9l3z48d7aJUYr2b35xn2p/NIS7oEkmpnw0mDZiibo9IbZGxmRwfZjstokQuyAVRo+XFo2660RNmvqGAoPw4AFlxViWq98a2gmkRLhEKgCcVQYSHJw7pdYtcYA7sU7AuyZ3OTSoXJs6zoHpkHvu9aEM/K/WTQqIklBt1tAaCRN9B4Sp6kdW2dJ5d3cDExNOcMYixgFrnFlZQSfKGefOM+iHcEEGGoiF7kCdbCes=;5:y7ezDAeU7JAH7klNWGvZBveVwtnwcqKZB2g0gvtrSqYAAoPQkVGXgjQcug0lUsMk7Fif8PLa2BR05zAnkFb0rPkUS8FGsOSZJ18JvSwpyig4xyWeXPdK7odFc3wKBnMAywXhetWupjRHJX9oB/m96daeXZKK8A4K/aBmGu8vajY=;24:acSqTcZi21mtopueOYgWGtEJ2Rao5MCzyqZbb9cIZKQSJpfqvJ9Y/MO03RlizLPGwVCHi3x9OCHl2fSCFMUpfAWpUfEWM4XJhqXG20ZFDAo=;7:u3XRvCDjApFR8IzV8jt/Z1d0MrxfZY6V3oiO5y1jpU3XB57it5myWuLPBoGEPk8153EQOvOt5AXlhZZOmnAIvLi32yxAYsepFB4l+j5/eC2pKu+B4RmVsUS6l96aDPsmB6HbfG2E3T8hygxwRt4Im+vGMuwn1thxQgU7b+tCbudx9kdNBKW8Hmsdvg08/4jyL5Ur41uDill68oaAq28nfk3GROlFJU5ov/WJdSIYxCzycvOtQDOumgbcr1u++NtK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:fphEi7cMEenrEskEonG+o6rvYzgJS4AT+V8BEg4KzWMBnex1esAPuQHJKJ9LEixZiUo/Bee/c18MkvA2GhMnWy3mJvanltNgHIWEoNZMsrp0/vAw2HW+Uq/Nj8hBjGhL2q31D/nDHOGiIjdeK+RMLbQ1j5lRDR5joIzevGJZdk4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:50:34.3881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b03e170-63f2-4759-c011-08d57251e1a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
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
