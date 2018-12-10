Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14529C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35922082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ol1GCFJd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ayUEim2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35922082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeLJUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52584 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727596AbeLJUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJxNeE031979;
        Mon, 10 Dec 2018 11:59:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=laFvmhLu1XU8kPONGuHW6OuXsXiuED390f4AeWqxBZk=;
 b=ol1GCFJdaiKBzOum6uUK0LeRZgRVYxl1SXg1zT/HwKpFwXXk4Q8PtlNa3EFGJz2LxzUr
 Cz0vXR8iQyUm1Tjg/3G/XG4PUJPNC0WeQm4gaolz/p/wPP9TM1QOgTErTGdX3fnvLuVa
 P4QHkgShPj7VpXbquT4UVULmF1BQtBURygc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9wvx872q-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:59:54 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:59:40 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:59:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laFvmhLu1XU8kPONGuHW6OuXsXiuED390f4AeWqxBZk=;
 b=ayUEim2QD55MsqNCDdgKMWlNtOh8/rnRdKOmeneEC0X6JnrTHzIBCcLZRLr3nvf2qWYgvje6E0v6eUAdUVR7s754T0GCui17Tr94DymQS967YKZsf/ZAq7jANhmYRKlCyj9/D6jhOIzuFxF/zS3xGx+k5cGm7LTpSoDZwosVdF4=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1118.namprd15.prod.outlook.com (10.175.2.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 19:59:38 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:59:38 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 11/12] x86/crypto: aesni: Introduce partial block macro
Thread-Topic: [PATCH 11/12] x86/crypto: aesni: Introduce partial block macro
Thread-Index: AQHUkMLhsUg1ZlT5qEOkVFI0jgUkaQ==
Date:   Mon, 10 Dec 2018 19:59:38 +0000
Message-ID: <67137103e3a6b4ac0f20fe94eef0575536b11af8.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:301:73::43) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1118;20:H2M5j3tIDwGbeK8hg533xU2Wg0q3GhivKMDIndYDOFfIgBA7zI9jG12+d8Qls34c6yi+cubBZl/dBXt3te9YZTX84nZCHB4pM2obbSOPopUdXUHzulDVoFg/EygOVsWDgs2Vx34wA0kkYQouYC3/hgBm5RExafl++etcGk/0Za0=
x-ms-office365-filtering-correlation-id: 5d46d37e-d2d1-4607-d2cd-08d65eda03d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1118;
x-ms-traffictypediagnostic: MWHPR15MB1118:
x-microsoft-antispam-prvs: <MWHPR15MB111801531BB5066BBA7700E3DDA50@MWHPR15MB1118.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1118;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1118;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(102836004)(5660300001)(305945005)(36756003)(106356001)(99286004)(316002)(7736002)(4326008)(81156014)(54906003)(68736007)(76176011)(53936002)(2906002)(14454004)(58126008)(478600001)(6506007)(386003)(52116002)(186003)(8936002)(110136005)(118296001)(6116002)(2616005)(97736004)(476003)(11346002)(256004)(6436002)(2501003)(25786009)(6512007)(81166006)(8676002)(86362001)(486006)(46003)(14444005)(446003)(105586002)(6486002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1118;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3WJ21OzUudcd6S/51caXAWI+kT081P6JqEpvUGxbQk/GVLhwKzCB18z+26rGnZdt9I9NGtpf0UHA3v/EGgJVUXLNyUrfO1zrwsXLIuaCW40GJGspPllv6wfgjoL42qRTopLehaarP9GG5GIAV7g/45YxEWkZ+p9sUKcS1h5x7P8T2b5qrkXUPUKJphwMN3c8bk5aDeDB83bzOT0HWGkMP02KENX7FR+D8RgKmNgR5V57d6j16t7hbBqq3bEOw3fRQ4XBR2LT68ESvJ7z79MSk1rjaM+fM1M1TiMdujoqELOE8NFD1o/PkcU3ztacIhiy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE772F2144BDCA44A208FC5231E0D859@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d46d37e-d2d1-4607-d2cd-08d65eda03d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:59:38.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this diff, multiple calls to GCM_ENC_DEC will
succeed, but only if all calls are a multiple of 16 bytes.

Handle partial blocks at the start of GCM_ENC_DEC, and update
aadhash as appropriate.

The data offset %r11 is also updated after the partial block.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 156 ++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index ff00ad19064d..af45fc57db90 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -301,6 +301,12 @@ VARIABLE_OFFSET =3D 16*8
         vmovdqu  HashKey(arg2), %xmm13      # xmm13 =3D HashKey
         add arg5, InLen(arg2)
=20
+        # initialize the data pointer offset as zero
+        xor     %r11d, %r11d
+
+        PARTIAL_BLOCK \GHASH_MUL, arg3, arg4, arg5, %r11, %xmm8, \ENC_DEC
+        sub %r11, arg5
+
         mov     arg5, %r13                  # save the number of bytes of =
plaintext/ciphertext
         and     $-16, %r13                  # r13 =3D r13 - (r13 mod 16)
=20
@@ -737,6 +743,150 @@ _read_next_byte_lt8_\@:
 _done_read_partial_block_\@:
 .endm
=20
+# PARTIAL_BLOCK: Handles encryption/decryption and the tag partial blocks
+# between update calls.
+# Requires the input data be at least 1 byte long due to READ_PARTIAL_BLOC=
K
+# Outputs encrypted bytes, and updates hash and partial info in gcm_data_c=
ontext
+# Clobbers rax, r10, r12, r13, xmm0-6, xmm9-13
+.macro PARTIAL_BLOCK GHASH_MUL CYPH_PLAIN_OUT PLAIN_CYPH_IN PLAIN_CYPH_LEN=
 DATA_OFFSET \
+        AAD_HASH ENC_DEC
+        mov 	PBlockLen(arg2), %r13
+        cmp	$0, %r13
+        je	_partial_block_done_\@	# Leave Macro if no partial blocks
+        # Read in input data without over reading
+        cmp	$16, \PLAIN_CYPH_LEN
+        jl	_fewer_than_16_bytes_\@
+        vmovdqu	(\PLAIN_CYPH_IN), %xmm1	# If more than 16 bytes, just fill=
 xmm
+        jmp	_data_read_\@
+
+_fewer_than_16_bytes_\@:
+        lea	(\PLAIN_CYPH_IN, \DATA_OFFSET, 1), %r10
+        mov	\PLAIN_CYPH_LEN, %r12
+        READ_PARTIAL_BLOCK %r10 %r12 %xmm1
+
+        mov PBlockLen(arg2), %r13
+
+_data_read_\@:				# Finished reading in data
+
+        vmovdqu	PBlockEncKey(arg2), %xmm9
+        vmovdqu	HashKey(arg2), %xmm13
+
+        lea	SHIFT_MASK(%rip), %r12
+
+        # adjust the shuffle mask pointer to be able to shift r13 bytes
+        # r16-r13 is the number of bytes in plaintext mod 16)
+        add	%r13, %r12
+        vmovdqu	(%r12), %xmm2		# get the appropriate shuffle mask
+        vpshufb %xmm2, %xmm9, %xmm9		# shift right r13 bytes
+
+.if  \ENC_DEC =3D=3D  DEC
+        vmovdqa	%xmm1, %xmm3
+        pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+
+        mov	\PLAIN_CYPH_LEN, %r10
+        add	%r13, %r10
+        # Set r10 to be the amount of data left in CYPH_PLAIN_IN after fil=
ling
+        sub	$16, %r10
+        # Determine if if partial block is not being filled and
+        # shift mask accordingly
+        jge	_no_extra_mask_1_\@
+        sub	%r10, %r12
+_no_extra_mask_1_\@:
+
+        vmovdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+        # get the appropriate mask to mask out bottom r13 bytes of xmm9
+        vpand	%xmm1, %xmm9, %xmm9		# mask out bottom r13 bytes of xmm9
+
+        vpand	%xmm1, %xmm3, %xmm3
+        vmovdqa	SHUF_MASK(%rip), %xmm10
+        vpshufb	%xmm10, %xmm3, %xmm3
+        vpshufb	%xmm2, %xmm3, %xmm3
+        vpxor	%xmm3, \AAD_HASH, \AAD_HASH
+
+        cmp	$0, %r10
+        jl	_partial_incomplete_1_\@
+
+        # GHASH computation for the last <16 Byte block
+        \GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+        xor	%eax,%eax
+
+        mov	%rax, PBlockLen(arg2)
+        jmp	_dec_done_\@
+_partial_incomplete_1_\@:
+        add	\PLAIN_CYPH_LEN, PBlockLen(arg2)
+_dec_done_\@:
+        vmovdqu	\AAD_HASH, AadHash(arg2)
+.else
+        vpxor	%xmm1, %xmm9, %xmm9			# Plaintext XOR E(K, Yn)
+
+        mov	\PLAIN_CYPH_LEN, %r10
+        add	%r13, %r10
+        # Set r10 to be the amount of data left in CYPH_PLAIN_IN after fil=
ling
+        sub	$16, %r10
+        # Determine if if partial block is not being filled and
+        # shift mask accordingly
+        jge	_no_extra_mask_2_\@
+        sub	%r10, %r12
+_no_extra_mask_2_\@:
+
+        vmovdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+        # get the appropriate mask to mask out bottom r13 bytes of xmm9
+        vpand	%xmm1, %xmm9, %xmm9
+
+        vmovdqa	SHUF_MASK(%rip), %xmm1
+        vpshufb %xmm1, %xmm9, %xmm9
+        vpshufb %xmm2, %xmm9, %xmm9
+        vpxor	%xmm9, \AAD_HASH, \AAD_HASH
+
+        cmp	$0, %r10
+        jl	_partial_incomplete_2_\@
+
+        # GHASH computation for the last <16 Byte block
+        \GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+        xor	%eax,%eax
+
+        mov	%rax, PBlockLen(arg2)
+        jmp	_encode_done_\@
+_partial_incomplete_2_\@:
+        add	\PLAIN_CYPH_LEN, PBlockLen(arg2)
+_encode_done_\@:
+        vmovdqu	\AAD_HASH, AadHash(arg2)
+
+        vmovdqa	SHUF_MASK(%rip), %xmm10
+        # shuffle xmm9 back to output as ciphertext
+        vpshufb	%xmm10, %xmm9, %xmm9
+        vpshufb	%xmm2, %xmm9, %xmm9
+.endif
+        # output encrypted Bytes
+        cmp	$0, %r10
+        jl	_partial_fill_\@
+        mov	%r13, %r12
+        mov	$16, %r13
+        # Set r13 to be the number of bytes to write out
+        sub	%r12, %r13
+        jmp	_count_set_\@
+_partial_fill_\@:
+        mov	\PLAIN_CYPH_LEN, %r13
+_count_set_\@:
+        vmovdqa	%xmm9, %xmm0
+        vmovq	%xmm0, %rax
+        cmp	$8, %r13
+        jle	_less_than_8_bytes_left_\@
+
+        mov	%rax, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+        add	$8, \DATA_OFFSET
+        psrldq	$8, %xmm0
+        vmovq	%xmm0, %rax
+        sub	$8, %r13
+_less_than_8_bytes_left_\@:
+        movb	%al, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+        add	$1, \DATA_OFFSET
+        shr	$8, %rax
+        sub	$1, %r13
+        jne	_less_than_8_bytes_left_\@
+_partial_block_done_\@:
+.endm # PARTIAL_BLOCK
+
 #ifdef CONFIG_AS_AVX
 ##########################################################################=
#####
 # GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -856,9 +1006,6 @@ _done_read_partial_block_\@:
 	setreg
         vmovdqu AadHash(arg2), reg_i
=20
-	# initialize the data pointer offset as zero
-	xor     %r11d, %r11d
-
 	# start AES for num_initial_blocks blocks
 	vmovdqu CurCount(arg2), \CTR
=20
@@ -1798,9 +1945,6 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
 	setreg
 	vmovdqu AadHash(arg2), reg_i
=20
-	# initialize the data pointer offset as zero
-	xor     %r11d, %r11d
-
 	# start AES for num_initial_blocks blocks
 	vmovdqu CurCount(arg2), \CTR
=20
--=20
2.17.1

