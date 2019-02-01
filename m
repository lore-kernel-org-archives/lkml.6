Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA74C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFC320869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jZjDJTrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfBAVgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:36:46 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2255 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:36:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c54bbce0000>; Fri, 01 Feb 2019 13:36:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 13:36:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 13:36:43 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 21:36:42 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 21:36:42 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3368.namprd12.prod.outlook.com (20.178.55.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 21:36:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 21:36:41 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXLS2aAgAAWV5CAAAOxgIAAEYLg
Date:   Fri, 1 Feb 2019 21:36:41 +0000
Message-ID: <BYAPR12MB339835E59C2D4DCDFC93BEF4C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
 <BYAPR12MB339865C0876E1BF7278DC7C8C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
 <f0c4cc1b-4e3d-3956-7ac4-de35073fbf94@gmail.com>
In-Reply-To: <f0c4cc1b-4e3d-3956-7ac4-de35073fbf94@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3368;6:j6KNMeweWTv4xMI+l2lIv8oW+e1EPfk1h2lqUWXFTJAXS847v1vN7v7kBTLFKevuxxlUDy7sWG98UJZl6MOtL3EIKnVszk1ZbmzXqfnTGIW+zkO2ibENZWLkuSqFzUHY1JDB8ZpR1SqxusID3SLLQGQMMiyWfFO7xgne908fnul74qEpy6Un3wVGI9JuIGUzC0c6LGWhn2aSlWS3qU8z11ten+z95NmYQX4odda5UmtsXQWikPMDkCUfIxhAZ6ot0JOu1DKNhFQrAcnT684Lc2EIfi+ok/is/f0iduUD5WrB2gGgkXpnpQnvBnqAsBV+WNo0fKWfWo0mJxS6DDQsxve7E9NL/DlLoWOIjz/qDujCP3fvuegCSq26737r30Ik2D2kBk96+cfgZHYFrssODCXXWBkySBGDTyqx4/Cm7fywKBsPgz8+Morh0pdRVHOZ4/eGrSLC+TKFMRhHZOSxSA==;5:U5MLFPhITZBriAkhuiJ9sO8PMHbqhuR3Tbr6TcNqMUxvEmAd932ttTSX3RhkuxaAQV+slKyo3KWMt5kzZmYnH2KNB+jvo/szy4BlSSaoRMTQTNMkw/E/mUU/5GlzNj8hlabYEhdp2W065EH/ZqEHxoIFkArpXX/su4e+DEMUldjTIOTv2LQh96TXPu2z6msS4T3lrtE48Qt/yr0wUUL7DQ==;7:TYYDtpCHj8j/9I4hn25k6Wr9kiDme0XhxQW+/F4dVUTvFcZjCrPTeUc022Kzblb8whUtglnmvWAllmnDSXXmJB3lH8BunBX3iSJqLNtR4qfSfYB+MFnzfLm83BErUTFnj2IvaWrJD4v+SRWGbdLLZQ==
x-ms-office365-filtering-correlation-id: 76e174fc-f320-4fb9-0266-08d6888d5ac6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3368;
x-ms-traffictypediagnostic: BYAPR12MB3368:
x-microsoft-antispam-prvs: <BYAPR12MB33685A7F7E607BA3EC31AE04C2920@BYAPR12MB3368.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(14444005)(106356001)(476003)(86362001)(105586002)(53936002)(8676002)(256004)(486006)(39060400002)(93886005)(305945005)(6116002)(6246003)(7736002)(74316002)(4326008)(68736007)(76176011)(3846002)(2906002)(97736004)(25786009)(6436002)(7696005)(54906003)(6636002)(186003)(33656002)(99286004)(71200400001)(229853002)(71190400001)(316002)(66066001)(446003)(110136005)(2501003)(102836004)(478600001)(55016002)(9686003)(14454004)(81156014)(81166006)(11346002)(26005)(6506007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3368;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v4+70h2ydzMLtZmCTTEWRCnDQg+nKM+MKuSYiIgE7DGoZS+vVAwiDPkcMiILlmy9J/vktQrAGuuiiM/p4waEBn2y4tDO1P6hWCh2eipL52qY+7wIPn1SqtOmbv4I7Dg2Y0O0GeUtPRN9sf4+1wuHcPLzKJCBSBHV3nkK1j203ss3ed3O0TslNqvKY2grdvwtO6sHt/wUUWpKCElBgLzFV5hm4X7tcy6hHgW9dtDTAblz22KHIUNi29re1PNqd5VfKT4u1bR9FfMqzKA86SMoxSJh1Mmy2JHM2MmqygplCrm20IW12+oBtidCuViXBIqOxBZSu/b0l4Z+LzFIdTOqHrqEnDhwMhOoEyJiiylx7KPBK7rIpHCj77Cjh806+EvHrFVblepnD+1THTK2QLNbPHWoBSfUMS9PfCd1iao2GZE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e174fc-f320-4fb9-0266-08d6888d5ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 21:36:41.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549056974; bh=uZ0Srp+H2JVA+nNaPL1L3+X6BvumuLfXPaXyOR5K5rs=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=jZjDJTrn/Wjc1i8u0mxA2Y86ICTALA/VUerrJpXlorPoYKCd+fce6ltx4mwPcLiJL
         dyDRieDP2AOIGMlwxln4V4YTRgJLsN9eHa5xwbZnb95iSjp8A4iUHvR/g71epDBqpR
         OjZaV+E53yvTH8UUATv/5wo2IaQ06nNI/ZzlVrPm57TDY+q+BRRK7LK5jEydVAvyWe
         aAFc152/TfOzfCvY69sQFQj58G3sQ3olFf+HqbvmglsZVwr5Wr3lO+66ykvx+a4dSd
         q7NLS+HtanvTpAdFmK6r0Y1MkvRGfiHwAxQQSTRmfNX7cceHbauhDj95pTIkamphr7
         3YES8d3ETVAUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gDQo+ID4+IAlyeF9jaGFuID0gZG1hX3JlcXVlc3Rfc2xhdmVfY2hhbm5lbF9yZWFzb24o
aTJjX2Rldi0+ZGV2LCAicngiKTsNCj4gPj4gCWlmIChJU19FUlIocnhfY2hhbikpDQo+ID4+IAkJ
cmV0dXJuIFBUUl9FUlIocnhfY2hhbik7IA0KPiA+Pg0KPiA+Pg0KPiA+Pj4gKw0KPiA+Pj4gKwlk
bWFfY2hhbiA9IGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWxfcmVhc29uKGkyY19kZXYtPmRldiwg
InR4Iik7DQo+ID4+PiArCWlmIChJU19FUlIoZG1hX2NoYW4pKSB7DQo+ID4+PiArCQllcnIgPSBQ
VFJfRVJSKGRtYV9jaGFuKTsNCj4gPj4+ICsJCWdvdG8gZXJyb3I7DQo+ID4+DQo+ID4+IEl0J3Mg
YSBnb29kIHByYWN0aWNlIHRvIHJlbGVhc2UgcmVzb3VyY2VzIGluIG9wcG9zaXRlIG9yZGVyIHRv
IHRoZSBhbGxvY2F0aW9uLiBIZW5jZSBiZXR0ZXIgdG8gd3JpdGUgdGhpcyBhczoNCj4gPj4NCj4g
Pj4gCQlnb3RvIGVycl9yZWxlYXNlX3J4Ow0KPiA+Pg0KPiA+Pj4gKwl9DQo+ID4+PiArDQo+ID4+
PiArCWkyY19kZXYtPnR4X2RtYV9jaGFuID0gZG1hX2NoYW47DQo+ID4+PiArDQo+ID4+PiArCWRt
YV9idWYgPSBkbWFfYWxsb2NfY29oZXJlbnQoaTJjX2Rldi0+ZGV2LA0KPiA+Pj4gKwkJCQkgICAg
IGkyY19kZXYtPmRtYV9idWZfc2l6ZSwgJmRtYV9waHlzLA0KPiA+Pj4gKwkJCQkgICAgIEdGUF9L
RVJORUwgfCBfX0dGUF9OT1dBUk4pOw0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAoIWRtYV9idWYpIHsN
Cj4gPj4+ICsJCWRldl9lcnIoaTJjX2Rldi0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIHRoZSBE
TUEgYnVmZmVyXG4iKTsNCj4gPj4+ICsJCWVyciA9IC1FTk9NRU07DQo+ID4+PiArCQlnb3RvIGVy
cm9yOw0KPiA+Pg0KPiA+PiAJCWdvdG8gZXJyX3JlbGVhc2VfdHg7DQo+ID4+DQo+ID4+PiArCX0N
Cj4gPj4+ICsNCj4gPj4+ICsJaTJjX2Rldi0+ZG1hX2J1ZiA9IGRtYV9idWY7DQo+ID4+PiArCWky
Y19kZXYtPmRtYV9waHlzID0gZG1hX3BoeXM7CQ0KPg0KPglpMmNfZGV2LT5yeF9kbWFfY2hhbiA9
IHJ4X2NoYW47DQo+ID4+IAlpMmNfZGV2LT50eF9kbWFfY2hhbiA9IHR4X2NoYW47DQo+ID4+DQo+
ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gKw0KPiA+Pj4gK2Vycm9yOg0KPiA+Pj4gKwlpZiAoaTJj
X2Rldi0+dHhfZG1hX2NoYW4pDQo+ID4+PiArCQlkbWFfcmVsZWFzZV9jaGFubmVsKGkyY19kZXYt
PnR4X2RtYV9jaGFuKTsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKGkyY19kZXYtPnJ4X2RtYV9jaGFu
KQ0KPiA+Pj4gKwkJZG1hX3JlbGVhc2VfY2hhbm5lbChpMmNfZGV2LT5yeF9kbWFfY2hhbik7IA0K
PiA+Pg0KPiA+PiBlcnJvcl9yZWxlYXNlX3R4Og0KPiA+PiAJZG1hX3JlbGVhc2VfY2hhbm5lbCh0
eF9jaGFuKTsNCj4gPj4gZXJyb3JfcmVsZWFzZV9yeDoNCj4gPj4gCWRtYV9yZWxlYXNlX2NoYW5u
ZWwocnhfY2hhbik7DQo+ID4+DQo+ID4+PiArDQo+ID4+PiArCXJldHVybiBlcnI7DQo+ID4gDQo+
ID4gSSBhbSByZWxlYXNpbmcgcmVzb3VyY2VzIGluIHJldmVyc2Ugb3JkZXIgdG8gYWxsb2NhdGlv
bi4NCj4gPiBUcnlpbmcgZm9yIHJ4IGFsbG9jYXRpb24gZm9sbG93ZWQgYnkgdHggYWxsb2NhdGlv
biBEdXJpbmcgcmVsZWFzZSANCj4gPiByZWxlYXNpbmcgdHggYW5kIHRoZW4gcnguDQo+ID4gSW4g
Y2FzZSBpZiB0eCBhbGxvY2F0aW9uIGZhaWxzLCBkb2VzbuKAmXQgZ28gdGhydSByZWxlYXNlLiBJ
ZiByeCBvciBidWYgDQo+ID4gYWxsb2NhdGlvbiBmYWlscywgcmVsZWFzZXMgdHggZmlyc3QgYW5k
IHRoZW4gcngNCj4gPiANCj4NCj4NCj4gT2theS4gQW55d2F5IGl0J3MgYSBnb29kLW4tY29tbW9u
IHByYWN0aWNlIHRvIHdyaXRlIGl0IGluIHRoZSB3YXkgSSdtIHN1Z2dlc3RpbmcuDQo+DQo+IEFu
ZCBwbGVhc2Ugc2V0IHJ4X2NoYW4gYW5kIHR4X2NoYW4gYWZ0ZXIgZG1hX2J1ZiBhbGxvY2F0aW9u
IGFzIEknbSBzdWdnZXN0aW5nIGJlY2F1c2UgeW91IGN1cnJlbnQgdmFyaWFudCB3aWxsIGNyYXNo
IGtlcm5lbCBzaW5jZSBpZiBkbWFfYnVmIGFsbG9jYXRpb24gZmFpbHMsIGJvdGggcnggYW5kIHR4
IGNoYW5uZWxzIHdpbGwgYmUgcmVsZWFzZWQgYW5kIHlvdSdyZSBub3Qgc2V0dGluZyB0aGVtIHRv
IE5VTEwgaW4gdGhhdCBjYXNlLg0KDQpPSywgbXkgd3JvbmcgYXNzdW1wdGlvbi4gVGhvdWdodCBk
bWFfcmVsZWFzZV9jaGFubmVsIHdpbGwgTlVMTCBjaGFuIGFmdGVyIGl0cyBmcmVlZA0KV2lsbCB1
cGRhdGUgYW5kIHNlbmQgVjEwDQo=
