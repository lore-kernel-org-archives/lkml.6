Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B7C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A510C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSfbdANj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAVCcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:32:25 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:64319
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfAVCcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr9dTHZo3qWTn7vfr1giNyR6yYP+xxcdeWiut5PQ6DY=;
 b=bSfbdANjyc7Wq13C4eDTh70Zul4jSZ7xkQFmR8p1HHtO6dlUEchzbhsLQfjQbA8VJydwj9+Zjyo68mXM22TBYj+YMeozuZ37N/6lRdJbZdYvuz1XHsYJ7e4WsS4HC9DqB6pJbg6BctvHfIMTaRPktp2go5E51Ic71svbiVgyP3g=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB6211.eurprd04.prod.outlook.com (20.179.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 02:32:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 02:32:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
Subject: RE: [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Topic: [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jm6W5ZAkAgAErX3A=
Date:   Tue, 22 Jan 2019 02:32:19 +0000
Message-ID: <AM0PR04MB44815AC8861DBED64E959DB688980@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <20190121082830.GC12420@infradead.org>
In-Reply-To: <20190121082830.GC12420@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6211;6:gbbBEfhXfPhkKNp9TNmRkFU16wi8w2H+3OS/tWHBaN2zSkWx6uYrnkr7fI5KEF10/+/JM20V7JrlnKADI0vea+lt+0IX448YzSqzxxUap5Ec5WHmXG2h22klM59AwDPDtUrVC2vUcXOPakFakVyMrPTBHb0rqhE8bBmfn5H3A7+mr43EC7fBxuhhZm5O9FiKF+PsbN10g7mLxOqDk3GhFZbrk56/DouI0IBCKlJkbbD4cPZ50/63wLK2eEDSQioY4MZLWyEfyQaSD+wb7S9UIcWrSJE1LcYHHxhTuw94u1vVx28Lx3pes59dCFyWYP6uUnKOI0kRq1U/GM5YsbnkYmqB6Q5WKzi5oDnKtbLzKpKq5Gdo5pRwgp1VIxXXSpDLDhtJoHCIB0myfOh2mATieaeocu872//KpJbkmQl0kVqKXJ+dqu8a5EG9t7dxU+OOYqwN2PjyTWKGSvGQg4PkPw==;5:jKnVDxdFchZ+vjSW8BS26fnL2N0uIGRL/tIrXfDkmyXBJRbtHLVUdJvcd4iG9aSLNyMYrbAYtP/QVw9gG58pT8t+hiY3AhZNjQj9V+gvuSSzZbN//+KUqG/FGXz7XhQvDRmIEOkOwi8WGN7qn+tZNSAfMRL5Qg+IJ9l9SdJnN8DCdKJgKd31462hs3GqhYL2eBOv2gr5hMO3wi7GqpHqcQ==;7:edhCmutU1iW6U2g0h+FXKPHApYNog234Z6JMFelA4WNPdkaqWPkyTsNAywPyBauel55P1gOwqtG20CF2ZQWjmswRWkH0s+m+B5ireRTscxzP2r5FL4nphjbAsHZA2P4if6VPp0bR9j3pOyH1RT2TyA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ea2de6cc-22df-4952-504d-08d68011d4d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6211;
x-ms-traffictypediagnostic: AM0PR04MB6211:
x-microsoft-antispam-prvs: <AM0PR04MB621111F272DF737E3722AC5688980@AM0PR04MB6211.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(346002)(136003)(13464003)(189003)(199004)(476003)(3846002)(11346002)(316002)(53546011)(26005)(99286004)(6506007)(102836004)(446003)(6346003)(7696005)(76176011)(86362001)(6116002)(8936002)(81166006)(81156014)(1730700003)(8676002)(68736007)(44832011)(486006)(53936002)(2501003)(55016002)(9686003)(7736002)(2351001)(6306002)(105586002)(71190400001)(71200400001)(106356001)(305945005)(966005)(2906002)(74316002)(33656002)(6436002)(186003)(54906003)(5640700003)(6916009)(6246003)(66066001)(256004)(478600001)(25786009)(14454004)(4326008)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6211;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 24gtk7fpTy4xh797oOD1M+St3YGWml3Qr1n/8yGAdQ/Hm5yy9FstGLdAypTRG2VXKoXVgwHhbpZj+armA7Vjv7QaeAklbtHay1gucAAbXpQmivDNb24qRp4bo5B6MwFQB+A03SEvQGGgHJPGUsNDDUFQTQ96DJLVyYFhC6UMd4OUPv2r22IdXRgAkeyHiDxZt5WUhfeza7VG49lo6dN/QnAcfzAPHJx53ePOVplEq9XhD6H6nmOTfxtVazYbVxIvzidrZqeIau2vtNH6E0qVR5uB8y1HcAk5glr3lJd0gJqBFNF2zL53OCUtOoVVjKRHtbO0tNXsjIRs+1pu0l6jneIyETGm/QHOkAG8vUn/A8QsNlEsZIN55+h6tv964Z2Ag6D9VeJ/D5s6zkZRgDVokzrHCswEKAyiBd+HRBZSzCk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2de6cc-22df-4952-504d-08d68011d4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 02:32:19.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBoY2hAaW5mcmFkZWFk
Lm9yZyBbbWFpbHRvOmhjaEBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiAyMDE5xOox1MIyMcjVIDE2
OjI5DQo+IFRvOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gQ2M6IG1zdEByZWRoYXQu
Y29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBzc3RhYmVsbGluaUBrZXJuZWwub3JnOw0KPiBoY2hA
aW5mcmFkZWFkLm9yZzsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
DQo+IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtcmVtb3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtSRkNdIHZpcnRpb19yaW5nOiBjaGVjayBkbWFfbWVtIGZvciB4ZW5fZG9tYWluDQo+IA0K
PiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAwNDo1MTo1N0FNICswMDAwLCBQZW5nIEZhbiB3cm90
ZToNCj4gPiBvbiBpLk1YOFFNLCBNNF8xIGlzIGNvbW11bmljYXRpbmcgd2l0aCBEb21VIHVzaW5n
IHJwbXNnIHdpdGggYSBmaXhlZA0KPiA+IGFkZHJlc3MgYXMgdGhlIGRtYSBtZW0gYnVmZmVyIHdo
aWNoIGlzIHByZWRlZmluZWQuDQo+ID4NCj4gPiBXaXRob3V0IHRoaXMgcGF0Y2gsIHRoZSBmbG93
IGlzOg0KPiA+IHZyaW5nX21hcF9vbmVfc2cgLT4gdnJpbmdfdXNlX2RtYV9hcGkNCj4gPiAgICAg
ICAgICAgICAgICAgIC0+IGRtYV9tYXBfcGFnZQ0KPiA+IAkJICAgICAgIC0+IF9fc3dpb3RsYl9t
YXBfcGFnZQ0KPiA+IAkJICAgICAgICAgICAgICAgIC0+c3dpb3RsYl9tYXBfcGFnZQ0KPiA+IAkJ
CQktPl9fZG1hX21hcF9hcmVhKHBoeXNfdG9fdmlydChkbWFfdG9fcGh5cyhkZXYsDQo+IGRldl9h
ZGRyKSksIHNpemUsDQo+ID4gZGlyKTsgSG93ZXZlciB3ZSBhcmUgdXNpbmcgcGVyIGRldmljZSBk
bWEgYXJlYSBmb3IgcnBtc2csIHBoeXNfdG9fdmlydA0KPiA+IGNvdWxkIG5vdCByZXR1cm4gYSBj
b3JyZWN0IHZpcnR1YWwgYWRkcmVzcyBmb3IgdmlydHVhbCBhZGRyZXNzIGluDQo+ID4gdm1hbGxv
YyBhcmVhLiBUaGVuIGtlcm5lbCBwYW5pYy4NCj4gDQo+IEFuZCB0aGF0IGlzIHRoZSByaWdodCB0
aGluZyB0byBkby4gIFlvdSBtdXN0IG5vdCBjYWxsIGRtYV9tYXBfKiBvbiBtZW1vcnkNCj4gdGhh
dCB3YXMgYWxsb2NhdGVkIGZyb20gZG1hX2FsbG9jXyouDQoNClVuZGVyc3RhbmQuIEJ1dCB0aGUg
Y3VycmVudCBjb2RlIGlzIHRoYXQgdnJpbmdfdXNlX2RtYV9hcGkgd2lsbCBhbHdheXMgcmV0dXJu
DQp0cnVlLCBpZiB0aGUgY3VycmVudCBPUyBpcyBhIHhlbiBWTS4NCg0KQWN0dWFsbHkgaXQgbmVl
ZHMgdG8gcmV0dXJuIGZhbHNlIGZvciBteSBjYXNlLCB0aGVuIHdlIGNvdWxkIHVzZSBzZ19waHlz
KHNnKQ0KdG8gZ2V0IHRoZSBjb3JyZWN0IHBoeXNpY2FsIGFkZHJlc3MuDQoNCj4gDQo+IFdlIGFj
dHVhbGx5IGhhdmUgYW5vdGhlciB0aHJlYWQgd2hpY2ggYXBwZWFycyB0byBiZSBmb3IgdGhpcyBz
YW1lIGlzc3VlLg0KDQpZb3UgbWVhbiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNo
LzEwNzQyOTIzLyA/DQoNCllvdSBzdWdnZXN0IHVzZSBjbWEgdGhlcmUsIGJ1dCB2cmluZ191c2Vf
ZG1hX2FwaSB3aWxsIHN0aWxsIHJldHVybiB0cnVlIGlmIHRoZSBPUw0KaXMgcnVubmluZyBvbiB4
ZW4uIFRoZW4gdnJpbmdfbWFwX29uZV9zZyB3aWxsIHN0aWxsIHJ1bnMgaW50byBfX2RtYV9tYXBf
YXJlYS4NCg0KSW4gbXkgY2FzZSwganVzdCBuZWVkIHZyaW5nX3VzZV9kbWFfYXBpIHRvIHJldHVy
biBmYWxzZSBhbmQgdXNlIHNnX3BoeXMoc2cpIHRvDQpnZXQgdGhlIGNvcnJlY3QgcGh5c2ljYWwg
YWRkcmVzcywgd2hldGhlciBwZXIgZG1hIHJlc2VydmVkIGFyZWEgb3IgcGVyIGRldmljZSBjbWEu
DQoNClRoYW5rcywNClBlbmcuDQo=
