Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB98C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270642081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mdkos8df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270642081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeK3ONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:13:25 -0500
Received: from mail-oln040092033094.outbound.protection.outlook.com ([40.92.33.94]:25684
        "EHLO NAM06-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbeK3ONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEEF4gna/fCcT0LIG89KEGL3RKAIu4PcOgJxcFHTmN0=;
 b=mdkos8df7ScFbE0ODXdonlBHVyoYRww5dfk9lgiM/Ahd4l/L8J5p8KCQjCZcJoU4Ce86r9IAuN6fVRFIQcPAwU5jaawFwERVtYo0jW32i3LGZyQHLF/iI6fjoFmKexXaYiS2I+0bm6FMfWy7FREkpoyXLz6JRhbWlBdFonwVIE+1IazraS5pZGTwFFSUgTflNKSrmLHeUkSpaPJKnr5MJf9+mQwJ9sRYTGtmhma1Dqoyms69NCgMleE0YpWMWCRznRieN9RZm4CLR7XXqgPkK0sKHIoGGT92wUBYgnuhkUr/LrBeXQKidp2E1P0dYjhQFiGsEjAxV7ubjyBo9KNi/w==
Received: from BL2NAM06FT003.Eop-nam06.prod.protection.outlook.com
 (10.152.106.59) by BL2NAM06HT023.Eop-nam06.prod.protection.outlook.com
 (10.152.107.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1420.0; Fri, 30 Nov
 2018 03:05:38 +0000
Received: from SN1PR13MB0304.namprd13.prod.outlook.com (10.152.106.59) by
 BL2NAM06FT003.mail.protection.outlook.com (10.152.106.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1420.0 via Frontend Transport; Fri, 30 Nov 2018 03:05:38 +0000
Received: from SN1PR13MB0304.namprd13.prod.outlook.com
 ([fe80::399e:4b0e:8423:5bad]) by SN1PR13MB0304.namprd13.prod.outlook.com
 ([fe80::399e:4b0e:8423:5bad%3]) with mapi id 15.20.1404.010; Fri, 30 Nov 2018
 03:05:38 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>
CC:     nd <nd@arm.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAHDqgCAAKwqAA==
Date:   Fri, 30 Nov 2018 03:05:38 +0000
Message-ID: <SN1PR13MB030426DBA527C725AE28B5A9DFD30@SN1PR13MB0304.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
In-Reply-To: <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To SN1PR13MB0304.namprd13.prod.outlook.com
 (2a01:111:e400:c42a::30)
x-incomingtopheadermarker: OriginalChecksum:F837E1216827B0D880A1693863126E8AB7FC749D2E3D7FF25ECA67C6F6D8B5EB;UpperCasedChecksum:68A3280B817CF404AC710605724811C5D8A91F9B5B93085DFE7CF5C9BABA4E87;SizeAsReceived:7841;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [KeZkD8Gvw26xp3rDnIxsnl/MXxB5c0fK]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2NAM06HT023;6:vU7904V9dlQThX80K9qjb2KwlIR2AKO8w1X7J3Jvk1+PfPsC0ZiDxsKzzYvwfHPeL6Gl2Bxykmuays94Z2HyU2mKam30+xVaYpN1sACR41GjQK/WhnVrAepu6yx4YKLxk2oTnDlorpuRQQuTE84EX/bdIyDopCv/zI5VgampkA1AUR01iViLYdeob5rmnZ/VAIKJVs2sO5d7mWbfSiH0l/X36BmcIPYqrAA06piVq1D7VrpYhAp0DE/NihqGi36G80N8tu/r21D9y7qwrhJMyzlnRUNO7qmmJmv2gyfTEVhDS/GtB9vR/84JxORsa9eHGR2ZUhOY9c9blj88/Yn36qeCDHcUVs2grVHH8Qt+DPe7HSqzTkdYk/mnmzHW/T6RBYKACeccLRgJ9Lt1guZG640SuxQDwPBoUZokcleofLxLfU1yCV+PPZwaVRAh8hbGWGlJcfqtBgeptrYTKKfilg==;5:iXqbcXWwl7ju8cNYhZrumnqOSdiQ4/udqTOasMv4tJaovuySgnqKXWXVNAFKAcJuazeQxvIp6B93DCupiv5IPZ+gCTIXQUBYXlqfsRy95AZrNhrc1fq+krcvSLl2/vbI+X3ohcTRx+mfI6O0pb3JVMzU/+1+d7p1iG/vzjc3mHQ=;7:U7+iBpUGrfPdHWEycYXWvSpM3CpuETzuMNUtV47w7ljlaTquswl27iCY7xY92UKItuTtUa++ALOBArl7BS42KyJ5y7eOAsjnV8OOlxtHUZ5qXVYO2aD92cX8LesFmsnSNldt09o8DYq1AsA9w/JQ9g==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(20181119015)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BL2NAM06HT023;
x-ms-traffictypediagnostic: BL2NAM06HT023:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BL2NAM06HT023;BCL:0;PCL:0;RULEID:;SRVR:BL2NAM06HT023;
x-microsoft-antispam-message-info: 8C0S+f9k0G/opC9kt0hEbPaRrmpqGgMrEUek/fRILGPfobMmR3AtMpSUESO3UVNk
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6EBD592B08D0F498AA624BA786DEEC9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: b6587b75-6f1a-4db7-b0b6-5cad10ef59a7
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e54b4-be0b-4f82-1385-08d65670b34a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: b6587b75-6f1a-4db7-b0b6-5cad10ef59a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 03:05:38.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM06HT023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2ZSwNCg0KDQpPbiAyMDE4LzExLzMwIDA6NDksIERhdmUgUm9kZ21hbiB3cm90ZToNCj4g
T24gMjgvMTEvMjAxOCAxOjUyIHBtLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+DQo+PiBUaGUgZml4
IGlzIGFkZGluZyBhIGZldyBicmFuY2hlcyB0byBjb2RlIHRoYXQncyBzdXBwb3NlZCB0byBiZSBh
cyBmYXN0DQo+PiBhcyBwb3NzaWJsZS4gVGhlIGJyYW5jaGVzIHdvdWxkIGJlIGV2YWx1YXRlZCBh
bGwgdGhlIHRpbWUgd2hpbGUNCj4+IHByb3RlY3RpbmcgYWdhaW5zdCBvbmUgc2lnbmxlIGJhZCBw
YWdlIGFkZHJlc3MuIFRoaXMgZG9lcyBub3QgbG9vayBsaWtlDQo+PiBhIGdvb2QgcGVyZm9ybWFu
Y2UgdHJhZGVvZmYuDQo+IEFzIGFuIGFsdGVybmF0aXZlLCBmb3IgYWxsIGJ1dCB0aGUgZmlyc3Qg
Y2FzZSwgaW5zdGVhZCBvZjoNCj4NCj4gaWYgKHVubGlrZWx5KE9WRVJGTE9XX0FERF9DSEVDSyhp
cCwgbV9sZW4pIHx8IChpcCArIG1fbGVuID49IGlwX2VuZCkpKQ0KPg0KPiBJJ2Qgc3VnZ2VzdCB3
ZSBkbzoNCj4NCj4gaWYgKHVubGlrZWx5KChpcF9lbmQgLSBpcCkgPD0gbV9sZW4pKQ0KPg0KPiB3
aGljaCB3aWxsIGJlIGFib3V0IGFzIGVmZmljaWVudCBhcyB3aGF0J3MgY3VycmVudGx5IHRoZXJl
LCBidXQgZG9lc24ndA0KPiBoYXZlIGlzc3VlcyB3aXRoIG92ZXJmbG93Lg0KDQpPb2gsIHllcywg
cHJldHR5IGdvb2Qgc29sdXRpb24gdG8gdGhpcywgdGhhbmtzLg0KDQo+IERhdmUNCg0KVGhhbmtz
LA0KWXVleWkNCg==
