Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050CE2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="TXPLFTOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050CE2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbeKEXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:25:55 -0500
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:55472
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbeKEXZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKFwLmIVftsNzPbjVoIzgERegYQH5tUWSfNOj0upimw=;
 b=TXPLFTOFyiNraihUq9nHN9ylDdCc1z1lG6DTcGVO7iV9lW+lTYqi3yOVoChz5SnSwJ6B9pwfBnyRTkT0VJdT0/IQ+fffw3TR6Pchsy/NtqUt/xVdO/yZwdQInWsY6+lC2m8382++Roqgk5G7TtwzdKTP7snHQIt4XAyUnsBiOEM=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2352.eurprd05.prod.outlook.com (10.169.135.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Mon, 5 Nov 2018 14:05:50 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::acd8:cd0c:4b28:84bd]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::acd8:cd0c:4b28:84bd%7]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 14:05:50 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Thread-Topic: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Thread-Index: AQHUct0lyDGDgl0BVkimwQnHWBD3DKU85rGAgABmGwCAA+7GgA==
Date:   Mon, 5 Nov 2018 14:05:49 +0000
Message-ID: <1541426747.7086.15.camel@toradex.com>
References: <20181102182857.064326086@linuxfoundation.org>
         <20181102182902.797148907@linuxfoundation.org>
         <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
         <20181103020224.GK194472@sasha-vm>
In-Reply-To: <20181103020224.GK194472@sasha-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2352;6:s1W8gs9tR1sF010qvwL53VOvW/O2eLUODBWZ93a2AYMnXrZK+qDRIplhrevtCcjy8wQ3FwibbG331f+Q0+58vazpXogyZ3TLYGlIPH2slKHtahPV/BKJTliTyC9/byc9HqzR9TZ2h652AmOMuKVskM/QQoVJSEAx6RO5SN2XwOAnDTQQl4tOsFoXx14nexSwU/afsqYzM7h757UT+rWtLgKPO8spdDSH6Xk8kXc0GU7zujt+GTmn5JOSSR0q/qSJ+kVhs78/6gEqIamulxkRHJwcs39MbkHfBARYaPaZg0vIoAJ4DM5cOwjZksDRnFJ0gYaE23o6MzoZ6RL6YeT+kw/kVDM74hm5tszep6EM1NUspBVvBQfL8z8KTbQgeJ5uxSsgXMu25cTs8Aqgcn0JlKjvXGxIFhPbrvK4bVQap0nGyJ4A5k8BGQyoli2tdggIlxk6sdBv/J7Ir61ru3H5aw==;5:i7DO4/ePrhycBlIy54L6BXL9to4m5+FHgC6yxFs8UgYsW/j0UsyycLKFZceL9vfiKa+o9nvBOoSJIb+bwOaC5wW5AG0AWJAezAJaHuuyIhvEx0nmlHU7HVrcK+uNJR8O7Q5/uaaJKd0KB3iV5dGcsGF3NO7vBtFTJhX4lh3gTes=;7:MuTSuA9OJXxEzcM6ZAUwFhahvXUlq5B/2Yeg02ay6Otj7Wmo4R3w9zJQYggTNBKmGuk37K2Pga6KxhdIhgMB7NSZ8wpbujFhg1E1Uor6pDxeblzy93KyyhnBdW77VZPHmBt/iVWR47DOB2m/xPIXTw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8aad5018-e6d1-4ffb-990e-08d64327caa3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2352;
x-ms-traffictypediagnostic: VI1PR0501MB2352:
x-microsoft-antispam-prvs: <VI1PR0501MB23521BB4473802E1CE52BC37FBCA0@VI1PR0501MB2352.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2352;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2352;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39840400004)(189003)(199004)(4326008)(2501003)(106356001)(7736002)(305945005)(103116003)(508600001)(99286004)(6486002)(2900100001)(76176011)(102836004)(53546011)(6506007)(26005)(186003)(2906002)(229853002)(105586002)(476003)(39060400002)(44832011)(53936002)(6436002)(446003)(486006)(25786009)(6246003)(66066001)(2616005)(11346002)(6512007)(71200400001)(71190400001)(97736004)(86362001)(81156014)(93886005)(81166006)(54906003)(110136005)(14454004)(36756003)(316002)(256004)(8676002)(68736007)(5660300001)(3846002)(6116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2352;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yObi+1v2UmmlAwZhWiAbJfCESp0dyVrCPLBTtM+O9gTV9oDakQ1vSgiXK3lxio1ZwCgGSFVuBAvOTqL/EWptXigcnG3esybX00YDg4Ze7Ds02zyblX+mKiGD5bzqjuzr4Oart/yTMCPmsIaeIHyj2hbaB2iF9xTVisWaoKLeMvG+kbUxuOllNdh1lwgOnKLV51/KEJSV0wjAtEGwKIF815PQe1fvqPLPtZF9R25THl/8ZrL9aAKW7oQZ8CZqs1fkohWxAGKg+OmcJxeipaSzBZdtvCKRZ03yhrQ9lfoFJrevhNruSwZimixWTq1aGzNzlf5TEWqH1uZfGLKGFKkwKO36FNaKadN+UK1uANYfXf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D197FE99521B41A19E88DE78E88DBB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aad5018-e6d1-4ffb-990e-08d64327caa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 14:05:50.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTAyIGF0IDIyOjAyIC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
T24gRnJpLCBOb3YgMDIsIDIwMTggYXQgMDc6NTY6NTdQTSArMDAwMCwgU3VkaXAgTXVraGVyamVl
IHdyb3RlOg0KPiA+IEhpIEdyZWcsDQo+ID4gDQo+ID4gT24gRnJpLCBOb3YgMiwgMjAxOCBhdCA2
OjUzIFBNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IDQuMTQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFu
eW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZQ0KPiA+ID4gbGV0IG1lIGtub3cuDQo+ID4g
DQo+ID4gSXQgc2VlbXMgdGhpcyBoYXMgYWxyZWFkeSBiZWVuIHJldmVydGVkIHVwc3RyZWFtOg0K
PiA+IDliZjRlMzcwMDQ4ZCAoIkFSTTogZHRzOiB0ZWdyYTIwOiBSZXZlcnQgIkZpeCBVTFBJIHJl
Z3Jlc3Npb24gb24NCj4gPiBUZWdyYTIwIiIpDQo+IA0KPiBUaGUgY29tbWl0IGxvZyBvZiA5YmY0
ZTM3MDA0OGQgc3VnZ2VzdHMgdGhhdCB0aGlzIGlzc3VlIHdhcyBmaXhlZA0KPiBzb21ld2hlcmUg
ZWxzZSB3aGljaCBtYWRlIDliZjRlMzcwMDQ4ZCB1bm5lY2Vzc2FyeS4gQ2FuIHNvbWVvbmUgcG9p
bnQNCj4gdG8NCj4gdGhhdCBmaXg/DQoNClllcywgc29ycnkuIFRoYXQgZ290IGZpeGVkIHByb3Bl
cmx5IGJ5IERtaXRyeSBpbiA1ZDc5NzExMWFmZTEgKCJjbGs6DQp0ZWdyYTogQWRkIHF1aXJrIGZv
ciBnZXR0aW5nIENERVYxLzIgY2xvY2tzIG9uIFRlZ3JhMjAiKS4NCg0KPiBJZiBub3QsIEknbGwg
anVzdCByZXZlcnQgdGhpcyBjb21taXQuDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IFNhc2hh
