Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A155C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EA0206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeK2BpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:01 -0500
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:24720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeK2BpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+ggN5JeIRB+P3lMdR1qYBMc9FQSAmmo/HD1uTRiMk=;
 b=N3Ce4URY7aqDLa94I2OoVQu2+IDUrrS0FxblJeuaqAyhqF40bmZYEW9Pexu9r7UYXqu5ED9YWWSptLuUEwJhbJYUZw23yPm3piUEZogPgBcjEj6yRLwJbqA2L+LA+n5fheAJM3vBOFuJl+JVwW0ZlPfItoAb/lZIf26aiwbXTWY=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5182.namprd07.prod.outlook.com (52.135.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:03 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:02 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Topic: [PATCH v2 00/10] irqdomain, gic-v3-its: Implement late irq
 domain initialization
Thread-Index: AQHUhyiqlMdEsFpCz0uB8aDmjfRnhg==
Date:   Wed, 28 Nov 2018 14:43:02 +0000
Message-ID: <20181128144240.28727-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.14.124.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5182;6:wdFxme+Sb2zkJoJCSqM1JGLzHxYa4js2DNnJ9rng072Ds87/fHje0XbG2JkKeQW9RAuUFnj6K5gNBfvQ1uz8VFNsy2R1PUcFLsuItVvpFzhjsnIQc/8oz25M4RJbqD+54qNDvQErE69t9xeCYDkpUv1QEjIlw02BKMats9lQqtybUssM2eZ9VCQD016w/ilBiogKbVoGrlNjXtYKSdqkQCHeYzsdKyQqJ6T1YnEjEM6QZ1+T0prAo6gWBOcMFox4qfJqiIeX3autQh9YVrfqwHMEiyN7VUl1YImveGjFY09KrfgeNXlOplg+lOkigOtbRJLlEjRZnOfl/gUApfd6qA6kAIH5DphJ8EYpXNurOX+oyHPW4Ig2zVS5M9JM95+IhqdTMCrJhV1cUK03StgO3E+waQmL0b8CbhNqWa3ifs3Gae6wjjkFatXuErSFEeZDhwQNnBHxYHNeJtPSJ+WHtA==;5:B/+BWufQye9gBOgykg/QPjQbw6kXuu0FJOBIV+cZGSR4s2cVpj3+bIoVi+zoLPml5rSQe1+ZJdxoBv7OW/ObWlIUK0VKfaybwB5DARP5PLUTBwgV1whCi1pajrYVFlGEcsrpKnm6+bkycBu7LjRwt6j81VwPcJJPLbjmARbJFCc=;7:+xKf3G9h/GIYJwEb30nVv7GpSdk4fUP3m1+v+seaPe1iexohAVsWwxMImuSqSjNFXud0Fi7jsNEGSoUr3Vb1BY+FkDQNrwd9kpfCfFRvb39q5w9mROLSX1gYT2TYP4B8JsIQr+i2qjox6BGbjv4VAQ==
x-ms-office365-filtering-correlation-id: 1a1f6797-2a9d-4093-21ec-08d6553fccbf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5182;
x-ms-traffictypediagnostic: SN6PR07MB5182:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-microsoft-antispam-prvs: <SN6PR07MB5182BD9FBA886B5924BA976AF1D10@SN6PR07MB5182.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5182;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5182;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(7416002)(5660300001)(6436002)(36756003)(54906003)(39060400002)(110136005)(6116002)(3846002)(53936002)(97736004)(52116002)(102836004)(4326008)(476003)(316002)(14454004)(2616005)(71190400001)(71200400001)(6512007)(1076002)(6506007)(7736002)(305945005)(486006)(81156014)(81166006)(386003)(72206003)(2906002)(99286004)(68736007)(8936002)(478600001)(106356001)(186003)(105586002)(6486002)(14444005)(66066001)(26005)(25786009)(256004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5182;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2mhawP3HGWX3drmi/fwo0kE6bJpmq9OpEPac+KwpitAvONQSl25gvSXvk6gTVce+88RjXDNkCHf+gPAcW8TorhOpJLHBkOpSQFlrCIgi8ZDbR7ERTYZdx+90E52980x1/IKzLtfG86a7wsYgBcRYUQ3xEODQq82Sl5xaM1cCNZYoo858qiSp+YhW0PRfQfvGTcHFTcD9ACoRlnFFH8Fn/cqCk6tpkQ6luc0DMhcNBeUV4bjX4rwg9K643/9fL2qlyH1WxBdT9aiUoyXaeJWrN2nIko9spdC3mcAB4XCWIR0IbSeRVAwBRiyNuHcfmUps81B0IGP0UFxuU6dDKMfKrzYrU0TvkqUl9T4Gw3k9c8w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3072BA1FA4EA3419AB5DC7C43FB3240@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f6797-2a9d-4093-21ec-08d6553fccbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:02.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaXMgYSByZXdvcmsgb2YgdGhlIGdpYy12My1pdHMgaW5pdGlhbGl6
YXRpb24uIEl0IGlzDQppbiBwcmVwYXJhdGlvbiBvZiBhIGZ1cnRoZXIgc2VyaWVzIHRoYXQgdXNl
cyBDTUEgbWVtb3J5IGFsbG9jYXRpb24gZm9yDQpJVFMgdGFibGVzLiBGb3IgdGhpcyB0aGUgQ01B
IGZyYW1ld29yayBtdXN0IGJlIGF2YWlsYWJsZSBhbmQgdGh1cyBJVFMNCm5lZWRzIHRvIGJlIGlu
aXRpYWxpemVkIGFmdGVyIHRoZSBhcmNoX2luaXRjYWxscy4gVGhpcyByZXF1aXJlcyB0d28NCm1h
am9yIHJld29ya3MuDQoNCkZpcnN0IHdlIG11c3QgcmVtb3ZlIGFsbCBpcnEgZG9tYWluIGluaXQg
b3JkZXIgZGVwZW5kZW5jaWVzIChwYXRjaGVzDQojMS0jNSksIHNlY29uZCB0aGUgSVRTIGluaXRp
YWxpemF0aW9uIG11c3QgYmUgc3BsaXQgaW50byBhbiBlYXJseQ0KcHJvYmUgYW5kIGEgbGF0ZXIg
aW5pdCBwYXJ0IChwYXRjaGVzICM2LSMxMCkuDQoNClBhdGNoICMxIGludHJvZHVjZXMgYSBuZXcg
aW50ZXJmYWNlIHRvIHJlcXVlc3QgYW4gaXJxIGRvbWFpbiwgc2VlIHRoZQ0KcGF0Y2ggZGVzY3Jp
cHRpb24gZm9yIGRldGFpbHMuIEluIHBhdGNoZXMgIzItIzUgYWxsIElUUyByZWxhdGVkIGlycQ0K
ZG9tYWlucyBhcmUgY29udmVydGVkIHRvIHVzZSB0aGUgbmV3IGludGVyZmFjZS4gVGhlcmUgYXJl
IG5vIG9yZGVyDQpkZXBlbmRlbmNpZXMgZm9yIHBhcmVudCBhbmQgY2xpZW50IGlycSBkb21haW4g
aW5pdGlhbGl6YXRpb24gYW55bW9yZQ0Kd2hpY2ggYWxsb3dzIHVzIHRvIGluaXRpYWxpemUgYWxs
IElUUyBpcnEgZG9tYWlucyBpbiB0aGUgc2FtZSBpbml0Y2FsbA0KKG1vdmluZyB0byB0aGUgbGF0
ZXIgc3Vic3lzX2luaXRjYWxsKS4gTm90ZSB0aGF0IEkgZG8gbm90IGhhdmUgZnNsDQpoYXJkd2Fy
ZSBhdmFpbGFibGUsIHRoZSBjb2RlIHNob3VsZCB3b3JrLCBidXQgaXMgb25seSBjYXJlZnVsbHkN
CnJldmlld2VkIGFuZCBjb21waWxlIHRlc3RlZCwgcGxlYXNlIHRlc3Qgb24gdGhhdCBoYXJkd2Fy
ZS4NCg0KVGhlIHJlbWFpbmluZyBwYXRjaGVzICM2LSMxMCBhcmUgYW4gaW5jcmVtZW50YWwgcmV3
b3JrIG9mIHRoZSBJVFMNCmluaXRpYWxpemF0aW9uLCBiYXNpY2FsbHkgc3BsaXR0aW5nIHByb2Jl
IGFuZCBpbml0IChwYXRjaCAjNykgYW5kDQpzZXBhcmF0aW5nIGl0IGZyb20gZ2ljLXYzIGNvZGUg
KHBhdGNoICM4KS4gUGF0Y2hlcyAjOSBhbmQgIzEwIGNoYW5nZQ0KaW5pdGNhbGwgbGV2ZWxzIGZv
ciB2YXJpb3VzIGRyaXZlcnMuDQoNClBhdGNoZXMgaGF2ZSBiZWVuIHRlc3RlZCB3aXRoIENhdml1
bSBUaHVuZGVyWCBhbmQgVGh1bmRlclgyLiBJIGhhdmUgYW4NCmltcGxlbWVudGF0aW9uIG9mIENN
QSBJVFMgdGFibGUgYWxsb2NhdGlvbiBvbiB0b3Agb2YgdGhpcyBzZXJpZXMNCmF2YWlsYWJsZSwg
SSB3aWxsIHNlbmQgb3V0IHBhdGNoZXMgZm9yIHRoaXMgaW4gYSBjb3VwbGUgb2YgZGF5cy4NCg0K
djI6DQogKiBmaXggY2hlY2sgZm9yIGRvbWFpbiBtYXRjaCBpbiBpcnFfZG9tYWluX2hhbmRsZV9y
ZXF1ZXN0cygpDQogKiBhZGQgY29tbWVudCB0aGF0IGRlc2NyaWJlcyB0aGlzIGNoZWNrIGluIGly
cV9kb21haW5faGFuZGxlXw0KICAgcmVxdWVzdHMoKQ0KDQpSb2JlcnQgUmljaHRlciAoMTApOg0K
ICBpcnFkb21haW46IEFkZCBpbnRlcmZhY2UgdG8gcmVxdWVzdCBhbiBpcnEgZG9tYWluDQogIGly
cWNoaXAvZ2ljLXYzLWl0cy1wbGF0Zm9ybS1tc2k6IFJlbW92ZSBkb21haW4gaW5pdCBvcmRlciBk
ZXBlbmRlbmNpZXMNCiAgaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy1wY2ktbXNpOiBSZW1vdmUgZG9t
YWluIGluaXQgb3JkZXIgZGVwZW5kZW5jaWVzDQogIGlycWNoaXAvaXJxLWdpYy12My1pdHMtZnNs
LW1jLW1zaTogUmVtb3ZlIGRvbWFpbiBpbml0IG9yZGVyDQogICAgZGVwZW5kZW5jaWVzDQogIGZz
bC1tYy9kcHJjLWRyaXZlcjogUmVtb3ZlIGRvbWFpbiBpbml0IG9yZGVyIGRlcGVuZGVuY2llcw0K
ICBpcnFjaGlwL2dpYy12My1pdHM6IEluaXRpYWxpemUgaXRzIG5vZGVzIGluIHByb2JlIG9yZGVy
DQogIGlycWNoaXAvZ2ljLXYzLWl0czogU3BsaXQgcHJvYmluZyBmcm9tIGl0cyBub2RlIGluaXRp
YWxpemF0aW9uDQogIGlycWNoaXAvZ2ljLXYzLWl0czogRGVjb3VwbGUgaXRzIGluaXRpYWxpemF0
aW9uIGZyb20gZ2ljDQogIGlycWNoaXAvZ2ljLXYzLWl0czogSW5pdGlhbGl6ZSBpdHMgbm9kZXMg
bGF0ZXINCiAgaXJxY2hpcC9naWMtdjMtaXRzOiBJbml0aWFsaXplIE1TSXMgd2l0aCBzdWJzeXNf
aW5pdGNhbGxzDQoNCiBkcml2ZXJzL2J1cy9mc2wtbWMvZHByYy1kcml2ZXIuYyAgICAgICAgICAg
ICAgfCAgNDEgKysrKysrKw0KIGRyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtbXNpLmMgICAgICAg
ICAgICAgICB8ICAgNiArLQ0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy1mc2wtbWMt
bXNpLmMgICB8ICA0OSArKysrKy0tLQ0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy1w
Y2ktbXNpLmMgICAgICB8ICA2OCArKysrKystLS0tLQ0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2lj
LXYzLWl0cy1wbGF0Zm9ybS1tc2kuYyB8ICA1NiArKysrKysrLS0NCiBkcml2ZXJzL2lycWNoaXAv
aXJxLWdpYy12My1pdHMuYyAgICAgICAgICAgICAgfCAxNjAgKysrKysrKysrKysrKysrKy0tLS0t
LS0tLQ0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgICAgICAgICAgICAgICAgICB8ICAx
MiArLQ0KIGluY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oICAgICAgICAgICAgICAgICAgICB8ICAg
MSArDQogaW5jbHVkZS9saW51eC9pcnFjaGlwL2FybS1naWMtdjMuaCAgICAgICAgICAgIHwgICA1
ICstDQogaW5jbHVkZS9saW51eC9pcnFkb21haW4uaCAgICAgICAgICAgICAgICAgICAgIHwgIDE1
ICsrKw0KIGtlcm5lbC9pcnEvaXJxZG9tYWluLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDE2
MyArKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDExIGZpbGVzIGNoYW5nZWQsIDQ0NiBpbnNl
cnRpb25zKCspLCAxMzAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xMS4wDQoNCg==
