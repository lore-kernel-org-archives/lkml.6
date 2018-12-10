Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B1620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZXxo0h7p";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KZFs8wHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B1620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeLJUAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbeLJUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:18 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJucNW028457;
        Mon, 10 Dec 2018 12:00:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=j4zhyvYyAMIxU7aQ4m1s86x1RvTKoZSSRH2DnMPCkKk=;
 b=ZXxo0h7pU+EsiDKbGAC+5DKwvWqlalWsPFlMHNhpo3Z/IJulME8fa+X1zaGFcvCEkrjb
 IqxCCDQIKB3kU/pkYrWMKIB/su9TWr5CNLHpIPlQef8AOBO2c3p919Rt87nCricBuz/F
 bv3ngvY8H77ULOqpBeuUNGhW39THBgamOo8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9w0v8fj7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 12:00:05 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:59:28 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:59:28 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:59:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4zhyvYyAMIxU7aQ4m1s86x1RvTKoZSSRH2DnMPCkKk=;
 b=KZFs8wHdpBbn7qRyIa8ajhcAU2usgSghRLJdfVEsebg7dkeylE5Rnf18Yw1GnoY9NKClr28/Hz6Y6QIqm9uO7+/evpErpTfhYlTNUCZd7gQQuYG85ap9UU8ITudxULqYyy0+C2iRu2hd98Ba4W2Pijfl8cNIkAcOl/RSpZVZACE=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:59:26 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:59:26 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 10/12] x86/crypto: aesni: Introduce READ_PARTIAL_BLOCK macro
Thread-Topic: [PATCH 10/12] x86/crypto: aesni: Introduce READ_PARTIAL_BLOCK
 macro
Thread-Index: AQHUkMLaQACb3l2c0kCSJjrb2sD0iA==
Date:   Mon, 10 Dec 2018 19:59:26 +0000
Message-ID: <1b813c4617813c08bea79ff57f3497ea2d32df24.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR17CA0083.namprd17.prod.outlook.com
 (2603:10b6:300:c2::21) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:C8NoiVyZEnIOnThYga5B0I1EcGQJoN3CSC/8AUWxPcc1lxeer2Kt8T6gsZ7QcHKsWJ5lQIcNRFgHQ4wL2bN54RjhQsYhGEBl/Y/qnLyVtzCZSSIitX2yCtcMYC3415A+Pe0DUgXIjB7O8tcFPhw/SwWYnXrDcl4CdNZ1QC4B2Lg=
x-ms-office365-filtering-correlation-id: 9620a2c3-5d4c-41b5-c4c4-08d65ed9fc97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB1166ACBE8491301D24F259D6DDA50@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(7736002)(256004)(8936002)(14444005)(486006)(386003)(76176011)(316002)(54906003)(58126008)(110136005)(99286004)(4326008)(2616005)(446003)(11346002)(52116002)(102836004)(305945005)(6506007)(46003)(476003)(186003)(5660300001)(36756003)(71190400001)(71200400001)(106356001)(105586002)(97736004)(118296001)(2501003)(53936002)(8676002)(68736007)(81166006)(81156014)(478600001)(14454004)(2906002)(25786009)(86362001)(6486002)(6512007)(6116002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ey9L8SyGbPkpkO7ATYBgNrofa/WQmP8tmzw2PqnxOMuEirF4we4NYibe1T6+jNkN+YtEKfTT/utEd1a84HqIDefK8EpoUrdNGMPfvAtKL+UN4ROl4Vgv2xZwsFs0VJWXV/VEEnoaCDp/wWmQAYL0fMRW0evzYy2b/L2TyQZ/UyEbDG4f3yiMC/sRn6p5BW7yssz/0Z+INbzJRQlpPAOX+CbVPrTFfZCYoEH0fYoWz1OlH4yUnVUdW2u1zbenVa+f/zqehMhhDYWYF5gqrm9yXffAg/EM8Psm3jI+TejzOjUGocUtIABDSI0jdxs4YJ+T
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CECA8052A795CB45BBA55D51003D6040@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9620a2c3-5d4c-41b5-c4c4-08d65ed9fc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:59:26.1745
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

Introduce READ_PARTIAL_BLOCK macro, and use it in the two existing
partial block cases: AAD and the end of ENC_DEC.   In particular,
the ENC_DEC case should be faster, since we read by 8/4 bytes if
possible.

This macro will also be used to read partial blocks between
enc_update and dec_update calls.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 102 +++++++++++++----------
 1 file changed, 59 insertions(+), 43 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 44a4a8b43ca4..ff00ad19064d 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -415,68 +415,56 @@ _zero_cipher_left\@:
         vmovdqu %xmm14, AadHash(arg2)
         vmovdqu %xmm9, CurCount(arg2)
=20
-        cmp     $16, arg5
-        jl      _only_less_than_16\@
-
+        # check for 0 length
         mov     arg5, %r13
         and     $15, %r13                            # r13 =3D (arg5 mod 1=
6)
=20
         je      _multiple_of_16_bytes\@
=20
-        # handle the last <16 Byte block seperately
+        # handle the last <16 Byte block separately
=20
         mov %r13, PBlockLen(arg2)
=20
-        vpaddd   ONE(%rip), %xmm9, %xmm9             # INCR CNT to get Yn
+        vpaddd  ONE(%rip), %xmm9, %xmm9              # INCR CNT to get Yn
         vmovdqu %xmm9, CurCount(arg2)
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
=20
         ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Yn)
         vmovdqu %xmm9, PBlockEncKey(arg2)
=20
-        sub     $16, %r11
-        add     %r13, %r11
-        vmovdqu (arg4, %r11), %xmm1                  # receive the last <1=
6 Byte block
-
-        lea     SHIFT_MASK+16(%rip), %r12
-        sub     %r13, %r12                           # adjust the shuffle =
mask pointer to be
-						     # able to shift 16-r13 bytes (r13 is the
-						     # number of bytes in plaintext mod 16)
-        vmovdqu (%r12), %xmm2                        # get the appropriate=
 shuffle mask
-        vpshufb %xmm2, %xmm1, %xmm1                  # shift right 16-r13 =
bytes
-        jmp     _final_ghash_mul\@
-
-_only_less_than_16\@:
-        # check for 0 length
-        mov     arg5, %r13
-        and     $15, %r13                            # r13 =3D (arg5 mod 1=
6)
+        cmp $16, arg5
+        jge _large_enough_update\@
=20
-        je      _multiple_of_16_bytes\@
+        lea (arg4,%r11,1), %r10
+        mov %r13, %r12
=20
-        # handle the last <16 Byte block separately
-
-
-        vpaddd  ONE(%rip), %xmm9, %xmm9              # INCR CNT to get Yn
-        vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
-        ENCRYPT_SINGLE_BLOCK    \REP, %xmm9                # E(K, Yn)
-
-        vmovdqu %xmm9, PBlockEncKey(arg2)
+        READ_PARTIAL_BLOCK %r10 %r12 %xmm1
=20
         lea     SHIFT_MASK+16(%rip), %r12
         sub     %r13, %r12                           # adjust the shuffle =
mask pointer to be
 						     # able to shift 16-r13 bytes (r13 is the
-						     # number of bytes in plaintext mod 16)
+	# number of bytes in plaintext mod 16)
=20
-_get_last_16_byte_loop\@:
-        movb    (arg4, %r11),  %al
-        movb    %al,  TMP1 (%rsp , %r11)
-        add     $1, %r11
-        cmp     %r13,  %r11
-        jne     _get_last_16_byte_loop\@
+        jmp _final_ghash_mul\@
+
+_large_enough_update\@:
+        sub $16, %r11
+        add %r13, %r11
+
+        # receive the last <16 Byte block
+        vmovdqu	(arg4, %r11, 1), %xmm1
=20
-        vmovdqu  TMP1(%rsp), %xmm1
+        sub	%r13, %r11
+        add	$16, %r11
=20
-        sub     $16, %r11
+        lea	SHIFT_MASK+16(%rip), %r12
+        # adjust the shuffle mask pointer to be able to shift 16-r13 bytes
+        # (r13 is the number of bytes in plaintext mod 16)
+        sub	%r13, %r12
+        # get the appropriate shuffle mask
+        vmovdqu	(%r12), %xmm2
+        # shift right 16-r13 bytes
+        vpshufb  %xmm2, %xmm1, %xmm1
=20
 _final_ghash_mul\@:
         .if  \ENC_DEC =3D=3D  DEC
@@ -490,8 +478,6 @@ _final_ghash_mul\@:
         vpxor   %xmm2, %xmm14, %xmm14
=20
         vmovdqu %xmm14, AadHash(arg2)
-        sub     %r13, %r11
-        add     $16, %r11
         .else
         vpxor   %xmm1, %xmm9, %xmm9                  # Plaintext XOR E(K, =
Yn)
         vmovdqu ALL_F-SHIFT_MASK(%r12), %xmm1        # get the appropriate=
 mask to
@@ -501,8 +487,6 @@ _final_ghash_mul\@:
         vpxor   %xmm9, %xmm14, %xmm14
=20
         vmovdqu %xmm14, AadHash(arg2)
-        sub     %r13, %r11
-        add     $16, %r11
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9        # shuffle xmm9 back t=
o output as ciphertext
         .endif
=20
@@ -721,6 +705,38 @@ _get_AAD_done\@:
         \PRECOMPUTE  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
 .endm
=20
+
+# Reads DLEN bytes starting at DPTR and stores in XMMDst
+# where 0 < DLEN < 16
+# Clobbers %rax, DLEN
+.macro READ_PARTIAL_BLOCK DPTR DLEN XMMDst
+        vpxor \XMMDst, \XMMDst, \XMMDst
+
+        cmp $8, \DLEN
+        jl _read_lt8_\@
+        mov (\DPTR), %rax
+        vpinsrq $0, %rax, \XMMDst, \XMMDst
+        sub $8, \DLEN
+        jz _done_read_partial_block_\@
+        xor %eax, %eax
+_read_next_byte_\@:
+        shl $8, %rax
+        mov 7(\DPTR, \DLEN, 1), %al
+        dec \DLEN
+        jnz _read_next_byte_\@
+        vpinsrq $1, %rax, \XMMDst, \XMMDst
+        jmp _done_read_partial_block_\@
+_read_lt8_\@:
+        xor %eax, %eax
+_read_next_byte_lt8_\@:
+        shl $8, %rax
+        mov -1(\DPTR, \DLEN, 1), %al
+        dec \DLEN
+        jnz _read_next_byte_lt8_\@
+        vpinsrq $0, %rax, \XMMDst, \XMMDst
+_done_read_partial_block_\@:
+.endm
+
 #ifdef CONFIG_AS_AVX
 ##########################################################################=
#####
 # GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
--=20
2.17.1

