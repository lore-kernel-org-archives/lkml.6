Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC66C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE3A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QZxbgABH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FsqijNJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE3A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeLJT7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:59:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbeLJT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:59:34 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJuc1s028465;
        Mon, 10 Dec 2018 11:59:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e33+RpqgdV1HyezVlJFAdsPskablAUqjTSgxUF2JgP8=;
 b=QZxbgABHiglBrG+x8S6MxDOst9GjeD8OCeDRvMR0eitTf45RalermX++ZOCcohajziaN
 MkemBQIRxU28UeEFsAHqd+0p2ZTlUlefr8H6OfOKYtKi9tciyL1KgMCiNokpjQVbxmOd
 rDci03CLtirn3cQU2SwjTzwbvLi6rcgvlcw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9w0v8fg1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:59:19 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:58:22 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:58:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e33+RpqgdV1HyezVlJFAdsPskablAUqjTSgxUF2JgP8=;
 b=FsqijNJ/Alfh0t2nIY1ldVeBfdwMfbHtfEXCsxm89S5XsbcfDAfljXa+QjGIdwl1ezkMMK6jrz/+196LTdJr4aCaWsKWwYKYS6Cnbct1kMB31QVvIUMIcOOs9GwO0jWo9K4Xj3rUk99+N8W/Eenb1XKDpiEgbtXxLkhwyW4fbVM=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 19:58:19 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:58:19 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 06/12] x86/crypto: aesni: Split AAD hash calculation to
 separate macro
Thread-Topic: [PATCH 06/12] x86/crypto: aesni: Split AAD hash calculation to
 separate macro
Thread-Index: AQHUkMKy7qHIg9RTq0OEMzQl2A9y7w==
Date:   Mon, 10 Dec 2018 19:58:19 +0000
Message-ID: <12ee6b81fee1d5a112b81537f52b87b23a39caac.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:320:31::33) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1710;20:hIg8AdEYWY1Tzvwn6WtWAIp4godx7r/+kmPosTFfRmELwk/gw+KVEPpnw303qJXuylRPfgZWHHqtrAvifl9uAUk3DA+m9d3x8sBg2Zj91kI0XTw6yaF9L8QSAkHUkXx2xKqTD68UxtybqLy83C86CnEJtkVWW0WtB3CvJ1FQpbY=
x-ms-office365-filtering-correlation-id: 2d6dc9af-65b0-4d4d-22d7-08d65ed9d4e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-antispam-prvs: <MWHPR15MB1710147CD67735FEC4BEA2E6DDA50@MWHPR15MB1710.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1710;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(386003)(5660300001)(25786009)(11346002)(46003)(446003)(68736007)(2616005)(478600001)(7736002)(105586002)(305945005)(6436002)(575784001)(476003)(186003)(71190400001)(71200400001)(6506007)(8936002)(81156014)(4744004)(14454004)(81166006)(86362001)(6486002)(52116002)(8676002)(102836004)(316002)(14444005)(256004)(54906003)(2501003)(6512007)(58126008)(76176011)(118296001)(99286004)(110136005)(2906002)(36756003)(97736004)(6116002)(486006)(53936002)(106356001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OLJlHFrvQu1Q/HiFogqzq5xWVuiQdfaWxIZntUGAVvzrADmSW+1hqyNm0mvkRF57MIblXeoPG920a4Oo+SilJ9H39d/BhBRWARYv3SGFA/UODJfB6uSoRo7eNxfxKcQX4RYEc0dNMH8FyQBZr7lLHKUwlTuwRhwbe5YmtY9cEAmmNl1oenQ5JfWK5LFhhknQB71FbeDd3iILkUEYNa9brUMMWnG8QTZh1WkZLiebH/RB51IyJgfnA1mwemmbisWRjAMJC1aXYBv7XiP3vGT3NRI59wLosZoNBkHrjB83P0LYM71G7TWCEqatOzKPz/9c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6862799116472045B2319D6FE51A36BE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6dc9af-65b0-4d4d-22d7-08d65ed9d4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:58:19.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AAD hash only needs to be calculated once for each scatter/gather operation=
.
Move it to its own macro, and call it from GCM_INIT instead of
INITIAL_BLOCKS.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 228 ++++++++++-------------
 arch/x86/crypto/aesni-intel_glue.c       |  28 ++-
 2 files changed, 115 insertions(+), 141 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 8e9ae4b26118..305abece93ad 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -182,6 +182,14 @@ aad_shift_arr:
 .text
=20
=20
+#define AadHash 16*0
+#define AadLen 16*1
+#define InLen (16*1)+8
+#define PBlockEncKey 16*2
+#define OrigIV 16*3
+#define CurCount 16*4
+#define PBlockLen 16*5
+
 HashKey        =3D 16*6   # store HashKey <<1 mod poly here
 HashKey_2      =3D 16*7   # store HashKey^2 <<1 mod poly here
 HashKey_3      =3D 16*8   # store HashKey^3 <<1 mod poly here
@@ -585,6 +593,74 @@ _T_16\@:
 _return_T_done\@:
 .endm
=20
+.macro CALC_AAD_HASH GHASH_MUL AAD AADLEN T1 T2 T3 T4 T5 T6 T7 T8
+
+	mov     \AAD, %r10                      # r10 =3D AAD
+	mov     \AADLEN, %r12                      # r12 =3D aadLen
+
+
+	mov     %r12, %r11
+
+	vpxor   \T8, \T8, \T8
+	vpxor   \T7, \T7, \T7
+	cmp     $16, %r11
+	jl      _get_AAD_rest8\@
+_get_AAD_blocks\@:
+	vmovdqu (%r10), \T7
+	vpshufb SHUF_MASK(%rip), \T7, \T7
+	vpxor   \T7, \T8, \T8
+	\GHASH_MUL       \T8, \T2, \T1, \T3, \T4, \T5, \T6
+	add     $16, %r10
+	sub     $16, %r12
+	sub     $16, %r11
+	cmp     $16, %r11
+	jge     _get_AAD_blocks\@
+	vmovdqu \T8, \T7
+	cmp     $0, %r11
+	je      _get_AAD_done\@
+
+	vpxor   \T7, \T7, \T7
+
+	/* read the last <16B of AAD. since we have at least 4B of
+	data right after the AAD (the ICV, and maybe some CT), we can
+	read 4B/8B blocks safely, and then get rid of the extra stuff */
+_get_AAD_rest8\@:
+	cmp     $4, %r11
+	jle     _get_AAD_rest4\@
+	movq    (%r10), \T1
+	add     $8, %r10
+	sub     $8, %r11
+	vpslldq $8, \T1, \T1
+	vpsrldq $8, \T7, \T7
+	vpxor   \T1, \T7, \T7
+	jmp     _get_AAD_rest8\@
+_get_AAD_rest4\@:
+	cmp     $0, %r11
+	jle      _get_AAD_rest0\@
+	mov     (%r10), %eax
+	movq    %rax, \T1
+	add     $4, %r10
+	sub     $4, %r11
+	vpslldq $12, \T1, \T1
+	vpsrldq $4, \T7, \T7
+	vpxor   \T1, \T7, \T7
+_get_AAD_rest0\@:
+	/* finalize: shift out the extra bytes we read, and align
+	left. since pslldq can only shift by an immediate, we use
+	vpshufb and an array of shuffle masks */
+	movq    %r12, %r11
+	salq    $4, %r11
+	vmovdqu  aad_shift_arr(%r11), \T1
+	vpshufb \T1, \T7, \T7
+_get_AAD_rest_final\@:
+	vpshufb SHUF_MASK(%rip), \T7, \T7
+	vpxor   \T8, \T7, \T7
+	\GHASH_MUL       \T7, \T2, \T1, \T3, \T4, \T5, \T6
+
+_get_AAD_done\@:
+        vmovdqu \T7, AadHash(arg2)
+.endm
+
 #ifdef CONFIG_AS_AVX
 ##########################################################################=
#####
 # GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -701,72 +777,9 @@ _return_T_done\@:
=20
 .macro INITIAL_BLOCKS_AVX REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 X=
MM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC
 	i =3D (8-\num_initial_blocks)
-	j =3D 0
 	setreg
+        vmovdqu AadHash(arg2), reg_i
=20
-	mov     arg7, %r10                      # r10 =3D AAD
-	mov     arg8, %r12                      # r12 =3D aadLen
-
-
-	mov     %r12, %r11
-
-	vpxor   reg_j, reg_j, reg_j
-	vpxor   reg_i, reg_i, reg_i
-	cmp     $16, %r11
-	jl      _get_AAD_rest8\@
-_get_AAD_blocks\@:
-	vmovdqu (%r10), reg_i
-	vpshufb SHUF_MASK(%rip), reg_i, reg_i
-	vpxor   reg_i, reg_j, reg_j
-	GHASH_MUL_AVX       reg_j, \T2, \T1, \T3, \T4, \T5, \T6
-	add     $16, %r10
-	sub     $16, %r12
-	sub     $16, %r11
-	cmp     $16, %r11
-	jge     _get_AAD_blocks\@
-	vmovdqu reg_j, reg_i
-	cmp     $0, %r11
-	je      _get_AAD_done\@
-
-	vpxor   reg_i, reg_i, reg_i
-
-	/* read the last <16B of AAD. since we have at least 4B of
-	data right after the AAD (the ICV, and maybe some CT), we can
-	read 4B/8B blocks safely, and then get rid of the extra stuff */
-_get_AAD_rest8\@:
-	cmp     $4, %r11
-	jle     _get_AAD_rest4\@
-	movq    (%r10), \T1
-	add     $8, %r10
-	sub     $8, %r11
-	vpslldq $8, \T1, \T1
-	vpsrldq $8, reg_i, reg_i
-	vpxor   \T1, reg_i, reg_i
-	jmp     _get_AAD_rest8\@
-_get_AAD_rest4\@:
-	cmp     $0, %r11
-	jle      _get_AAD_rest0\@
-	mov     (%r10), %eax
-	movq    %rax, \T1
-	add     $4, %r10
-	sub     $4, %r11
-	vpslldq $12, \T1, \T1
-	vpsrldq $4, reg_i, reg_i
-	vpxor   \T1, reg_i, reg_i
-_get_AAD_rest0\@:
-	/* finalize: shift out the extra bytes we read, and align
-	left. since pslldq can only shift by an immediate, we use
-	vpshufb and an array of shuffle masks */
-	movq    %r12, %r11
-	salq    $4, %r11
-	movdqu  aad_shift_arr(%r11), \T1
-	vpshufb \T1, reg_i, reg_i
-_get_AAD_rest_final\@:
-	vpshufb SHUF_MASK(%rip), reg_i, reg_i
-	vpxor   reg_j, reg_i, reg_i
-	GHASH_MUL_AVX       reg_i, \T2, \T1, \T3, \T4, \T5, \T6
-
-_get_AAD_done\@:
 	# initialize the data pointer offset as zero
 	xor     %r11d, %r11d
=20
@@ -1535,7 +1548,13 @@ _initial_blocks_done\@:
 #void   aesni_gcm_precomp_avx_gen2
 #        (gcm_data     *my_ctx_data,
 #         gcm_context_data *data,
-#        u8     *hash_subkey)# /* H, the Hash sub key input. Data starts o=
n a 16-byte boundary. */
+#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on=
 a 16-byte boundary. */
+#        u8      *iv, /* Pre-counter block j0: 4 byte salt
+#			(from Security Association) concatenated with 8 byte
+#			Initialisation Vector (from IPSec ESP Payload)
+#			concatenated with 0x00000001. 16-byte aligned pointer. */
+#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
+#        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen2)
         FUNC_SAVE
@@ -1560,6 +1579,8 @@ ENTRY(aesni_gcm_precomp_avx_gen2)
         vmovdqu  %xmm6, HashKey(arg2)       # store HashKey<<1 mod poly
=20
=20
+        CALC_AAD_HASH GHASH_MUL_AVX, arg5, arg6, %xmm2, %xmm6, %xmm3, %xmm=
4, %xmm5, %xmm7, %xmm1, %xmm0
+
         PRECOMPUTE_AVX  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
=20
         FUNC_RESTORE
@@ -1716,7 +1737,6 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
=20
 .endm
=20
-
 ## if a =3D number of total plaintext bytes
 ## b =3D floor(a/16)
 ## num_initial_blocks =3D b mod 4#
@@ -1726,73 +1746,9 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
=20
 .macro INITIAL_BLOCKS_AVX2 REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 =
XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
 	i =3D (8-\num_initial_blocks)
-	j =3D 0
 	setreg
+        vmovdqu AadHash(arg2), reg_i
=20
-	mov     arg7, %r10                       # r10 =3D AAD
-	mov     arg8, %r12                       # r12 =3D aadLen
-
-
-	mov     %r12, %r11
-
-	vpxor   reg_j, reg_j, reg_j
-	vpxor   reg_i, reg_i, reg_i
-
-	cmp     $16, %r11
-	jl      _get_AAD_rest8\@
-_get_AAD_blocks\@:
-	vmovdqu (%r10), reg_i
-	vpshufb SHUF_MASK(%rip), reg_i, reg_i
-	vpxor   reg_i, reg_j, reg_j
-	GHASH_MUL_AVX2      reg_j, \T2, \T1, \T3, \T4, \T5, \T6
-	add     $16, %r10
-	sub     $16, %r12
-	sub     $16, %r11
-	cmp     $16, %r11
-	jge     _get_AAD_blocks\@
-	vmovdqu reg_j, reg_i
-	cmp     $0, %r11
-	je      _get_AAD_done\@
-
-	vpxor   reg_i, reg_i, reg_i
-
-	/* read the last <16B of AAD. since we have at least 4B of
-	data right after the AAD (the ICV, and maybe some CT), we can
-	read 4B/8B blocks safely, and then get rid of the extra stuff */
-_get_AAD_rest8\@:
-	cmp     $4, %r11
-	jle     _get_AAD_rest4\@
-	movq    (%r10), \T1
-	add     $8, %r10
-	sub     $8, %r11
-	vpslldq $8, \T1, \T1
-	vpsrldq $8, reg_i, reg_i
-	vpxor   \T1, reg_i, reg_i
-	jmp     _get_AAD_rest8\@
-_get_AAD_rest4\@:
-	cmp     $0, %r11
-	jle     _get_AAD_rest0\@
-	mov     (%r10), %eax
-	movq    %rax, \T1
-	add     $4, %r10
-	sub     $4, %r11
-	vpslldq $12, \T1, \T1
-	vpsrldq $4, reg_i, reg_i
-	vpxor   \T1, reg_i, reg_i
-_get_AAD_rest0\@:
-	/* finalize: shift out the extra bytes we read, and align
-	left. since pslldq can only shift by an immediate, we use
-	vpshufb and an array of shuffle masks */
-	movq    %r12, %r11
-	salq    $4, %r11
-	movdqu  aad_shift_arr(%r11), \T1
-	vpshufb \T1, reg_i, reg_i
-_get_AAD_rest_final\@:
-	vpshufb SHUF_MASK(%rip), reg_i, reg_i
-	vpxor   reg_j, reg_i, reg_i
-	GHASH_MUL_AVX2      reg_i, \T2, \T1, \T3, \T4, \T5, \T6
-
-_get_AAD_done\@:
 	# initialize the data pointer offset as zero
 	xor     %r11d, %r11d
=20
@@ -2581,8 +2537,13 @@ _initial_blocks_done\@:
 #void   aesni_gcm_precomp_avx_gen4
 #        (gcm_data     *my_ctx_data,
 #         gcm_context_data *data,
-#        u8     *hash_subkey)# /* H, the Hash sub key input.
-#				Data starts on a 16-byte boundary. */
+#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on=
 a 16-byte boundary. */
+#        u8      *iv, /* Pre-counter block j0: 4 byte salt
+#			(from Security Association) concatenated with 8 byte
+#			Initialisation Vector (from IPSec ESP Payload)
+#			concatenated with 0x00000001. 16-byte aligned pointer. */
+#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
+#        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen4)
         FUNC_SAVE
@@ -2606,6 +2567,7 @@ ENTRY(aesni_gcm_precomp_avx_gen4)
         ##################################################################=
#####
         vmovdqu  %xmm6, HashKey(arg2)         # store HashKey<<1 mod poly
=20
+        CALC_AAD_HASH GHASH_MUL_AVX2, arg5, arg6, %xmm2, %xmm6, %xmm3, %xm=
m4, %xmm5, %xmm7, %xmm1, %xmm0
=20
         PRECOMPUTE_AVX2  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
=20
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-int=
el_glue.c
index 7d1259feb0f9..2648842f1c3f 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -189,7 +189,10 @@ asmlinkage void aes_ctr_enc_256_avx_by8(const u8 *in, =
u8 *iv,
  */
 asmlinkage void aesni_gcm_precomp_avx_gen2(void *my_ctx_data,
 					   struct gcm_context_data *gdata,
-					   u8 *hash_subkey);
+					   u8 *hash_subkey,
+					   u8 *iv,
+					   const u8 *aad,
+					   unsigned long aad_len);
=20
 asmlinkage void aesni_gcm_enc_avx_gen2(void *ctx,
 				struct gcm_context_data *gdata, u8 *out,
@@ -214,7 +217,8 @@ static void aesni_gcm_enc_avx(void *ctx,
 			plaintext_len, iv, hash_subkey, aad,
 			aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	}
@@ -231,7 +235,8 @@ static void aesni_gcm_dec_avx(void *ctx,
 			ciphertext_len, iv, hash_subkey, aad,
 			aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	}
@@ -246,7 +251,10 @@ static void aesni_gcm_dec_avx(void *ctx,
  */
 asmlinkage void aesni_gcm_precomp_avx_gen4(void *my_ctx_data,
 					   struct gcm_context_data *gdata,
-					   u8 *hash_subkey);
+					   u8 *hash_subkey,
+					   u8 *iv,
+					   const u8 *aad,
+					   unsigned long aad_len);
=20
 asmlinkage void aesni_gcm_enc_avx_gen4(void *ctx,
 				struct gcm_context_data *gdata, u8 *out,
@@ -271,11 +279,13 @@ static void aesni_gcm_enc_avx2(void *ctx,
 			      plaintext_len, iv, hash_subkey, aad,
 			      aad_len, auth_tag, auth_tag_len);
 	} else if (plaintext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_enc_avx_gen4(ctx, data, out, in, plaintext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	}
@@ -292,11 +302,13 @@ static void aesni_gcm_dec_avx2(void *ctx,
 			      ciphertext_len, iv, hash_subkey,
 			      aad, aad_len, auth_tag, auth_tag_len);
 	} else if (ciphertext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey);
+		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey, iv,
+					   aad, aad_len);
 		aesni_gcm_dec_avx_gen4(ctx, data, out, in, ciphertext_len, iv,
 				       aad, aad_len, auth_tag, auth_tag_len);
 	}
--=20
2.17.1

