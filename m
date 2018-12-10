Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15155C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B449F20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c7bpzW5o";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iaQ+qZ2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B449F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeLJT7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:59:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbeLJT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:59:31 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJucNG028457;
        Mon, 10 Dec 2018 11:59:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bc3ifg7fHAsHQlm5psCliNfUneGx1fLZ/+hMVOYcWoE=;
 b=c7bpzW5oQTxKikmMBM7HIY7VtD0qmqUfdx7WkKp4UfZ61IunR4Ug8xnyhTig7Db/pkRc
 LPozDJ1ZJ0r8pk+O77Sf7tjyOiPGUHNAp5oWrINq0oeCqZM/Xwtvn6bYF/19jednR4D0
 mvsUDZR5DBTrYa9otjPeq5zNTsE5g9fOnXE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9w0v8ff8-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:59:18 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:58:58 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:58:57 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:58:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc3ifg7fHAsHQlm5psCliNfUneGx1fLZ/+hMVOYcWoE=;
 b=iaQ+qZ2AaRxkOmEBCmH/oJKSbJ3yCSGVK2rHBGl8Yt6hmHllUv8ycKZryD/Fm8XrVJ8UELDT7divec2sI+8OwP8roQk9O2E+ueJ95VJ+w438v+AwJ1H25Qg28NAk08w3gCXNvXSmhG3ekkOV2qI+PwxycAcoMlSmkFdHnnRALHg=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:58:56 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:58:56 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 08/12] x86/crypto: aesni: Fill in new context data structures
Thread-Topic: [PATCH 08/12] x86/crypto: aesni: Fill in new context data
 structures
Thread-Index: AQHUkMLI5S/Pd+eCmU+qRiAtcEi5sQ==
Date:   Mon, 10 Dec 2018 19:58:56 +0000
Message-ID: <8104eaf3639f9c70ced8d4867e572d6a1182afd2.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:300:6c::29) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:56vEdhJWcI+98ILr+hVykI4ua+bSYasNCc+50uk4NNtdACBLbFleVLujw4nh7ik+FPCloKJRvIytOrroIvv4wMmpZfg7feSD3e9cMaRmZOGtCkErbD801eZqmfYR9VDBITiGvUWiHxO5LVp3C95aHmtfcRCJGfMgB6Xnwj0g3ew=
x-ms-office365-filtering-correlation-id: 20faa47e-b474-4319-3602-08d65ed9eaa3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB11661802C42F5EF6ACFB72D2DDA50@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(7736002)(256004)(8936002)(486006)(386003)(76176011)(316002)(54906003)(58126008)(110136005)(99286004)(4326008)(2616005)(446003)(11346002)(52116002)(102836004)(305945005)(6506007)(46003)(476003)(186003)(5660300001)(36756003)(71190400001)(71200400001)(106356001)(105586002)(97736004)(118296001)(2501003)(53936002)(8676002)(68736007)(81166006)(81156014)(478600001)(14454004)(2906002)(25786009)(86362001)(6486002)(6512007)(6116002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8ust5hkPGFpsSWDWtWzxKROG1/M8DjuRBmT4Yc2r7mZmBYuGTW/n8kde/HWUOzYQcV7eLsJA/qHcZzsrIR0Qib/ZU2/O3K3WKbstgM2P5A2xfVYLNbhVvqFftO7oT1Ps1iwIFZIA+d1nq0/iPE1EbR6+hbYWeHUXBfQCX28bvXmKUQFvzfcHhAyhftTyDqDK+MJn8eSG7tue2UWHTXDIgiLZ/Pfp2X6fVlB0IyZDCy1mHeh101EJ32LqzklFSXzwPL7GFfI99UsR+63rC8O/XI3RlkfzvwlU+RNL2vOWGAFOQHy4xK8elm1iZvlrQ0GZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D83259952139E418754B441A59A0A77@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 20faa47e-b474-4319-3602-08d65ed9eaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:58:56.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in aadhash, aadlen, pblocklen, curcount with appropriate values.
pblocklen, aadhash, and pblockenckey are also updated at the end
of each scatter/gather operation, to be carried over to the next
operation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 51 +++++++++++++++++-------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index e347ba61db65..0a9cdcfdd987 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -297,7 +297,9 @@ VARIABLE_OFFSET =3D 16*8
 # clobbering all xmm registers
 # clobbering r10, r11, r12, r13, r14, r15
 .macro  GCM_ENC_DEC INITIAL_BLOCKS GHASH_8_ENCRYPT_8_PARALLEL GHASH_LAST_8=
 GHASH_MUL ENC_DEC REP
+        vmovdqu AadHash(arg2), %xmm8
         vmovdqu  HashKey(arg2), %xmm13      # xmm13 =3D HashKey
+        add arg5, InLen(arg2)
=20
         mov     arg5, %r13                  # save the number of bytes of =
plaintext/ciphertext
         and     $-16, %r13                  # r13 =3D r13 - (r13 mod 16)
@@ -410,6 +412,9 @@ _eight_cipher_left\@:
=20
=20
 _zero_cipher_left\@:
+        vmovdqu %xmm14, AadHash(arg2)
+        vmovdqu %xmm9, CurCount(arg2)
+
         cmp     $16, arg5
         jl      _only_less_than_16\@
=20
@@ -420,10 +425,14 @@ _zero_cipher_left\@:
=20
         # handle the last <16 Byte block seperately
=20
+        mov %r13, PBlockLen(arg2)
=20
         vpaddd   ONE(%rip), %xmm9, %xmm9             # INCR CNT to get Yn
+        vmovdqu %xmm9, CurCount(arg2)
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
+
         ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Yn)
+        vmovdqu %xmm9, PBlockEncKey(arg2)
=20
         sub     $16, %r11
         add     %r13, %r11
@@ -451,6 +460,7 @@ _only_less_than_16\@:
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
         ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Yn)
=20
+        vmovdqu %xmm9, PBlockEncKey(arg2)
=20
         lea     SHIFT_MASK+16(%rip), %r12
         sub     %r13, %r12                           # adjust the shuffle =
mask pointer to be
@@ -480,6 +490,7 @@ _final_ghash_mul\@:
         vpxor   %xmm2, %xmm14, %xmm14
 	#GHASH computation for the last <16 Byte block
         \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6
+        vmovdqu %xmm14, AadHash(arg2)
         sub     %r13, %r11
         add     $16, %r11
         .else
@@ -491,6 +502,7 @@ _final_ghash_mul\@:
         vpxor   %xmm9, %xmm14, %xmm14
 	#GHASH computation for the last <16 Byte block
         \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6
+        vmovdqu %xmm14, AadHash(arg2)
         sub     %r13, %r11
         add     $16, %r11
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9        # shuffle xmm9 back t=
o output as ciphertext
@@ -526,12 +538,16 @@ _multiple_of_16_bytes\@:
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
 .macro GCM_COMPLETE GHASH_MUL REP
-        mov     arg8, %r12                           # r12 =3D aadLen (num=
ber of bytes)
+        vmovdqu AadHash(arg2), %xmm14
+        vmovdqu HashKey(arg2), %xmm13
+
+        mov AadLen(arg2), %r12                          # r12 =3D aadLen (=
number of bytes)
         shl     $3, %r12                             # convert into number=
 of bits
         vmovd   %r12d, %xmm15                        # len(A) in xmm15
=20
-        shl     $3, arg5                             # len(C) in bits  (*1=
28)
-        vmovq   arg5, %xmm1
+        mov InLen(arg2), %r12
+        shl     $3, %r12                        # len(C) in bits  (*128)
+        vmovq   %r12, %xmm1
         vpslldq $8, %xmm15, %xmm15                   # xmm15 =3D len(A)|| =
0x0000000000000000
         vpxor   %xmm1, %xmm15, %xmm15                # xmm15 =3D len(A)||l=
en(C)
=20
@@ -539,8 +555,7 @@ _multiple_of_16_bytes\@:
         \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6    # final GHASH computation
         vpshufb SHUF_MASK(%rip), %xmm14, %xmm14      # perform a 16Byte sw=
ap
=20
-        mov     arg6, %rax                           # rax =3D *Y0
-        vmovdqu (%rax), %xmm9                        # xmm9 =3D Y0
+        vmovdqu OrigIV(arg2), %xmm9
=20
         ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Y0)
=20
@@ -662,6 +677,20 @@ _get_AAD_done\@:
 .endm
=20
 .macro INIT GHASH_MUL PRECOMPUTE
+        mov arg6, %r11
+        mov %r11, AadLen(arg2) # ctx_data.aad_length =3D aad_length
+        xor %r11d, %r11d
+        mov %r11, InLen(arg2) # ctx_data.in_length =3D 0
+
+        mov %r11, PBlockLen(arg2) # ctx_data.partial_block_length =3D 0
+        mov %r11, PBlockEncKey(arg2) # ctx_data.partial_block_enc_key =3D =
0
+        mov arg4, %rax
+        movdqu (%rax), %xmm0
+        movdqu %xmm0, OrigIV(arg2) # ctx_data.orig_IV =3D iv
+
+        vpshufb SHUF_MASK(%rip), %xmm0, %xmm0
+        movdqu %xmm0, CurCount(arg2) # ctx_data.current_counter =3D iv
+
         vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
=20
         vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
@@ -809,10 +838,7 @@ _get_AAD_done\@:
 	xor     %r11d, %r11d
=20
 	# start AES for num_initial_blocks blocks
-	mov     arg6, %rax                     # rax =3D *Y0
-	vmovdqu (%rax), \CTR                   # CTR =3D Y0
-	vpshufb SHUF_MASK(%rip), \CTR, \CTR
-
+	vmovdqu CurCount(arg2), \CTR
=20
 	i =3D (9-\num_initial_blocks)
 	setreg
@@ -1748,16 +1774,13 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
 .macro INITIAL_BLOCKS_AVX2 REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 =
XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
 	i =3D (8-\num_initial_blocks)
 	setreg
-        vmovdqu AadHash(arg2), reg_i
+	vmovdqu AadHash(arg2), reg_i
=20
 	# initialize the data pointer offset as zero
 	xor     %r11d, %r11d
=20
 	# start AES for num_initial_blocks blocks
-	mov     arg6, %rax                     # rax =3D *Y0
-	vmovdqu (%rax), \CTR                   # CTR =3D Y0
-	vpshufb SHUF_MASK(%rip), \CTR, \CTR
-
+	vmovdqu CurCount(arg2), \CTR
=20
 	i =3D (9-\num_initial_blocks)
 	setreg
--=20
2.17.1

