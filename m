Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A34EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6402087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BAbG9FJV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JjtaR70w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6402087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJVV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:21:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44839 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539179979; x=1570715979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJsOWL1oEHiLFW0p0cxok0ntRTm/PhxQ45Lp51PRn+4=;
  b=BAbG9FJV64YwxXkXAy4dzvl4DNI0/3EA/f6eQgoJxL3P9aw96hUDh3iJ
   7ZPMbZ0P1Nv7V0RvLKClD8Lnlb1j8bThO/aOv2A9WG5gVKdSyDdyxGe5L
   suk1+xXfKLhyNdyAk2COpozQEQwxCrz82VIQt0tnOdXvci2DBc/HJ7/Rh
   WJdblclLpDWB+jJ9OyGfWOh7/m9A9ML6VbkALF1NiHhY0ZRBppdS43IxI
   Znlgi5lxRZu3HSgw7HfFbO1XYOLuNbowE0uMbq0Cj5G5HRk3MwtNmg3dc
   GL7+zykcO4tzTGdELFx9Xs7PTUVlTw5c43/z4L+relgCUvvqjy7F5EvFc
   A==;
X-IronPort-AV: E=Sophos;i="5.54,364,1534780800"; 
   d="scan'208";a="93334578"
Received: from mail-co1nam05lp0079.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.79])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 21:59:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJsOWL1oEHiLFW0p0cxok0ntRTm/PhxQ45Lp51PRn+4=;
 b=JjtaR70wy1ABmthEm2+EN6v/VEQ4yAQeZ8HGHgLUkjwFUliVrHIG3+XBycuewpimf3mE3kH/YopRhgxGXQeFqqssGya1B83lC94D2hJR2BomX9qvEkTKEK5T4NSYkpbsxfL4qpvHr5kzchrI5ihlaMpRkhxALdKoo4OAj1na9oU=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4335.namprd04.prod.outlook.com (52.135.72.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 13:59:36 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 13:59:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     James Nuss <jamesnuss@nanometrics.ca>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Thread-Topic: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Thread-Index: AQHUX/Xq43uhKANLSEyJ2lkIDSULFaUYKgrAgABXEwCAAADdQA==
Date:   Wed, 10 Oct 2018 13:59:36 +0000
Message-ID: <SN6PR04MB4925102E47C0D0B6E6083124FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
 <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
 <CALgcdhhqvn3YWvQjtFfo46wH1N29-4vThNDzN1B2AROLY-kovw@mail.gmail.com>
In-Reply-To: <CALgcdhhqvn3YWvQjtFfo46wH1N29-4vThNDzN1B2AROLY-kovw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4335;6:H5tmMP9bseJUqML56xcI7XyAZNs/b/SKTZHrnvZkaIRv1UmZ4MeeX0x5hGrrrIXNTdRAG8hNucrZY/gqDX5YADH/jswhAIXuGqnK4/oItYWP5vU2YF4NHclDYub/HoinlJom3mkIli9pGaOKg84OAqFnlh3UXuGMOULMFtWV1ThExo8f81vDh5RrOPNKJbZLa9GSmmlkBqoTeNjGLRtsOtJVCM6ayxZ6phTy4d7qwrZZmHXHETZSBiEHb4pC0UVAkiW0pc6Zm1ee8G77Gnhe0yihOVcxT3G5xmNJ4KjxtLdJTc6qKHEPNhV5qwqL0OKU5orm5nbFSC78I+UeC9Shu8AjS6arKQSVxhbdm2XNgnyoH0nN3EnFRhseM1XAQYAcL2f3I4pVmjW0lfOlgeTbo2FfuZnPh60Vc3OlkTVJubCStcicE0rFrQp8dy5YnniPIPyC1fq4FNZj8swoClaqlg==;5:1WXLk6cxePAF1MnOfhqdB4SaNZ95hW31DQh/8m6xjQ1SzOCDguCoA6369SJQqr9XlHe3zVY0G64UuSa08XIhlO8VqklNLpOMxzCiMDwJLVFa4nQxOIvPYjHGQBfQsFJv+JX0F5mdr8lRCotia+0PpqQFLbRK4xzLSpB2d0Pp+lQ=;7:gVdM762UzCxRbTC1kPEgIi6uDFLUWMezYxVbeV1o/3u1naZEQYWeOOejiOuA8YC2Bxmys7Es8vt3/+GafEcV9MughVs42VBfwtkW5qeIwUZ5n/eih1rxwc3Nsaj+crIoQm6agktmbIcxDTq5ILbV802b0br1F5n+65KF7twEUMfng3/69O72V74QfGO/jRpbwzqEABec8g2hWqiYk3kV6jxINIQdfb6jM2kg2HfZ0qhNEM/5a6npx99cV8+fjaV5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 01386616-17bb-4480-90ef-08d62eb89d32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4335;
x-ms-traffictypediagnostic: SN6PR04MB4335:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB433582BAF95C1AD292A7E7F9FCE00@SN6PR04MB4335.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:SN6PR04MB4335;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4335;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(476003)(68736007)(53936002)(76176011)(11346002)(5250100002)(86362001)(446003)(3846002)(486006)(6116002)(14454004)(5660300001)(7696005)(72206003)(9686003)(66066001)(2906002)(81156014)(6436002)(8936002)(478600001)(55016002)(93886005)(8676002)(81166006)(71190400001)(33656002)(229853002)(316002)(71200400001)(97736004)(7736002)(305945005)(25786009)(99286004)(6246003)(54906003)(102836004)(256004)(106356001)(6506007)(74316002)(53546011)(26005)(105586002)(4326008)(6916009)(2900100001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4335;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7+xJyMm5OayTmbrHp3FmlU1hKttxQOLii37OvEbYxXNCQ8etBfmYb7J609vnynlhZBM0fz2D2WpQTuYhLaMl+jvk4QCC+ywk65cjvyQTSvuItPXNTobIuPDZjuCdcz98CDwAPZGZrmOV/+6ZLELdRGxSocmknvi0nxo1BoO1V/gN8zHRcam1DsGcw9XxeifE7db+d0WNwl7NZXg9ThYojSiEbj8ohYIXYj+Nd0XOJuDi7wKa0REPImMgXZv2gOUz1GgCSMHZdKHZ2SS+etyD7FRzxT7qQY1NSeFfmaA/1TNp5fWo1v/tBcHY/J+x1f/2axEp8lKGhgFoH21MUXk/B9yrMhgLG2e7shh0WkqBuWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01386616-17bb-4480-90ef-08d62eb89d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 13:59:36.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gV2VkLCBPY3QgMTAsIDIwMTggYXQgNDo0MyBBTSBBdnJpIEFsdG1hbiA8QXZyaS5B
bHRtYW5Ad2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gKysrIGIvbW1jX2NtZHMuYw0K
PiA+ID4gQEAgLTE3NTgsOCArMTc1OCwxNSBAQCBpbnQgZG9fcmVhZF9leHRjc2QoaW50IG5hcmdz
LCBjaGFyICoqYXJndikNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICBpZiAoZXh0
X2NzZF9yZXYgPj0gNykgew0KPiA+ID4gLSAgICAgICAgICAgICBwcmludGYoImVNTUMgRmlybXdh
cmUgVmVyc2lvbjogJXNcbiIsDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgKGNoYXIqKSZl
eHRfY3NkW0VYVF9DU0RfRklSTVdBUkVfVkVSU0lPTl0pOw0KPiA+ID4gKyAgICAgICAgICAgICBw
cmludGYoIkZpcm13YXJlIFZlcnNpb246DQo+ID4gPiAweCUwMnglMDJ4JTAyeCUwMnglMDJ4JTAy
eCUwMnglMDJ4XG4iLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NT
RF9GSVJNV0FSRV9WRVJTSU9OXzddLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGV4dF9j
c2RbRVhUX0NTRF9GSVJNV0FSRV9WRVJTSU9OXzZdLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGV4dF9jc2RbRVhUX0NTRF9GSVJNV0FSRV9WRVJTSU9OXzVdLA0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9GSVJNV0FSRV9WRVJTSU9OXzRdLA0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9GSVJNV0FSRV9WRVJTSU9OXzNd
LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9GSVJNV0FSRV9W
RVJTSU9OXzJdLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9G
SVJNV0FSRV9WRVJTSU9OXzFdLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGV4dF9jc2Rb
RVhUX0NTRF9GSVJNV0FSRV9WRVJTSU9OXzBdKTsNCj4gPiBFeHRDU0RbMjYxOjI1NF0gaXMgYW4g
QVNDSUkgc3RyaW5nLCBqdXN0IGFkZCBhIHRlcm1pbmF0aW5nIG51bGwuDQo+IA0KPiBVbmZvcnR1
bmF0ZWx5IEkgZm91bmQgdHdvIGRpZmZlcmVudCBtYW51ZmFjdHVyZXJzIHdoaWNoIHB1dA0KPiBu
b24tcHJpbnRhYmxlIGNoYXJhY3RlcnMgaW4gdGhpcyA4LWJ5dGUgZmllbGQuIFNvIEkgZG9uJ3Qg
dGhpbmsgaXQgY2FuDQo+IGJlIHRyZWF0ZWQgYXMgQVNDSUkgaW4gYWxsIGNhc2VzLiBQcmludGlu
ZyBvdXQgdGhlIGhleCB2YWx1ZSBzZWVtZWQNCj4gbGlrZWQgdGhlIG1vc3QgY29tcHJlaGVuc2l2
ZSBzb2x1dGlvbi4NCk5BSyB3aXRoIHByZWp1ZGljZS4NClRoaXMgaW50ZXJmZXJlIHdpdGggdGhl
IG91dHB1dCB0aGF0IHdlL291ciBjbGllbnRzIGV4cGVjdHMuDQo=
