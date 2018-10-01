Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDCFC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926852083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o6exARoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926852083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJAHN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:27 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728673AbeJAHNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKPa9SEygqwUIg+ym080LHFu9S0M+gDcyWx7MBH1WjQ=;
 b=o6exARoHS4zkQq5H/PWbOcS8rIAIZfelknYcyCozQ4XZkMcbp/v9TRSbTSuXV4Cc3wxN2ofZd3WFbEsE+BKi5THGtorakeCjj+7uS3skt8R7b79GNdpwOksb3jUW+/hZaMsMNCaH0pOXqQHMFAbyXdm6Da8By01/NzwJEL/eQgo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 11/65] perf annotate: Properly interpret indirect
 call
Thread-Topic: [PATCH AUTOSEL 4.18 11/65] perf annotate: Properly interpret
 indirect call
Thread-Index: AQHUWR8GDA7TYEC0fk6jN35kfyAX/g==
Date:   Mon, 1 Oct 2018 00:38:09 +0000
Message-ID: <20181001003754.146961-11-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:60snUCKK+b8RfVssrvpdvfZAmS7YORSZdUiaFb+Z5JLOaMe4fIZCLOdLmFgrtTJuEqCiTCF6Bc+P93E1BAY2MyEGR3TtB8cXY9ibFTx93xtQPo5eQBQsD1LdXBBJnYyiSTz6anPkTFwsiohENueqoOp15x9t3i7cpm+CEFYGqQzJrmbc2V6ouWjRux/X0sM5PiWrotm+t8/qF9ARZgYp5ypV9nmgyFWT+GETGMS0fk6sLLwmGPw2QSqP2VIZdt7P26a2v6XQEMwLlXKkzZApNHPyhxjPB+gyjfsQwILewQWxwMll1yu6HAZ9kciI3HdwazicmlnOcrz87f6eKUCOyMRvIngs5/TmOlzodQLrxxfknxIuWYIAmrIjt8XHa3pLR5NigsEdmM0+EVeCwzN4eW98QwCU9PEfRs4kdpVTghnjNqTRDzSBo0+Z5kLYOasNmxmNP/JvGWHRn3rlPZOJgg==;5:EjsLiLiKEQStDyH5Jo7hDSNzyHukcp1p5D0Qz9iBWMFP6TaadlbOMp2qsHwPILlk8AH13KFdzIVoHf7vDIezzFryMSeQhSZoPimZbg4XrAENgyoGpCpiOFXhHdEFKv/H76wOLWj4qBbxI9B6wwyGQkoTbqYXFizWN64Vu5e875Y=;7:4s2F9Uei7+Ry1kN60SWYt5SWetFIFeZozZUXtfpEYpxCgigjm3DBksd69OaKr/6SAzzpELodjFqqvmaGrbxvgnz3Xw3KR1uaWn8ASpXe+v82qOs+oOS7lo6dnGn923nYdiv9xLM0Txf+pX5LT9OYSFZ5YqbPimF2g5PxYN3MO2DsYQ6ZP3vqUCnbnvc+L8tYNGDgcEKn2rIcS8tGWaH0g2CHAzow2tJquKsW3QTLU4h8xnJEmzGHLx/itDKlpmv6
x-ms-office365-filtering-correlation-id: 3a71aa88-20bc-4863-ec6d-08d62736295b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469CE7C6CF3D3F45581032DFBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(966005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(6306002)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6yXkxXkfswQASXSfya7u9H5jgAldqRMKFcrXPr1frW4Nif5TSu1HUDfHS3VuBFL5rCV+pDU1EIIQmyo/kPFI1bSyfhjniAU0nXu09BArlXU/pIQ9ZIJ1TkS9jrtHPuqpUgjYI0mCk48KzSgFqG3ynI2SPTTOMyHfZYh8OReEqfCp5Q2T/8IE6aMygzwYA6nZ+anYIWpAtfNF37VoBzXBrlgQYjMtzxOmpwhP4ACmi0n3g2qGaKb+hHx5ZaeknhBbLIg2kbj8vdGYfVEknumJ5eKmsGDZczLS/j8R9Ya3VJ0r4403LiMOTWYzaIuF0hMl2D6JHIGbXvlkQ+BQYOb5oojk1EoR2/g8Kk8+76jehpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B2D0353947224EAB72A3D1C420D560@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a71aa88-20bc-4863-ec6d-08d62736295b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:09.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFydGluIExpxaFrYSA8bWxpc2thQHN1c2UuY3o+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDFkYzI3ZjYzMzAzZGI1OGNlMWIxYTY5MzJkMTgyNTMwNWY4NmQ1NzQgXQ0KDQpUaGUgcGF0Y2gg
Y2hhbmdlcyB0aGUgcGFyc2luZyBvZjoNCg0KCWNhbGxxICAqMHg4KCVyYngpDQoNCmZyb206DQoN
CiAgMC4yNiDilIIgICAgIOKGkiBjYWxscSAgKjgNCg0KdG86DQoNCiAgMC4yNiDilIIgICAgIOKG
kiBjYWxscSAgKjB4OCglcmJ4KQ0KDQppbiB0aGlzIGNhc2UgYW4gYWRkcmVzcyBpcyBmb2xsb3dl
ZCBieSBhIHJlZ2lzdGVyLCB0aHVzIG9uZSBjYW4ndCBwYXJzZQ0Kb25seSB0aGUgYWRkcmVzcy4N
Cg0KQ29tbWl0dGVyIHRlc3Rpbmc6DQoNCjEpIHJ1biAncGVyZiByZWNvcmQgc2xlZXAgMTAnDQoy
KSBiZWZvcmUgYXBwbHlpbmcgdGhlIHBhdGNoLCBydW46DQoNCiAgICAgcGVyZiBhbm5vdGF0ZSAt
LXN0ZGlvMiA+IC90bXAvYmVmb3JlDQoNCjMpIGFmdGVyIGFwcGx5aW5nIHRoZSBwYXRjaCwgcnVu
Og0KDQogICAgIHBlcmYgYW5ub3RhdGUgLS1zdGRpbzIgPiAvdG1wL2FmdGVyDQoNCjQpIGRpZmYg
L3RtcC9iZWZvcmUgL3RtcC9hZnRlcjoNCiAgLS0tIC90bXAvYmVmb3JlIDIwMTgtMDgtMjggMTE6
MTY6MDMuMjM4Mzg0MTQzIC0wMzAwDQogICsrKyAvdG1wL2FmdGVyICAyMDE4LTA4LTI4IDExOjE1
OjM5LjMzNTM0MTA0MiAtMDMwMA0KICBAQCAtMTMyNzQsNyArMTMyNzQsNyBAQA0KICAgICAgICAg
ICAgICAgIOKGkyBqbGUgICAgMTI4DQogICAgICAgICAgICAgICAgICBoYXNoX3ZhbHVlID0gaGFz
aF90YWJsZS0+aGFzaF9mdW5jIChrZXkpOw0KICAgICAgICAgICAgICAgICAgbW92ICAgIDB4OCgl
cnNwKSwlcmRpDQogIC0gIDAuOTEgICAgICAg4oaSIGNhbGxxICAqMzANCiAgKyAgMC45MSAgICAg
ICDihpIgY2FsbHEgICoweDMwKCVyMTIpDQogICAgICAgICAgICAgICAgICBtb3YgICAgJDB4Miwl
cjhkDQogICAgICAgICAgICAgICAgICBjbXAgICAgJDB4MiwlZWF4DQogICAgICAgICAgICAgICAg
ICBub2RlX2hhc2ggPSBoYXNoX3RhYmxlLT5oYXNoZXNbbm9kZV9pbmRleF07DQogIEBAIC0xMzg0
OCw3ICsxMzg0OCw3IEBADQogICAgICAgICAgICAgICAgICAgbW92ICAgICVyMTQsJXJkaQ0KICAg
ICAgICAgICAgICAgICAgIHN1YiAgICAlcmJ4LCVyMTMNCiAgICAgICAgICAgICAgICAgICBtb3Yg
ICAgJXIxMywlcmR4DQogIC0gICAgICAgICAgICAgIOKGkiBjYWxscSAgKjM4DQogICsgICAgICAg
ICAgICAgIOKGkiBjYWxscSAgKjB4MzgoJXIxNSkNCiAgICAgICAgICAgICAgICAgICBjbXAgICAg
JXJheCwlcjEzDQogICAgIDEuOTEgICAgICAgIOKGkyBqZSAgICAgMjQwDQogICAgICAgICAgICAx
YjQ6ICAgbW92ICAgICQweGZmZmZmZmZmLCVyMTNkDQogIEBAIC0xNDAyNiw3ICsxNDAyNiw3IEBA
DQogICAgICAgICAgICAgICAgICAgbW92ICAgICVyY3gsLTB4NTAwKCVyYnApDQogICAgICAgICAg
ICAgICAgICAgbW92ICAgICVyMTUsJXJzaQ0KICAgICAgICAgICAgICAgICAgIG1vdiAgICAlcjE0
LCVyZGkNCiAgLSAgICAgICAgICAgICAg4oaSIGNhbGxxICAqMzgNCiAgKyAgICAgICAgICAgICAg
4oaSIGNhbGxxICAqMHgzOCglcmF4KQ0KICAgICAgICAgICAgICAgICAgIG1vdiAgICAtMHg1MDAo
JXJicCksJXJjeA0KICAgICAgICAgICAgICAgICAgIGNtcCAgICAlcmF4LCVyY3gNCiAgICAgICAg
ICAgICAgICAg4oaTIGpuZSAgICA5YjANCjxTTklQIHRvbnMgb2Ygb3RoZXIgc3VjaCBjYXNlcz4N
Cg0KU2lnbmVkLW9mZi1ieTogTWFydGluIExpxaFrYSA8bWxpc2thQHN1c2UuY3o+DQpUZXN0ZWQt
Ynk6IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUByZWRoYXQuY29tPg0KVGVzdGVkLWJ5
OiBLaW0gUGhpbGxpcHMgPGtpbS5waGlsbGlwc0Bhcm0uY29tPg0KQ2M6IEppcmkgT2xzYSA8am9s
c2FAcmVkaGF0LmNvbT4NCkxpbms6IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci9iZDFmMzkzMi1i
ZTJiLTg1ZjktNzU4Mi0xMTFlZTBhNDNiMDdAc3VzZS5jeg0KU2lnbmVkLW9mZi1ieTogQXJuYWxk
byBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNo
YSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiB0b29scy9wZXJm
L3V0aWwvYW5ub3RhdGUuYyB8IDEwICsrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGls
L2Fubm90YXRlLmMgYi90b29scy9wZXJmL3V0aWwvYW5ub3RhdGUuYw0KaW5kZXggZjkxNzc1YjRi
YzNjLi4zMWExZTE4YzdiZjIgMTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3V0aWwvYW5ub3RhdGUu
Yw0KKysrIGIvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmMNCkBAIC0yNDUsOCArMjQ1LDE0IEBA
IHN0YXRpYyBpbnQgY2FsbF9fcGFyc2Uoc3RydWN0IGFyY2ggKmFyY2gsIHN0cnVjdCBpbnNfb3Bl
cmFuZHMgKm9wcywgc3RydWN0IG1hcF9zDQogDQogaW5kaXJlY3RfY2FsbDoNCiAJdG9rID0gc3Ry
Y2hyKGVuZHB0ciwgJyonKTsNCi0JaWYgKHRvayAhPSBOVUxMKQ0KLQkJb3BzLT50YXJnZXQuYWRk
ciA9IHN0cnRvdWxsKHRvayArIDEsIE5VTEwsIDE2KTsNCisJaWYgKHRvayAhPSBOVUxMKSB7DQor
CQllbmRwdHIrKzsNCisNCisJCS8qIEluZGlyZWN0IGNhbGwgY2FuIHVzZSBhIG5vbi1yaXAgcmVn
aXN0ZXIgYW5kIG9mZnNldDogY2FsbHEgICoweDgoJXJieCkuDQorCQkgKiBEbyBub3QgcGFyc2Ug
c3VjaCBpbnN0cnVjdGlvbi4gICovDQorCQlpZiAoc3Ryc3RyKGVuZHB0ciwgIiglciIpID09IE5V
TEwpDQorCQkJb3BzLT50YXJnZXQuYWRkciA9IHN0cnRvdWxsKGVuZHB0ciwgTlVMTCwgMTYpOw0K
Kwl9DQogCWdvdG8gZmluZF90YXJnZXQ7DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
