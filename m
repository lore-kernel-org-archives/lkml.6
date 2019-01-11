Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944BBC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDF220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="tNGRBLlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfAKJRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:17:03 -0500
Received: from mail-eopbgr150100.outbound.protection.outlook.com ([40.107.15.100]:50150
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfAKJRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=527uqIgKGmDpWU40YpnV0nKSBafJDnhPf9ae9jS/AVs=;
 b=tNGRBLlHtLsebbqKPXon9pntpw7jCaX/XN5368L079FwSig1ZqGlJLybck2zVEgOynBqjynV2X028T6xpIudM/ei9yrwMdEoVdnt1WaQaCxjCEcefrnybSC7PBJwLgrd+31sqDDXm109JC6H7Y5Lqr9fqnBbb1HD+FqRPj+J9AU=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4454.eurprd02.prod.outlook.com (20.177.196.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.11; Fri, 11 Jan 2019 09:16:54 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 09:16:54 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKWoxn6AgAAqWgCAANn/AA==
Date:   Fri, 11 Jan 2019 09:16:53 +0000
Message-ID: <995284f0-b29d-feda-6c3d-13a59533b7a0@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon> <20190110201636.GA7074@ravnborg.org>
In-Reply-To: <20190110201636.GA7074@ravnborg.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0283.eurprd05.prod.outlook.com
 (2603:10a6:7:93::14) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4454;6:zCu68lT8t7YOrRNYf+SifOQKGZWacaF70D26qUYgz/aKdrKuHrhP6Cw2T4sZeRFPEId668bFgCtT6r6g3pt/zYCTDDMLr/y9D19srhpoGbqqUzO+Js1hJM9NDtyfOBkh+lKeC7zBrElIk/fsdzTD82hTvdwwbc/8AXKkpHtLast4jUrdWeK+rxia6Io3lfXx8db0EY+3I82ZfNQxGTgtemX4/oFwUW1bUZTS2ir25euR098lCFpJSYJ6072W9SGG/RvKPg7ofmkzXy4l2+0laT2fWYE0Kmhzow8N6y0ibSkgGTj6mwVHhC2KqrX5r9lS302sfvHJjgN+0ljWdmJ2RZg1VwdfzwoDu/Bl8St+nVUzNsXOIKNmXqBcZhTYgN0mJaAlP7f33lWuuuMkOBR6zAcZZ4Wxms9FoI+LLkpt4OLYjX+LkJwXc+nNOapQauesrqLOZPcxnDLVRdDS10hBZQ==;5:miKPwntdf0fIa0fNMzuDrSfqFmKDDKx4+juuyUalBEAkrA5ACJ0as9JZLQRBbaVcNO/5RYBMWYlsP47e2kjWSu8ss4qTzWBlqGXPbXBV3ln1dxMedI5Ehix4EGNGoEIqL030ZUlW1l94tXyBuZQ/QsVBQyuW5e4G7w8nTcd0X8O/qi3t8BzLvEMDpIG9iRKbkDt/mOugCAZrV2QY8dZUPA==;7:bSukjdCjfinpobqUaqrDy9IE/WCVUPXOnYi0/n6qn/+nHExz5N4+4Hsex4qAV3FmGlmAeg2K2jZJ/pHM21c0WuvOBqvTYBzFhatpHqKALEWTWgsVLYC+RF5nyoGMbmcESge0E4G7eKP+fMh5ugbQSA==
x-ms-office365-filtering-correlation-id: e7d1b449-ce51-4ac8-0261-08d677a586ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4454;
x-ms-traffictypediagnostic: AM6PR02MB4454:
x-microsoft-antispam-prvs: <AM6PR02MB445414F8BED61A1D8CC69F0EBC850@AM6PR02MB4454.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39830400003)(136003)(376002)(189003)(199004)(54094003)(52314003)(966005)(229853002)(2906002)(36756003)(4326008)(186003)(65806001)(25786009)(6486002)(6306002)(65956001)(26005)(97736004)(6436002)(3846002)(6116002)(53936002)(316002)(65826007)(256004)(5660300001)(71190400001)(486006)(6512007)(102836004)(66066001)(64126003)(71200400001)(386003)(305945005)(31686004)(446003)(7736002)(52116002)(476003)(508600001)(6246003)(86362001)(81166006)(106356001)(81156014)(105586002)(58126008)(8936002)(54906003)(110136005)(14454004)(31696002)(8676002)(68736007)(53546011)(6346003)(76176011)(99286004)(2616005)(74482002)(11346002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4454;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +axoUt5iHCLXmw7iAbU4SFcjEgVWE4SQoz9zi74QhJ252sTbhZg9zJxP4Zeog8GQa/qlLWlRTzoJHqmXUM1N4iaAJBltG4uNZaY1meWSNgZ26m79Q79fQ4EEK2MvSuC0xXZFtPBB8x/bVL6FKnSmWutYQvOmyLbqm5md0lAXKQthJCAODgo77N9b9hpe2ZAn/UtMknMYPRmCialIQK/VP3PlgSQWqcuodJ8eCh1lPcSfj001YNQhNyF0FS8iYBrUBCWThPfBDfJvUBobX88RwWT0cMski5cUbmE2S8HVuex9e33WVIJZMsLj+VlmH+PURP07z1ryK/jrfOAVNfVigfA9LcndE/ekaE/XFZhVlfl2i61rjjoD2BdZwGaUUfBi+I005I0tURfQv7ExU0xwb7IOMhTt3I3O2+p8xzXDhIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0F2BA89937EB4B8756D2E1D308EEAF@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1b449-ce51-4ac8-0261-08d677a586ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 09:16:52.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xMCAyMToxNiwgU2FtIFJhdm5ib3JnIHdyb3RlOg0KPiBIaSBQZXRlci4NCj4g
DQo+IChIaWphY2tpbmcgdGhpcyB0aHJlYWQgYXMgSSBsb3N0IHRoZSBvcmdpbmFsIG1haWxzKQ0K
DQpBc3N1bWluZyB5b3Ugd2FudGVkIHRvIHJlcGx5IHRvIHRoaXMgcGF0Y2g/DQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzUzNTcxLw0KDQo+Pj4gSSBmb3VuZCBhbiB1bmZv
cnR1bmF0ZSBpc3N1ZSB3aGlsZSByZWNvZGluZyBwbGFuZSBoYW5kbGluZyB0byB1c2UNCj4+PiBk
cm1fYXRvbWljX2hlbHBlcl9jaGVja19wbGFuZV9zdGF0ZSgpLiBUaGUgZHJpdmVyIHJvdGF0ZXMg
Y2xvY2t3aXNlLA0KPj4+IHdoaWNoIGlzIG5vdCBjb3JyZWN0LiBJIHNpbXBseSBmaXhlZCBpdCAo
cGF0Y2ggMS80KSwgYnV0IG1heWJlIHRoYXQNCj4+PiB3aWxsIGNhdXNlIHJlZ3Jlc3Npb25zIGZv
ciB1bnN1c3BlY3RpbmcgdXNlcnMgd2hvIHNpbXBseSBhc3N1bWVkDQo+Pj4gdGhhdCB0aGUgY2xv
Y2t3aXNlIHJvdGF0aW9uIHdhcyBjb3JyZWN0PyBJIGRvbid0IGtub3cgd2hhdCB0byBkbw0KPj4+
IGFib3V0IHRoYXQ/IEFkZGluZyBhbiBvcHRpb24gdG8gZ2V0IHRoZSBvbGQgYnJva2VuIGJlaGF2
aW9yIHNlZW1zDQo+Pj4gdXNlbGVzcywgd291bGRuJ3QgaXQgYmUganVzdCBhcyBlYXN5IHRvIGp1
c3QgZml4IHdoYXRldmVyIGFwcCB0bw0KPj4+IHJvdGF0ZSB0aGUgb3RoZXIgd2F5IGluc3RlYWQg
b2YgYWRkaW5nIGFuIG9wdGlvbiBzb21ld2hlcmU/DQo+Pg0KPj4gSG0sIHJvdGF0aW9uIHN1cHBv
cnQgaGFzIGJlZW4gYWRkZWQgYmVmb3JlIHRoZSBzdGFuZGFyZCByb3RhdGlvbg0KPj4gcHJvcGVy
dHkgd2FzIGNyZWF0ZWQsIGFuZCBhdCB0aGF0IHRpbWUgSSBhc3N1bWVkIHJvdGF0aW9uIHdhcyBj
bG9ja3dpc2UNCj4+ICh3aGljaCBhcHBhcmVudGx5IHdhcyBhbiB1bndpc2UgY2hvaWNlKS4gQW55
d2F5LCBJIGRvbid0IGhhdmUgYQ0KPj4gc29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbSwgc28gSSds
bCBsZXQgTmljb2xhcyBkZWNpZGUgaWYgaXQncw0KPj4gYWNjZXB0YWJsZSB0byBjaGFuZ2UgdGhl
IHJvdGF0aW9uIGJlaGF2aW9yLg0KPj4NCj4+PiBJIGhhdmUgb25seSB0ZXN0ZWQgdGhpcyBzZXJp
ZXMgb24gc2FtYTVkMywgYnV0IEkgZGlkIGNoZWNrIHRoZSBkb2NzDQo+Pj4gZm9yIHZhcmlvdXMg
b3RoZXIgY2hpcHMgKHNhbWE1ZDIsIHNhbWE1ZDQsIHNhbTluMTIsIHNhbTlnMTUsIHNhbTlnMzUN
Cj4+PiBhbmQgc2FtOXgzNSkgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIgKHJlbGV2YW50IHRvIHBh
dGNoIDQvNCkuDQo+IA0KPiBJIHdvbmRlciBpZiwgd2hlbiB0aGlzIGNvZGUgcGF0aCBpcyBhbnl3
YXkgdG91Y2hlZCwgY291bGQgYmVuZWZpdA0KPiBmcm9tIGRybV9yZWN0X3JvdGF0ZSgpLg0KPiAN
Cj4gSXQgaXMgb2J2aW91c2x5IG5vdCBhIHNpbXBsZSByZXBsYWNlbWVudCwgYnV0IGNvdWxkIGl0
IGJlIHVzZWQgdGhlbg0KPiBJIGhvcGUgdGhlIHJlc3VsdGluZyBjb2RlIGlzIHNpbXBsZXIuDQoN
CldoYXQgYXJlIHlvdSByZWZlcnJpbmcgdG8gdGhhdCBnb2VzIGJleW9uZCB3aGF0IGlzIGRvbmUg
aW4gcGF0Y2ggMy80DQppbiB0aGlzIHNlcmllcz8gQWZ0ZXIgc2V0dGluZyB1cCB0aGUgc3RyaWRl
cywgdGhlIG9ubHkgdXNlIG9mIHNyY19beHl3aF0NCmFyZSB0byBjYWxjdWxhdGUgdGhlIHNjYWxp
bmcgZmFjdG9ycywgYW5kIGZvciB0aGF0IHRoZSBwb3NpdGlvbiBpcw0KaXJyZWxldmFudC4gSS5l
LiBzcmNfeCBhbmQgc3JjX3kgYXJlIG5vdCB1c2VkLiBTdXJlLCBpbiBzb21lIHRoZW9yZXRpY2Fs
DQpzZW5zZSBpdCBtaWdodCBiZSBnb29kIGlmIHNyY19beHldIGFyZSBhbHNvIHRyYW5zZm9ybWVk
IGludG8gdGhlIHJvdGF0ZWQNCmNvb3JkaW5hdGUgc3lzdGVtIGFsb25nIHdpdGggc3JjX1t3aF0s
IGJ1dCBpdCBzZWVtcyBhIGJpdCBiYWNrd2FyZHMgdG8NCnN3aXRjaCBvdmVyIHRvIHN0cnVjdCBk
cm1fcmVjdCB3aGVuIHRoZSBpbnRlcmVzdGluZyBwcm9wZXJ0aWVzIGFyZSB0aGUNCndpZHRoIGFu
ZCBoZWlnaHQsIG5vdCB0aGUgY29vcmRpbmF0ZXMgb2YgdGhlIGNvcm5lcnMuIE5vIHN0cm9uZyBm
ZWVsaW5ncw0Kb24gdGhlIGlzc3VlIHRob3VnaC4uLg0KDQpDaGVlcnMsDQpQZXRlcg0K
