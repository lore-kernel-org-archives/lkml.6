Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7514C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F5C208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cFhWOI1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F5C208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755017AbeFNKOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:14:01 -0400
Received: from mail-sg2apc01on0123.outbound.protection.outlook.com ([104.47.125.123]:63903
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754967AbeFNKN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM6uDlzyMQLH1S+Kjj9zhL8W+2fYdEAdACSDnhQDQlY=;
 b=cFhWOI1A/SFKn6JFS5IUuc7N8caTFqyVrbgLuQ0uf64lRqxrABOGeN7iUJPEgbiGf6dimpex5zj/ukMyuPqXdtbboaDy1a10/RXCr2s6bte/1R1HlMAeOTyDac4e8bkNcmdsJPH1NgFbxp5x0nJw2/FqDhePcYVDzPfaBQFjjZQ=
Received: from SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM (10.170.136.18) by
 SG2P15301MB0029.APCP153.PROD.OUTLOOK.COM (10.170.135.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 10:13:51 +0000
Received: from SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cae:4bd:cf5d:6e8d]) by SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cae:4bd:cf5d:6e8d%5]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 10:13:51 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support
 for vmcs
Thread-Topic: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support
 for vmcs
Thread-Index: AQHT++OdAN2+GrZK4EuBP0Cwrph5uaRcx7edgALROgA=
Date:   Thu, 14 Jun 2018 10:13:46 +0000
Message-ID: <f868a339-03fc-4ba6-4882-4bb6232f599d@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
 <20180604090749.489-4-Tianyu.Lan@microsoft.com>
 <87h8m8qbso.fsf@vitty.brq.redhat.com>
In-Reply-To: <87h8m8qbso.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0029;7:wbHAo2PeTqiuI+LLMfIHNhpCBmUu+J5XF666z0yn5kbhB+KPxNnfuSBmUv5gjigcd8EPzBi8rhzfZbykGtEu41bNGiKH3nqaBkBHjPMnpO00Dg1wbC8ICfyW8RO1I+DtYZzjt5ywv0im4bNCtpRGR6fFt4ky4p9+OQpIqdV00RqwkLoIZhmggk8tBlIlGEaQECAFMkVRUg1aa6iJZVJ2ywIHxT9JLJx6igM3Di9lrBcFa4vaIEjkC4tCne0Zp97f
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b80426b1-45ad-4eb9-22ea-08d5d1df8714
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7193020);SRVR:SG2P15301MB0029;
x-ms-traffictypediagnostic: SG2P15301MB0029:
x-microsoft-antispam-prvs: <SG2P15301MB0029F15F1153340FE3DA5EFA927D0@SG2P15301MB0029.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0029;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0029;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(5250100002)(25786009)(53936002)(76176011)(105586002)(106356001)(110136005)(22452003)(4326008)(66066001)(316002)(6116002)(3846002)(1511001)(6666003)(53546011)(186003)(102836004)(6506007)(59450400001)(26005)(10090500001)(5660300001)(2616005)(476003)(486006)(54906003)(11346002)(446003)(99286004)(6246003)(107886003)(14454004)(8936002)(2900100001)(97736004)(68736007)(10290500003)(7736002)(3280700002)(305945005)(86362001)(478600001)(2906002)(31696002)(86612001)(3660700001)(72206003)(31686004)(6512007)(6436002)(6486002)(229853002)(36756003)(8676002)(81166006)(81156014)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0029;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5LmRBKVpCFF1yAh9hy+jOt8EZ47bgZ9pp73esUPzuZaNhwPATDuXPhWOZS3Uvlt80vcO85jdCKMsqmNxjOAMu9x5f+CymgAwDbxkM1dyjaR+cMJqeIk3yoCHcv1HDnZzIAALO2DgQM5qaLgIuZ31OoorqH4JhTqP4Hj2ccqadyajI1PqryJfuvBKJFHEpRo1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8094FC9BCBDC3244A95B3227EE965750@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80426b1-45ad-4eb9-22ea-08d5d1df8714
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 10:13:46.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0YWx5Og0KCVRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIDYvMTIvMjAxOCAxMTox
MiBQTSwgVml0YWx5IEt1em5ldHNvdiB3cm90ZToNCj4gVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBt
aWNyb3NvZnQuY29tPiB3cml0ZXM6DQo+IA0KPj4gUmVnaXN0ZXIgdGxiX3JlbW90ZV9mbHVzaCBj
YWxsYmFjayBmb3Igdm1jcyB3aGVuIGh5cGVydiBjYXBhYmlsaXR5IG9mDQo+PiBuZXN0ZWQgZ3Vl
c3QgbWFwcGluZyBmbHVzaCBpcyBkZXRlY3RlZC4gVGhlIGludGVyZmFjZSBjYW4gaGVscCB0byBy
ZWR1Y2UNCj4+IG92ZXJoZWFkIHdoZW4gZmx1c2ggZXB0IHRhYmxlIGFtb25nIHZjcHVzIGZvciBu
ZXN0ZWQgVk0uIFRoZSB0cmFkaXRpb24gd2F5DQo+PiBpcyB0byBzZW5kIElQSXMgdG8gYWxsIGFm
ZmVjdGVkIHZjcHVzIGFuZCBleGVjdXRlcyBJTlZFUFQgb24gZWFjaCB2Y3B1cy4NCj4+IEl0IHdp
bGwgdHJpZ2dlciBzZXZlcmFsIHZtZXhpdHMgZm9yIElQSSBhbmQgSU5WRVBUIGVtdWxhdGlvbi4g
SHlwZXJ2IHByb3ZpZGVzDQo+PiBzdWNoIGh5cGVyY2FsbCB0byBkbyBmbHVzaCBmb3IgYWxsIHZj
cHVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhbiBUaWFueXUgPFRpYW55dS5MYW5AbWljcm9z
b2Z0LmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9rdm0vdm14LmMgfCAxNSArKysrKysrKysr
KysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC5jDQo+PiBpbmRl
eCBlNTBiZWI3NmQ4NDYuLjZjYjI0MWMwNTY5MCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2t2
bS92bXguYw0KPj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jDQo+PiBAQCAtNDczNyw2ICs0NzM3
LDE3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3ZteF9mbHVzaF90bGIoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBpbnQgdnBpZCwNCj4+ICAgCX0NCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZt
eF9yZW1vdGVfZmx1c2hfdGxiKHN0cnVjdCBrdm0gKmt2bSkNCj4+ICt7DQo+PiArCXN0cnVjdCBr
dm1fdmNwdSAqdmNwdSA9IGt2bV9nZXRfdmNwdShrdm0sIDApOw0KPj4gKw0KPj4gKwlpZiAoIVZB
TElEX1BBR0UodmNwdS0+YXJjaC5tbXUucm9vdF9ocGEpKQ0KPj4gKwkJcmV0dXJuIC0xOw0KPiAN
Cj4gV2h5IHZjcHUwPyBDYW4gYXJjaC5tbXUucm9vdF9ocGEtcyBkaWZmZXIgYWNyb3NzIHZDUFVz
PyBXaGF0IGhhcHBlbnMgaWYNCj4gdGhleSBkbz8NCg0KWWVzLCBpdCBtYXkgdGFrZSBwbGFjZSB0
aGF0IGFyY2gubW11LnJvb3RfaHBhIGlzIGRpZmZlciBhY3Jvc3MgdkNQVXMuDQpXZSBtYXkgY2hl
Y2sgYWxsIHZjcHUgcm9vdF9ocGEgYW5kIHVzZSB0aGUgaHlwZXJjYWxsIHdoZW4gdGhlcmUgaXMg
b25seSANCm9uZSB2YWxpZGF0ZWQgZXB0IHRhYmxlLiBJZiBub3QsIGdvIGJhY2sgdG8gY3VycmVu
dCB3YXkuDQoNCnN0YXRpYyBpbnQgaHZfcmVtb3RlX2ZsdXNoX3RsYigpDQp7DQogICAgICAgICBz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHU7DQogICAgICAgICB1NjQgcm9vdF9ocGEgPSBJTlZBTElEX1BB
R0U7DQogICAgICAgICBpbnQgaTsNCg0KICAgICAgICAga3ZtX2Zvcl9lYWNoX3ZjcHUoaSwgdmNw
dSwga3ZtKSB7DQogICAgICAgICAgICAgICAgIGlmICghVkFMSURfUEFHRSh2Y3B1LT5hcmNoLm1t
dS5yb290X2hwYSkpDQogICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQoNCiAgICAg
ICAgICAgICAgICAgaWYgKCFWQUxJRF9QQUdFKHJvb3RfaHBhKSkNCiAgICAgICAgICAgICAgICAg
ICAgICAgICByb290X2hwYSA9IHZjcHUtPmFyY2gubW11LnJvb3RfaHBhOw0KICAgICAgICAgICAg
ICAgICBlbHNlIGlmIChyb290X2hwYSAhPSB2Y3B1LT5hcmNoLm1tdS5yb290X2hwYSkgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCiAgICAgICAgICAgICAgICAgfQ0KICAg
ICAgICAgfQ0KDQogICAgICAgICBpZiAoIVZBTElEX1BBR0Uocm9vdF9ocGEpKQ0KICAgICAgICAg
ICAgICAgICByZXR1cm4gLTE7DQoNCiAgICAgICAgIHJldHVybiBoeXBlcnZfZmx1c2hfZ3Vlc3Rf
bWFwcGluZyhjb25zdHJ1Y3RfZXB0cCh2Y3B1LA0KICAgICAgICAgICAgICAgICByb290X2hwYSkp
Ow0KfQ0KDQoNCj4gDQo+PiArDQo+PiArCXJldHVybiBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGlu
Zyhjb25zdHJ1Y3RfZXB0cCh2Y3B1LA0KPj4gKwkJdmNwdS0+YXJjaC5tbXUucm9vdF9ocGEpKTsN
Cj4+ICt9DQo+IA0KPiBUaGUgJ3ZteF9yZW1vdGVfZmx1c2hfdGxiJyBuYW1lIGxvb2tzIGdlbmVy
aWMgZW5vdWdoIGJ1dCBpdCBpcyBhY3R1YWxseQ0KPiBIeXBlci1WLXNwZWNpZmljLiBJJ2Qgc3Vn
Z2VzdCByZW5hbWluZyB0byBzb21ldGhpbmcgbGlrZQ0KPiBodl9yZW1vdGVfZmx1c2hfdGxiKCku
DQo+IA0KPj4gKw0KPj4gICBzdGF0aWMgdm9pZCB2bXhfZmx1c2hfdGxiKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgYm9vbCBpbnZhbGlkYXRlX2dwYSkNCj4+ICAgew0KPj4gICAJX192bXhfZmx1c2hf
dGxiKHZjcHUsIHRvX3ZteCh2Y3B1KS0+dnBpZCwgaW52YWxpZGF0ZV9ncGEpOw0KPj4gQEAgLTc0
OTUsNiArNzUwNiwxMCBAQCBzdGF0aWMgX19pbml0IGludCBoYXJkd2FyZV9zZXR1cCh2b2lkKQ0K
Pj4gICAJaWYgKGVuYWJsZV9lcHQgJiYgIWNwdV9oYXNfdm14X2VwdF8ybV9wYWdlKCkpDQo+PiAg
IAkJa3ZtX2Rpc2FibGVfbGFyZ2VwYWdlcygpOw0KPj4NCj4+ICsJaWYgKG1zX2h5cGVydi5uZXN0
ZWRfZmVhdHVyZXMgJiBIVl9YNjRfTkVTVEVEX0dVU0VUX01BUFBJTkdfRkxVU0gNCj4+ICsJICAg
ICYmIGVuYWJsZV9lcHQpDQo+PiArCQlrdm1feDg2X29wcy0+dGxiX3JlbW90ZV9mbHVzaCA9IHZt
eF9yZW1vdGVfZmx1c2hfdGxiOw0KPj4gKw0KPj4gICAJaWYgKCFjcHVfaGFzX3ZteF9wbGUoKSkg
ew0KPj4gICAJCXBsZV9nYXAgPSAwOw0KPj4gICAJCXBsZV93aW5kb3cgPSAwOw0KPiA=
