Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6DFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE3C20834
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hBjhlIup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE3C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGDGZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:25:09 -0400
Received: from mail-pu1apc01on0129.outbound.protection.outlook.com ([104.47.126.129]:22688
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752990AbeGDGZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE8TTgFLrH6k+u8YVHi5h2YX8HPQvCh3/J/NZtADVFA=;
 b=hBjhlIupqHcgKBJ+adeKZfuKc0fN5ux23bmYX0BZRyGr7roOTTZKy0nYuj/rkX80K1fglm82+irX5XlI0FTaqpeW1TzhVhSZFv5/KPX9iqYwflPn8kaw/lY7+GZhKOD1/J4Qj9+9n8TtZNtUx2jjtjD2tn8fND/SOjnx/IMXhtA=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (10.170.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.7; Wed, 4 Jul 2018 06:24:58 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Wed, 4 Jul 2018
 06:24:58 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Topic: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Index: AQHUEg9paY7djkcpC0ykdZ+fV8ZzGaR8MHAAgAJq3IA=
Date:   Wed, 4 Jul 2018 06:24:57 +0000
Message-ID: <0551a777-880a-5019-6e9e-6c0fb5816525@microsoft.com>
References: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
 <20180702141653.88936-4-Tianyu.Lan@microsoft.com>
 <20180702172950.GA27827@linux.intel.com>
In-Reply-To: <20180702172950.GA27827@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0120;7:yZEMKh4of/MtS5kUr3et4FKMHkz4qa4TkOM74UHu3y6CRxkOs4/CNuIFa6l9aC2GSAhQPDNAGEPZwyewLElKpymldQ1uEqzp0F+oF+Jz5CK0QG3FpVO3va5pwAadOagKdqHG224ZB0zdjJnmDCNv5mCFRiUuMptcRyaAlsgP1d8Ihbf8PTsbWB66E9Yw6U6blEn9W+q/3HVzmC+4EnTwfo+NPzJdfyD+pbEur4n8we1NqElJUl4L6qCHbnpmmnRB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9202e0c-6dae-4f41-87cc-08d5e176dd70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0120;
x-ms-traffictypediagnostic: KU1P153MB0120:
x-microsoft-antispam-prvs: <KU1P153MB0120CAA0AA1CF7334F2BA9A792410@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0120;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0120;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(97736004)(22452003)(486006)(110136005)(6246003)(2900100001)(53546011)(446003)(53936002)(476003)(305945005)(6512007)(6486002)(14444005)(36756003)(2906002)(86362001)(1511001)(7416002)(5660300001)(86612001)(256004)(7736002)(316002)(11346002)(6436002)(54906003)(31696002)(66066001)(6506007)(99286004)(105586002)(8676002)(81156014)(81166006)(31686004)(2616005)(229853002)(25786009)(3846002)(26005)(14454004)(10090500001)(186003)(68736007)(6116002)(102836004)(10290500003)(72206003)(5250100002)(76176011)(4326008)(8936002)(106356001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0120;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w3g2g0vzUn5iVTrrFMZZn9wpnJ0IFskO2QAhiRXEhjmoVb1OLMC3oXBwHmYIP74HM8JkFRqN0v6Te3uTfhHKPJ9N4G+cwXpLXGwr3Y+jCClH+0oyFCioVsatXtZOz8SG5eA2P+WKrr1KomiY+M7Ck1oejs8Mpooz+TDx/SxFG+GNgpIbDIGNrOkZlMeJpjMA598FtwXsEj/conoW+rMr9GfwM9B+DIpb3C35DQ+1H399S9gl7ZjyeReW2Gb0HJWfd5BPRMxVOLa7+jObSuTP4i8YpFQqeQFRv1g+u8WEykCr1FwWH3w8mYGiELHo6OzHtQxDv2J8BXK4JdiaohJ/SpWMREA/zBmAfeUZlnM7hNQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <550A78C9D826A8438502E42CFE31501F@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9202e0c-6dae-4f41-87cc-08d5e176dd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 06:24:57.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VhbjoNCglUaGFuayBmb3IgeW91ciByZXZpZXcuDQoNCg0KT24gNy8zLzIwMTggMToyOSBB
TSwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gT24gTW9uLCBKdWwgMDIsIDIwMTggYXQg
MDI6MTc6MjlQTSArMDAwMCwgVGlhbnl1IExhbiB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggaXMgdG8g
Y2hlY2sgZXB0IHRhYmxlIHBvaW50ZXIgb2YgZWFjaCBjcHVzIHdoZW4gc2V0IGVwdA0KPj4gdGFi
bGVzIGFuZCBzdG9yZSBpZGVudGljYWwgZXB0IHRhYmxlIHBvaW50ZXIgaWYgYWxsIGVwdCB0YWJs
ZSBwb2ludGVycw0KPj4gb2Ygc2luZ2xlIFZNIGFyZSBzYW1lLiBUaGlzIGlzIGZvciBzdXBwb3J0
IG9mIHBhcmEtdmlydCBlcHQgZmx1c2gNCj4+IGh5cGVyY2FsbC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBMYW4gVGlhbnl1IDxUaWFueXUuTGFuQG1pY3Jvc29mdC5jb20+DQo+PiAtLS0NCj4+ICAg
YXJjaC94ODYva3ZtL3ZteC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rdm0vdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14LmMNCj4+IGluZGV4IDE2ODlm
NDMzZjNhMC4uMGIxZTRlOWZlZjJiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC5j
DQo+PiArKysgYi9hcmNoL3g4Ni9rdm0vdm14LmMNCj4+IEBAIC0xOTQsNiArMTk0LDkgQEAgc3Ry
dWN0IGt2bV92bXggew0KPj4gICAJdW5zaWduZWQgaW50IHRzc19hZGRyOw0KPj4gICAJYm9vbCBl
cHRfaWRlbnRpdHlfcGFnZXRhYmxlX2RvbmU7DQo+PiAgIAlncGFfdCBlcHRfaWRlbnRpdHlfbWFw
X2FkZHI7DQo+PiArDQo+PiArCXU2NCBpZGVudGljYWxfZXB0X3BvaW50ZXI7DQo+PiArCXNwaW5s
b2NrX3QgZXB0X3BvaW50ZXJfbG9jazsNCj4+ICAgfTsNCj4+ICAgDQo+PiAgICNkZWZpbmUgTlJf
QVVUT0xPQURfTVNSUyA4DQo+PiBAQCAtODUzLDYgKzg1Niw3IEBAIHN0cnVjdCB2Y3B1X3ZteCB7
DQo+PiAgIAkgKi8NCj4+ICAgCXU2NCBtc3JfaWEzMl9mZWF0dXJlX2NvbnRyb2w7DQo+PiAgIAl1
NjQgbXNyX2lhMzJfZmVhdHVyZV9jb250cm9sX3ZhbGlkX2JpdHM7DQo+PiArCXU2NCBlcHRfcG9p
bnRlcjsNCj4+ICAgfTsNCj4+ICAgDQo+PiAgIGVudW0gc2VnbWVudF9jYWNoZV9maWVsZCB7DQo+
PiBAQCAtNDk1OCw2ICs0OTYyLDI5IEBAIHN0YXRpYyB1NjQgY29uc3RydWN0X2VwdHAoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIHJvb3RfaHBhKQ0KPj4gICAJcmV0dXJuIGVw
dHA7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIHZvaWQgY2hlY2tfZXB0X3BvaW50ZXIoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZXB0cCkNCj4+ICt7DQo+PiArCXN0cnVjdCBrdm0gKmt2
bSA9IHZjcHUtPmt2bTsNCj4+ICsJdTY0IHRtcF9lcHRwID0gSU5WQUxJRF9QQUdFOw0KPj4gKwlp
bnQgaTsNCj4+ICsNCj4+ICsJc3Bpbl9sb2NrKCZ0b19rdm1fdm14KGt2bSktPmVwdF9wb2ludGVy
X2xvY2spOw0KPj4gKwl0b192bXgodmNwdSktPmVwdF9wb2ludGVyID0gZXB0cDsNCj4+ICsNCj4+
ICsJa3ZtX2Zvcl9lYWNoX3ZjcHUoaSwgdmNwdSwga3ZtKSB7DQo+PiArCQlpZiAoIVZBTElEX1BB
R0UodG1wX2VwdHApKSB7DQo+PiArCQkJdG1wX2VwdHAgPSB0b192bXgodmNwdSktPmVwdF9wb2lu
dGVyOw0KPj4gKwkJfSBlbHNlIGlmICh0bXBfZXB0cCAhPSB0b192bXgodmNwdSktPmVwdF9wb2lu
dGVyKSB7DQo+PiArCQkJdG9fa3ZtX3ZteChrdm0pLT5pZGVudGljYWxfZXB0X3BvaW50ZXIgPSBJ
TlZBTElEX1BBR0U7DQo+PiArCQkJc3Bpbl91bmxvY2soJnRvX2t2bV92bXgoa3ZtKS0+ZXB0X3Bv
aW50ZXJfbG9jayk7DQo+PiArCQkJcmV0dXJuOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiAr
CXRvX2t2bV92bXgoa3ZtKS0+aWRlbnRpY2FsX2VwdF9wb2ludGVyID0gdG1wX2VwdHA7DQo+PiAr
CXNwaW5fdW5sb2NrKCZ0b19rdm1fdm14KGt2bSktPmVwdF9wb2ludGVyX2xvY2spOw0KPj4gK30N
Cj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgdm14X3NldF9jcjMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCB1bnNpZ25lZCBsb25nIGNyMykNCj4+ICAgew0KPj4gICAJdW5zaWduZWQgbG9uZyBndWVzdF9j
cjM7DQo+PiBAQCAtNDk2Nyw2ICs0OTk0LDggQEAgc3RhdGljIHZvaWQgdm14X3NldF9jcjMoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIGNyMykNCj4+ICAgCWlmIChlbmFibGVf
ZXB0KSB7DQo+PiAgIAkJZXB0cCA9IGNvbnN0cnVjdF9lcHRwKHZjcHUsIGNyMyk7DQo+PiAgIAkJ
dm1jc193cml0ZTY0KEVQVF9QT0lOVEVSLCBlcHRwKTsNCj4+ICsJCWNoZWNrX2VwdF9wb2ludGVy
KHZjcHUsIGVwdHApOw0KPiANCj4gU2hvdWxkbid0IHRoaXMgY2FsbCwgb3IgdGhlIGZ1bmN0aW9u
IGl0c2VsZiwgYmUgY29uZGl0aW9uYWwgb24gSHlwZXItVg0KPiBvciByZW1vdGUgZmx1c2hpbmcs
IGUuZy4gYnkgY2hlY2tpbmcga3ZtX3g4Nl9vcHMtPnRsYl9yZW1vdGVfZmx1c2g/DQo+IA0KDQpZ
ZXMsIGdvb2Qgc3VnZ2VzdGlvbiBhbmQgd2lsbCB1cGRhdGUgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KPj4gKw0KPj4gICAJCWlmIChlbmFibGVfdW5yZXN0cmljdGVkX2d1ZXN0IHx8IGlzX3BhZ2lu
Zyh2Y3B1KSB8fA0KPj4gICAJCSAgICBpc19ndWVzdF9tb2RlKHZjcHUpKQ0KPj4gICAJCQlndWVz
dF9jcjMgPSBrdm1fcmVhZF9jcjModmNwdSk7DQo+PiBAQCAtMTAzODMsNiArMTA0MTIsOCBAQCBz
dGF0aWMgc3RydWN0IGt2bV92Y3B1ICp2bXhfY3JlYXRlX3ZjcHUoc3RydWN0IGt2bSAqa3ZtLCB1
bnNpZ25lZCBpbnQgaWQpDQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IHZteF92bV9pbml0KHN0cnVj
dCBrdm0gKmt2bSkNCj4+ICAgew0KPj4gKwlzcGluX2xvY2tfaW5pdCgmdG9fa3ZtX3ZteChrdm0p
LT5lcHRfcG9pbnRlcl9sb2NrKTsNCj4+ICsNCj4+ICAgCWlmICghcGxlX2dhcCkNCj4+ICAgCQlr
dm0tPmFyY2gucGF1c2VfaW5fZ3Vlc3QgPSB0cnVlOw0KPj4gICAJcmV0dXJuIDA7DQo+PiAtLSAN
Cj4+IDIuMTQuMw==
