Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21705C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7E320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M4Zgc2tj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ePewa7Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7E320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLJUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbeLJUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJvlNd010188;
        Mon, 10 Dec 2018 11:59:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jucX9AZEzQUtdSJRRHLi5CMYefs+aWYDzBST1YLppiU=;
 b=M4Zgc2tjjHC1qpmJLziWBnNnLRjY7c8ASzPwYL+ekx0J1+5fVGnSHkE2hKWFGnmM0881
 MOgGME2TBcb483y/r6iUMcdifSD5Cy8Sni8lwpeW5iFmmq/2Rn0L5AjMzfkh3q1QRPxV
 sqqfkvrgHVTkFmAl9G+7hdYVz0UYVntkWF4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9wgwrbcy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:59:58 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:58:41 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:58:40 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:58:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jucX9AZEzQUtdSJRRHLi5CMYefs+aWYDzBST1YLppiU=;
 b=ePewa7UsmnlvVXTIEMQVrc5cEHBovZqo+yzlmU1sHFV9kK59xts/RbJVWgIEH9IVyeBvE7O1jdDY0NoarvczDAyn7SXL1cZSzl0u8f6XfHW6wjL8SHVgt8RvuDKJmzPvFdiWbOlvjVWFEUI0H9emuCkTxLK3yGGrz1AATl7oZk0=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:58:38 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:58:38 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 07/12] x86/crypto: aesni: Merge avx precompute functions
Thread-Topic: [PATCH 07/12] x86/crypto: aesni: Merge avx precompute functions
Thread-Index: AQHUkMK+eVEZ+uWr2ESLeqxqAeCPPA==
Date:   Mon, 10 Dec 2018 19:58:38 +0000
Message-ID: <f2b870d980ed5c7fdabd1c4746ab94a145fa9807.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR17CA0094.namprd17.prod.outlook.com
 (2603:10b6:300:c2::32) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:7Xb+3kghEtyqaK6WHDizMw0O59eTUyS6QCch9dbQmRB/IpryPPKtQAWlV+h2eUFmdgu5mjFf5UZEztKD8S4b6uvyRurSvYYzRQpgbv+REVoKvDdmDutgBMiCC1zuZTAJxvYnHZq4kAcB9KMH9iXaAuXdhV1kMYytrvv+OMUqo9c=
x-ms-office365-filtering-correlation-id: 4e628f27-2c86-47d3-a561-08d65ed9e059
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB11666C8C19A509251DF28619DDA50@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(7736002)(256004)(8936002)(14444005)(486006)(386003)(76176011)(316002)(54906003)(58126008)(110136005)(99286004)(4326008)(2616005)(446003)(11346002)(52116002)(102836004)(305945005)(6506007)(46003)(476003)(186003)(5660300001)(36756003)(71190400001)(71200400001)(106356001)(105586002)(97736004)(118296001)(2501003)(53936002)(8676002)(68736007)(81166006)(81156014)(478600001)(14454004)(2906002)(25786009)(86362001)(6486002)(6512007)(6116002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X+44EaN/3ZKLfyUFxOhjF6xA8PCwvIbU9aO3/yV0YlcAiY1p9CJ4dPrV4WVfZeLQE8e9cAYE5ie/cGYXmlK21I23tlBSe8pxdD7fV8LbgCiLIHr4WnPEehaupgnhgkHLlGkDFr7Tl3PK73ZJ3rZe3qwGtQPE+XXkb2KlZDaavtJJ2HtYDFxAhROH+vLlRzZp1bP6V6P7Umz9BIL4PsLC4VC4ODbSX8oQITyxRh7FReCBW1FEMDuL5i9mqr+sQ8rhUqasmO7DJdZwZAZoik3mh1MEOxBshxaZeJy+ewKbBcSzpP5Ff1eQ2Z/jatoi/m77
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6B142CDB14D114E973E598D4DA0A361@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e628f27-2c86-47d3-a561-08d65ed9e059
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:58:38.7762
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

The precompute functions differ only by the sub-macros
they call, merge them to a single macro.   Later diffs
add more code to fill in the gcm_context_data structure,
this allows changes in a single place.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 76 +++++++++---------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 305abece93ad..e347ba61db65 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -661,6 +661,31 @@ _get_AAD_done\@:
         vmovdqu \T7, AadHash(arg2)
 .endm
=20
+.macro INIT GHASH_MUL PRECOMPUTE
+        vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
+
+        vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
+        ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
+        vmovdqa  %xmm6, %xmm2
+        vpsllq   $1, %xmm6, %xmm6
+        vpsrlq   $63, %xmm2, %xmm2
+        vmovdqa  %xmm2, %xmm1
+        vpslldq  $8, %xmm2, %xmm2
+        vpsrldq  $8, %xmm1, %xmm1
+        vpor     %xmm2, %xmm6, %xmm6
+        #reduction
+        vpshufd  $0b00100100, %xmm1, %xmm2
+        vpcmpeqd TWOONE(%rip), %xmm2, %xmm2
+        vpand    POLY(%rip), %xmm2, %xmm2
+        vpxor    %xmm2, %xmm6, %xmm6        # xmm6 holds the HashKey<<1 mo=
d poly
+        ##################################################################=
#####
+        vmovdqu  %xmm6, HashKey(arg2)       # store HashKey<<1 mod poly
+
+        CALC_AAD_HASH \GHASH_MUL, arg5, arg6, %xmm2, %xmm6, %xmm3, %xmm4, =
%xmm5, %xmm7, %xmm1, %xmm0
+
+        \PRECOMPUTE  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
+.endm
+
 #ifdef CONFIG_AS_AVX
 ##########################################################################=
#####
 # GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -1558,31 +1583,7 @@ _initial_blocks_done\@:
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen2)
         FUNC_SAVE
-
-        vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
-
-        vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
-        ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
-        vmovdqa  %xmm6, %xmm2
-        vpsllq   $1, %xmm6, %xmm6
-        vpsrlq   $63, %xmm2, %xmm2
-        vmovdqa  %xmm2, %xmm1
-        vpslldq  $8, %xmm2, %xmm2
-        vpsrldq  $8, %xmm1, %xmm1
-        vpor     %xmm2, %xmm6, %xmm6
-        #reduction
-        vpshufd  $0b00100100, %xmm1, %xmm2
-        vpcmpeqd TWOONE(%rip), %xmm2, %xmm2
-        vpand    POLY(%rip), %xmm2, %xmm2
-        vpxor    %xmm2, %xmm6, %xmm6        # xmm6 holds the HashKey<<1 mo=
d poly
-        ##################################################################=
#####
-        vmovdqu  %xmm6, HashKey(arg2)       # store HashKey<<1 mod poly
-
-
-        CALC_AAD_HASH GHASH_MUL_AVX, arg5, arg6, %xmm2, %xmm6, %xmm3, %xmm=
4, %xmm5, %xmm7, %xmm1, %xmm0
-
-        PRECOMPUTE_AVX  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
-
+        INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
         FUNC_RESTORE
         ret
 ENDPROC(aesni_gcm_precomp_avx_gen2)
@@ -2547,30 +2548,7 @@ _initial_blocks_done\@:
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen4)
         FUNC_SAVE
-
-        vmovdqu  (arg3), %xmm6                # xmm6 =3D HashKey
-
-        vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
-        ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
-        vmovdqa  %xmm6, %xmm2
-        vpsllq   $1, %xmm6, %xmm6
-        vpsrlq   $63, %xmm2, %xmm2
-        vmovdqa  %xmm2, %xmm1
-        vpslldq  $8, %xmm2, %xmm2
-        vpsrldq  $8, %xmm1, %xmm1
-        vpor     %xmm2, %xmm6, %xmm6
-        #reduction
-        vpshufd  $0b00100100, %xmm1, %xmm2
-        vpcmpeqd TWOONE(%rip), %xmm2, %xmm2
-        vpand    POLY(%rip), %xmm2, %xmm2
-        vpxor    %xmm2, %xmm6, %xmm6          # xmm6 holds the HashKey<<1 =
mod poly
-        ##################################################################=
#####
-        vmovdqu  %xmm6, HashKey(arg2)         # store HashKey<<1 mod poly
-
-        CALC_AAD_HASH GHASH_MUL_AVX2, arg5, arg6, %xmm2, %xmm6, %xmm3, %xm=
m4, %xmm5, %xmm7, %xmm1, %xmm0
-
-        PRECOMPUTE_AVX2  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
-
+        INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
         FUNC_RESTORE
         ret
 ENDPROC(aesni_gcm_precomp_avx_gen4)
--=20
2.17.1

