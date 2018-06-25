Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F5BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3C208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VrhKk7Eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D3C208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933724AbeFYV3W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:29:22 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:60768
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752162AbeFYV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goloDcW1OLveu/PmB4Twl0ojGrABUH8wY5fyhqLdmVU=;
 b=VrhKk7EqyXZ5J4HfQQkP2IaVuCm4Xm3sSUf/WlCdBo2yhqtAdhOtpiP/J8svfUxjzNEimY733RqiA285VbcqEZL+977EVLZBA2rz4D+eNKqQ6j8ub3DImqPZn75bl1/djq2e9JWEXo/yVp5UEcHRiypdXcAyfB+8eJ5iLXWH8Bo=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0867.namprd21.prod.outlook.com (52.132.102.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Mon, 25 Jun 2018 21:29:18 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 21:29:18 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 09/15] CIFS: SMBD: Support page offset in RDMA recv
Thread-Topic: [Patch v2 09/15] CIFS: SMBD: Support page offset in RDMA recv
Thread-Index: AQHT+E9ghGNh0PZBUEyG6Dma8OJ1MaRu0gmAgALTEdA=
Date:   Mon, 25 Jun 2018 21:29:17 +0000
Message-ID: <CY4PR2101MB07221AFF7B75D21C00C60035CE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-10-longli@linuxonhyperv.com>
 <1e6b7cb0-98e8-d1fd-cb59-d3344fc70b19@talpey.com>
In-Reply-To: <1e6b7cb0-98e8-d1fd-cb59-d3344fc70b19@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0867;7:7SXRyy2baRu2BzeXGY04Ebbzzt2Q/eDChj1tlAlrEFQX30IxA65XsD8csU2f4mvK1c/3Sa3zqgQS6mj89DsipyuLOTFCDp4B7KOrFHBRf7H16xjEg2YhAuoIJhYb5XdejfpmYQdjvS1miXe6gvNtNXSNiJMq0UAGHTuMIjNEqz++YNyYbV1zcSwwcnrOn/QmmXVvCCpMv93OUuzHpfCNEpUIBVxrOlS4LSqesNyWjb7vovtQdqE+jDbD9TGyvymm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9f2e94c-c5ca-4f9e-7baf-08d5dae2b53e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0867;
x-ms-traffictypediagnostic: CY4PR2101MB0867:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR2101MB08672B6AE8015FDC463EB83CCE4A0@CY4PR2101MB0867.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0867;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0867;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(6436002)(10090500001)(11346002)(7736002)(305945005)(106356001)(74316002)(2900100001)(446003)(14454004)(10290500003)(256004)(14444005)(229853002)(478600001)(105586002)(55016002)(9686003)(6116002)(68736007)(81166006)(97736004)(99286004)(486006)(5660300001)(8676002)(2201001)(6506007)(25786009)(81156014)(53546011)(33656002)(102836004)(46003)(476003)(8936002)(8990500004)(186003)(2906002)(316002)(53936002)(2501003)(22452003)(76176011)(7696005)(86612001)(86362001)(110136005)(6246003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0867;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t+IuU241jfVYoIj/4hmZP3TrqR76dem99z4hNN/BbZg591zjppaKeTdProgMKhc+wahT8v4+hD7RD1+duHb7bx14RYbhX9c7vjCFlkjAgki2AasectJdAoIy8p700UnhbF6uFOpihM0wSoZBzZyE6hNdJClmScS5Ipeuwv5YHXKapdVOl1jXePLfvemskUavNcHwjEoSXXXoMFSkqBIbe99daBhzjdmK3rXuoohPwkJ03XWcXiz5bEUSUbC8P/lasNDxzA/0fIdk/+3fjLPNCA1+XElAWu4hFykuIPrCH8NFOucixvUGTLoRLHT43d1XaUVNcexWADmNoEQyQa9aWzLDrGJAvnBdjiQkhg4Rdd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f2e94c-c5ca-4f9e-7baf-08d5dae2b53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 21:29:17.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA5LzE1XSBDSUZTOiBTTUJEOiBTdXBwb3J0IHBhZ2Ug
b2Zmc2V0IGluIFJETUEgcmVjdg0KPiANCj4gT24gNS8zMC8yMDE4IDM6NDggUE0sIExvbmcgTGkg
d3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4g
PiBSRE1BIHJlY3YgZnVuY3Rpb24gbmVlZHMgdG8gcGxhY2UgZGF0YSB0byB0aGUgY29ycmVjdCBw
bGFjZSBzdGFydGluZw0KPiA+IGF0IHBhZ2Ugb2Zmc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBmcy9jaWZz
L3NtYmRpcmVjdC5jIHwgMTggKysrKysrKysrKystLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9mcy9jaWZzL3NtYmRpcmVjdC5jIGIvZnMvY2lmcy9zbWJkaXJlY3QuYyBpbmRleA0KPiA+IDYx
NDFlM2MuLmJhNTNjNTIgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvY2lmcy9zbWJkaXJlY3QuYw0KPiA+
ICsrKyBiL2ZzL2NpZnMvc21iZGlyZWN0LmMNCj4gPiBAQCAtMjAwNCwxMCArMjAwNCwxMiBAQCBz
dGF0aWMgaW50IHNtYmRfcmVjdl9idWYoc3RydWN0DQo+IHNtYmRfY29ubmVjdGlvbiAqaW5mbywg
Y2hhciAqYnVmLA0KPiA+ICAgICogcmV0dXJuIHZhbHVlOiBhY3R1YWwgZGF0YSByZWFkDQo+ID4g
ICAgKi8NCj4gPiAgIHN0YXRpYyBpbnQgc21iZF9yZWN2X3BhZ2Uoc3RydWN0IHNtYmRfY29ubmVj
dGlvbiAqaW5mbywNCj4gPiAtCQlzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IHRvX3Jl
YWQpDQo+ID4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGludCBwYWdlX29mZnNldCwN
Cj4gPiArCQl1bnNpZ25lZCBpbnQgdG9fcmVhZCkNCj4gPiAgIHsNCj4gPiAgIAlpbnQgcmV0Ow0K
PiA+ICAgCWNoYXIgKnRvX2FkZHJlc3M7DQo+ID4gKwl2b2lkICpwYWdlX2FkZHJlc3M7DQo+ID4N
Cj4gPiAgIAkvKiBtYWtlIHN1cmUgd2UgaGF2ZSB0aGUgcGFnZSByZWFkeSBmb3IgcmVhZCAqLw0K
PiA+ICAgCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZSgNCj4gPiBAQCAtMjAxNSwxNiAr
MjAxNywxNyBAQCBzdGF0aWMgaW50IHNtYmRfcmVjdl9wYWdlKHN0cnVjdA0KPiBzbWJkX2Nvbm5l
Y3Rpb24gKmluZm8sDQo+ID4gICAJCWluZm8tPnJlYXNzZW1ibHlfZGF0YV9sZW5ndGggPj0gdG9f
cmVhZCB8fA0KPiA+ICAgCQkJaW5mby0+dHJhbnNwb3J0X3N0YXR1cyAhPSBTTUJEX0NPTk5FQ1RF
RCk7DQo+ID4gICAJaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiArCQlyZXR1cm4gcmV0
Ow0KPiA+DQo+ID4gICAJLyogbm93IHdlIGNhbiByZWFkIGZyb20gcmVhc3NlbWJseSBxdWV1ZSBh
bmQgbm90IHNsZWVwICovDQo+ID4gLQl0b19hZGRyZXNzID0ga21hcF9hdG9taWMocGFnZSk7DQo+
ID4gKwlwYWdlX2FkZHJlc3MgPSBrbWFwX2F0b21pYyhwYWdlKTsNCj4gPiArCXRvX2FkZHJlc3Mg
PSAoY2hhciAqKSBwYWdlX2FkZHJlc3MgKyBwYWdlX29mZnNldDsNCj4gPg0KPiA+ICAgCWxvZ19y
ZWFkKElORk8sICJyZWFkaW5nIGZyb20gcGFnZT0lcCBhZGRyZXNzPSVwIHRvX3JlYWQ9JWRcbiIs
DQo+ID4gICAJCXBhZ2UsIHRvX2FkZHJlc3MsIHRvX3JlYWQpOw0KPiA+DQo+ID4gICAJcmV0ID0g
c21iZF9yZWN2X2J1ZihpbmZvLCB0b19hZGRyZXNzLCB0b19yZWFkKTsNCj4gPiAtCWt1bm1hcF9h
dG9taWModG9fYWRkcmVzcyk7DQo+ID4gKwlrdW5tYXBfYXRvbWljKHBhZ2VfYWRkcmVzcyk7DQo+
IA0KPiBJcyAicGFnZSIgdHJ1bHkgbm90IG1hcHBlZD8gVGhpcyBrbWFwL2t1bm1hcCBmb3IgZWFj
aCByZWNlaXZlZCA0S0IgaXMgdmVyeQ0KPiBleHBlbnNpdmUuIElzIHRoZXJlIG5vdCBhIHdheSB0
byBrZWVwIGEga3ZhIGZvciB0aGUgcmVhc3NlbWJseSBxdWV1ZQ0KPiBzZWdtZW50cz8NCg0KSSB3
aWxsIGZpbmQgYSB3YXkgdG8gbm90IG1hcCB0aG9zZSB1cHBlciBsYXllciBwYWdlcyB3aGVuIGRv
aW5nIFJETUEgcmVjZWl2ZS4gVGhlIHJlYXNvbiBmb3IgZG9pbmcgdGhpcyBpcyB0byB1c2UgYSBj
b21tb24gbGF5ZXIgKHRoYXQgd2lsbCBncmVhdGx5IHNpbXBsaWZpZXMgdGhlIGNvZGUpIGZvciB0
cmFuc3BvcnQuIEl0J3MgcHJvYmFibHkgYSB3YXN0ZSBvZiB0aW1lIHdoZW4gb25seSBwYWdlcyBh
cmUgaW52b2x2ZWQsIGFuZCBub3QgbmVlZCB0byBiZSBtYXBwZWQuDQoNCkkgd2lsbCBhZGRyZXNz
IHRob3NlIGluIGEgc2VwYXJhdGUgcGF0Y2guDQoNCj4gDQo+ID4NCj4gPiAgIAlyZXR1cm4gcmV0
Ow0KPiA+ICAgfQ0KPiA+IEBAIC0yMDM4LDcgKzIwNDEsNyBAQCBpbnQgc21iZF9yZWN2KHN0cnVj
dCBzbWJkX2Nvbm5lY3Rpb24gKmluZm8sDQo+IHN0cnVjdCBtc2doZHIgKm1zZykNCj4gPiAgIHsN
Cj4gPiAgIAljaGFyICpidWY7DQo+ID4gICAJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gLQl1bnNp
Z25lZCBpbnQgdG9fcmVhZDsNCj4gPiArCXVuc2lnbmVkIGludCB0b19yZWFkLCBwYWdlX29mZnNl
dDsNCj4gPiAgIAlpbnQgcmM7DQo+ID4NCj4gPiAgIAlpbmZvLT5zbWJkX3JlY3ZfcGVuZGluZysr
Ow0KPiA+IEBAIC0yMDUyLDE1ICsyMDU1LDE2IEBAIGludCBzbWJkX3JlY3Yoc3RydWN0IHNtYmRf
Y29ubmVjdGlvbiAqaW5mbywNCj4gPiBzdHJ1Y3QgbXNnaGRyICptc2cpDQo+ID4NCj4gPiAgIAlj
YXNlIFJFQUQgfCBJVEVSX0JWRUM6DQo+ID4gICAJCXBhZ2UgPSBtc2ctPm1zZ19pdGVyLmJ2ZWMt
PmJ2X3BhZ2U7DQo+ID4gKwkJcGFnZV9vZmZzZXQgPSBtc2ctPm1zZ19pdGVyLmJ2ZWMtPmJ2X29m
ZnNldDsNCj4gPiAgIAkJdG9fcmVhZCA9IG1zZy0+bXNnX2l0ZXIuYnZlYy0+YnZfbGVuOw0KPiA+
IC0JCXJjID0gc21iZF9yZWN2X3BhZ2UoaW5mbywgcGFnZSwgdG9fcmVhZCk7DQo+ID4gKwkJcmMg
PSBzbWJkX3JlY3ZfcGFnZShpbmZvLCBwYWdlLCBwYWdlX29mZnNldCwgdG9fcmVhZCk7DQo+ID4g
ICAJCWJyZWFrOw0KPiA+DQo+ID4gICAJZGVmYXVsdDoNCj4gPiAgIAkJLyogSXQncyBhIGJ1ZyBp
biB1cHBlciBsYXllciB0byBnZXQgdGhlcmUgKi8NCj4gPiAgIAkJY2lmc19kYmcoVkZTLCAiQ0lG
UzogaW52YWxpZCBtc2cgdHlwZSAlZFxuIiwNCj4gPiAgIAkJCW1zZy0+bXNnX2l0ZXIudHlwZSk7
DQo+ID4gLQkJcmMgPSAtRUlPOw0KPiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiAgIAl9DQo+ID4N
Cj4gPiAgIAlpbmZvLT5zbWJkX3JlY3ZfcGVuZGluZy0tOw0KPiA+DQo=
