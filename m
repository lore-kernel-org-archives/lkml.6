Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F9C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5088B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l4MbR00t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfA2UkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:40:08 -0500
Received: from mail-eopbgr800087.outbound.protection.outlook.com ([40.107.80.87]:35406
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfA2UkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysLSnnGPWm8C3buRpsePcHQIvj4dmhJCFcXGoKTJrJE=;
 b=l4MbR00tOR1mx+SbTn4ECuaEXsPabzRKVGRuyIpyfpxojOeV6GDuS6+3hOZgJXACi3husqyVXd9RSf2nGnMvxz0k7JdWOc3PoNORg2RJ1scLTmW1m5JAW3+RyDFWgY5i+dBdZz8puZ/MFHJBsJhX7/Kb/6c2nXm276y+Yups9oU=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB3959.namprd02.prod.outlook.com (20.176.248.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 20:40:04 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 20:40:04 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
 management APIs
Thread-Topic: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
 management APIs
Thread-Index: AQHUrD6mdAof5ly9qEGscyOgLDHLxqXGT7WAgAB9SRA=
Date:   Tue, 29 Jan 2019 20:40:04 +0000
Message-ID: <BYAPR02MB59921AA0C4ADDC078FA28BE3B8970@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
 <1547493778-22720-3-git-send-email-jollys@xilinx.com>
 <e4b34ee3-49ba-8b6e-76ad-69bf078a8256@xilinx.com>
In-Reply-To: <e4b34ee3-49ba-8b6e-76ad-69bf078a8256@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB3959;6:T/IRzfAGX8CIEmuzTLA1WYb7ak08sc3eJrj8UXkph84vAzdXkVFnkOpIRkQjyj7QRNN5wWoINs4P4L6r5jBnKwsg/+ihq8xUU/OGOYbkkoBz3ZD7yLHYIOfXnVPhMwsj8+OwDtiU8Fc4M2yZuupXSXlGJ4dvlQpS5e9MxeqMVrhouY/y/DDKbY2jh1lYV9rdyqSjSeqK92qQGfW/yr2zMZmN7VKejb6G/BRQlVzIMzl5gUPSH/+r6qxoL9pllmBS1VzhmZkSEyPU2qItULARJUAJSTZW2lAUBX2MA6kOiSyqc66IJdQkoX699AiuSPwxb3t+WCggdMTBgC9nY/WaKvrGcmvVIRCEoTU35SmpCCN3ORYQHC1O5seVH4EA2GBXpl9rUmREDdF8tQ92ZBpxQhq8HiA/0DcWIZp5ak+ekwJn3x9MRgkdqZXqsYJ6snFk7iKIB87pRPDtW9S4221eng==;5:iZaUaK+H00uvdgcrIn0iDS1S8TFm9ylIrnF6yHRFDyNQ1n4Ul9eHvVevpnlv6W4e2Ka6v1IJwhWys8dY/QeWWnc/vY6VEw1J75HIxt94b2gwbUQtcCO+z1sLfRVJDRyEglZ2SpS6AFZFs3+GuHI1Axa0s2mWORO1Vl7iLWepU8vm/aq1eezuuNR2//m0D0lSJqG23zl+p++NrZ2tPjAT/w==;7:59C4gCShb/kGfX7GMJg1ZV/DaELjOdPYnRZP8A76I3JcYtjWXdDWYOhsFgsO1L28H+D42gzxiB4FzR3MT5lAuxfo4kLTakNgRDLAorUB0Ljp6hxr2I6CIZNezJlJoBvx0JhdjJ0iMZVRVGjih12Byw==
x-ms-office365-filtering-correlation-id: 6a0568aa-4d20-4e38-668f-08d68629f2a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB3959;
x-ms-traffictypediagnostic: BYAPR02MB3959:
x-microsoft-antispam-prvs: <BYAPR02MB39595747A033AD5DD8AFD8EAB8970@BYAPR02MB3959.namprd02.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(13464003)(189003)(8676002)(66066001)(486006)(2501003)(6436002)(86362001)(74316002)(99286004)(256004)(229853002)(14444005)(102836004)(76176011)(53546011)(71200400001)(8936002)(26005)(7696005)(71190400001)(6506007)(2201001)(186003)(476003)(446003)(14454004)(11346002)(39060400002)(478600001)(6116002)(305945005)(107886003)(54906003)(7736002)(25786009)(3846002)(68736007)(4326008)(106356001)(55016002)(53936002)(7416002)(72206003)(33656002)(966005)(316002)(110136005)(2906002)(9686003)(6306002)(105586002)(81166006)(6246003)(81156014)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB3959;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QjuQjpJX7NEiqVqS123WolFqQBzY94E4IGwLc0MdwzPgUMf+45qIu1dhDPsS13TOE5SaQP60/b6Uv0e15dazVckXsA3YlYYKg9GWTZFTvJ6Q/VDgdOCHctEGJdfn/7e2VpnnrhPKt+UH7QyKT8K4zJg1RR7xGJ1HdqtO7clXZV31NVdGlhp8qeEwyh3dl9ofwGvMbJhKfIpKh8IgSV8OcSSceqvO6NV+BY+vt/FgDxzuuC7q5BVwy2GWkUixqh1P+/+Lgiujqumk20XE1b9VJG+1he1A2z//L9v7/YvWZDsa5cGmoyAwndNFneBIOX/KAJ4DGgLr/JWK8VvzUGV+mJCGYDg41RdKuyuX70rFM5AbRINMVf+EU7YitHBXeQfuaFptjvLWHGdZ7h7wKQOclcOidDlt+jLUXxbKrrRTRNE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0568aa-4d20-4e38-668f-08d68629f2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:40:04.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layBbbWFpbHRvOm1pY2hhbC5zaW1la0B4aWxpbnguY29tXQ0KPiBTZW50OiBUdWVzZGF5
LCBKYW51YXJ5IDI5LCAyMDE5IDU6MTEgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxp
bnguY29tPjsgbWF0dGhpYXMuYmdnQGdtYWlsLmNvbTsNCj4gYW5keS5ncm9zc0BsaW5hcm8ub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBnZWVydCtyZW5lc2FzQGdsaWRlci5iZTsNCj4gYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7IHNlYW4ud2FuZ0BtZWRpYXRlay5jb207DQo+IG0uc3p5cHJv
d3NraUBzYW1zdW5nLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBy
b2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tDQo+IENjOiBSYWphbiBWYWph
IDxSQUpBTlZAeGlsaW54LmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBSYWphbiBWYWphDQo+IDxSQUpBTlZAeGlsaW54LmNvbT47IEpvbGx5IFNoYWggPEpP
TExZU0B4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvM10gZmlybXdhcmU6
IHhpbGlueDogSW1wbGVtZW50IFp5bnFNUCBwb3dlcg0KPiBtYW5hZ2VtZW50IEFQSXMNCj4gDQo+
IE9uIDE0LiAwMS4gMTkgMjA6MjIsIEpvbGx5IFNoYWggd3JvdGU6DQo+ID4gRnJvbTogUmFqYW4g
VmFqYSA8cmFqYW4udmFqYUB4aWxpbnguY29tPg0KPiA+DQo+ID4gQWRkIFhpbGlueCBaeW5xTVAg
ZmlybXdhcmUgQVBJcyB0byBzZXQgc3VzcGVuZCBtb2RlDQo+ID4gYW5kIGluZm9ybSBmaXJtd2Fy
ZSB0aGF0IG1hc3RlciBoYXMgaW5pdGlhbGl6ZWQgaXRzDQo+ID4gb3duIHBvd2VyIG1hbmFnZW1l
bnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWphbiBWYWphIDxyYWphbi52YWphQHhpbGlu
eC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9sbHkgU2hhaCA8am9sbHlzQHhpbGlueC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICAgICB8IDI5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdh
cmUveGxueC16eW5xbXAuaCB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlu
cW1wLmMNCj4gPiBpbmRleCA4NGIzZmQyLi5jN2EzYjZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS94
aWxpbngvenlucW1wLmMNCj4gPiBAQCAtNDI4LDYgKzQyOCwzMyBAQCBzdGF0aWMgaW50IHp5bnFt
cF9wbV9jbG9ja19nZXRwYXJlbnQodTMyIGNsb2NrX2lkLA0KPiB1MzIgKnBhcmVudF9pZCkNCj4g
PiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICsvKioNCj4gPiArICogenlucW1wX3Bt
X2luaXRfZmluYWxpemUoKSAtIFBNIGNhbGwgdG8gaW5mb3JtIGZpcm13YXJlIHRoYXQgdGhlIGNh
bGxlcg0KPiA+ICsgKgkJCSAgICAgICBtYXN0ZXIgaGFzIGluaXRpYWxpemVkIGl0cyBvd24gcG93
ZXIgbWFuYWdlbWVudA0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIEFQSSBmdW5jdGlvbiBpcyB0byBi
ZSB1c2VkIGZvciBub3RpZnkgdGhlIHBvd2VyIG1hbmFnZW1lbnQgY29udHJvbGxlcg0KPiA+ICsg
KiBhYm91dCB0aGUgY29tcGxldGVkIHBvd2VyIG1hbmFnZW1lbnQgaW5pdGlhbGl6YXRpb24uDQo+
ID4gKyAqDQo+ID4gKyAqIFJldHVybjogUmV0dXJucyBzdGF0dXMsIGVpdGhlciBzdWNjZXNzIG9y
IGVycm9yK3JlYXNvbg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludCB6eW5xbXBfcG1faW5pdF9m
aW5hbGl6ZSh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4genlucW1wX3BtX2ludm9rZV9mbihQ
TV9QTV9JTklUX0ZJTkFMSVpFLCAwLCAwLCAwLCAwLCBOVUxMKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArLyoqDQo+ID4gKyAqIHp5bnFtcF9wbV9zZXRfc3VzcGVuZF9tb2RlKCkJLSBTZXQgc3lzdGVt
IHN1c3BlbmQgbW9kZQ0KPiA+ICsgKiBAbW9kZToJTW9kZSB0byBzZXQgZm9yIHN5c3RlbSBzdXNw
ZW5kDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgQVBJIGZ1bmN0aW9uIGlzIHVzZWQgdG8gc2V0IG1v
ZGUgb2Ygc3lzdGVtIHN1c3BlbmQuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogUmV0dXJucyBz
dGF0dXMsIGVpdGhlciBzdWNjZXNzIG9yIGVycm9yK3JlYXNvbg0KPiA+ICsgKi8NCj4gPiArc3Rh
dGljIGludCB6eW5xbXBfcG1fc2V0X3N1c3BlbmRfbW9kZSh1MzIgbW9kZSkNCj4gPiArew0KPiA+
ICsJcmV0dXJuIHp5bnFtcF9wbV9pbnZva2VfZm4oUE1fU0VUX1NVU1BFTkRfTU9ERSwgbW9kZSwg
MCwgMCwgMCwNCj4gTlVMTCk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgenlucW1wX2VlbWlfb3BzIGVlbWlfb3BzID0gew0KPiA+ICAJLmdldF9hcGlfdmVyc2lvbiA9
IHp5bnFtcF9wbV9nZXRfYXBpX3ZlcnNpb24sDQo+ID4gIAkucXVlcnlfZGF0YSA9IHp5bnFtcF9w
bV9xdWVyeV9kYXRhLA0KPiA+IEBAIC00NDAsNiArNDY3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCB6eW5xbXBfZWVtaV9vcHMgZWVtaV9vcHMgPSB7DQo+ID4gIAkuY2xvY2tfZ2V0cmF0ZSA9IHp5
bnFtcF9wbV9jbG9ja19nZXRyYXRlLA0KPiA+ICAJLmNsb2NrX3NldHBhcmVudCA9IHp5bnFtcF9w
bV9jbG9ja19zZXRwYXJlbnQsDQo+ID4gIAkuY2xvY2tfZ2V0cGFyZW50ID0genlucW1wX3BtX2Ns
b2NrX2dldHBhcmVudCwNCj4gPiArCS5pbml0X2ZpbmFsaXplID0genlucW1wX3BtX2luaXRfZmlu
YWxpemUsDQo+ID4gKwkuc2V0X3N1c3BlbmRfbW9kZSA9IHp5bnFtcF9wbV9zZXRfc3VzcGVuZF9t
b2RlLA0KPiANCj4gVGhpcyBoYXMgYmVlbiBjcmVhdGVkIGxvbmcgdGltZSBhZ28gYW5kIHRoZXJl
IHdhcyBvbmUgbW9yZSBwYXRjaCBpbiB0aGUNCj4gbWlkZGxlIG9mIHRoaXMuDQo+IEkgaGF2ZSBh
cHBsaWVkIHJlc2V0IGRyaXZlciBqdXN0IG5vdyB3aGljaCBkaWRuJ3QgaGF2ZSBhbnkgaXNzdWUg
dGhhdCdzDQo+IHdoeSBwbGVhc2UgcmViYXNlIHlvdXIgcGF0Y2hlcyBvbiB0aGUgdG9wIG9mIHRo
aXMgYnJhbmNoDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9YaWxpbngvbGludXgteGxueC9jb21taXRz
L3p5bnFtcC9zb2MgYW5kIHJlc2VuZC4NCj4gDQoNClJlYmFzZWQgYW5kIHNlbnQgdjYuDQoNClRo
YW5rcywNCkpvbGx5IFNoYWgNCg0KPiBUaGFua3MsDQo+IE1pY2hhbA0K
