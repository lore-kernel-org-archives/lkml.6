Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A882082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="D7FD3hN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A882082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLDPD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:03:57 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:2400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbeLDPD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oiu8JNZFP8xtm6K2+PYF71XitJs/2avxO+1PcilNzRg=;
 b=D7FD3hN+MrDKMcCMh6yfhvdoufNQWlSS6i+a7x5KNp+EU/7N/fQN3OtoQpLsQDWLXW7Q7fGmEPtSEfnfTJ/a1kmo248vE+oSdHNYp/pSq3z0gECPNBMszwKPsbBjybIaRqPYsC+YBb4AGKQwxdPnVsar9c4aU3uSawu7l9oaOZo=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5963.eurprd04.prod.outlook.com (20.178.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 15:03:38 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 15:03:37 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH 2/4] video: ssd1307fb: Do not hard code active-low reset
 sequence
Thread-Topic: [PATCH 2/4] video: ssd1307fb: Do not hard code active-low reset
 sequence
Thread-Index: AQHUi+KJ395FeYACCUmT9qboSgnbUQ==
Date:   Tue, 4 Dec 2018 15:03:37 +0000
Message-ID: <1543935806-94880-3-git-send-email-michal.vokac@ysoft.com>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5963;6:L7wtF+SQONZGi3OBYRZ9Kgg2ZElKjBi34Is9a6Qw+JLtWhNe6DsUcAgc6VYHfc4zvqJoofGMbRn4+yZltoUznL86vAVWi9sGZuqysM1lN6hkA7VjbThpT1Hggj2nv83EWZHj5siOzfnhZeRPZ5lGAPI/wULJick+/ramoydoEi/+uIHKSdnToQkCEyjAeq4XSgkkxSGAo69Vq9P+mD0uZS0lyiYcKS+N8oE7sEyTgiCuyTG5qoID7OpNWJMuvmgBSA/at4jV2dng6kzu973cpsNMKB84/dtKbLZyPTReYtXyr+U74aRCPSdZUE64W3EorIy+ZYSbUQ6r70wwhzN4BI4vfVqOvkwLZ+cy91bOkBi+tr0w+ADc/fPjZLjfRnG2Zb6kCBbGOnHDevqbTJhYIectWsY6Dg1vyWya8iY/wX25k1PX/K8Pd9R+z9TRCsvQ21pqmhCmjq8soNRIYwPJ2A==;5:1uiXHxwU4xo9d/hAqROVkRo037mIliJ9ZW8Y/M4lOYRCNb0FMa8gyYkbN25f2PEijHOwyjlD1j/HWgZhBStxmcCmHPk3TM74fFl9YtZ86jrD8lZETHsuOjZ4BPm/ckaoL67SarUO/qRM8Gb4aFJZvHKGpX2ZtQVsRsYefWspeco=;7:VwUttV6Qow6VVEMWVCNkcMLuaKVE/m+RxJTDi4lM7J9ZIDVzaelSXzCJIS5e8OxDF2oLs5dtOR12r4YVy/ngaVt6H8svqMNbXoYITMSh7H4vnownS0IrUggBlh37BDINDK5TCDY1Ja/Kj8VDuad5Tg==
x-ms-office365-filtering-correlation-id: beb0d9d2-9bcc-4409-eeff-08d659f9ab40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5963;
x-ms-traffictypediagnostic: DB7PR04MB5963:
x-microsoft-antispam-prvs: <DB7PR04MB5963A31D8AD0A25CB49BD6BC9EAF0@DB7PR04MB5963.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5963;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5963;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(136003)(396003)(346002)(376002)(199004)(189003)(72206003)(53936002)(478600001)(76176011)(6512007)(26005)(386003)(305945005)(186003)(4326008)(107886003)(7736002)(256004)(81156014)(66066001)(8936002)(71200400001)(14454004)(71190400001)(6506007)(81166006)(6486002)(5660300001)(11346002)(25786009)(99286004)(36756003)(2616005)(6436002)(446003)(316002)(68736007)(102836004)(105586002)(2906002)(110136005)(106356001)(54906003)(486006)(52116002)(6116002)(86362001)(3846002)(476003)(85182001)(8676002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5963;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wrxw/WifOcEi/0TRppgrD9zOnNBEca6DakqEnZEOIursjuVUiAj2f7MuyZHIfB8TJxDQ45+yyTljAwINGbtf15nYDeSdQ+6FuCBpALIjx8OSOoUvHS4KdYkYXBANQ07B1aj0wJ3ut0Ggwz2gjAvDnhuwS6oa0RyzV3nK1bviLwqMxdL+n2/QV4O03xbOho4O7DSAkWFFRMU2CyiOtEDUT0PWnU+95qaXirGsQYE0wOqEuewwy/yQOTmbzhKq3+X1WwoOWtPq5GaRGHKBuAgdZXq/39iDXbZ1DAB5zrXpCPb1ofOghdgxkgWrabt61l3H9JNjQjSAtIzWJGJAOHh9H1WWfzngWKVprT8hECPyYmQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFEBB006D9A470479A0B03225DF6057F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0d9d2-9bcc-4409-eeff-08d659f9ab40
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 15:03:37.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFNTRDEzMHggT0xFRMKgZGlzcGxheSByZXNldCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gTm93
IHRoZSByZXNldA0Kc2VxdWVuY2UgaXMgaW1wbGVtZW50ZWQgaW4gc3VjaCBhIHdheSB0aGF0IHVz
ZXJzIGFyZSBmb3JjZWQgdG8NCmRlZmluZSByZXNldC1ncGlvcyBhcyBHUElPX0FDVElWRV9ISUdI
IGluIERUIHRvIG1ha2UgdGhlIHJlc2V0IHdvcmsuDQoNCkRvIG5vdCBoYXJkIGNvZGUgdGhlIGFj
dGl2ZS1sb3cgc2VxdWVuY2UgaW50byB0aGUgZHJpdmVyIGJ1dCBpbnN0ZWFkDQphbGxvdyB0aGUg
dXNlciB0byBzcGVjaWZ5IHRoZSBncGlvIGFzIEdQSU9fQUNUSVZFX0xPVyB0byByZWZsZWN0DQp0
aGUgcmVhbCB3b3JsZC4NCg0KU2lnbmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52
b2thY0B5c29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jIHwg
NCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMgYi9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jDQppbmRleCA0MDYxYTIwLi4zYjM2MWJjIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYw0KKysrIGIvZHJpdmVycy92aWRl
by9mYmRldi9zc2QxMzA3ZmIuYw0KQEAgLTY2NywxMCArNjY3LDEwIEBAIHN0YXRpYyBpbnQgc3Nk
MTMwN2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogDQogCWlmIChwYXItPnJl
c2V0KSB7DQogCQkvKiBSZXNldCB0aGUgc2NyZWVuICovDQotCQlncGlvZF9zZXRfdmFsdWVfY2Fu
c2xlZXAocGFyLT5yZXNldCwgMCk7DQotCQl1ZGVsYXkoNCk7DQogCQlncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAocGFyLT5yZXNldCwgMSk7DQogCQl1ZGVsYXkoNCk7DQorCQlncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAocGFyLT5yZXNldCwgMCk7DQorCQl1ZGVsYXkoNCk7DQogCX0NCiANCiAJaWYg
KHBhci0+dmJhdF9yZWcpIHsNCi0tIA0KMi4xLjQNCg0K
