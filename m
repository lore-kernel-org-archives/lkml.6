Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC442098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZeL6J2do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC442098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeIXUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:06 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731107AbeIXUu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uFI0uf+bgURTHtkjSadPAqd5S3AO+avlt/tYXSAk9Y=;
 b=ZeL6J2doJB6DvEP+fdGdGelZfJWk7HMawfSmzKfwpoaIgBV2nWGpyOadlj71qGVkTZbL8j+UjjLKh4JI26EHwtWjfd5DKeCTqyA0CdDs2Y6mu3wT/ID2IOyWRflyy/MNgRuclk6koivuih0zVrW73MCjoldAodshauamgiTiRp8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/76] bpf: fix sg shift repair start offset in
 bpf_msg_pull_data
Thread-Topic: [PATCH AUTOSEL 4.18 29/76] bpf: fix sg shift repair start offset
 in bpf_msg_pull_data
Thread-Index: AQHUVBWhE6SoR6o3akOt1jMUcX982g==
Date:   Mon, 24 Sep 2018 14:48:18 +0000
Message-ID: <20180924144751.164410-29-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:1tm29eBwNjrGfqM/RnJpK11nbkMHol4/ozmkC5WrVtBzx2LMADoz8qNLkfEffWp5FVWsXSLrmzaKVSi8aQFYkALa03ILE1AnL5mXHM6W2f+KxQSItfmh+ypHPo9iOTxqePKNnVIoQkRleBL1t9ozuDeKiD+0NhkhZ/I6+0kgFZrpuv+SLjXsHnO57r7YceP0EvGx7c8t0bD1CrvcWVG020AV2u8HcmUO8oOTzgAeBOEFLJnW5UsVzMvWSDqX7ayA4uXn/eXfdvH02Bl+wxxolJhO+rMUTjN2A/tOElmIj27B7FncOlTI21twf5Na3cl/u8iUCEI8t96I5cLypTsjHKXdyV3NA1D15HO+9YBdQZtIjbB1okphWzSPfrYVRBssZ/27K7wJp3WDdb7ykKrymmQ0bBjL92c6Z+/Ee1Tj4Ovonua1CgqbW0hkUo20A9HMb8tljruSk1uYWu4ugOWf1g==;5:4290yAyRrD5YGt3vrh4BYZuLJqGpfTpYSH8qcqWsZh2ucs+61Xq8KpW8yqKdy1msS/cOp0L3es5ZaOTjEWBe6AW5ym/hIohyWwAw4b1NXxWk8HKRWcujYFWrEp/86Sf9ZgBbi1AlWABCgtf/cGduW+q0DwZcV+Et4iYebzcJXik=;7:A6v2f6OH/HtTW5Z24cPhrA8BTAeOotIUvhNHM1gPWjgAThVPNiXy2fSm8YnWX9MrB3wsmglfLWYr0CyepuRVTpml+aHj3rHqWsIiuzjZGFjMqL0JnGegyhxf48jI1wo4IB3oTCxIJd7bPME0aR9TZlwLAjT3IXFNJuqLn9xZtDHw5dGhaGr+mcy7wPPWFxVm/KeVxPoPn4tjksip0KAZqZXt5K1zhLCBMcJuZE77uxHJ1aAJLx5Eg8RFZXAAqYUD
x-ms-office365-filtering-correlation-id: 3198553e-2320-4a68-dbc9-08d6222cc477
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821A57D502F6357DFDC4291FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4ALPImHcClOJNcIF7n+sJtPSNlKbNhyX6Y+sfnON2UYHoDLTgXahqcQV8ckD5zRfTebfDBeT3d5Fzt9pxgYTKpwCEFln/eorRxH0iYtaH9BcgV3NoRRBxIA4BQwCM8AXgx8HQrAktRsz/OKug9jCGeZdMSEWC2orYh+wfmkK2fI9HewFH3QjOHUicPqcizaKYKiQqNTSzzBlXmGgBD5d1/GD/Jf/ftCktLLXBC/gXRaT5hGJueXmqXh946raAeMuVUAFJLjOBGgIl5VdqpSX+H2CsG5g0fdpmbrwgr+hByB6O1pSCNrG3bVmsMeB/9ONnFWI64n2Z7G7WZUAx9Scz3ZbCWzs3+nESwER77w9PuQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3198553e-2320-4a68-dbc9-08d6222cc477
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:18.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit a8cf76a9023bc6709b1361d06bb2fae5227b9d68 ]

When we perform the sg shift repair for the scatterlist ring, we
currently start out at i =3D first_sg + 1. However, this is not
correct since the first_sg could point to the sge sitting at slot
MAX_SKB_FRAGS - 1, and a subsequent i =3D MAX_SKB_FRAGS will access
the scatterlist ring (sg) out of bounds. Add the sk_msg_iter_var()
helper for iterating through the ring, and apply the same rule
for advancing to the next ring element as we do elsewhere. Later
work will use this helper also in other places.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cc4d660aafe1..a80b57e4aaed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2272,6 +2272,13 @@ static const struct bpf_func_proto bpf_msg_cork_byte=
s_proto =3D {
 	.arg2_type      =3D ARG_ANYTHING,
 };
=20
+#define sk_msg_iter_var(var)			\
+	do {					\
+		var++;				\
+		if (var =3D=3D MAX_SKB_FRAGS)	\
+			var =3D 0;		\
+	} while (0)
+
 BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
@@ -2292,9 +2299,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		if (start < offset + len)
 			break;
 		offset +=3D len;
-		i++;
-		if (i =3D=3D MAX_SKB_FRAGS)
-			i =3D 0;
+		sk_msg_iter_var(i);
 	} while (i !=3D msg->sg_end);
=20
 	if (unlikely(start >=3D offset + len))
@@ -2320,9 +2325,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	 */
 	do {
 		copy +=3D sg[i].length;
-		i++;
-		if (i =3D=3D MAX_SKB_FRAGS)
-			i =3D 0;
+		sk_msg_iter_var(i);
 		if (bytes_sg_total <=3D copy)
 			break;
 	} while (i !=3D msg->sg_end);
@@ -2348,9 +2351,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		sg[i].length =3D 0;
 		put_page(sg_page(&sg[i]));
=20
-		i++;
-		if (i =3D=3D MAX_SKB_FRAGS)
-			i =3D 0;
+		sk_msg_iter_var(i);
 	} while (i !=3D last_sg);
=20
 	sg[first_sg].length =3D copy;
@@ -2367,7 +2368,8 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (!shift)
 		goto out;
=20
-	i =3D first_sg + 1;
+	i =3D first_sg;
+	sk_msg_iter_var(i);
 	do {
 		int move_from;
=20
@@ -2384,9 +2386,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		sg[move_from].page_link =3D 0;
 		sg[move_from].offset =3D 0;
=20
-		i++;
-		if (i =3D=3D MAX_SKB_FRAGS)
-			i =3D 0;
+		sk_msg_iter_var(i);
 	} while (1);
 	msg->sg_end -=3D shift;
 	if (msg->sg_end < 0)
--=20
2.17.1
