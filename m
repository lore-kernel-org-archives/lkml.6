Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40726C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EAD20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Bo5MeVkE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NtjgKhh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EAD20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeLJT6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:58:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47522 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbeLJT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:58:46 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJmu4G004445;
        Mon, 10 Dec 2018 11:58:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/Lhu42xP7/j4S6dfOLmX7B6SeuA5mwmg+cwzkAXX8GI=;
 b=Bo5MeVkEQkmnFDuJkoJeKva/ox6lFV955TpH3iJ4NUFxkw87mZga9umbafPZwWWNamDA
 O+c5HGfjYa2xdDt8CS7pMv1FPp20H0CTdwknD2D3G9jO/fKHB0/9t6X6dzeey2b1NAxL
 fajgCv9DD8qU9890/j0cR/ZdNKoTh51XsMw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9vtc0hm3-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:58:36 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:57:51 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:57:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Lhu42xP7/j4S6dfOLmX7B6SeuA5mwmg+cwzkAXX8GI=;
 b=NtjgKhh02YWcaY3RX19eurjpzvKvj4WcYWP3laMoqKnbiiiFRrRtNDu9gc5c2MxEKFY+QbVouyqMytoB93XfBqdMtkygUC2iUu6lY2ZoTTW6krRVunEyb02+NTDsKtCZaYQC28ftTX60m3+Bhz7x94wexm1ycqYsJs04RIpuHXw=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 19:57:49 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:57:49 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 05/12] x86/crypto: aesni: Add GCM_COMPLETE macro
Thread-Topic: [PATCH 05/12] x86/crypto: aesni: Add GCM_COMPLETE macro
Thread-Index: AQHUkMKgkYuomEwTI0O5eKu9Voer4Q==
Date:   Mon, 10 Dec 2018 19:57:49 +0000
Message-ID: <85c7157eb2c38a3bd0d39e17a8156e451fcd13e2.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:301:2::33) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1710;20:IEePco4V/BXjXM7cydwJn35guWW1UU4z5Omc3+lgx1PnuNfijwRUnA7CImSi6M0JlqdRL2K+nQP6quRyxFcYHKZm2OKqzkx4hYSviwO/Vs7ZiLDJxqNHnZfRukXf23q6/YsO/Pxvc7FGMrXUvRqvz5Au1ylM6ZOU9dZ/7baUPVs=
x-ms-office365-filtering-correlation-id: 5541e075-1edc-49a1-a765-08d65ed9c2ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-antispam-prvs: <MWHPR15MB1710C2E394AEEB2032721E9FDDA50@MWHPR15MB1710.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1710;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(386003)(5660300001)(25786009)(11346002)(46003)(446003)(68736007)(2616005)(478600001)(7736002)(105586002)(305945005)(6436002)(476003)(186003)(71190400001)(71200400001)(6506007)(8936002)(81156014)(14454004)(81166006)(86362001)(6486002)(52116002)(8676002)(102836004)(316002)(14444005)(256004)(54906003)(2501003)(6512007)(58126008)(76176011)(118296001)(99286004)(110136005)(2906002)(36756003)(97736004)(6116002)(486006)(53936002)(106356001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0Fqwf/YK9OGb5EDTHZL5CT/MpZrIrOPt60FBNaUwsla55T+ushJFpialP0q6M4fYbxL+dV3YEVkEsFEZ69to6myi4+UQhPskH3yrxo9HlwYYma/n+8J1uPINuMtCOizeefSn0JScyKXjfXIKG1VDl5YeE7AWiS1kx/3mzNiUg2Mg2MMIg6HpY0oYoY9NVPLaEpioxEvOsfn1eg+XHSEWhhVu0hwJ8TpJiuGoo7qu4F+HiY+koAT7m4Q3CJl3zhtm/B/CEoNH8TWxN3WrwC7qjWaCCNM11aCAFz+f3hw2894bWpagRbl1eES98ZBB3hap
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE0B978C3C5C3943A0A68A63FC9D3AAA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5541e075-1edc-49a1-a765-08d65ed9c2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:57:49.2014
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

Merge encode and decode tag calculations in GCM_COMPLETE macro.
Scatter/gather routines will call this once at the end of encryption
or decryption.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 2aa11c503bb9..8e9ae4b26118 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -510,6 +510,14 @@ _less_than_8_bytes_left\@:
         #############################
=20
 _multiple_of_16_bytes\@:
+        GCM_COMPLETE \GHASH_MUL \REP
+.endm
+
+
+# GCM_COMPLETE Finishes update of tag of last partial block
+# Output: Authorization Tag (AUTH_TAG)
+# Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
+.macro GCM_COMPLETE GHASH_MUL REP
         mov     arg8, %r12                           # r12 =3D aadLen (num=
ber of bytes)
         shl     $3, %r12                             # convert into number=
 of bits
         vmovd   %r12d, %xmm15                        # len(A) in xmm15
--=20
2.17.1

