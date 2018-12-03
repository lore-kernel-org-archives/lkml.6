Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D60CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51873206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="eXMMgcWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51873206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLCCqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:46:46 -0500
Received: from mail-oln040092010061.outbound.protection.outlook.com ([40.92.10.61]:63312
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbeLCCqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTwFAIRwuCWzkjY3XgxAcHrCU6kosJuSxzZIIvAPgfU=;
 b=eXMMgcWlHD/QgBjOaS4Yuwde5nxdU1tXvQDmRHd093tB06nBVcEE4zfU3m+Sh1H19nfrYi894MmD4IZhRfx5zVQchqNOSUMUSquhbqspCT63d7wP3DJkycEwXLfNTMTDxoUZ7svxuEWuOLKIhfU8gTiGJgVNwDfNC+hfeW9/v2tVARsWrLan7lab2LmgQPyalhPLUHU8nbyIj4SGLfvPBI8cH/wxjSP9FWSQ72CsFyDuFzwCITJ0NFiIP2sSAyqRFckNHma0u9jKMKjzFg5Sq4/rZaysnAc69ySCv6Xq4fPw9I1gphy5mY00Ud+tgFp83gpelGUK6Gzaa1eROrb6+g==
Received: from BN3NAM04FT059.eop-NAM04.prod.protection.outlook.com
 (10.152.92.59) by BN3NAM04HT122.eop-NAM04.prod.protection.outlook.com
 (10.152.93.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Mon, 3 Dec
 2018 02:46:38 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.92.60) by
 BN3NAM04FT059.mail.protection.outlook.com (10.152.93.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Mon, 3 Dec 2018 02:46:38 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1404.011; Mon, 3 Dec 2018
 02:46:38 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>, "w@1wt.eu" <w@1wt.eu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAHDqgCAAKwqAIAAmyGAgAQWjQA=
Date:   Mon, 3 Dec 2018 02:46:38 +0000
Message-ID: <BLUPR13MB02895D29089318B8B3519D9ADFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
 <SN1PR13MB030426DBA527C725AE28B5A9DFD30@SN1PR13MB0304.namprd13.prod.outlook.com>
 <3bde9678-ac05-62f1-bfc3-434832adda11@arm.com>
In-Reply-To: <3bde9678-ac05-62f1-bfc3-434832adda11@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:C371B4487DB0351275D536E536E435D25F90D735525F3343C2ED428FEB092420;UpperCasedChecksum:EDC0B9CE0D3DFA6316CEB6CD09B9826FBB54B5C41AC0974FD429FA22A580040E;SizeAsReceived:7982;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [s/EZZrUldj2lDRRi75ktGPVraf5uKc/3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM04HT122;6:jxwoFyVmIhtwIdOSoz9R19svg55yV7/ZYfoGNwfwp84FgZQEfx6GVh0Us/gcjsjqlUZ1FxLDl70OvNHB2qd57TrN7RvY20yDKru0ChXfddbc5HVynE+8y1Dc5i3eeDWNS+myk+afHm9UAo0mGdv0OBKb0eEkVNBrLLmy419VCzBBBvTicfakvMpbLcDzCOmmbFq0LpW1tucGsZ82zeeCixrmobEl16Vhq+Nrlu2FKOb4oLJVSfgdZAx3aikTLLV+tG+Md1VBFuJrCWLKE/1/pH6BJQ4EapMvcSSvAx0I1oUhEOs6Plvmhs1A/evttaGjJhS4H6rXRgx1v0rlpxptMUlS/tMgc5BlBjR8NcX/HRdkFbpJSqpJZKaFS5aZaFMt7HpglhYxPDpGW1WxLHAPaVRBqd18HemHTxB14erLIVIajBsLnbEonK6nhxZX0PttLzD1HeAc+jbWnhG7ApuGrg==;5:1fPrQ8JRLI0jGhPCpzPhvBNodV2t80d5dj4r3M0ejE9coID2f02iSsVNZHF03yWqZYqU62KRDG/1SRjlGS27ekVghS1JwGYR2a1Ejkp8R3lrvCt38qoqLiMvgkGfvi3NEf+tQhbRYqZP5sUin8zD68BBvtc+7h6wOQhZ5Eh6cFo=;7:r40/NrIAI3mubfA4L689xmVbzMlJpdS00CszT0OcyoqCKRwnGHadF+aP2L1AU3yJ66ACTUG1hvhBqAghPdfHfTr0ejnoPPOMaRrSRKxGICeoMxPdrK02CVeGKn2TjlvL8NJf/Nii1GXXvjvT/qmhdA==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BN3NAM04HT122;
x-ms-traffictypediagnostic: BN3NAM04HT122:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM04HT122;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM04HT122;
x-microsoft-antispam-message-info: ayayljbZdrzntkw+oH4JruUyj0Jnvltm+9PtvNjZh2ozKs/UULDRvnIyvnR27Byy
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2BB6F151B0DD4AB051EA9B718741C8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4fa50-b605-4230-91ae-08d658c98bb7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 02:46:38.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTgvMTEvMzAgMjA6MjAsIERhdmUgUm9kZ21hbiB3cm90ZToNCj4+IE9uIDIwMTgv
MTEvMzAgMDo0OSwgRGF2ZSBSb2RnbWFuIHdyb3RlOg0KPj4+IE9uIDI4LzExLzIwMTggMTo1MiBw
bSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4+DQo+Pj4+IFRoZSBmaXggaXMgYWRkaW5nIGEgZmV3
IGJyYW5jaGVzIHRvIGNvZGUgdGhhdCdzIHN1cHBvc2VkIHRvIGJlIGFzIGZhc3QNCj4+Pj4gYXMg
cG9zc2libGUuIFRoZSBicmFuY2hlcyB3b3VsZCBiZSBldmFsdWF0ZWQgYWxsIHRoZSB0aW1lIHdo
aWxlDQo+Pj4+IHByb3RlY3RpbmcgYWdhaW5zdCBvbmUgc2lnbmxlIGJhZCBwYWdlIGFkZHJlc3Mu
IFRoaXMgZG9lcyBub3QgbG9vayBsaWtlDQo+Pj4+IGEgZ29vZCBwZXJmb3JtYW5jZSB0cmFkZW9m
Zi4NCj4+PiBBcyBhbiBhbHRlcm5hdGl2ZSwgZm9yIGFsbCBidXQgdGhlIGZpcnN0IGNhc2UsIGlu
c3RlYWQgb2Y6DQo+Pj4NCj4+PiBpZiAodW5saWtlbHkoT1ZFUkZMT1dfQUREX0NIRUNLKGlwLCBt
X2xlbikgfHwgKGlwICsgbV9sZW4gPj0gaXBfZW5kKSkpDQo+Pj4NCj4+PiBJJ2Qgc3VnZ2VzdCB3
ZSBkbzoNCj4+Pg0KPj4+IGlmICh1bmxpa2VseSgoaXBfZW5kIC0gaXApIDw9IG1fbGVuKSkNCj4+
Pg0KPj4+IHdoaWNoIHdpbGwgYmUgYWJvdXQgYXMgZWZmaWNpZW50IGFzIHdoYXQncyBjdXJyZW50
bHkgdGhlcmUsIGJ1dCBkb2Vzbid0DQo+Pj4gaGF2ZSBpc3N1ZXMgd2l0aCBvdmVyZmxvdy4NCj4+
IE9vaCwgeWVzLCBwcmV0dHkgZ29vZCBzb2x1dGlvbiB0byB0aGlzLCB0aGFua3MuDQo+IE5wIDot
KQ0KPg0KPiBBY3R1YWxseSwgbG9va2luZyBtb3JlIGNsb3NlbHkgYXQgdGhlIGZpcnN0IGNhc2Us
IHNvbWV0aGluZyBsaWtlIHRoaXMNCj4gd29ya3MgcXVpdGUgd2VsbDoNCj4NCj4gc2l6ZV90IGlu
YyA9IDEgKyAoKGlwIC0gaWkpID4+IDUpOw0KPiBpZiAodW5saWtlbHkoKGlwX2VuZCAtIGlwKSA8
PSBpbmMpKQ0KPiAJYnJlYWs7DQo+IGlwICs9IGluYzsNCj4NCj4gT24gYXJtNjQsIHRoaXMgZ2Vu
ZXJhdGVzIG9ubHkgYSBzaW5nbGUgYnJhbmNoIGluc3RydWN0aW9uLCBzbyBpdCdzIG9ubHkNCj4g
dHdvIGV4dHJhIGFyaXRobWV0aWMgb3BlcmF0aW9ucyBtb3JlIHRoYW4gdGhlIG9yaWdpbmFsIGNv
ZGUgKHVzaW5nIHRoZQ0KPiBtYWNybyByZXN1bHRzIGluIGFuIGFkZGl0aW9uYWwgY29tcGFyZSAm
IGJyYW5jaCkuDQo+DQpIb3cgYWJvdXQganVzdCBpbnN0ZWFkIG9mOg0KDQogICBpZiAodW5saWtl
bHkoaXAgPj0gaXBfZW5kKSkNCiAgICAgICAgIGJyZWFrOw0KDQp0bzoNCg0KICAgaWYodW5saWtl
bHkoKGlwIC0gaXBfZW5kKSA8IH5pbl9sZW4pKQ0KICAgICAgICAgYnJlYWs7DQoNClRoaXMganVz
dCBnZW5lcmF0ZXMgb25seSBvbmUgbW9yZSBhcml0aG1ldGljIG9wZXJhdGlvbiB0aGFuIG9yaWdp
bmFsIA0KY29kZSwgbm90IGVhc3kgdG8gZ3Jhc3AgYnV0IG1vcmUgZWZmaWNpZW50Lg0KDQoNClRo
YW5rcywNCll1ZXlpDQoNCg0K
