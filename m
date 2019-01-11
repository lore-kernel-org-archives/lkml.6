Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6322F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="HoLam4Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbfAKO3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:35 -0500
Received: from mail-eopbgr20091.outbound.protection.outlook.com ([40.107.2.91]:10704
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388746AbfAKO3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkO8wB0FH59VSGFP1SfU7V7CEw38jL+1FPPct5jZdXA=;
 b=HoLam4Ii1XdDZzuJ9sJ4Bys+JBYQBX12TIP9txCYY30dWXpIifaF33HqqHj+pUYGeg2K4NBtjdgbx+s548QmkepFByegWudcR+DijQ1xq5pd8K9CBCQZmj4P8AWmD8wEeyw3MRWkBn867dkkIzLLeMXzHC9KaGa7ejQRs+Xp+b8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5302.eurprd02.prod.outlook.com (20.178.91.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 14:29:28 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:29:28 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vKWowhmAgAAW64CAAAmEAIABP6SA
Date:   Fri, 11 Jan 2019 14:29:28 +0000
Message-ID: <e35d6894-fd62-efd1-38f7-cc5cbdbbacbb@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se> <20190110182904.5efd08f2@bbrezillon>
 <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
 <20190110202522.10206f2d@bbrezillon>
In-Reply-To: <20190110202522.10206f2d@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0039.eurprd07.prod.outlook.com
 (2603:10a6:7:66::25) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB5302;6:9UXOe+CKwDjR8ltumaP7WK81dqZm2NN3gboIGOmnV/4Scf+7MkmOg0w/9mWdhkywWd3+IrzCaDxcJEEUlEN/OWuEjCJhToBgKrPU9AQrlU5BEEHOWbjWXENCYiXms21CjVvaMCY7FZyVj7A0B8tiYwTwUnhJu8q4LzenvEf2loCi0jQ+l8X9jJ0MY2e/zUgS6d0Rl+uPOGqPyD5iz6yMy12nGnJiHF5X0CZoGFBZ6rWQZqI8ucLrfH1Dp27953SIT9PESGR94fMS6NsKBYb28yTjyZtiHPaWj58snoh9KCTHEMy2zxL8AKEOydZGnvqrd0gGdArF45C5Ln3sELi3Ifh8ogitpKcmvfCe8fTvTF1tyKLAmfK98wqbsojimDgP6y8qCD2R0bAYH03BEbR1cUnvTTfPan2VoV9T05TybvZ73Vyngm2UtVJ8rgy35d5dbju+0Lq6HNm64IqdqiMgmw==;5:PeNcFPI8vlgo8U6iLfsDOvvGv66sjeUI6XC3d6sVv02wfkp+DMvRartSeVc/H1nXF6oMRF5SB5KW2BY3fko2ZnY+7g/+n0UxL7ofqiMg3LKH2Cz0kyzlVJEzBI0tCa8Bgu7k3UXRE1pRoCIfkQzcOI+xnJpoGTETqNYa1RXQ5bed9JeE7IqC1hvdTpzkf+QA/SbmCuniL+0FGOxyfntluQ==;7:i/mmJyEWLsvq0wpXGstoGrtgiuPDxKETOQb5YUiiGYD+KbCYf1UoFkFvD5kXJjmcFu0fPcVZUuyVdhyrVFKooPgd2xQgptp+Mo/JifKKUvtmLWW9T1hn+6yNpwCQdCMhdEnVv9plbMeZVaYbD4MbYA==
x-ms-office365-filtering-correlation-id: e4293c82-a24c-429c-ab13-08d677d13193
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB5302;
x-ms-traffictypediagnostic: AM6PR02MB5302:
x-microsoft-antispam-prvs: <AM6PR02MB5302D8DA862CDE0BCD4DFA50BC850@AM6PR02MB5302.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(52314003)(6512007)(65826007)(5660300001)(68736007)(8676002)(66066001)(65806001)(65956001)(81166006)(81156014)(6916009)(64126003)(7736002)(305945005)(76176011)(6116002)(31696002)(52116002)(3846002)(446003)(11346002)(2616005)(386003)(102836004)(476003)(186003)(26005)(97736004)(25786009)(36756003)(93886005)(71190400001)(99286004)(31686004)(6436002)(71200400001)(486006)(6246003)(6506007)(2906002)(53936002)(53546011)(86362001)(54906003)(4326008)(106356001)(14454004)(508600001)(105586002)(74482002)(8936002)(6486002)(316002)(58126008)(229853002)(14444005)(256004)(14773001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5302;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PolZWXxM77y0YUXNRgeXn5m2nlkM0XlZ1yZJEVd6lzqLf23ti8oWUPgfVT8Os00FYB4fg60b0/QVwoUouFrxBDWUYKfstUtzVHuQ7EgNvd/6IiUqPP5GgkOpREioIosYXV7wSYkDI/hu+VgrGdnoT5czsr6CqO1Ep8BIuNun80cunqTZGaqZwG/9v7Ihgde85HVrdyeF/vpiW76L5ENavezs5yvnLQLeSLQCUEgRn36VUxsJOnxZuFt85JAdfNxMAXuxH/kR3xWUPp9Gw7pMDKUdeFoaSgzyWl8DEFAe0lsroa+4kMTQV5QJT7r+dIu/Gr5qcpXXTHaLqVJBbfIZs8YJ/I5PJD7TRVyM8zqfvZA8itdWM78l1uh2ZfOQ1YwxA2mNwHzO4WGEwn+Yl2a4ujGS1/VjRVL/a8WzF7sXqjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <898D23C585639C4395B84DE60D6CBBA4@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e4293c82-a24c-429c-ab13-08d677d13193
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:29:27.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xMCAyMDoyNSwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUsIDEw
IEphbiAyMDE5IDE4OjUxOjIxICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IE9uIDIwMTktMDEtMTAgMTg6MjksIEJvcmlzIEJyZXppbGxvbiB3cm90
ZToNCj4+PiBPbiBUaHUsIDEwIEphbiAyMDE5IDE1OjEwOjQ4ICswMDAwDQo+Pj4gUGV0ZXIgUm9z
aW4gPHBlZGFAYXhlbnRpYS5zZT4gd3JvdGU6DQo+Pj4gICANCj4+Pj4gVGhlIEEyUSBhbmQgVVBE
QVRFIGJpdHMgaGF2ZSBubyBlZmZlY3QgaW4gdGhlIGNoYW5uZWwgZGlzYWJsZSByZWdpc3RlcnMu
DQo+Pj4+IEhvd2V2ZXIsIHNpbmNlIHRoZXkgYXJlIHByZXNlbnQsIGFzc3VtZSB0aGF0IHRoZSBp
bnRlbnRpb24gaXMgdG8gZGlzYWJsZQ0KPj4+PiBwbGFuZXMsIG5vdCBpbW1lZGlhdGVseSBhcyBp
bmRpY2F0ZWQgYnkgdGhlIFJTVCBiaXQsIGJ1dCBvbiB0aGUgbmV4dA0KPj4+PiBmcmFtZSBzaGlm
dCBzaW5jZSB0aGF0IGlzIHdoYXQgQTJRIGFuZCBVUERBVEUgbWVhbnMgaW4gdGhlIGNoYW5uZWwg
ZW5hYmxlDQo+Pj4+IHJlZ2lzdGVycy4NCj4+Pj4NCj4+Pj4gRGlzYWJsaW5nIHRoZSBwbGFuZSBv
biB0aGUgbmV4dCBmcmFtZSBzaGlmdCBpcyBkb25lIHdpdGggdGhlIEVOIGJpdCwNCj4+Pj4gc28g
dXNlIHRoYXQuICANCj4+Pg0KPj4+IEl0J3MgYmVlbiBhIGxvbmcgdGltZSwgYnV0IEkgdGhpbmsg
SSBoYWQgYSBnb29kIHJlYXNvbiBmb3IgZm9yY2luZyBhDQo+Pj4gcmVzZXQuIElJUkMsIHdoZW4g
eW91IGRvbid0IGRvIHRoYXQgYW5kIHRoZSBDUlRDIGlzIGRpc2FibGVkIGJlZm9yZSB0aGUNCj4+
PiBwbGFuZSwgdGhlIEVOIGJpdCBzdGF5cyBhcm91bmQsIGFuZCBuZXh0IHRpbWUgeW91IHF1ZXVl
IGEgcGxhbmUgdXBkYXRlLA0KPj4+IHlvdSdsbCBzdGFydCB3aXRoIGFuIGludmFsaWQgYnVmIHBv
aW50ZXIuICANCj4+DQo+PiBJdCBtaWdodCBiZSBwb3NzaWJsZSB0byBjbGVhciB0aGUgRU4gYml0
IGluIC4uLkNIRFIgYmVmb3JlIGVuYWJsaW5nIHRoZQ0KPj4gcGxhbmUgaW4gLi4uQ0hFUi4gT3Ig
aXMgdGhhdCB0b28gbGF0ZT8NCj4gDQo+IEkgdGhpbmsgSSB0cmllZCB0aGF0LCBidXQgSSdtIG5v
dCBzdXJlIChCVFcsIHRoaXMgY2hhbmdlIHdhcyBkb25lIGluDQo+IGJkNDI0OGJiNWU4YiAoImRy
bTogYXRtZWwtaGxjZGM6IHJlc2V0IGxheWVyIEEyUSBhbmQgVVBEQVRFIGJpdHMgd2hlbg0KDQpU
aGF0IHBhdGNoIGlzIGEgYmlnIGZhdCBOT1AgaWYgeW91IHJlYWQgdGhlIGRvY3VtZW50YXRpb24u
IFRob3NlIGJpdHMNCmFyZSBtYXJrZWQgd2l0aCBhICctJyBmb3IgYWxsIExDREMgY2hhbm5lbCBk
aXNhYmxlIHJlZ2lzdGVycywgZm9yIGFsbA0Kc3VwcG9ydGVkIGNoaXBzIElJVUMuIEFyZSB0aGUg
ZWZmZWN0cyBvZiB0aG9zZSBiaXRzIG1lbnRpb25lZCBpbiBhbnkNCmVycmF0YT8NCg0KSXQgd291
bGQgYmUgZ29vZCB3aXRoIGEgY29tbWVudCB0aGF0IHRoZSBwcmVzZW50IHVuZG9jdW1lbnRlZCBk
aXNhYmxlDQptZXRob2QgaXMgaW50ZW50aW9uYWwuIFRoYXQgd291bGQgaGF2ZSBrZXB0IG1lIGZy
b20gYXNzdW1pbmcgdGhlIHdob2xlDQp0aGluZyB3YXMganVzdCBjb3B5LXBhc3RlIGp1bmsgZnJv
bSAuLi5fZW5hYmxlIHRoYXQgaGFwcGVuZWQgdG8gd29yay4NCg0KPj4gZGlzYWJsaW5nIGl0Iikp
LiBBbnl3YXksIEknbSBub3QgZXZlbiBzdXJlIHRoaXMgaXMgc3RpbGwgbmVlZGVkIG5vdw0KPj4g
dGhhdCBhdG9taWMgdXBkYXRlcyBoYXZlIGEgd2FpdF9mb3JfZmxpcF9kb25lL3ZibGFuaygpIGlu
IHRoZSBjb21taXQNCj4+IHBhdGguDQoNClRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgUlNUIGJp
dCBzdGF0ZXMgIlJlc2V0cyB0aGUgbGF5ZXIgaW1tZWRpYXRlbHkuDQpUaGUgZnJhbWUgaXMgYWJv
cnRlZC4iIHdoaWNoIHNvdW5kcyBhIGJpdCBzY2FyeSBhbmQgaGVhdnktaGFuZGVkLiBCdXQNCmFn
YWluLCBJIGRvbid0IGtub3cgd2hhdCB0aGF0IGFjdHVhbGx5IG1lYW5zIGFuZCB3aGF0IHRoZSBl
ZmZlY3RzIGFyZQ0KYnV0IHRoYXQgd2FzIHRoZSByZWFzb24gZm9yIG1lIHdhbnRpbmcgdG8gYXZv
aWQgdGhlIFJTVCBiaXQuDQoNCkNoZWVycywNClBldGVyDQoNCj4+IEJ1dCB0aGlzIHBhdGNoIGlz
IG5vdCBvdmVybHkNCj4+IGltcG9ydGFudCwgSSBqdXN0IHdhbnRlZCB0byBhdm9pZCB0aGUgcmVz
dWx0aW5nICJibGFjayBob2xlIiB3aGVuIHRoZQ0KPj4gcGxhbmUgRE1BIGlzIGRpc2FibGVkIG1p
ZC1mcmFtZS4gQnV0IGRpc2FibGluZyBwbGFuZXMgaXMgcHJvYmFibHkgbm90DQo+PiBzb21ldGhp
bmcgdGhhdCBoYXBwZW5zIGZyZXF1ZW50bHkgYW5kIHdpbGwgcGVyaGFwcyBub3QgYmUgbm90aWNl
ZCBhdA0KPj4gYWxsLi4uDQo+IA0KPiBPa2F5LiBPdGhlciBwYXRjaGVzIGxvb2sgZ29vZCB0byBt
ZSwgSSdtIGp1c3Qgd2FpdGluZyBmb3IgTmljb2xhcw0KPiBmZWVkYmFjayBiZWZvcmUgYXBwbHlp
bmcgdGhlbS4NCj4gDQoNCg==
