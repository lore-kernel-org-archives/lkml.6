Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C43A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o4DD2IWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfBKM0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:41 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:16664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfBKM0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VejCmhzdMwe7UHPjg65TGKridhcxr8VDBPkQaURJW0A=;
 b=o4DD2IWcf5b+832xty9lF6/epH+mFWwcno+1uSfinM2rLb99MH6lrtZQz6hzHP8Hj3Rm/NzqEsWZ3Mmzc2b2X5/uy/Quk8K/dptsSqcSt82EucDgC8J6/sF/MWT/HgBPsljP3CPsTmAQZB4qaLnxLukJ18MpIVC7QFPGSY6XtHk=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4873.eurprd04.prod.outlook.com (20.176.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 12:26:30 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 12:26:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "ghackmann@android.com" <ghackmann@android.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm64: use memblocks_present
Thread-Topic: [PATCH] arm64: use memblocks_present
Thread-Index: AQHUwSMEW3Pz/Bimd06u3YBihOcWUKXahhcAgAABDcA=
Date:   Mon, 11 Feb 2019 12:26:28 +0000
Message-ID: <DB7PR04MB4490C1F037EB7C82A4EB218D88640@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190210093738.30923-1-peng.fan@nxp.com>
 <20190211122032.GC165128@arrakis.emea.arm.com>
In-Reply-To: <20190211122032.GC165128@arrakis.emea.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4873;6:5KkH0yWiFphfYnNf6BzJIFYtvGI5aFuM5v0C0f2l5GnqYv9p6FCV8VKqIVyhLasXfRTSOJi3oz9dBkubYPvtZu/mX9QFyk4aw3mQodTaTv+eOhAhT0IvxcY6ep8JF3tC6XcvdgK86aWvsrJnnP23gVezONpufv/LwKtynKJ/n1ochDWgwLB2dkgo/4Z5JImH0ednBaXMSVgAUFbW5Elpz+EfmTKJNBeQ7x2MRrQIis/1+jMWD7QugVqZLqJUVzT4rLD1upgdcVA+iKqvVUNvkCg5c4HAL1Yb+UPUGamlEb6/T1whO3RS9B3KIlwP8jg9t/HuwFH/8bX1t2DEb4jRxNDIt3fm/9hzRmA8iNTQnWwVrLMtU3ZpGoD8sai1HiVkf2qw8kHmMv0t3vCs5c1eD4XMBqszp6HPQA1OpK8GVAAxFdVFcMgfCs/rSSiQ2TeiyjHl3DwKIwOasr6L/OdBzQ==;5:UttVO7BASdEZjTdh44S1qZawZtJq72jEBtO7aVn5HxCh8L9s+mkl6C9R56RlwWNDJrc2zRiccNQCfr7KfDVksI92AehdWNhR1hjo7NoZm1gcAztgbmWBVwhVjGSTwIGopilkUCrbK7VnjgpUta87cTbM1p9gFjChvXaoR7KXo0N78bBaMerVx2dMdJBieP7UaMcxbUw6wrsMq4/h/2+Lzw==;7:mFh26dPRKm9FhZaucrBJGb6OlXfUpbpBDiWOu00tyHHyNPSQxTB+jLRA4EtTqSlpxKWZiJG52Wa82A6PWuMV16B/SW3HKs5XEuersR0LIKCnJ/zsdRAVsTbrMaE0WmavVOpOVl0RHyxJ8zNa5e5/4Q==
x-ms-office365-filtering-correlation-id: 723b3afa-62c7-4006-d449-08d6901c268d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4873;
x-ms-traffictypediagnostic: DB7PR04MB4873:
x-microsoft-antispam-prvs: <DB7PR04MB4873200B3BDE861A96E2484A88640@DB7PR04MB4873.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(13464003)(189003)(199004)(99286004)(105586002)(26005)(7696005)(66066001)(4326008)(86362001)(97736004)(53546011)(6506007)(25786009)(102836004)(6246003)(71200400001)(53936002)(106356001)(68736007)(76176011)(71190400001)(2906002)(6436002)(316002)(11346002)(229853002)(14454004)(446003)(7416002)(305945005)(256004)(54906003)(486006)(6116002)(33656002)(3846002)(74316002)(44832011)(55016002)(9686003)(8936002)(6916009)(8676002)(81156014)(81166006)(476003)(7736002)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4873;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eH67NXaJc91SYXMt+SwE/gS0FCAfC+hLRunznnCCmNkrxdp70JLdltkHEsXlSdg3eWmgtgzDCRcU2MOs4iUo9QLN5ZfY7xwm76RNBuwLiKIXG9eu3rO7EvNF1QOYE4Yr56jQgTFwOsUjYBgXCsuuKejYQFsAQFyFH+JYSDe4UJGdW9bSN1okD8D7bRmcxzrKfYlHGmvCwLzGextVSA+bg1/DFrPnKW17q1NnfE8d1s3eYpVzN4Pl6P2b/VYPQSPDWueJxq6iGf5+QLTFN7DGZOadGrBi7TN0zk7tNDW/XJGdCmyxqrex9MH0A0gW94jI3ZpfGFgIQYgRlvMkXvkyva90kbeGUtKEV0yI0r3gAO85+0w1720MQQlSwaLRqLjUO9Ygp5sRF0fxBRQNXaKI2D02viWU6LHTeb/sOyZ80rk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723b3afa-62c7-4006-d449-08d6901c268d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:26:29.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4873
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2F0YWxpbiBNYXJpbmFz
IFttYWlsdG86Y2F0YWxpbi5tYXJpbmFzQGFybS5jb21dDQo+IFNlbnQ6IDIwMTnlubQy5pyIMTHm
l6UgMjA6MjENCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogd2lsbC5k
ZWFjb25AYXJtLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gcnBwdEBsaW51eC52
bmV0LmlibS5jb207IGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7IGYuZmFpbmVsbGlAZ21haWwu
Y29tOw0KPiByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsgZ2hhY2tt
YW5uQGFuZHJvaWQuY29tOw0KPiBzdGVmYW5AYWduZXIuY2g7IGhhbm5lc0BjbXB4Y2hnLm9yZzsg
bG9nYW5nQGRlbHRhdGVlLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB2YW4uZnJlZW5peEBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IHVzZSBtZW1ibG9ja3NfcHJlc2VudA0K
PiANCj4gT24gU3VuLCBGZWIgMTAsIDIwMTkgYXQgMDk6Mjg6NDNBTSArMDAwMCwgUGVuZyBGYW4g
d3JvdGU6DQo+ID4gYXJtNjRfbWVtb3J5X3ByZXNlbnQgaXMgZG9pbmcgc2FtZSB0aGluZyBhcyBt
ZW1ibG9ja3NfcHJlc2VudCwgc28NCj4gPiBsZXQncyB1c2UgY29tbW9uIGNvZGUgbWVtYmxvY2tz
X3ByZXNlbnQgaW5zdGVhZCBvZiBwbGF0Zm9ybSBzcGVjaWZpYw0KPiA+IGFybTY0X21lbW9yeV9w
cmVzZW50Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+IA0KPiBJIGFscmVhZHkgbWVyZ2VkIGEgc2ltaWxhciBvbmUgKHNlZSBjb21taXQNCj4g
YTJjODAxYzUzZDE2ODI4NzFmYmExZTAzN2M5ZDNiMGM5ZmZmZWU4YSBpbiAtbmV4dCkuDQoNCkkg
c2hvdWxkIGNoZWNrIHlvdXIgdHJlZSBmaXJzdCBiZWZvcmUgc2VuZGluZyBwYXRjaGVzLg0KDQpU
aGUgYXJtMzIgY29kZSBjb3VsZCBhbHNvIHVzZSBzaW1pbGFyIGxvZ2ljLCBuZWVkIGNoZWNrIGFy
bSB0cmVlIDopDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IC0tDQo+IENhdGFsaW4NCg==
