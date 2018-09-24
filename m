Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FAEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B7E214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MxTudD3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B7E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbeIXUvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:32 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:39765
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732197AbeIXUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2CREeAwsX1C/X+9F1R2HiBeaWl14JOf+uu//Uoi1yg=;
 b=MxTudD3inJA1raPtXXYt/qpqdNd4VSlkd17hjSSB6w/7Ty41dq6hSBxhAJiLQ5Sm126GwphXOaqRPUkbNfgiPTYtWs9Ti3rSHZ2foj2CpFXUDAJh0kQnXV1ajkSOC9e98irpPT+cqzfrqRhC2bgZrsq6dM2vLhBY4Ils6M7Wquo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:48:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tushar Dave <tushar.n.dave@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 50/76] bpf: Fix bpf_msg_pull_data()
Thread-Topic: [PATCH AUTOSEL 4.18 50/76] bpf: Fix bpf_msg_pull_data()
Thread-Index: AQHUVBWpNg0ZmrNADUuUu0Fsk7CczA==
Date:   Mon, 24 Sep 2018 14:48:32 +0000
Message-ID: <20180924144751.164410-49-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:bKDrKYHoBKCOLLRMj6f7QD73255UINdHqfhNbojBmV1w2iDnE8w4vzwMBfbf6QP+/rR/tdKUhm45HDN4A7E1Ka60onFFjtT6HCTB0hf09T/7un7kZ9/quGGR6aQ15UgO0i1Q6nyPIm5BwUoiVfTKALyemCpfmUoo6XzIdblZuAfZQxzfrVZbZnqN/Cifk5TxTIYTxKl+ZVV9ldQqRTRKDwI8tfrmpq5e9+uIqkaIBklyriQXMWbZBtN8up6o7Gu0hm6fnmSGGvm7iXh3YKXK/fk8ZuOiSp74joKVrfrW8KMrxT9IyR0su2qenbrwu6+u9SZePWYlvNwtnoDSAUJD8XMkBkeVGE4TLpc0jBhKX44TKC/9OwF238ri4RsliZGHifq9yQjlKmsb1WJa3PJq0/kCcXbMoSgE0cNhu0I6W6qBLhKnLo1jFR9pnB/YJBH9s5/4Vdwqh/yla0/HKejp7A==;5:VaYezuqOTFEzh3/qyivSOjqRdTAku/pI07VelF+XSwu3EA1ovm/xDufzYSkoU01LoSTrOgSNaKM+FD+GcWnKS1SkN/FnpRFGMKVOaIDeV3pjnwcxR8q5VNgykcgqj8yldl1eL3ptJkarPKWhsnEx6Wlg459tdM9ITAFI6mLn8ig=;7:GLDChB1Pqa0vQlEuDNKJQyl0r02r0m3ZYPpdQCkoMM7J7eSG+MLGPwv8/yvdBNOO56SLX6PriG5T8OYFmCMqP0mVIvpfUHILqbOI6l4syEwbvAE0vYx/y3L//tat7RAtsJ/l2RNss+5e+2QTraKHDE2qRTKqxb49no31OdxeCzXr71PY7PMr1bAgkkBr7CE2dPB5ligeGwFcuMHl8MHR87d7IDvJN7J9ST73FuqPVtxqIjuAuZKxDk/NE0EippYA
x-ms-office365-filtering-correlation-id: 164d53df-70ec-4884-33a6-08d6222cdc08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744245688874E9BBDBBFF0CFB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QtbfgSWKhpHpYEd9ASamNghtMyYgzkUUWSSyVRezQU35q8ttXCGgaPspZnbx+QsRTPGnXfYYDkKOwZRHF3TLHItepVnqNKfZFowUhatQ6eql+7UkEKPaEgMv+KjNY+1YWM4EZJZZ85qKef7NjOg4TW0xgH1P1KyMfFF2xjIC57FySgATW1QtA9G+ci0KuKDun1vRAs68IPWCaYQA1NzHneb6zZiox+gDI0iX9u2NzdcwNUsZvtCpEiz3MyYr/oIT1shi/NglQl7g/UQAh3PlwvxF7olBErxe8tAoGeDIl3YiWXn/lPl4y66dMEq/NYzeVLffoMNJAkh4b63kl4P536CE5Kbg/wRtxnwAYhlI4AU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164d53df-70ec-4884-33a6-08d6222cdc08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:32.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>

[ Upstream commit 9db39f4d4f94b61e4b64b077f6ddb2bdfb533a88 ]

Helper bpf_msg_pull_data() mistakenly reuses variable 'offset' while
linearizing multiple scatterlist elements. Variable 'offset' is used
to find first starting scatterlist element
    i.e. msg->data =3D sg_virt(&sg[first_sg]) + start - offset"

Use different variable name while linearizing multiple scatterlist
elements so that value contained in variable 'offset' won't get
overwritten.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a80b57e4aaed..963ee2e88861 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2282,7 +2282,7 @@ static const struct bpf_func_proto bpf_msg_cork_bytes=
_proto =3D {
 BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
-	unsigned int len =3D 0, offset =3D 0, copy =3D 0;
+	unsigned int len =3D 0, offset =3D 0, copy =3D 0, poffset =3D 0;
 	int bytes =3D end - start, bytes_sg_total;
 	struct scatterlist *sg =3D msg->sg_data;
 	int first_sg, last_sg, i, shift;
@@ -2338,16 +2338,15 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(!page))
 		return -ENOMEM;
 	p =3D page_address(page);
-	offset =3D 0;
=20
 	i =3D first_sg;
 	do {
 		from =3D sg_virt(&sg[i]);
 		len =3D sg[i].length;
-		to =3D p + offset;
+		to =3D p + poffset;
=20
 		memcpy(to, from, len);
-		offset +=3D len;
+		poffset +=3D len;
 		sg[i].length =3D 0;
 		put_page(sg_page(&sg[i]));
=20
--=20
2.17.1
