Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D20C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C346214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9gZPToA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C346214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeHBLFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:05:17 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:8618
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbeHBLFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJWFvVYDyqcAZ2qnQFhf9A7OAoU6EfckWaSSf+sti9c=;
 b=U9gZPToAkx9Q1RskwEvuWaVhInVpSiLjV0t3nTrfyoeeX2Edr4LTaiK32RRaZoTRtJ5/N6rP9p4gCLTuOzXV/MlmEOnFhQyqqk0/JxUXoIUr/OHmJYSDLRz1mjss+LkOxMWOzbmDHbtQmtBqzExYlCnXSt7KPDevR/e9JbvFOjI=
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com (10.165.45.7) by
 AM4PR0401MB1937.eurprd04.prod.outlook.com (10.166.130.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 09:14:58 +0000
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c]) by AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c%7]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 09:14:58 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: fec: check DMA addressing limitations
Thread-Topic: [PATCH v2] net: fec: check DMA addressing limitations
Thread-Index: AQHUKjzPGCZa7lUgCU623pz9NP0c5aSsLeNw
Date:   Thu, 2 Aug 2018 09:14:58 +0000
Message-ID: <AM4PR0401MB2260C05C99B37EB487CAF90FFF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180802084250.26489-1-stefan@agner.ch>
In-Reply-To: <20180802084250.26489-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1937;6:OQV2vgG1O/fJaiWz/YGNE6G19PIcOr14knwW35V+Ng16/CzQnE20lwzJpQEk/1ch50DP9bLVJJWPz597vpaNpqxxNRTSN9UhJ4NOVfWKbayawIOmL1EXFhF7UI3G9R2JYAAfj9bMJw+7vpVqiU0lSkEETGv/YpBI2kS0BtXcBo6QCujHkQSb5nMV91IF5jSYktsfHUbmdZCbW9JeL4R0fSEFcVl8hOFZsYCcirPPDqxgO5on20wtDAXFEd43nfXk+z+Z87HwfQPGpRR7jYpc4l1nv9kk0GGkk/3ysf6ITN/ogmVS2fvNTcbX4rqm2x0pdetAbMFOy0CdrlIkFUa0YbJ60NtxWWtjya6NfgI9THIZLNqgOWw7BiK+L3aHxssj9FrEkTbQB+jgcLyjsEX6sxfTcqqNL4uKRAaobvMk85cs6Vu9N49HO3Melnlb7Rb3jFUwYtlkVFzgnOoVpBwH3w==;5:S6WkT8ByrAFJvdGhCMOG6ZbTJdi5cweQm4DmKkzF9zLFBTuGV9bQolGQvzrxp35aFlT3Hw0CWas9x+NN4388XKAFm7bniracxjhfuLp+ZcvpfV9io7uFVC6h4m1KYbi6imb463dBrov4BYjd4k/utPQTohN43QnZzmarEvMC5mo=;7:QBEL0HrnnWLq2Mik9aC9X3B5v0MBWhd+J/1vIdSO+oqLYjo5B0kALQH3vIBTfVqjyqH8C0ils3kNRGTwcfBGq+9U1a6O2xeOWVTUDvpRWmyYPrhr8Do2sewWXFzs6dcmqlyIpqj/UMHI0VcFf0E/+KeQ99qn+TM1fAizN5Y7HmngFA1NyAf9MD63+d9uTpNVCu//IADDzq6ZQNIRFQ5RrhLwMeSDhO+VMBfHliWwYwghOChj8CU1pRNrPKxIhJE7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b48288ff-66f4-4548-16fd-08d5f8586b59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1937;
x-ms-traffictypediagnostic: AM4PR0401MB1937:
x-microsoft-antispam-prvs: <AM4PR0401MB193767D476A7C1DA9126221EFF2C0@AM4PR0401MB1937.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB1937;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1937;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(3846002)(6116002)(6436002)(229853002)(6246003)(55016002)(5250100002)(2501003)(99286004)(2906002)(478600001)(74316002)(305945005)(7736002)(486006)(54906003)(106356001)(86362001)(256004)(53936002)(316002)(5660300001)(110136005)(476003)(9686003)(76176011)(2900100001)(11346002)(68736007)(7696005)(446003)(8936002)(6506007)(8676002)(81156014)(102836004)(81166006)(66066001)(14454004)(4326008)(105586002)(25786009)(186003)(33656002)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1937;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T04ZjQv2dQTQt9gtoCP/TxN8Hb9cBh/EMyvS3VHxD7sPwGP0arV31EKkAmB2GLfgWrn5t9nCPrjK1B0nvYE6enE/3exipBD+H2n25UYVFpFj2FFKkIqEXRUIdMmDJD/UEZYo1dcVJGzy61vCAmgb8cTsexj3fmX80gxPr4jO+Vx9SY3KyQOdJKxB6wNuKgCcZDLgSFAtMTBXhx5iUbQyCzp/rf2/u2KhtYJy1g7wzTOTAjj6nfwJoRd4ndpKVt1L1eoLtLVueU4IxlvfCLooiGHTICCkulQ4ZGa8bFQ/CB9Lh0EtKtnoMW4z1FQYmB36TnBvw35BTKKXo8vw14U6Lrbin4quF2Bzlp7SH3k5dJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48288ff-66f4-4548-16fd-08d5f8586b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 09:14:58.4053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+IFNlbnQ6IDIwMTjE6jjUwjLI1SAx
Njo0Mw0KPiBDaGVjayBETUEgYWRkcmVzc2luZyBsaW1pdGF0aW9ucyBhcyBzdWdnZXN0ZWQgYnkg
dGhlIERNQSBBUEkgaG93LXRvLg0KPiBUaGlzIGRvZXMgbm90IGZpeCBhIHBhcnRpY3VsYXIgaXNz
dWUgc2VlbiBidXQgaXMgY29uc2lkZXJlZCBnb29kIHN0eWxlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+DQoNCkFja2VkLWJ5OiBGdWdhbmcgRHVh
biA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Zl
Y19tYWluLmMNCj4gaW5kZXggYzcyOTY2NTEwN2Y1Li5jZGYyZjU0NDc5MTAgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0zMTM2LDYgKzMx
MzYsNyBAQCBzdGF0aWMgaW50IGZlY19lbmV0X2luaXQoc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5k
ZXYpDQo+ICAJdW5zaWduZWQgZHNpemUgPSBmZXAtPmJ1ZmRlc2NfZXggPyBzaXplb2Yoc3RydWN0
IGJ1ZmRlc2NfZXgpIDoNCj4gIAkJCXNpemVvZihzdHJ1Y3QgYnVmZGVzYyk7DQo+ICAJdW5zaWdu
ZWQgZHNpemVfbG9nMiA9IF9fZmxzKGRzaXplKTsNCj4gKwlpbnQgcmV0Ow0KPiANCj4gIAlXQVJO
X09OKGRzaXplICE9ICgxIDw8IGRzaXplX2xvZzIpKTsNCj4gICNpZiBkZWZpbmVkKENPTkZJR19B
Uk0pIHx8IGRlZmluZWQoQ09ORklHX0FSTTY0KSBAQCAtMzE0Niw2DQo+ICszMTQ3LDEzIEBAIHN0
YXRpYyBpbnQgZmVjX2VuZXRfaW5pdChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gIAlmZXAt
PnR4X2FsaWduID0gMHgzOw0KPiAgI2VuZGlmDQo+IA0KPiArCS8qIENoZWNrIG1hc2sgb2YgdGhl
IHN0cmVhbWluZyBhbmQgY29oZXJlbnQgQVBJICovDQo+ICsJcmV0ID0gZG1hX3NldF9tYXNrX2Fu
ZF9jb2hlcmVudCgmZmVwLT5wZGV2LT5kZXYsDQo+IERNQV9CSVRfTUFTSygzMikpOw0KPiArCWlm
IChyZXQgPCAwKSB7DQo+ICsJCWRldl93YXJuKCZmZXAtPnBkZXYtPmRldiwgIk5vIHN1aXRhYmxl
IERNQSBhdmFpbGFibGVcbiIpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiAgCWZl
Y19lbmV0X2FsbG9jX3F1ZXVlKG5kZXYpOw0KPiANCj4gIAliZF9zaXplID0gKGZlcC0+dG90YWxf
dHhfcmluZ19zaXplICsgZmVwLT50b3RhbF9yeF9yaW5nX3NpemUpICogZHNpemU7DQo+IC0tDQo+
IDIuMTguMA0KDQo=
