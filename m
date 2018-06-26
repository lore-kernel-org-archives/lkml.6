Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FFA264EC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GaqkdRT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FFA264EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeFZEeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:34:19 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:45780
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751095AbeFZEeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rulmu/QuOHHyPfpWn92qijA7cly5LvplbAJxXg9xWY=;
 b=GaqkdRT+HQm+fvIzm48waKO6xzVSgK7x4TmfC7qPusyfbLAhEq0wdxNCsrEaFDJu+/BCYlAtSnofE09rASk66QDvUfB2XAuSrTjcFVXA18A8uHbzBaPNINQao29c1Z4QYg8dfc7KAx5ok3rSUi1EJp+H7s/B56ObWehw7S2fjOI=
Received: from DM5PR2101MB0728.namprd21.prod.outlook.com (10.167.110.153) by
 DM5PR2101MB0998.namprd21.prod.outlook.com (52.132.133.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.4; Tue, 26 Jun 2018 04:34:09 +0000
Received: from DM5PR2101MB0728.namprd21.prod.outlook.com
 ([fe80::c9b4:8268:f6ba:8724]) by DM5PR2101MB0728.namprd21.prod.outlook.com
 ([fe80::c9b4:8268:f6ba:8724%2]) with mapi id 15.20.0930.005; Tue, 26 Jun 2018
 04:34:09 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 13/15] CIFS: Add support for direct I/O read
Thread-Topic: [Patch v2 13/15] CIFS: Add support for direct I/O read
Thread-Index: AQHT+E9qpm5mp7ugxkOqJ4eaETY3qaRu2JgAgANEZxA=
Date:   Tue, 26 Jun 2018 04:34:09 +0000
Message-ID: <DM5PR2101MB0728D2734E910F0AE1EF7CBACE490@DM5PR2101MB0728.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-14-longli@linuxonhyperv.com>
 <c8d8b852-b621-4f83-b127-535a10c0538d@talpey.com>
In-Reply-To: <c8d8b852-b621-4f83-b127-535a10c0538d@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:xPHnd00vcxZkIZ5r54zzzhfWGfWdIr2Yokn+PQAA1kDstZvxhSZ9nLKO3dM5HOCqcpyfPASgKrCdf76MeiaFRUkA/V5m9q5gNAd2k378SmkP9jm3XBHQ0F9j7QPm13gQmqabHreIgK83OyoraAlsUTwwTQwV26J7LfKByKdFO8J/C7+16katQ+nH34w47c4bbHcF+2cH2ZN+uJImRYDPsomWegkDubzSehkaQT4CKplGAY584GNyStsEKzq/ukL2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b15b9994-dcac-4ca2-cca9-08d5db1e0f42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
x-microsoft-antispam-prvs: <DM5PR2101MB0998A9FA0F1C9EA48FA4BD36CE490@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(69234005)(10290500003)(478600001)(8990500004)(186003)(6346003)(106356001)(10090500001)(46003)(81156014)(81166006)(55016002)(105586002)(9686003)(6506007)(6436002)(8676002)(102836004)(14444005)(476003)(229853002)(256004)(11346002)(2906002)(14454004)(5660300001)(7736002)(86612001)(22452003)(7696005)(305945005)(446003)(53936002)(6116002)(68736007)(316002)(53546011)(2900100001)(6246003)(74316002)(97736004)(76176011)(8936002)(486006)(110136005)(2201001)(2501003)(99286004)(5250100002)(25786009)(86362001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB0728.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-message-info: qx/Sb6YQw0u6YDF3VIIths+7lUO7Za7x+uKL+PmxgWQNhWbfCHssr2GbXN5kJcV/LtHEOnVeKcfTYU6bv5nFV4q/pWtUdKza7/+ex+off1o/oKGqc5UJC03+YnDWDMZk3TZV+SYoyvwvX/hb3BsKgIxYQPxTq7ehDm5IDRh5WiAu6eodAmSiup4hYQSqghxxS+eNyQMGKF7HhJ7W+7kv2N0iZxLlj9qDezS/bvMgFRZ5szHF8lLsJIMDEXywAaoBNathohadvuduN7cU+v+hM0pBfwCSuheZKlevCgTxB/kqGiMJZMwxkANC4gZQB67e7RY24ZIaRjFjWBnWzmmt63rZP8lK7Eda6Ub0c5qgG8c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15b9994-dcac-4ca2-cca9-08d5db1e0f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 04:34:09.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDEzLzE1XSBDSUZTOiBBZGQgc3VwcG9ydCBmb3IgZGly
ZWN0IEkvTyByZWFkDQo+IA0KPiANCj4gDQo+IE9uIDUvMzAvMjAxOCAzOjQ4IFBNLCBMb25nIExp
IHdyb3RlOg0KPiA+IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+DQo+
ID4gSW1wbGVtZW50IHRoZSBmdW5jdGlvbiBmb3IgZGlyZWN0IEkvTyByZWFkLiBJdCBkb2Vzbid0
IHN1cHBvcnQgQUlPLA0KPiA+IHdoaWNoIHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4gYSBmb2xsb3cg
dXAgcGF0Y2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb25nIExpIDxsb25nbGlAbWljcm9z
b2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGZzL2NpZnMvY2lmc2ZzLmggfCAgIDEgKw0KPiA+ICAg
ZnMvY2lmcy9maWxlLmMgICB8IDE0OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE1MCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZnMuaCBiL2ZzL2Np
ZnMvY2lmc2ZzLmggaW5kZXgNCj4gPiA1ZjAyMzE4Li43ZmJhOWFhIDEwMDY0NA0KPiA+IC0tLSBh
L2ZzL2NpZnMvY2lmc2ZzLmgNCj4gPiArKysgYi9mcy9jaWZzL2NpZnNmcy5oDQo+ID4gQEAgLTEw
Miw2ICsxMDIsNyBAQCBleHRlcm4gaW50IGNpZnNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZQ0KPiAqZmlsZSk7DQo+ID4gICBleHRlcm4gaW50IGNpZnNfY2xvc2Uoc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpOw0KPiA+ICAgZXh0ZXJuIGludCBjaWZz
X2Nsb3NlZGlyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTsNCj4gPiAg
IGV4dGVybiBzc2l6ZV90IGNpZnNfdXNlcl9yZWFkdihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVj
dCBpb3ZfaXRlcg0KPiA+ICp0byk7DQo+ID4gK2V4dGVybiBzc2l6ZV90IGNpZnNfZGlyZWN0X3Jl
YWR2KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyDQo+ID4gKyp0byk7DQo+ID4g
ICBleHRlcm4gc3NpemVfdCBjaWZzX3N0cmljdF9yZWFkdihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0
cnVjdCBpb3ZfaXRlciAqdG8pOw0KPiA+ICAgZXh0ZXJuIHNzaXplX3QgY2lmc191c2VyX3dyaXRl
dihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSk7DQo+ID4gICBleHRl
cm4gc3NpemVfdCBjaWZzX3N0cmljdF93cml0ZXYoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QN
Cj4gPiBpb3ZfaXRlciAqZnJvbSk7IGRpZmYgLS1naXQgYS9mcy9jaWZzL2ZpbGUuYyBiL2ZzL2Np
ZnMvZmlsZS5jIGluZGV4DQo+ID4gODdlZWNlNi4uZTZlNmYyNCAxMDA2NDQNCj4gPiAtLS0gYS9m
cy9jaWZzL2ZpbGUuYw0KPiA+ICsrKyBiL2ZzL2NpZnMvZmlsZS5jDQo+ID4gQEAgLTI5NTUsNiAr
Mjk1NSwxOCBAQCBjaWZzX3JlYWRfYWxsb2NhdGVfcGFnZXMoc3RydWN0IGNpZnNfcmVhZGRhdGEN
Cj4gKnJkYXRhLCB1bnNpZ25lZCBpbnQgbnJfcGFnZXMpDQo+ID4gICAJcmV0dXJuIHJjOw0KPiA+
ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGNpZnNfZGlyZWN0X3JlYWRkYXRhX3JlbGVhc2Uo
c3RydWN0IGtyZWYgKnJlZmNvdW50KSB7DQo+ID4gKwlzdHJ1Y3QgY2lmc19yZWFkZGF0YSAqcmRh
dGEgPSBjb250YWluZXJfb2YocmVmY291bnQsDQo+ID4gKwkJCQkJc3RydWN0IGNpZnNfcmVhZGRh
dGEsIHJlZmNvdW50KTsNCj4gPiArCXVuc2lnbmVkIGludCBpOw0KPiA+ICsNCj4gPiArCWZvciAo
aSA9IDA7IGkgPCByZGF0YS0+bnJfcGFnZXM7IGkrKykNCj4gPiArCQlwdXRfcGFnZShyZGF0YS0+
cGFnZXNbaV0pOw0KPiA+ICsNCj4gPiArCWNpZnNfcmVhZGRhdGFfcmVsZWFzZShyZWZjb3VudCk7
DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZA0KPiA+ICAgY2lmc191bmNhY2hlZF9y
ZWFkZGF0YV9yZWxlYXNlKHN0cnVjdCBrcmVmICpyZWZjb3VudCkNCj4gPiAgIHsNCj4gPiBAQCAt
MzI2Nyw2ICszMjc5LDE0MyBAQCBjb2xsZWN0X3VuY2FjaGVkX3JlYWRfZGF0YShzdHJ1Y3QNCj4g
Y2lmc19haW9fY3R4ICpjdHgpDQo+ID4gICAJCWNvbXBsZXRlKCZjdHgtPmRvbmUpOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGNpZnNfZGlyZWN0X3JlYWR2X2NvbXBsZXRlKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykgew0KPiA+ICsJc3RydWN0IGNpZnNfcmVhZGRhdGEgKnJkYXRh
ID0NCj4gPiArCQljb250YWluZXJfb2Yod29yaywgc3RydWN0IGNpZnNfcmVhZGRhdGEsIHdvcmsp
Ow0KPiA+ICsNCj4gPiArCWNvbXBsZXRlKCZyZGF0YS0+ZG9uZSk7DQo+ID4gKwlrcmVmX3B1dCgm
cmRhdGEtPnJlZmNvdW50LCBjaWZzX2RpcmVjdF9yZWFkZGF0YV9yZWxlYXNlKTsgfQ0KPiA+ICsN
Cj4gPiArc3NpemVfdCBjaWZzX2RpcmVjdF9yZWFkdihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVj
dCBpb3ZfaXRlciAqdG8pIHsNCj4gPiArCXNpemVfdCBsZW4sIGN1cl9sZW4sIHN0YXJ0Ow0KPiA+
ICsJdW5zaWduZWQgaW50IG5wYWdlcywgcnNpemUsIGNyZWRpdHM7DQo+ID4gKwlzdHJ1Y3QgZmls
ZSAqZmlsZTsNCj4gPiArCXN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2I7DQo+ID4gKwlzdHJ1
Y3QgY2lmc0ZpbGVJbmZvICpjZmlsZTsNCj4gPiArCXN0cnVjdCBjaWZzX3Rjb24gKnRjb247DQo+
ID4gKwlzdHJ1Y3QgcGFnZSAqKnBhZ2V2ZWM7DQo+ID4gKwlzc2l6ZV90IHJjLCB0b3RhbF9yZWFk
ID0gMDsNCj4gPiArCXN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcjsNCj4gPiArCWxvZmZf
dCBvZmZzZXQgPSBpb2NiLT5raV9wb3M7DQo+ID4gKwlwaWRfdCBwaWQ7DQo+ID4gKwlzdHJ1Y3Qg
Y2lmc19yZWFkZGF0YSAqcmRhdGE7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIGlvdl9pdGVy
X2dldF9wYWdlc19hbGxvYygpIGRvZXNuJ3Qgd29yayB3aXRoIElURVJfS1ZFQywNCj4gPiArCSAq
IGZhbGwgYmFjayB0byBkYXRhIGNvcHkgcmVhZCBwYXRoDQo+ID4gKwkgKi8NCj4gPiArCWlmICh0
by0+dHlwZSAmIElURVJfS1ZFQykgew0KPiA+ICsJCWNpZnNfZGJnKEZZSSwgInVzZSBub24tZGly
ZWN0IGNpZnNfdXNlcl9yZWFkdiBmb3Iga3ZlYw0KPiBJL09cbiIpOw0KPiA+ICsJCXJldHVybiBj
aWZzX3VzZXJfcmVhZHYoaW9jYiwgdG8pOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWxlbiA9IGlv
dl9pdGVyX2NvdW50KHRvKTsNCj4gPiArCWlmICghbGVuKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+
ICsNCj4gPiArCWZpbGUgPSBpb2NiLT5raV9maWxwOw0KPiA+ICsJY2lmc19zYiA9IENJRlNfRklM
RV9TQihmaWxlKTsNCj4gPiArCWNmaWxlID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsJdGNv
biA9IHRsaW5rX3Rjb24oY2ZpbGUtPnRsaW5rKTsNCj4gPiArCXNlcnZlciA9IHRjb24tPnNlcy0+
c2VydmVyOw0KPiA+ICsNCj4gPiArCWlmICghc2VydmVyLT5vcHMtPmFzeW5jX3JlYWR2KQ0KPiA+
ICsJCXJldHVybiAtRU5PU1lTOw0KPiA+ICsNCj4gPiArCWlmIChjaWZzX3NiLT5tbnRfY2lmc19m
bGFncyAmIENJRlNfTU9VTlRfUldQSURGT1JXQVJEKQ0KPiA+ICsJCXBpZCA9IGNmaWxlLT5waWQ7
DQo+ID4gKwllbHNlDQo+ID4gKwkJcGlkID0gY3VycmVudC0+dGdpZDsNCj4gPiArDQo+ID4gKwlp
ZiAoKGZpbGUtPmZfZmxhZ3MgJiBPX0FDQ01PREUpID09IE9fV1JPTkxZKQ0KPiA+ICsJCWNpZnNf
ZGJnKEZZSSwgImF0dGVtcHRpbmcgcmVhZCBvbiB3cml0ZSBvbmx5IGZpbGUgaW5zdGFuY2VcbiIp
Ow0KPiANCj4gQ29uZnVzaW5nLiBNYXliZSAiYXR0ZW1wdGluZyByZWFkIG9uIHdyaXRlLW9ubHkg
ZmlsZWhhbmRsZSI/DQo+IA0KPiA+ICsNCj4gPiArCWRvIHsNCj4gPiArCQlyYyA9IHNlcnZlci0+
b3BzLT53YWl0X210dV9jcmVkaXRzKHNlcnZlciwgY2lmc19zYi0+cnNpemUsDQo+ID4gKwkJCQkJ
JnJzaXplLCAmY3JlZGl0cyk7DQo+ID4gKwkJaWYgKHJjKQ0KPiA+ICsJCQlicmVhazsNCj4gPiAr
DQo+ID4gKwkJY3VyX2xlbiA9IG1pbl90KGNvbnN0IHNpemVfdCwgbGVuLCByc2l6ZSk7DQo+ID4g
Kw0KPiA+ICsJCXJjID0gaW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jKHRvLCAmcGFnZXZlYywgY3Vy
X2xlbiwgJnN0YXJ0KTsNCj4gPiArCQlpZiAocmMgPCAwKSB7DQo+ID4gKwkJCWNpZnNfZGJnKFZG
UywNCj4gPiArCQkJCSJjb3VsZG4ndCBnZXQgdXNlciBwYWdlcyAocmM9JXpkKSBpdGVyDQo+IHR5
cGUgJWQiDQo+ID4gKwkJCQkiIGlvdl9vZmZzZXQgJWx1IGNvdW50ICVsdVxuIiwNCj4gPiArCQkJ
CXJjLCB0by0+dHlwZSwgdG8tPmlvdl9vZmZzZXQsIHRvLT5jb3VudCk7DQo+ID4gKwkJCWR1bXBf
c3RhY2soKTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlyZGF0YSA9
IGNpZnNfcmVhZGRhdGFfZGlyZWN0X2FsbG9jKA0KPiA+ICsJCQkJcGFnZXZlYywgY2lmc19kaXJl
Y3RfcmVhZHZfY29tcGxldGUpOw0KPiA+ICsJCWlmICghcmRhdGEpIHsNCj4gPiArCQkJYWRkX2Ny
ZWRpdHNfYW5kX3dha2VfaWYoc2VydmVyLCBjcmVkaXRzLCAwKTsNCj4gPiArCQkJcmMgPSAtRU5P
TUVNOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCW5wYWdlcyA9IChy
YyArIHN0YXJ0ICsgUEFHRV9TSVpFLTEpIC8gUEFHRV9TSVpFOw0KPiA+ICsJCXJkYXRhLT5ucl9w
YWdlcyA9IG5wYWdlczsNCj4gPiArCQlyZGF0YS0+cGFnZV9vZmZzZXQgPSBzdGFydDsNCj4gPiAr
CQlyZGF0YS0+cGFnZXN6ID0gUEFHRV9TSVpFOw0KPiA+ICsJCXJkYXRhLT50YWlsc3ogPSBucGFn
ZXMgPiAxID8NCj4gPiArCQkJCXJjLShQQUdFX1NJWkUtc3RhcnQpLShucGFnZXMtMikqUEFHRV9T
SVpFIDoNCj4gPiArCQkJCXJjOw0KPiANCj4gVGhpcyBleHByZXNzaW9uIG1ha2VzIG15IGhlYWQg
aHVydC4gU3VyZWx5IGl0IGNhbiBiZSBzaW1wbGlmaWVkLCBvciBleHByZXNzZWQNCj4gaW4gYSBj
bGVhcmVyIHdheS4NCj4gDQo+ID4gKwkJY3VyX2xlbiA9IHJjOw0KPiA+ICsNCj4gPiArCQlyZGF0
YS0+Y2ZpbGUgPSBjaWZzRmlsZUluZm9fZ2V0KGNmaWxlKTsNCj4gPiArCQlyZGF0YS0+b2Zmc2V0
ID0gb2Zmc2V0Ow0KPiA+ICsJCXJkYXRhLT5ieXRlcyA9IHJjOw0KPiA+ICsJCXJkYXRhLT5waWQg
PSBwaWQ7DQo+ID4gKwkJcmRhdGEtPnJlYWRfaW50b19wYWdlcyA9IGNpZnNfdW5jYWNoZWRfcmVh
ZF9pbnRvX3BhZ2VzOw0KPiA+ICsJCXJkYXRhLT5jb3B5X2ludG9fcGFnZXMgPSBjaWZzX3VuY2Fj
aGVkX2NvcHlfaW50b19wYWdlczsNCj4gPiArCQlyZGF0YS0+Y3JlZGl0cyA9IGNyZWRpdHM7DQo+
ID4gKw0KPiA+ICsJCXJjID0gMDsNCj4gPiArCQlpZiAocmRhdGEtPmNmaWxlLT5pbnZhbGlkSGFu
ZGxlKQ0KPiA+ICsJCQlyYyA9IGNpZnNfcmVvcGVuX2ZpbGUocmRhdGEtPmNmaWxlLCB0cnVlKTsN
Cj4gPiArDQo+ID4gKwkJaWYgKCFyYykNCj4gPiArCQkJcmMgPSBzZXJ2ZXItPm9wcy0+YXN5bmNf
cmVhZHYocmRhdGEpOw0KPiA+ICsNCj4gPiArCQlpZiAocmMpIHsNCj4gDQo+IFRoaXMgd2hvbGUg
cmMgdGhpbmcgaXMgbWVzc3kuIEluaXRpYWxpemluZyB0byB6ZXJvLCBzZXR0aW5nIG9ubHkgaW4g
b25lIGNhc2UsIHRoZW4NCj4gdGVzdGluZyB0aGUgcmVzdWx0LCB0aGVuIHNldHRpbmcgaXQgYWdh
aW4sIGlzIHR3aXN0ZWQuDQo+IEkgYWN0dWFsbHkgdGhpbmsgYSBnb3RvIG9yIHR3byB3b3VsZCBy
ZWFkIG11Y2ggbW9yZSBjbGVhcmx5Lg0KPiANCj4gPiArCQkJYWRkX2NyZWRpdHNfYW5kX3dha2Vf
aWYoc2VydmVyLCByZGF0YS0+Y3JlZGl0cywgMCk7DQo+ID4gKwkJCWtyZWZfcHV0KCZyZGF0YS0+
cmVmY291bnQsDQo+ID4gKwkJCQkgY2lmc19kaXJlY3RfcmVhZGRhdGFfcmVsZWFzZSk7DQo+ID4g
KwkJCWlmIChyYyA9PSAtRUFHQUlOKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gKwkJCWJyZWFr
Ow0KPiANCj4gSXQncyB3b3J0aCBhIGNvbW1lbnQgaGVyZSB0aGF0IHRoaXMgZWl0aGVyIGJyZWFr
cyBvciBjb250aW51ZXMgdGhlIGVudGlyZSBkbyB7fQ0KPiB3aGlsZSAoKTsgYW5kIGJ0dyB3aGVu
IGl0IGJyZWFrcyBpdCBkb2VzICpub3QqIHJldHVybiAicmMiLg0KPiBBZ2FpbiwgbWF5YmUgYSBn
b3RvIGluc3RlYWQgb2YgYSBicmVhaz8NCj4gDQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQl3YWl0
X2Zvcl9jb21wbGV0aW9uKCZyZGF0YS0+ZG9uZSk7DQo+ID4gKwkJcmMgPSByZGF0YS0+cmVzdWx0
Ow0KPiA+ICsJCWlmIChyYykgew0KPiA+ICsJCQlrcmVmX3B1dCgNCj4gPiArCQkJCSZyZGF0YS0+
cmVmY291bnQsDQo+ID4gKwkJCQljaWZzX2RpcmVjdF9yZWFkZGF0YV9yZWxlYXNlKTsNCj4gPiAr
CQkJaWYgKHJjID09IC1FQUdBSU4pDQo+ID4gKwkJCQljb250aW51ZTsNCj4gPiArCQkJYnJlYWs7
DQo+IA0KPiBEaXR0by4NCg0KSSB3aWxsIHJlLXdvcmsgdGhpcyBwYXRjaC4NCg0KPiANCj4gPiAr
CQl9DQo+ID4gKw0KPiA+ICsJCXRvdGFsX3JlYWQgKz0gcmRhdGEtPmdvdF9ieXRlczsNCj4gPiAr
CQlrcmVmX3B1dCgmcmRhdGEtPnJlZmNvdW50LCBjaWZzX2RpcmVjdF9yZWFkZGF0YV9yZWxlYXNl
KTsNCj4gPiArDQo+ID4gKwkJaW92X2l0ZXJfYWR2YW5jZSh0bywgY3VyX2xlbik7DQo+ID4gKwkJ
bGVuIC09IGN1cl9sZW47DQo+ID4gKwkJb2Zmc2V0ICs9IGN1cl9sZW47DQo+ID4gKwl9IHdoaWxl
IChsZW4pOw0KPiA+ICsNCj4gPiArCWlvY2ItPmtpX3BvcyArPSB0b3RhbF9yZWFkOw0KPiA+ICsN
Cj4gPiArCXJldHVybiB0b3RhbF9yZWFkOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3NpemVfdCBj
aWZzX3VzZXJfcmVhZHYoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRvKQ0K
PiA+ICAgew0KPiA+ICAgCXN0cnVjdCBmaWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsNCj4gPg0K
