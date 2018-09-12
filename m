Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A10C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795AF20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795AF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeILV5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:57:40 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:14525 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeILV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:57:40 -0400
Received: from G9W8454.americas.hpqcorp.net (g9w8454.houston.hp.com [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 7FFD797;
        Wed, 12 Sep 2018 16:52:16 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 12 Sep 2018 16:52:14 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 12 Sep 2018 16:52:14 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0385.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Wed, 12 Sep 2018 16:52:12 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1122.020; Wed, 12 Sep 2018
 16:52:12 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "jack@suse.cz" <jack@suse.cz>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Topic: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Index: AQHUSekFUjINM6/+Z0KwkBt2ibRdAqTsYPUAgABlMgCAAA8lAIAAAwUA
Date:   Wed, 12 Sep 2018 16:52:12 +0000
Message-ID: <80fb47d31dfced7cf8d115bd55768447e9e53a84.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
         <20180911154246.6844-2-toshi.kani@hpe.com>
         <20180912092422.GA7782@quack2.suse.cz>
         <92faf51ac89e62dcd67e39cc66eef60966d1263c.camel@hpe.com>
         <20180912162046.GA23522@quack2.suse.cz>
In-Reply-To: <20180912162046.GA23522@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0385;6:iK0vTkQvzpQOykibkthgVB0LO2zC5Ykd6zHwh3kSF5xUxxkhjAhDS4BcKLAzsUi/V/E3yw8qRzubFlNaeB4opzsa9xvik4ZpFrEZrIG5596u8SthDkH4RQUToYHNZxqHFVHaUW0IXJ4fnCiPPZ9imkQuadIkGoRp4WlnFMOPOFbU6zFbEjtzCHFo3OzuWIk+dP5awMfiBjgmuB2ADBN2qGhkVswWqsdlKrpMu1RPHdWwxlFWqPqDyOMcOjWlvu59HFJxmJx34SYHv/lIEzFou2/xyiiLzw1lyxPsMzDNG6gQ70FQrXBCyv11nErXhceRQ9MkFiiiPYPQcOhVJjjdX76noywgxu9CNVUES8U5ZaQtcSWYSgVBb5bwJx/Hbn0UmDdsHjgxCgvX33zh/j5EzFg1BjtitbOd0vNSx8iWT5zJbb7jNLmnDiYiyxKyU133wrRK1DRo7r2kiK2qWXmoMw==;5:zU/T2kK86jlUxDF+zuD4NntuquqxSZEAMq747qiSb+8SIKYC3GNHcYeir4KJPg8I/qkBJhQ8/JrA+f4JebEg0T8F64kO0GZtjKMA9LFzCU9YFnbhz2u9ZGSZclQuJaLUcJB12bHxd6Ho+WJq2cGW2CKLYG0/AlShgc/dTvmaGMY=;7:7PxvQeiZQHmkmNWLbEnNSKxJd9rZNzFV3f8E5cvduq2veYDjpu5iT3KZg5Ondusux8kFOmPzVRjsaH2lnkfw+y4gmDLz1yJwu26yHzUvkZCoazQhOnxUEmO4OXELzdJC7qh3Oa7qT1MHurCiaiKf1zasqshBPdZpT7FVv8TRgEWZpqdHVLeownHCYdGgx5ao/0HcJqBWsDyymimsI5OjOnf+zKc46F4AIGkqBX/eJL8foGH7g3SCX+WD8OanGRP/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ad1fedea-7f75-4d04-8a0e-08d618d01644
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0385;
x-ms-traffictypediagnostic: AT5PR8401MB0385:
x-microsoft-antispam-prvs: <AT5PR8401MB0385E5629AAE37A84DB8A483821B0@AT5PR8401MB0385.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(190756311086443)(227479698468861)(240460790083961)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0385;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0385;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(476003)(25786009)(1730700003)(99286004)(105586002)(81156014)(106356001)(76176011)(36756003)(8936002)(66066001)(256004)(2351001)(5660300001)(486006)(14444005)(81166006)(15650500001)(14454004)(2906002)(6246003)(2900100001)(2616005)(4326008)(93886005)(118296001)(6436002)(6116002)(6512007)(478600001)(3846002)(68736007)(53936002)(446003)(5640700003)(6506007)(97736004)(11346002)(86362001)(575784001)(7736002)(26005)(6486002)(6916009)(305945005)(8676002)(316002)(5250100002)(186003)(54906003)(102836004)(229853002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0385;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 13SbdMoYbtB+f9RqXr0IO3KAxfuxTnKhSVGRdPiuWuNHC18/J6aAytUt80DO6yMj7q3G5NIFjQQ044NoUuib/w+1Y+y2Sll7lb/X11fdGZjseVZd909YyIl5ObtZilRTvNXmBNm4Ly3G3IDyEd/zbwOO8aysKcgFs0cfY0ojRQeI5sAXIm0R/PnL2Rx19H1P6vSOMkXxGGxegqCkOW8z/xiP87aNLJr+FC2eQ6K9ZBVQIcNz6NySwGaNeBbReBGPyUZ06cGHEB06hB9LYimWA95PaeK938EwsEOp7GcnfZZ4LkSBYHY5R0SXUMQcAb0djcWNR/Vt/ncJgK0YknaU1tQRhSHj30gCalCxai8vLEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B2CEFF2271F7948B0551D7A14AAFC21@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1fedea-7f75-4d04-8a0e-08d618d01644
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 16:52:12.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0385
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDE4OjIwICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
V2VkIDEyLTA5LTE4IDE1OjQ3OjEyLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MTgtMDktMTIgYXQgMTE6MjQgKzAyMDAsIEphbiBLYXJhIHdyb3RlOg0KPiA+ID4gT24gVHVlIDEx
LTA5LTE4IDA5OjQyOjQ1LCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+ID4gPiBFeHQ0IG1vdW50IHBh
dGggY2FsbHMgZXh0NF9pZ2V0KCkgdG8gb2J0YWluIHRoZSBqb3VybmFsIGlub2RlLiAgVGhpcw0K
PiA+ID4gPiBpbm9kZSBkb2VzIG5vdCBzdXBwb3J0IERBWCwgYW5kICdleHQ0X2RhX2FvcHMnIG5l
ZWRzIHRvIGJlIHNldC4gIEl0DQo+ID4gPiA+IGN1cnJlbnRseSB3b3JrcyBmb3IgdGhlIERBWCBt
b3VudCBjYXNlIGJlY2F1c2UgZXh0NF9pZ2V0KCkgYWx3YXlzIHNldA0KPiA+ID4gPiAnZXh0NF9k
YV9hb3BzJyB0byBhbnkgcmVndWxhciBmaWxlcy4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgZXh0NF9m
aWxsX3N1cGVyDQo+ID4gPiA+ICAgICBleHQ0X2xvYWRfam91cm5hbA0KPiA+ID4gPiAgICAgICBl
eHQ0X2dldF9qb3VybmFsX2lub2RlDQo+ID4gPiA+ICAgICAgICAgZXh0NF9pZ2V0DQo+ID4gPiA+
IA0KPiA+ID4gPiBJbiBwcmVwYXJhdGlvbiB0byBmaXggZXh0NF9pZ2V0KCkgdG8gc2V0ICdleHQ0
X2RheF9hb3BzJyBmb3IgREFYIGZpbGVzLA0KPiA+ID4gPiB1cGRhdGUgZXh0NF9zaG91bGRfdXNl
X2RheCgpIHRvIHJldHVybiBmYWxzZSBmb3IgdGhlIGpvdXJuYWwgaW5vZGUuDQo+ID4gPiA+IA0K
PiA+ID4gPiBGaXhlczogNWYwNjYzYmI0YTY0ZjU4OGYwYTJkZDZkMWJlNjhkNDBmOWFmMDA4Ng0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+DQo+
ID4gPiA+IENjOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KPiA+ID4gPiBDYzogRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gPiA+IENjOiAiVGhlb2RvcmUgVHMn
byIgPHR5dHNvQG1pdC5lZHU+DQo+ID4gPiA+IENjOiBBbmRyZWFzIERpbGdlciA8YWRpbGdlci5r
ZXJuZWxAZGlsZ2VyLmNhPg0KPiA+ID4gDQo+ID4gPiBUaGUgam91cm5hbCBpbm9kZSBpcyBzaW1p
bGFyIHRvIGFueSBvdGhlciAnc3lzdGVtJyBpbm9kZSB3ZSBoYXZlIGluIGV4dDQuDQo+ID4gPiBX
ZSBkb24ndCByZWFsbHkgZXhwZWN0IGFueSBvZiB0aGUgYWRkcmVzcyBzcGFjZSBvcGVyYXRpb25z
IHRvIGJlIGNhbGxlZCBmb3INCj4gPiA+IGl0IGJlY2F1c2Ugd2UgZG9uJ3QgdXNlIHBhZ2UgY2Fj
aGUgd2l0aCB0aGVzZSBpbm9kZXMuIFZlcnkgc2ltaWxhcg0KPiA+ID4gc2l0dWF0aW9uIGlzIHdp
dGggZS5nLiBxdW90YSBmaWxlcy4gU28gdG8gbWUgaXQgc2VlbXMgdGhpcyBwYXRjaCBpcyBub3QN
Cj4gPiA+IHJlYWxseSBuZWNlc3NhcnkuIE9yIGRpZCB5b3Ugb2JzZXJ2ZSBhbnkgYmFkIGVmZmVj
dHMgd2l0aG91dCB0aGlzIHBhdGNoPw0KPiA+IA0KPiA+IFllcywgd2l0aG91dCB0aGlzIGNoYW5n
ZSwgbW91bnQgZmFpbHMgd2l0aCB0aGUgZXJyb3IgYmVsb3cuICBJIGJlbGlldmUNCj4gPiAuYm1h
cCBvcGVyYXRpb24gaW4gZXh0NF9kYV9hb3BzIGlzIG5lY2Vzc2FyeSBmb3IgdGhpcyBjYXNlLg0K
PiA+IA0KPiA+ICAgamJkMl9qb3VybmFsX2luaXRfaW5vZGU6IENhbm5vdCBsb2NhdGUgam91cm5h
bCBzdXBlcmJsb2NrDQo+ID4gICBFWFQ0LWZzDQo+ID4gKHBtZW0xKTogQ291bGQgbm90IGxvYWQg
am91cm5hbCBpbm9kZQ0KPiANCj4gQWgsIE9LLCBmb3Jnb3QgYWJvdXQgdGhpcy4gVGhlbiBob3cg
YWJvdXQgYWRkaW5nOg0KPiAJLmJtYXAgICAgICAgICAgICAgICAgICAgPSBleHQ0X2JtYXAsDQo+
IA0KPiB0byBleHQ0X2RheF9hb3BzPyAuYm1hcCBpcyBjb21wbGV0ZWx5IGZpbmUgZm9yIERBWCBp
bm9kZXMgYW5kIHRoZXJlJ3Mgbm8NCj4gcmVhc29uIHRvIGRpc2FsbG93IGl0Lg0KDQpZZXMsIG1v
dW50IC1vIGRheCBzdWNjZWVkcyB3aXRoIHRoZSBhZGRlZCBleHQ0X2JtYXAgaW4gZXh0NF9kYXhf
YW9wcy4NCg0KVGhhbmtzIQ0KLVRvc2hpDQoNCg==
