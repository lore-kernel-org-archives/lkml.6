Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE33C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8378216EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ui4suC4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8378216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHHFzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:55:04 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:2944
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbeHHFzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ6wo4zD02shIfEhJy/RcucCVgqZadFWUFhzsNS1kNM=;
 b=ui4suC4c7SEPuclhPNz0mANB5aeZn8hYGP0jMI4uFnjWclvPNfc0ce5ziF6jCIwJEWz2xqWDWI3y8nxWAiK2RZ3AK3JS211wSHKhbSQjgw0MZC5Ija1esw7IKV1tQIsNRsELamAXR3DqpZyRcZ/z5jwBlFdTkYBHufxsloB8HKU=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2564.eurprd04.prod.outlook.com (10.169.245.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 8 Aug 2018 03:37:28 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 03:37:28 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>, Rob Herring <robh@kernel.org>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Thread-Topic: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq
 ranges
Thread-Index: AQHUJY+K8uzq+AdU50upvFCJxJJUJ6S0qHwAgAAwmwCAAGuVwA==
Date:   Wed, 8 Aug 2018 03:37:28 +0000
Message-ID: <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
         <20180807180938.GA13623@rob-hp-laptop>
 <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
In-Reply-To: <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2564;6:mnnRb4AeAW91yJnhZgtbU7GNtA/t/CaLxk1hMFHNImBr0q06bimUH5BK5r5dvYnL82hvzZyM8gbYdz7bVplGf8ZxKqGs3JcKX6ah0Dus2dAyJDrCpQJz9Kcd3w/SF5YIQVzH0Pn0YCI26+CKA21/o3JXJ/0S2oE+dO+GtUm5oI9mcBVeJGhBD/XS4SLbfEpDcFxZ3TBe0QeOcMkXOhrDQzaRNEi7cuBCH988pnAs3mh1M0p1en90d0xRi1rUQqPlr/b0QV79oeJrCDHtFUyJ40xISDvEUALwEYTmFCEJOLrFr/0NZn9eirxjMqZ8DIvd/pXqzYD2pXcBaakraduX3XTQ7DTraDdwBTmd2ENhT1Vr1fyhq17DNCEXiwJuFM4TjizTcczpZwjQwbo04I0ZfRNBqw0YzJ+Uc0XA997f05VElDHN7XIQW/7sjc3DhF0rRn1pS75qJ+zmejqbXi0urg==;5:KrjhYdlPT0ZjA6mavpBMIwVNSc6DCjNZ/AoeyEdVpRtdpF/NuPwZso0Xe2a3orgkQtQ6b4pf6glmB/U1RbhZJIrqXcsxUUsX7MaFy/pZHSVFQw6JzoqjSBbvGUmCl93b3v7b7frSW+A2gRWS9tecMv9kiSXG3h/ejtoUR4gHTeQ=;7:ryjIqun/Jm6r81GFWELYGQRAajkCeSfCwzOsETgZnjC3IMKvdkjwel82OR++C3cFYNAyYg2j+RqBjqEl1r4fHdCpzYsaA3ri7LaYVilOuCJ+Ypg/3CHR+HUwSQt3Mxrk86RA98Nqs9u8p1frL3OlLNtKlGPXNnRWIppXDrC+4r6hxh8rjRsXQbm5OBmxbjDk2yYfDjGPBSUrwfW0OR6LzAK/HigawUWEvOiH0XFE/fGECU4A112N4f6tw23Aknz1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c2906bc6-2294-4526-661b-08d5fce043c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2564;
x-ms-traffictypediagnostic: AM5PR0401MB2564:
x-microsoft-antispam-prvs: <AM5PR0401MB25641BFAC5C194BC0867C44C9A260@AM5PR0401MB2564.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2564;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2564;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(13464003)(189003)(199004)(68736007)(316002)(6506007)(53546011)(8936002)(110136005)(54906003)(9686003)(7696005)(55016002)(102836004)(305945005)(7736002)(74316002)(25786009)(53936002)(76176011)(6246003)(186003)(8676002)(4326008)(99286004)(6436002)(81156014)(229853002)(81166006)(26005)(14454004)(478600001)(93886005)(97736004)(256004)(66066001)(14444005)(2906002)(105586002)(44832011)(7416002)(106356001)(86362001)(11346002)(446003)(476003)(486006)(5250100002)(33656002)(3846002)(6116002)(2900100001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2564;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3FyndEAJUlXdIuyvGL08xzFlKIT5xZ9sQW32ASt0ZwTzvqQbdRUBkNSuXCPmb00oTxZF85oYwPBpsvJz1bjOYAQR/rx893UQF0ol2w9O0skf4GtmDbqN+8d310rS5YIvF6dTl7kM1CI9Dzr67PcwXnFJmYuY8Z2RhEKcvPwOgU5tmbd0Mffs5XzbIFKGF8lqcja2Q/701whSc8gk9e8l43iVYB3pHiZRinFuPBxwKXGIdfnijpb3VcIwx5Ck3S3X6X2sH0xOfwt7pshpHKt4lpQ4qldYpavy1hhQaOQZbUGvjgmDu5B5vu8/L1f4r43G+J337Njk2NJXflwQPhywFNGg/8vnNpeEfbgKJoe2Pqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2906bc6-2294-4526-661b-08d5fce043c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 03:37:28.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
MjozNCBBTQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEJoYXJhdCBCaHVz
aGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPg0KPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hp
bmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+IGdhbGFrQGtl
cm5lbC5jcmFzaGluZy5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0KPiB0eXJl
bGRAbGludXgudm5ldC5pYm0uY29tOyBqb2VAcGVyY2hlcy5jb20NCj4gU3ViamVjdDogUmU6IFtS
RkMgMy81XSBwb3dlcnBjL21waWM6IEFkZCBzdXBwb3J0IGZvciBub24tY29udGlndW91cyBpcnEN
Cj4gcmFuZ2VzDQo+IA0KPiBPbiBUdWUsIDIwMTgtMDgtMDcgYXQgMTI6MDkgLTA2MDAsIFJvYiBI
ZXJyaW5nIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVsIDI3LCAyMDE4IGF0IDAzOjE3OjU5UE0gKzA1
MzAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gRnJlZXNjYWxlIE1QSUMgaC93IG1heSBu
b3Qgc3VwcG9ydCBhbGwgaW50ZXJydXB0IHNvdXJjZXMgcmVwb3J0ZWQgYnkNCj4gPiA+IGhhcmR3
YXJlLCAibGFzdC1pbnRlcnJ1cHQtc291cmNlIiBvciBwbGF0Zm9ybS4gT24gdGhlc2UgcGxhdGZv
cm1zIGENCj4gPiA+IG1pc2NvbmZpZ3VyZWQgZGV2aWNlIHRyZWUgdGhhdCBhc3NpZ25zIG9uZSBv
ZiB0aGUgcmVzZXJ2ZWQNCj4gPiA+IGludGVycnVwdHMgbGVhdmVzIGEgbm9uLWZ1bmN0aW9uaW5n
IHN5c3RlbSB3aXRob3V0IHdhcm5pbmcuDQo+ID4NCj4gPiBUaGVyZSBhcmUgbG90cyBvZiB3YXlz
IHRvIG1pc2NvbmZpZ3VyZSBEVHMuIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcw0KPiA+IHNwZWNpYWwg
YW5kIG5lZWRzIGEgcHJvcGVydHkuDQo+IA0KPiBZZWFoLCB0aGUgc3lzdGVtIHdpbGwgYmUganVz
dCBhcyBub24tZnVuY3Rpb25pbmcgaWYgeW91IHNwZWNpZnkgYSB2YWxpZC1idXQtDQo+IHdyb25n
LWZvci10aGUtZGV2aWNlIGludGVycnVwdCBudW1iZXIuDQoNClNvbWUgaXMgb25lIGFkZGl0aW9u
YWwgYmVuZWZpdHMgb2YgdGhpcyBjaGFuZ2VzLCBNUElDIGhhdmUgcmVzZXJ2ZWQgcmVnaW9ucyBm
b3IgdW4tc3VwcG9ydGVkIGludGVycnVwdHMgYW5kIHJlYWQvd3JpdGVzIHRvIHRoZXNlIHJlc2Vy
dmVkIHJlZ2lvbnMgc2VhbXMgaGF2ZSBubyBlZmZlY3QuDQpNUElDIGRyaXZlciByZWFkcy93cml0
ZXMgdG8gdGhlIHJlc2VydmVkIHJlZ2lvbnMgZHVyaW5nIGluaXQvdW5pbml0IGFuZCBzYXZlL3Jl
c3RvcmUgc3RhdGUuDQoNCkxldCBtZSBrbm93IGlmIGl0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSB0aGVz
ZSBjaGFuZ2VzIGZvciBtZW50aW9uZWQgcmVhc29ucy4NCg0KVGhhbmtzDQotQmhhcmF0DQoNCj4g
DQo+ID4gIFdlJ3ZlIGhhZCBzb21lIGludGVycnVwdCBtYXNrIG9yIHZhbGlkIHByb3BlcnRpZXMg
aW4gdGhlIHBhc3QsIGJ1dA0KPiA+IGdlbmVyYWxseSBkb24ndCBhY2NlcHQgdGhvc2UuDQo+IA0K
PiBGV0lXLCBzb21lIG9mIHRoZW0gbGlrZSBwcm90ZWN0ZWQtc291cmNlcyBhbmQgbXBpYy1tc2dy
LXJlY2VpdmUtbWFzaw0KPiBhcmVuJ3QgZm9yIGRldGVjdGluZyBlcnJvcnMsIGJ1dCBhcmUgZm9y
IHBhcnRpdGlvbmluZyAodGhvdWdoIHRoZSBmb3JtZXIgaXMNCj4gb2Jzb2xldGUgd2l0aCBwaWMt
bm8tcmVzZXQpLg0KPiANCj4gLVNjb3R0DQoNCg==
