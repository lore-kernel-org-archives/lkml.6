Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1211F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iZcukRhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1211F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK3X34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:29:56 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:14841
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbeK3X3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3pwa42tz6Z4GqLS1cchSXPEevcZVJEfwpSacUOfOlM=;
 b=iZcukRhRXFTY1UCvxOxZdjtVblORHU9GQEkT7oGikBE7zXtSRPdyOeFnGG8boo12MPyBa6c40MkcWwWmh/DxDQXGVVUDXqYkIPEayPmV224w2xpPTSvZ/QwnGFXeMm3AlspyvAnc/GB7oNF4j2TWMOtdFQIjf7QqklfHi3MlFG4=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2271.eurprd08.prod.outlook.com (10.172.13.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 12:20:45 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 12:20:45 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Yueyi Li <liyueyi@live.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAHDqgCAAKwqAIAAmyGA
Date:   Fri, 30 Nov 2018 12:20:44 +0000
Message-ID: <3bde9678-ac05-62f1-bfc3-434832adda11@arm.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
 <SN1PR13MB030426DBA527C725AE28B5A9DFD30@SN1PR13MB0304.namprd13.prod.outlook.com>
In-Reply-To: <SN1PR13MB030426DBA527C725AE28B5A9DFD30@SN1PR13MB0304.namprd13.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::13) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2271;6:w2pPbUV9ybiQvKmp2XEvsHRVhM4TXQMVTgoehQKScmmykD/ltflx5XaKbBFX+ELhINwYs/WHY1uRMzdgmLBo+Qmc90cj01dlVi9XKK/iZQXQBd+tGFhlYQr8i1BDtM/rtW3vVPb94F37BXa13E1cBtCMDsPZltdmPLrOoU/D7ZgJr9Kc+UmiU5pBfJeqlAa/3yN+h8mxh0wdP21oQnFieyIy5X+HGrOkujNHoOKh94VIBj3C7pgcd8Bf3qCgElFCKH2dUjjwqeN9+gZiqk4xNARkKnWBnWz/R+pSdJB6sf1X8HtdacwGkwbA4GZl6T/OLhe+gzT0rc2T3ngZQ1/cG9JmmPodnLQwtGS7v6t4J9NLixbuj+ByaOCGoZedizXigoIc9UIoiKfi8qJEeWo5v6GTRCdYqdntpTV0s87SLUhsjqNDJi7b46CSYERRA1raaEKiE6QkgxDO+RfCCL+2Qw==;5:P6W577EJdET/GbMmgGRXCHwfGDt45BcGkEbQwT1b3nPp/MSn05K/hURs/lkPrwqPh3ZUgtwDjH0cW1z49cmBIthLweEM2Lz9ApsMHzZiEtBlBiDlBtWCuED1gnkem7h0lqBmFU1S43NXXL1Y/SrYui75krlv/rjnMhpuSgb5MBQ=;7:/tqOnlsOvztuXsP3mldm/pII/YFBHxo7+SNLDOgter5JQXeDdF8UA3AKNLBq2djFQMvQW+dc5f+sQmDcO6P457KIAIA/R6kfkHalotVkf4YIXVEFvLry/3STwmS8FGaCCFErLGL2qCskzhXrYV63+A==
x-ms-office365-filtering-correlation-id: 05df6ed0-bd21-4bc0-38c8-08d656be4087
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2271;
x-ms-traffictypediagnostic: VI1PR0802MB2271:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB227177B35CA534C5FEBBCA938FD30@VI1PR0802MB2271.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2271;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2271;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(386003)(11346002)(99286004)(68736007)(6486002)(36756003)(71190400001)(486006)(6506007)(81156014)(8676002)(66066001)(7736002)(44832011)(5660300001)(71200400001)(476003)(6116002)(3846002)(966005)(97736004)(25786009)(31686004)(2906002)(6246003)(31696002)(53546011)(76176011)(39060400002)(86362001)(256004)(6512007)(81166006)(14454004)(6306002)(305945005)(446003)(26005)(106356001)(229853002)(105586002)(186003)(2501003)(110136005)(4326008)(102836004)(6436002)(2616005)(53936002)(52116002)(478600001)(93886005)(54906003)(8936002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2271;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k5EbpXpEZcDz30rMVAd57ykMeSTMOefzBNEtta3uvQqGoAEPitHIg+ApK8O+IOeT3tP+B3KbLQANu4Ef0mcSF6s5+3PYpd/FszUdJkE4Ug2pXjLvLKEerv2kj5prBEDJoQhVdyyrMRltIiJKGSxV0WUVMI7s6QAPfiQua3fyTsFN0MjC0fLt50UQGQu3wMpEvhRkNf6sqT6zd2J5hKbti/6WuGnOHtydXFa/VP6nKMYJf0JLa6pPsYXlVH9pA1k9uG3nighuC3AN6Hm+gKtj+v48XnwT+J5QP6j7PQIhQ7vp79yvuz+85Z6cx8OfLms4QsvFm99Em1VcMwakuPEs4KESAsL5bT/d2PnclmKOe/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3481CF33154C8045B17EC0C8A0746FA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05df6ed0-bd21-4bc0-38c8-08d656be4087
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 12:20:44.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDE4LzExLzMwIDA6NDksIERhdmUgUm9kZ21hbiB3cm90ZToNCj4+IE9uIDI4LzExLzIw
MTggMTo1MiBwbSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4NCj4+PiBUaGUgZml4IGlzIGFkZGlu
ZyBhIGZldyBicmFuY2hlcyB0byBjb2RlIHRoYXQncyBzdXBwb3NlZCB0byBiZSBhcyBmYXN0DQo+
Pj4gYXMgcG9zc2libGUuIFRoZSBicmFuY2hlcyB3b3VsZCBiZSBldmFsdWF0ZWQgYWxsIHRoZSB0
aW1lIHdoaWxlDQo+Pj4gcHJvdGVjdGluZyBhZ2FpbnN0IG9uZSBzaWdubGUgYmFkIHBhZ2UgYWRk
cmVzcy4gVGhpcyBkb2VzIG5vdCBsb29rIGxpa2UNCj4+PiBhIGdvb2QgcGVyZm9ybWFuY2UgdHJh
ZGVvZmYuDQo+PiBBcyBhbiBhbHRlcm5hdGl2ZSwgZm9yIGFsbCBidXQgdGhlIGZpcnN0IGNhc2Us
IGluc3RlYWQgb2Y6DQo+Pg0KPj4gaWYgKHVubGlrZWx5KE9WRVJGTE9XX0FERF9DSEVDSyhpcCwg
bV9sZW4pIHx8IChpcCArIG1fbGVuID49IGlwX2VuZCkpKQ0KPj4NCj4+IEknZCBzdWdnZXN0IHdl
IGRvOg0KPj4NCj4+IGlmICh1bmxpa2VseSgoaXBfZW5kIC0gaXApIDw9IG1fbGVuKSkNCj4+DQo+
PiB3aGljaCB3aWxsIGJlIGFib3V0IGFzIGVmZmljaWVudCBhcyB3aGF0J3MgY3VycmVudGx5IHRo
ZXJlLCBidXQgZG9lc24ndA0KPj4gaGF2ZSBpc3N1ZXMgd2l0aCBvdmVyZmxvdy4NCj4gDQo+IE9v
aCwgeWVzLCBwcmV0dHkgZ29vZCBzb2x1dGlvbiB0byB0aGlzLCB0aGFua3MuDQoNCk5wIDotKQ0K
DQpBY3R1YWxseSwgbG9va2luZyBtb3JlIGNsb3NlbHkgYXQgdGhlIGZpcnN0IGNhc2UsIHNvbWV0
aGluZyBsaWtlIHRoaXMgDQp3b3JrcyBxdWl0ZSB3ZWxsOg0KDQpzaXplX3QgaW5jID0gMSArICgo
aXAgLSBpaSkgPj4gNSk7DQppZiAodW5saWtlbHkoKGlwX2VuZCAtIGlwKSA8PSBpbmMpKQ0KCWJy
ZWFrOw0KaXAgKz0gaW5jOw0KDQpPbiBhcm02NCwgdGhpcyBnZW5lcmF0ZXMgb25seSBhIHNpbmds
ZSBicmFuY2ggaW5zdHJ1Y3Rpb24sIHNvIGl0J3Mgb25seSANCnR3byBleHRyYSBhcml0aG1ldGlj
IG9wZXJhdGlvbnMgbW9yZSB0aGFuIHRoZSBvcmlnaW5hbCBjb2RlICh1c2luZyB0aGUgDQptYWNy
byByZXN1bHRzIGluIGFuIGFkZGl0aW9uYWwgY29tcGFyZSAmIGJyYW5jaCkuDQoNCkkgdXNlZCB0
aGlzIHRvIGV4cGxvcmUgdGhlIGNvbXBpbGVyIG91dHB1dDoNCg0KaHR0cHM6Ly9nb2Rib2x0Lm9y
Zy96L25nMnFHWg0KDQpEYXZlDQo=
