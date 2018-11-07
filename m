Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8356C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="he7QQM14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8356C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeKHHfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:35:32 -0500
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:37952
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbeKHHfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj2OJSNK0sHNbg4OCqzVmXm3Kz6IBt+4XoFwJlrNrLI=;
 b=he7QQM14e/rliSGbKhGXotB7/NutTl15gGsBhMVdcAFm302nbJrcOXaplKCX7VEYYXSw2fvede11V5G4I2bR15gx6A4osl4CVkviwCh/5sfdHmnqWwwIQCY1cNu1oDXKDAcYEG0W0suLg5NF9JIN0Z3j8Eb+l1kOvWBQfi+hluQ=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:08 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:08 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Topic: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Index: AQHUduWqhR5TMbLPo06W2x2cs1kfyA==
Date:   Wed, 7 Nov 2018 22:03:08 +0000
Message-ID: <20181107220254.6116-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:20b::46)
 To SN6PR07MB5326.namprd07.prod.outlook.com (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.181.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:0dgk9Y8MGcWRIAzPPIdYXmh/nKtnaeFou0U3bkq++HS24GpzeJWd21rLCHHz9iI3LqTclxdsh8qY1B23BdnbDzAX1CyX41r4TLBcmKScE3cFAVKnW4sEWlyY8lcnCOutOBwdsuRnf8h9oI1zr0Hk9GnbbHA4ih6E3AI3TBFFE/nejCUPR80Mp2LRDsUtvt2qJ8Sl0ODUFnH3FKS5UJQ5LsYeoFLP7aY7DRff9nlodahwZbtledWCjZ5/ecLREYbljS8gER1q0BC3yyuSFEDJoZhtqhwe8B410K1ZNxAg1NBFYku7xYIfZm0TjDVF4ktXx2190o8c/UsPbJHO3RUtD+9zFl2Jn7eAtxfpnOgHcKaB2MOS5S4rKYOH/3MItb2nXR3bF/js9akiPk8CY2Bkm6VLWjW7nbRn2T2hxw/5oG4ITdiUafm5mIYqj5i9zZH1wPFKlONSW2dNOR+Z1D0HHQ==;5:DFA8ZB9OFhyRFZuVfrnLxDdr3BegOgL5AaGw+AunXMxnkvFnYjfaMaa0efJCjH6cNzjmuc+wrrfu0hoca/d0rT11DWV2wt2S3i6k4jf7EDcPNFSDvZVksAGNYFm+ZrCFHsl1pFyu7jPsP6bFQfkHvLqoh8qFVAnO4sYRR3IEVms=;7:b/uCCcRQYkNHcM9ynA3TV8MWXQMKvxWNLCPNYMqYLuqcHvy5SF81xQJ4lleM84Tu59yhfZ0NOimRiso2YVzoYscWdxCcknYv35XK3hkepYKqvO65c0W8Sg4C6h9CWyw3+xmBHDzCTCk1MifbaJE2HA==
x-ms-office365-filtering-correlation-id: ef39b88f-f016-4122-467c-08d644fcccad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB5232159EEB476E7E06307F68F1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(305945005)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0lPoJvIbedSMMysqo1ED5tGskqOuVHESkMRQkHf32kvptxXZqGTfV/pgSzZ4l1P30ZtUHbXalz8qij4UzLtyvmKHONa6FvZJv084m2bFcvYC9eTI5PDw4O8JFiyNUz/5aMR1tk8J9ceTdjkl1/wmP1whubUoMT4/zYArW/hjj8GU4I4JHnNVnxGQ2nPiu4RRQWdAGHiqFOmkpmacKE8Y+2SfrORqS5NZJkMF193FarTknIc0ryVh/lwvTSsflHAu7b9f9aANArizisVHEIEzgzI3AhSDBPQwsZLtJgYhwrOERNQ05VnCcZ/k8ev7+UJcFl4N2CId7BTfMlz7gNC+cN56tbBRQTB4QPOjQ61G0Rs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CBAC707956A148BC25A9A8D2AE151F@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef39b88f-f016-4122-467c-08d644fcccad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:08.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaXMgYSByZXdvcmsgb2YgdGhlIGdpYy12My1pdHMgaW5pdGlhbGl6
YXRpb24uIEl0IGlzDQppbiBwcmVwYXJhdGlvbiBvZiBhIGZ1cnRoZXIgc2VyaWVzIHRoYXQgdXNl
cyBDTUEgbWVtb3J5IGFsbG9jYXRpb24gZm9yDQpJVFMgdGFibGVzLiBGb3IgdGhpcyB0aGUgQ01B
IGZyYW1ld29yayBtdXN0IGJlIGF2YWlsYWJsZSBhbmQgdGh1cyBJVFMNCm5lZWRzIHRvIGJlIGlu
aXRpYWxpemVkIGFmdGVyIHRoZSBhcmNoX2luaXRjYWxscy4gVGhpcyByZXF1aXJlcyB0d28NCm1h
am9yIHJld29ya3MuDQoNCkZpcnN0IHdlIG11c3QgcmVtb3ZlIGFsbCBpcnEgZG9tYWluIGluaXQg
b3JkZXIgZGVwZW5kZW5jaWVzIChwYXRjaGVzDQojMS0jNSksIHNlY29uZCB0aGUgSVRTIGluaXRp
YWxpemF0aW9uIG11c3QgYmUgc3BsaXQgaW50byBhbiBlYXJseQ0KcHJvYmUgYW5kIGEgbGF0ZXIg
aW5pdCBwYXJ0IChwYXRjaGVzICM2LSMxMCkuDQoNClBhdGNoICMxIGludHJvZHVjZXMgYSBuZXcg
aW50ZXJmYWNlIHRvIHJlcXVlc3QgYW4gaXJxIGRvbWFpbiwgc2VlIHRoZQ0KcGF0Y2ggZGVzY3Jp
cHRpb24gZm9yIGRldGFpbHMuIEluIHBhdGNoZXMgIzItIzUgYWxsIElUUyByZWxhdGVkIGlycQ0K
ZG9tYWlucyBhcmUgY29udmVydGVkIHRvIHVzZSB0aGUgbmV3IGludGVyZmFjZS4gVGhlcmUgYXJl
IG5vIG9yZGVyDQpkZXBlbmRlbmNpZXMgZm9yIHBhcmVudCBhbmQgY2xpZW50IGlycSBkb21haW4g
aW5pdGlhbGl6YXRpb24gYW55bW9yZQ0Kd2hpY2ggYWxsb3dzIHVzIHRvIGluaXRpYWxpemUgYWxs
IElUUyBpcnEgZG9tYWlucyBpbiB0aGUgc2FtZSBpbml0Y2FsbA0KKG1vdmluZyB0byB0aGUgbGF0
ZXIgc3Vic3lzX2luaXRjYWxsKS4gTm90ZSB0aGF0IEkgZG8gbm90IGhhdmUgZnNsDQpoYXJkd2Fy
ZSBhdmFpbGFibGUsIHRoZSBjb2RlIHNob3VsZCB3b3JrLCBidXQgaXMgb25seSBjYXJlZnVsbHkN
CnJldmlld2VkIGFuZCBjb21waWxlIHRlc3RlZCwgcGxlYXNlIHRlc3Qgb24gdGhhdCBoYXJkd2Fy
ZS4NCg0KVGhlIHJlbWFpbmluZyBwYXRjaGVzICM2LSMxMCBhcmUgYW4gaW5jcmVtZW50YWwgcmV3
b3JrIG9mIHRoZSBJVFMNCmluaXRpYWxpemF0aW9uLCBiYXNpY2FsbHkgc3BsaXR0aW5nIHByb2Jl
IGFuZCBpbml0IChwYXRjaCAjNykgYW5kDQpzZXBhcmF0aW5nIGl0IGZyb20gZ2ljLXYzIGNvZGUg
KHBhdGNoICM4KS4gUGF0Y2hlcyAjOSBhbmQgIzEwIGNoYW5nZQ0KaW5pdGNhbGwgbGV2ZWxzIGZv
ciB2YXJpb3VzIGRyaXZlcnMuDQoNClBhdGNoZXMgaGF2ZSBiZWVuIHRlc3RlZCB3aXRoIENhdml1
bSBUaHVuZGVyWCBhbmQgVGh1bmRlclgyLiBJIGhhdmUgYW4NCmltcGxlbWVudGF0aW9uIG9mIENN
QSBJVFMgdGFibGUgYWxsb2NhdGlvbiBvbiB0b3Agb2YgdGhpcyBzZXJpZXMNCmF2YWlsYWJsZSwg
SSB3aWxsIHNlbmQgb3V0IHBhdGNoZXMgZm9yIHRoaXMgaW4gYSBjb3VwbGUgb2YgZGF5cy4NCg0K
Um9iZXJ0IFJpY2h0ZXIgKDEwKToNCiAgaXJxZG9tYWluOiBBZGQgaW50ZXJmYWNlIHRvIHJlcXVl
c3QgYW4gaXJxIGRvbWFpbg0KICBpcnFjaGlwL2dpYy12My1pdHMtcGxhdGZvcm0tbXNpOiBSZW1v
dmUgZG9tYWluIGluaXQgb3JkZXIgZGVwZW5kZW5jaWVzDQogIGlycWNoaXAvaXJxLWdpYy12My1p
dHMtcGNpLW1zaTogUmVtb3ZlIGRvbWFpbiBpbml0IG9yZGVyIGRlcGVuZGVuY2llcw0KICBpcnFj
aGlwL2lycS1naWMtdjMtaXRzLWZzbC1tYy1tc2k6IFJlbW92ZSBkb21haW4gaW5pdCBvcmRlcg0K
ICAgIGRlcGVuZGVuY2llcw0KICBmc2wtbWMvZHByYy1kcml2ZXI6IFJlbW92ZSBkb21haW4gaW5p
dCBvcmRlciBkZXBlbmRlbmNpZXMNCiAgaXJxY2hpcC9naWMtdjMtaXRzOiBJbml0aWFsaXplIGl0
cyBub2RlcyBpbiBwcm9iZSBvcmRlcg0KICBpcnFjaGlwL2dpYy12My1pdHM6IFNwbGl0IHByb2Jp
bmcgZnJvbSBpdHMgbm9kZSBpbml0aWFsaXphdGlvbg0KICBpcnFjaGlwL2dpYy12My1pdHM6IERl
Y291cGxlIGl0cyBpbml0aWFsaXphdGlvbiBmcm9tIGdpYw0KICBpcnFjaGlwL2dpYy12My1pdHM6
IEluaXRpYWxpemUgaXRzIG5vZGVzIGxhdGVyDQogIGlycWNoaXAvZ2ljLXYzLWl0czogSW5pdGlh
bGl6ZSBNU0lzIHdpdGggc3Vic3lzX2luaXRjYWxscw0KDQogZHJpdmVycy9idXMvZnNsLW1jL2Rw
cmMtZHJpdmVyLmMgICAgICAgICAgICAgIHwgIDQxICsrKysrKysNCiBkcml2ZXJzL2J1cy9mc2wt
bWMvZnNsLW1jLW1zaS5jICAgICAgICAgICAgICAgfCAgIDYgKy0NCiBkcml2ZXJzL2lycWNoaXAv
aXJxLWdpYy12My1pdHMtZnNsLW1jLW1zaS5jICAgfCAgNDkgKysrKystLS0NCiBkcml2ZXJzL2ly
cWNoaXAvaXJxLWdpYy12My1pdHMtcGNpLW1zaS5jICAgICAgfCAgNjggKysrKysrLS0tLS0NCiBk
cml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMtcGxhdGZvcm0tbXNpLmMgfCAgNTYgKysrKysr
LS0tDQogZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMgICAgICAgICAgICAgIHwgMTYw
ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQogZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMu
YyAgICAgICAgICAgICAgICAgIHwgIDEyICstDQogaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgg
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBpbmNsdWRlL2xpbnV4L2lycWNoaXAvYXJtLWdp
Yy12My5oICAgICAgICAgICAgfCAgIDUgKy0NCiBpbmNsdWRlL2xpbnV4L2lycWRvbWFpbi5oICAg
ICAgICAgICAgICAgICAgICAgfCAgMTUgKysrDQoga2VybmVsL2lycS9pcnFkb21haW4uYyAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTU4ICsrKysrKysrKysrKysrKysrKysrKysrKysNCiAxMSBm
aWxlcyBjaGFuZ2VkLCA0NDEgaW5zZXJ0aW9ucygrKSwgMTMwIGRlbGV0aW9ucygtKQ0KDQotLSAN
CjIuMTEuMA0KDQo=
