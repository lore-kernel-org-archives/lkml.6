Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeBLTvQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:51:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750953AbeBLTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:51:11 -0500
Date: Mon, 12 Feb 2018 11:50:44 -0800
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
Subject: [PATCH 11/14] x86/crypto: aesni: Introduce partial block macro
Message-ID: <20180212195044.GA60984@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: CY4PR18CA0043.namprd18.prod.outlook.com (10.173.177.29) To
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f514d1ab-1411-44ba-b415-08d57251eb94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1756;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;3:OHcuhtP5QFIA/n1EGb8E06oGbuc4YuFNNLJzYii8hrdTJsg1OJ19FuV623VCtOHUPXhWdvyAHMBUB4CsCqWTh8CotbF4bYwvGdiyn9292MeJ/z7BNvAHxL9VWxDO3tOVYmzjKeqACnp2Bc4Tu8/VYA0u5o0dwz+tiCUbiqcxV5ivQp8ad84/i/Z7WziOy3z8dj6sY+UT68QtrG2aiGNB63OlaO7q4rI+LhlTfM1xDb/VBFW0yKhr65f3gwvKYez6;25:L4s/+IU7HDC9D9ptnyTZzUoRqHyGuuYZi/lP7VHqbaQy71ZDmhvcimHjV1V1c7o1evFAnewmnGuy83BSP61wDG0LFvAChiChLVSTvuBO9WIHX66InT0xAriPPjlDQjhW5wpFQFBf2QV6LmzoTsC4u+YwmQiayCC7ng7Fjlwg5CJEkSGh3vYj7KcKDMLBAjMVHh+wL+pZm9twS20wZSXPsmxctezzL1hb6xObk9bOQws6E9Uz+zBKx655wgqfVNMGZ15cJ3NhPXgIu9di1G/vXAvCUCAcexEii4sIjOivJ5Y7yOyEow+wbgKQK24/pjOqnJmDdDUxeFUzmFXeVUtjeA==;31:47QuP+bnruNXkJhXzXNvLd8g+p2lBdFsDcN7Aj7L4/LrDyCRRtFJ1kIGR7XiMxGB7TRDp412vfCBwrgmzrWRRlRfk3xdh01YSCz5DCSLixrHPtsYRCv6UNj8yofo5U8BXk7BtoQ9FyuhfdhRZ/fV+DjKUB2wOkfnE0Xbt2NH1OYYTwip0/FRu/kfjzJTSRji0AK5cpMYQTAjHQqUllAosyUzGSGY69hZgm3oTBcbTHQ=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:B7NonCjL6uaL4wk7Bd2XtWYNSSrdQ006BaUTjY9XbEojb519LUbzTEUNUeDUwPh260yfTYjgEa3qjJVfyAuxyKrzFj2ZDBCJKNJUIf8NNYr/jtP3BRmcmUX5fonerJFR1DIr8WBp77mtEJY8pES15DsAWdGEhwum562DUVuuUejkeXuFod2tizmX2nU+4NTwJdAoPv+LQmH240+DHs7ihHUUcwFDO27OoSI50n8AABdYlIWLxZLiPe6RRpTEsVgx5qQhbBUN2IdsSRnmcE9aPW6LCggRc6zzyPRT1GLq8Hsd/2bm8btWT/YR9ATY+typeMmxrXjvga1r+MctJgqoCyLYTG0QB3xu7Ppa9YyrdsibDxYyzvqGHpT936aMMwUbDodjBwkOc76MpYheGLtki3zH5xV/kPaX67/8hbVVDQrNkekEiwQM73HMfjw+uA2nPSX4URrPHUtTiRNdlvF7rSkQfnzGOrPpJEmkGICWugjGq+uHQvdyJK5RyeFzKeDV;4:rKyiklZfBRVjX+swu6hnvdTjldQDmE7LpDWOcfGyDepxS7qT7cCFEhbSKoNVjXYbcSyzsBlh66VLjNnRtesUWMr0sg3C1E9C26L+YWuT4o9LBGYBSN1IwlDkS9o3FF8A8xAtbjE4Rg5DI4FUvLE/F6GhLpV47Kr+pkbwPS9zt3mr+CA7fTexH/SkFqqQojyMqK6+GoHOz4trnlIPvXmLGQT4c+FT/UB6SvLGefWGnPIE5CIYSXuFIbTQqvBqDEUpDDcilOkQLVjUI+nS9lb4n5tebtShHUB2R+EhMwEHmYx8gXo30tPxdlKHL9MjvniwFSupwueZG9V1VghvKAsrw8jcPzQ+pofGevsxzZHeRbg=
X-Microsoft-Antispam-PRVS: <DM5PR15MB1756ADB58133D522B05E3933DDF70@DM5PR15MB1756.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(199004)(189003)(16586007)(97736004)(316002)(7416002)(186003)(23726003)(16526019)(5660300001)(59450400001)(1076002)(50466002)(6116002)(33896004)(7736002)(110136005)(54906003)(386003)(305945005)(86362001)(25786009)(58126008)(83506002)(2906002)(33656002)(6666003)(8676002)(6346003)(478600001)(2950100002)(106356001)(68736007)(8936002)(81166006)(81156014)(98436002)(105586002)(76506005)(76176011)(4326008)(9686003)(53936002)(52116002)(52396003)(47776003)(6486002)(6496006)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1756;23:06Rla343lPhNntBSVppGzUQOCsOIlb2bgtUy9dKCL?=
 =?us-ascii?Q?cmCeXYCUWFMemgumKogT99wDybSDxAfw93848aofjbiJv4uVtuVpLThazXP1?=
 =?us-ascii?Q?DdMlJkQmqEw6QzuF3DQZExEI2ur1KoroGBsqQUzf5AIrSMMtRVmcCU+saXY+?=
 =?us-ascii?Q?vUhP3qQBF+W+MQUB0p0z/pmBvC8AYP4eMTLPxR5edcktv6cfpq9QVjCdOOsq?=
 =?us-ascii?Q?tbCaYEJl3MboVS+jxAUfxovVTfdWY+SkxDdWhpc6ECEFZjSdCT738dPu4ZUK?=
 =?us-ascii?Q?AeJql0ptz0vdr/4Rl18soPAvh+SYXQkYTD8JRbgmbBNShkPlSZRihPpT8Bqb?=
 =?us-ascii?Q?IeqPI3ov1A/XShOfFirseyjDkjXQQCDCVHrtiZXiJLMM88dEu+Thz9zeTs1e?=
 =?us-ascii?Q?xaLJtMn12p4DMgbo2LFRZZvnnbTltz0kKZu+pruHdffaEsXRV8OEzwqFFciF?=
 =?us-ascii?Q?chYtVPOZThOSRsMd5Z8sBldj3umYyJrCS/ULZKRURZBvLwjy05osm5YEvvCR?=
 =?us-ascii?Q?gTaIpnYYek4JUm9yAqQqyFo8yY1T96NT1J00IViq+Nmdf4M96fBQNqg8Pfhr?=
 =?us-ascii?Q?aOXbndmId18aOPVvdScp8vfjt+SS3xuzkHHk0Bb6b6Z7iYay3RYgtc8GxBJm?=
 =?us-ascii?Q?FCmNY/IvJfCFiD8nv+6NE3/F4b6PRxNY0ITWaQ59OnG1GRtWU1bzqQ0g5kWr?=
 =?us-ascii?Q?/yjRzuViWDNiUjYusyNHcyiHrrgsxssw0r08j/LmGMbctCMwlqOhKUcY4Cqc?=
 =?us-ascii?Q?KYrEGtZUoWZEKaZlzi/ol/7tVNuYiV3MfqiOLuBUjOE/nRzgObs1XcG+Lg2p?=
 =?us-ascii?Q?Z2xept4shMya9gbRb60B2qO38/1funZtw0cPnRAqf/cG7/e+b/wgIM6K6fjV?=
 =?us-ascii?Q?tkuoQPST5Aa7yr9UoQmf4biznMNW6k8DsJEZaEalvnlT358+3tf5gLpE1/NX?=
 =?us-ascii?Q?dxFAZuZ/PPNqHnOX2BnieRuvq+Ar8v5NmvT0iJY9iGk1RvffJ3Q6V2ynVK8X?=
 =?us-ascii?Q?cjwoQs6MQetDv8o2ba4Og12pcZTuPafMnsyOlwoI0pl4YVfIg8Bf0L7Qcwyv?=
 =?us-ascii?Q?5VRB7X/KZx33iqS6J8lSMGUlO9bxZeSo9F188Il2+TWV7IQC8aVmJqoLHM9q?=
 =?us-ascii?Q?WsCGqKXIyJAkYJOYqOqouxb90fUGEwv40Qsry+8Bt9ZkyINuc8wnh7039wif?=
 =?us-ascii?Q?56txEvheasPdrlvJ33Tlf6EMtbc0K7e7Y3s+YhxmXCC1Tdvih4PrTjs9iR5R?=
 =?us-ascii?Q?LCrt2TpMw3NEB/IlduN8xGURwdwRRlghPgqnwMmoL6nHpfTqeOWul0fhPBcH?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;6:AhWi01UcnptP/9CxwKcPHf8O0atrCbwzwj6VDGG0Rs23lxNUiWm1QHvKVVgSQ646cKyjMbz49hVutkzE9kQgYCmOsBVbzcJ4AYWIOLzZ25hYX6HLlfsvXW5dz/iDeyS83aiPqA++8M5Ur8ZxlYr9lYAPMN8TxkJacnwbq22APXBu9LxANbglhARFA/i1GIZ/E0UCDpSw/KUB3s4LAg3kywiFdpUIU/y4FyBXBv7v6LMGFK9NHIkQeTw2jeFUBadgwiQjgvWFZ2OHeP7jnj7wCQrmse96k/j0kIjnnABebaX//tdHC6oLYc8CeSCQkgcPuAQXt5vdyuESWr0tw9mG12kpaj9GeBlEB+eoNHFvFKw=;5:LpvA+iMk5f8t0xs3NjbYOq1bdVe/+Hsa0mVkItZ4aRKEj11hw0ITFDXJNVdrFxSowGtjH3f6nmb4V8nJC5AhHrqJtBLdJbYod0RHYPAbVnoXoNcDhtDhJ88WHVtNvCFn5+TvwGG9yUDeInQLl8eeS3M4Kc38C/5TPBZSgTEVNXE=;24:tdfF5v1vFuVxenfDMHuX9SMeGaTj5PiQdw1kk/w5XeuPtRV1BC76DoyQ8b5wJDJjKephwBLBW25cInPl+IG+bRsn3Wh5jbqmfJbNh3xCS1o=;7:TGjGS4+8dP0oEazIpnzhOVoj9HX12VXMMWaukjHPOueS6fj0aY2sUZmY/IQ5JiInOjgbLUPl+pHMlnEO6Q//TyLN5fWkCT6DS3KuI/y4yz5bPxtJ4B5WejR3NxqlfwJACC7CGGAp3vvGJtzxGDB8JgFkLl8xaUGR9to1oolw/nnLkGBEVVbNlpj8Mu+4+319wl5ST5jn1e/y3sEn53FaXdcuwMG1jq3G0MbF+no2TdAflxxOJo1d5PDMaI/gnkhQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:JAmymPicql/O1kNsR9u1KVOL9JNyOZScedUIlGUBhrzWuX6T8GugfM8NG9hcAgI35BHeqCol84+JHVAm1inYslDeCMK7Azc2SSFZ4lJRyVHJnFoS9HfJVGVNV+/hjIkCsjXeDenZyiqTJUUYzuyaIMchqPmqVpnXJR8Zylxc8vs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:50:51.1226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f514d1ab-1411-44ba-b415-08d57251eb94
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

Before this diff, multiple calls to GCM_ENC_DEC will
succeed, but only if all calls are a multiple of 16 bytes.

Handle partial blocks at the start of GCM_ENC_DEC, and update
aadhash as appropriate.

The data offset %r11 is also updated after the partial block.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 151 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 3ada06b..398bd2237f 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -284,7 +284,13 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	movdqu AadHash(%arg2), %xmm8
 	movdqu HashKey(%arg2), %xmm13
 	add %arg5, InLen(%arg2)
+
+	xor %r11, %r11 # initialise the data pointer offset as zero
+	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
+
+	sub %r11, %arg5		# sub partial block data used
 	mov %arg5, %r13		# save the number of bytes
+
 	and $-16, %r13		# %r13 = %r13 - (%r13 mod 16)
 	mov %r13, %r12
 	# Encrypt/Decrypt first few blocks
@@ -605,6 +611,150 @@ _get_AAD_done\@:
 	movdqu \TMP6, AadHash(%arg2)
 .endm
 
+# PARTIAL_BLOCK: Handles encryption/decryption and the tag partial blocks
+# between update calls.
+# Requires the input data be at least 1 byte long due to READ_PARTIAL_BLOCK
+# Outputs encrypted bytes, and updates hash and partial info in gcm_data_context
+# Clobbers rax, r10, r12, r13, xmm0-6, xmm9-13
+.macro PARTIAL_BLOCK CYPH_PLAIN_OUT PLAIN_CYPH_IN PLAIN_CYPH_LEN DATA_OFFSET \
+	AAD_HASH operation
+	mov 	PBlockLen(%arg2), %r13
+	cmp	$0, %r13
+	je	_partial_block_done_\@	# Leave Macro if no partial blocks
+	# Read in input data without over reading
+	cmp	$16, \PLAIN_CYPH_LEN
+	jl	_fewer_than_16_bytes_\@
+	movups	(\PLAIN_CYPH_IN), %xmm1	# If more than 16 bytes, just fill xmm
+	jmp	_data_read_\@
+
+_fewer_than_16_bytes_\@:
+	lea	(\PLAIN_CYPH_IN, \DATA_OFFSET, 1), %r10
+	mov	\PLAIN_CYPH_LEN, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm0 %xmm1
+
+	mov PBlockLen(%arg2), %r13
+
+_data_read_\@:				# Finished reading in data
+
+	movdqu	PBlockEncKey(%arg2), %xmm9
+	movdqu	HashKey(%arg2), %xmm13
+
+	lea	SHIFT_MASK(%rip), %r12
+
+	# adjust the shuffle mask pointer to be able to shift r13 bytes
+	# r16-r13 is the number of bytes in plaintext mod 16)
+	add	%r13, %r12
+	movdqu	(%r12), %xmm2		# get the appropriate shuffle mask
+	PSHUFB_XMM %xmm2, %xmm9		# shift right r13 bytes
+
+.ifc \operation, dec
+	movdqa	%xmm1, %xmm3
+	pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+
+	mov	\PLAIN_CYPH_LEN, %r10
+	add	%r13, %r10
+	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
+	sub	$16, %r10
+	# Determine if if partial block is not being filled and
+	# shift mask accordingly
+	jge	_no_extra_mask_1_\@
+	sub	%r10, %r12
+_no_extra_mask_1_\@:
+
+	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+	# get the appropriate mask to mask out bottom r13 bytes of xmm9
+	pand	%xmm1, %xmm9		# mask out bottom r13 bytes of xmm9
+
+	pand	%xmm1, %xmm3
+	movdqa	SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM	%xmm10, %xmm3
+	PSHUFB_XMM	%xmm2, %xmm3
+	pxor	%xmm3, \AAD_HASH
+
+	cmp	$0, %r10
+	jl	_partial_incomplete_1_\@
+
+	# GHASH computation for the last <16 Byte block
+	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+	xor	%rax,%rax
+
+	mov	%rax, PBlockLen(%arg2)
+	jmp	_dec_done_\@
+_partial_incomplete_1_\@:
+	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
+_dec_done_\@:
+	movdqu	\AAD_HASH, AadHash(%arg2)
+.else
+	pxor	%xmm1, %xmm9			# Plaintext XOR E(K, Yn)
+
+	mov	\PLAIN_CYPH_LEN, %r10
+	add	%r13, %r10
+	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
+	sub	$16, %r10
+	# Determine if if partial block is not being filled and
+	# shift mask accordingly
+	jge	_no_extra_mask_2_\@
+	sub	%r10, %r12
+_no_extra_mask_2_\@:
+
+	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+	# get the appropriate mask to mask out bottom r13 bytes of xmm9
+	pand	%xmm1, %xmm9
+
+	movdqa	SHUF_MASK(%rip), %xmm1
+	PSHUFB_XMM %xmm1, %xmm9
+	PSHUFB_XMM %xmm2, %xmm9
+	pxor	%xmm9, \AAD_HASH
+
+	cmp	$0, %r10
+	jl	_partial_incomplete_2_\@
+
+	# GHASH computation for the last <16 Byte block
+	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+	xor	%rax,%rax
+
+	mov	%rax, PBlockLen(%arg2)
+	jmp	_encode_done_\@
+_partial_incomplete_2_\@:
+	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
+_encode_done_\@:
+	movdqu	\AAD_HASH, AadHash(%arg2)
+
+	movdqa	SHUF_MASK(%rip), %xmm10
+	# shuffle xmm9 back to output as ciphertext
+	PSHUFB_XMM	%xmm10, %xmm9
+	PSHUFB_XMM	%xmm2, %xmm9
+.endif
+	# output encrypted Bytes
+	cmp	$0, %r10
+	jl	_partial_fill_\@
+	mov	%r13, %r12
+	mov	$16, %r13
+	# Set r13 to be the number of bytes to write out
+	sub	%r12, %r13
+	jmp	_count_set_\@
+_partial_fill_\@:
+	mov	\PLAIN_CYPH_LEN, %r13
+_count_set_\@:
+	movdqa	%xmm9, %xmm0
+	MOVQ_R64_XMM	%xmm0, %rax
+	cmp	$8, %r13
+	jle	_less_than_8_bytes_left_\@
+
+	mov	%rax, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+	add	$8, \DATA_OFFSET
+	psrldq	$8, %xmm0
+	MOVQ_R64_XMM	%xmm0, %rax
+	sub	$8, %r13
+_less_than_8_bytes_left_\@:
+	movb	%al, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+	add	$1, \DATA_OFFSET
+	shr	$8, %rax
+	sub	$1, %r13
+	jne	_less_than_8_bytes_left_\@
+_partial_block_done_\@:
+.endm # PARTIAL_BLOCK
+
 /*
 * if a = number of total plaintext bytes
 * b = floor(a/16)
@@ -623,7 +773,6 @@ _get_AAD_done\@:
 
 	movdqu AadHash(%arg2), %xmm\i		    # XMM0 = Y0
 
-	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
 	movdqu CurCount(%arg2), \XMM0                # XMM0 = Y0
-- 
2.9.5
