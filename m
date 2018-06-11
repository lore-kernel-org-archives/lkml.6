Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4cTHEafwHVsEZwAAmS7hNA
	; Mon, 11 Jun 2018 03:47:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5FE5D6070A; Mon, 11 Jun 2018 03:47:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="fXpd9APh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4EDB360385;
	Mon, 11 Jun 2018 03:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EDB360385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFKDrS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:47:18 -0400
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:10377
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753793AbeFKDrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlayZ4EFT6c5vqNBb5LYa1Mwq4jeeQgcN+5y4CNNauI=;
 b=fXpd9APhGuapmFGfu3Hdf3WltLsMdQe8mUBtlyDtpGYZXqhnh1XVm9cbbx/U0Z4i0oc6htq/wkN84hjuuCq6cyI4gqqWLHxBlwDHnHEbGOHCAPm2a1nCyxpD2zqMTrzcpN17+vylvhOV8aIo43utQRVZcVpjbeHGcvyWJsOPplQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4056.namprd05.prod.outlook.com (52.135.199.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.10; Mon, 11 Jun 2018 03:47:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%2]) with mapi id 15.20.0863.010; Mon, 11 Jun 2018
 03:47:12 +0000
From: Nadav Amit <namit@vmware.com>
To: "hpa@zytor.com" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 9/9] x86: jump-labels: use macros instead of inline
 assembly
Thread-Topic: [PATCH v3 9/9] x86: jump-labels: use macros instead of inline
 assembly
Thread-Index: AQHUAQLNA64s+KvCzkSUCgRDBNcB56RaRWAAgAAmWgA=
Date: Mon, 11 Jun 2018 03:47:12 +0000
Message-ID: <E151C478-11A4-4B11-82A5-9A4D637EFEC2@vmware.com>
References: <20180610141911.52948-1-namit@vmware.com>
 <20180610141911.52948-10-namit@vmware.com>
 <FF974700-F60D-4083-836C-0D4A2557FA16@zytor.com>
In-Reply-To: <FF974700-F60D-4083-836C-0D4A2557FA16@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4056;7:pczf7p8SMxOFGIpIRy6ni+I2EuUbPHppDIjbrmPu+NpT3A/PxGEiHdEqXLb53u4bdbOn6TTzdKXvwuNzH+vDOS2M/ObCoojhhaezTZtkDrl2KcVFYWFouzis2T95KwGsNJ6C+6x6Y34hVfwKNrCALF8yi0uKqghWFToxKycHc2PYa/Xlj187onE6ucE2fxghl9HPxQQn/Yy+Bd9WpcwRAsROAkiuDj9dJEO/Ai38OspvfyGfg+7arbXVYbwknrtw;20:GNbvsvJkg4/VRs+M0yG4KxZ+rqTvvlU4OzXZMsR8BabrSk0bhHnaE4u5G6mxbE26a0tPih8EMVEsTsz+PAqsirvbdkMqeJl4I0UAJe8DYTHCsG8nnut41IW7+OycM//gUw+1YgIfOBfZ8Qbuwp+HIHSjHtEEHRt8JJANVT6Kxr8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4056;
x-ms-traffictypediagnostic: BYAPR05MB4056:
x-microsoft-antispam-prvs: <BYAPR05MB4056B054F5E8BDCB4AB35B0ED0780@BYAPR05MB4056.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4056;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4056;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(51444003)(199004)(189003)(5640700003)(2616005)(11346002)(446003)(476003)(3280700002)(33656002)(6506007)(486006)(82746002)(2351001)(3846002)(105586002)(106356001)(6116002)(2900100001)(76176011)(14454004)(97736004)(68736007)(966005)(25786009)(3660700001)(54906003)(66066001)(4326008)(26005)(6916009)(8676002)(53936002)(5660300001)(1730700003)(81166006)(81156014)(2906002)(229853002)(6486002)(6512007)(6306002)(36756003)(86362001)(99286004)(7736002)(575784001)(8936002)(478600001)(6436002)(2501003)(6246003)(316002)(5250100002)(102836004)(305945005)(83716003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4056;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +sLKK8YS2RdFNVLGqxBbzSol3kvnBgCMB4/jb/tVLPwqiIfV02zToImtc9oM5XMqax/JJRvgLghdK7dx4vVe4GBvgCh5XpUVS0x21TWnpT6t00QgB5NmrlUTDLqpPeONDOOqV+JX6tlm4s3qmcFvJCmUynofyW9XtdzVTb9sxxEqC3XJwUOI/Dk93WnuRGfE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C09E05F735444B8689DBD84C1CCF80@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 302d180e-26a6-476f-217f-08d5cf4e0408
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d180e-26a6-476f-217f-08d5cf4e0408
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 03:47:12.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNjoyOSBQTSwgaHBhQHp5dG9yLmNvbSB3cm90ZToNCg0KPiBPbiBKdW5lIDEwLCAyMDE4IDc6
MTk6MTEgQU0gUERULCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IFVz
ZSBhc3NlbWJseSBtYWNyb3MgZm9yIGp1bXAtbGFiZWxzIGFuZCBjYWxsIHRoZW0gZnJvbSBpbmxp
bmUgYXNzZW1ibHkuDQo+PiBUaGlzIG5vdCBvbmx5IG1ha2VzIHRoZSBjb2RlIG1vcmUgcmVhZGFi
bGUsIGJ1dCBhbHNvIGltcHJvdmVzDQo+PiBjb21waWxhdGlvbiBkZWNpc2lvbiwgc3BlY2lmaWNh
bGx5IGlubGluZSBkZWNpc2lvbnMgd2hpY2ggR0NDIGJhc2Ugb24NCj4+IHRoZSBudW1iZXIgb2Yg
bmV3IGxpbmVzIGluIGlubGluZSBhc3NlbWJseS4NCj4+IA0KPj4gQXMgYSByZXN1bHQgdGhlIGNv
ZGUgc2l6ZSBpcyBzbGlnaHRseSBpbmNyZWFzZWQuDQo+PiANCj4+ICB0ZXh0CSAgIGRhdGEJICAg
IGJzcwkgICAgZGVjCSAgICBoZXgJZmlsZW5hbWUNCj4+IDE4MTYzNTI4IDEwMjI2MzAwIDI5NTcz
MTIgMzEzNDcxNDAgMWRlNTFjNCAuL3ZtbGludXggYmVmb3JlDQo+PiAxODE2MzYwOCAxMDIyNzM0
OCAyOTU3MzEyIDMxMzQ4MjY4IDFkZTU2MmMgLi92bWxpbnV4IGFmdGVyICgrMTEyOCkNCj4+IA0K
Pj4gQW5kIGZ1bmN0aW9ucyBzdWNoIGFzIGludGVsX3BzdGF0ZV9hZGp1c3RfcG9saWN5X21heCgp
LA0KPj4ga3ZtX2NwdV9hY2NlcHRfZG1faW50cigpLCBrdm1fcmVnaXN0ZXJfcmVhZCgpIGFyZSBp
bmxpbmVkLg0KPj4gDQo+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQo+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+PiBDYzogIkguIFBldGVy
IEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCj4+IENjOiB4ODZAa2VybmVsLm9yZw0KPj4gQ2M6IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+PiBDYzogS2F0
ZSBTdGV3YXJ0IDxrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4gQ2M6IFBoaWxpcHBl
IE9tYnJlZGFubmUgPHBvbWJyZWRhbm5lQG5leGIuY29tPg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gLS0tDQo+PiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9qdW1wX2xhYmVsLmggfCA2NSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
DQo+PiBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLlMgICAgICAgICAgfCAgMSArDQo+PiAyIGZpbGVz
IGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oDQo+PiBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaA0KPj4gaW5kZXggOGMwZGU0MjgyNjU5Li5lYTA2MzNh
NDExMjIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmgN
Cj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaA0KPj4gQEAgLTIsMTkg
KzIsNiBAQA0KPj4gI2lmbmRlZiBfQVNNX1g4Nl9KVU1QX0xBQkVMX0gNCj4+ICNkZWZpbmUgX0FT
TV9YODZfSlVNUF9MQUJFTF9IDQo+PiANCj4+IC0jaWZuZGVmIEhBVkVfSlVNUF9MQUJFTA0KPj4g
LS8qDQo+PiAtICogRm9yIGJldHRlciBvciBmb3Igd29yc2UsIGlmIGp1bXAgbGFiZWxzICh0aGUg
Z2NjIGV4dGVuc2lvbikgYXJlDQo+PiBtaXNzaW5nLA0KPj4gLSAqIHRoZW4gdGhlIGVudGlyZSBz
dGF0aWMgYnJhbmNoIHBhdGNoaW5nIGluZnJhc3RydWN0dXJlIGlzIGNvbXBpbGVkDQo+PiBvdXQu
DQo+PiAtICogSWYgdGhhdCBoYXBwZW5zLCB0aGUgY29kZSBpbiBoZXJlIHdpbGwgbWFsZnVuY3Rp
b24uICBSYWlzZSBhDQo+PiBjb21waWxlcg0KPj4gLSAqIGVycm9yIGluc3RlYWQuDQo+PiAtICoN
Cj4+IC0gKiBJbiB0aGVvcnksIGp1bXAgbGFiZWxzIGFuZCB0aGUgc3RhdGljIGJyYW5jaCBwYXRj
aGluZw0KPj4gaW5mcmFzdHJ1Y3R1cmUNCj4+IC0gKiBjb3VsZCBiZSBkZWNvdXBsZWQgdG8gZml4
IHRoaXMuDQo+PiAtICovDQo+PiAtI2Vycm9yIGFzbS9qdW1wX2xhYmVsLmggaW5jbHVkZWQgb24g
YSBub24tanVtcC1sYWJlbCBrZXJuZWwNCj4+IC0jZW5kaWYNCj4+IC0NCj4+ICNkZWZpbmUgSlVN
UF9MQUJFTF9OT1BfU0laRSA1DQo+PiANCj4+ICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+PiBAQCAt
MjgsMTggKzE1LDI3IEBADQo+PiANCj4+ICNpZm5kZWYgX19BU1NFTUJMWV9fDQo+PiANCj4+ICsj
aWZuZGVmIEhBVkVfSlVNUF9MQUJFTA0KPj4gKy8qDQo+PiArICogRm9yIGJldHRlciBvciBmb3Ig
d29yc2UsIGlmIGp1bXAgbGFiZWxzICh0aGUgZ2NjIGV4dGVuc2lvbikgYXJlDQo+PiBtaXNzaW5n
LA0KPj4gKyAqIHRoZW4gdGhlIGVudGlyZSBzdGF0aWMgYnJhbmNoIHBhdGNoaW5nIGluZnJhc3Ry
dWN0dXJlIGlzIGNvbXBpbGVkDQo+PiBvdXQuDQo+PiArICogSWYgdGhhdCBoYXBwZW5zLCB0aGUg
Y29kZSBpbiBoZXJlIHdpbGwgbWFsZnVuY3Rpb24uICBSYWlzZSBhDQo+PiBjb21waWxlcg0KPj4g
KyAqIGVycm9yIGluc3RlYWQuDQo+PiArICoNCj4+ICsgKiBJbiB0aGVvcnksIGp1bXAgbGFiZWxz
IGFuZCB0aGUgc3RhdGljIGJyYW5jaCBwYXRjaGluZw0KPj4gaW5mcmFzdHJ1Y3R1cmUNCj4+ICsg
KiBjb3VsZCBiZSBkZWNvdXBsZWQgdG8gZml4IHRoaXMuDQo+PiArICovDQo+PiArI2Vycm9yIGFz
bS9qdW1wX2xhYmVsLmggaW5jbHVkZWQgb24gYSBub24tanVtcC1sYWJlbCBrZXJuZWwNCj4+ICsj
ZW5kaWYNCj4+ICsNCj4+ICNpbmNsdWRlIDxsaW51eC9zdHJpbmdpZnkuaD4NCj4+ICNpbmNsdWRl
IDxsaW51eC90eXBlcy5oPg0KPj4gDQo+PiBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgYXJj
aF9zdGF0aWNfYnJhbmNoKHN0cnVjdCBzdGF0aWNfa2V5ICprZXksDQo+PiBib29sIGJyYW5jaCkN
Cj4+IHsNCj4+IC0JYXNtX3ZvbGF0aWxlX2dvdG8oIjE6Ig0KPj4gLQkJIi5ieXRlICIgX19zdHJp
bmdpZnkoU1RBVElDX0tFWV9JTklUX05PUCkgIlxuXHQiDQo+PiAtCQkiLnB1c2hzZWN0aW9uIF9f
anVtcF90YWJsZSwgIFwiYXdcIiBcblx0Ig0KPj4gLQkJX0FTTV9BTElHTiAiXG5cdCINCj4+IC0J
CV9BU01fUFRSICIxYiwgJWxbbF95ZXNdLCAlYzAgKyAlYzEgXG5cdCINCj4+IC0JCSIucG9wc2Vj
dGlvbiBcblx0Ig0KPj4gLQkJOiA6ICAiaSIgKGtleSksICJpIiAoYnJhbmNoKSA6IDogbF95ZXMp
Ow0KPj4gKwlhc21fdm9sYXRpbGVfZ290bygiU1RBVElDX0JSQU5DSF9HT1RPIGxfeWVzPVwiJWxb
bF95ZXNdXCIga2V5PVwiJWMwXCINCj4+ICINCj4+ICsJCQkgICJicmFuY2g9XCIlYzFcIiINCj4+
ICsJCQk6IDogICJpIiAoa2V5KSwgImkiIChicmFuY2gpIDogOiBsX3llcyk7DQo+PiANCj4+IAly
ZXR1cm4gZmFsc2U7DQo+PiBsX3llczoNCj4+IEBAIC00OCwxMyArNDQsOCBAQCBzdGF0aWMgX19h
bHdheXNfaW5saW5lIGJvb2wNCj4+IGFyY2hfc3RhdGljX2JyYW5jaChzdHJ1Y3Qgc3RhdGljX2tl
eSAqa2V5LCBib29sIGJyYW4NCj4+IA0KPj4gc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGFy
Y2hfc3RhdGljX2JyYW5jaF9qdW1wKHN0cnVjdCBzdGF0aWNfa2V5DQo+PiAqa2V5LCBib29sIGJy
YW5jaCkNCj4+IHsNCj4+IC0JYXNtX3ZvbGF0aWxlX2dvdG8oIjE6Ig0KPj4gLQkJIi5ieXRlIDB4
ZTlcblx0IC5sb25nICVsW2xfeWVzXSAtIDJmXG5cdCINCj4+IC0JCSIyOlxuXHQiDQo+PiAtCQki
LnB1c2hzZWN0aW9uIF9fanVtcF90YWJsZSwgIFwiYXdcIiBcblx0Ig0KPj4gLQkJX0FTTV9BTElH
TiAiXG5cdCINCj4+IC0JCV9BU01fUFRSICIxYiwgJWxbbF95ZXNdLCAlYzAgKyAlYzEgXG5cdCIN
Cj4+IC0JCSIucG9wc2VjdGlvbiBcblx0Ig0KPj4gKwlhc21fdm9sYXRpbGVfZ290bygiU1RBVElD
X0JSQU5DSF9KVU1QX0dPVE8gbF95ZXM9XCIlbFtsX3llc11cIg0KPj4ga2V5PVwiJWMwXCIgIg0K
Pj4gKwkJCSAgImJyYW5jaD1cIiVjMVwiIg0KPj4gCQk6IDogICJpIiAoa2V5KSwgImkiIChicmFu
Y2gpIDogOiBsX3llcyk7DQo+PiANCj4+IAlyZXR1cm4gZmFsc2U7DQo+PiBAQCAtMTA4LDYgKzk5
LDI2IEBAIHN0cnVjdCBqdW1wX2VudHJ5IHsNCj4+IAkucG9wc2VjdGlvbg0KPj4gLmVuZG0NCj4+
IA0KPj4gKy5tYWNybyBTVEFUSUNfQlJBTkNIX0dPVE8gbF95ZXM6cmVxIGtleTpyZXEgYnJhbmNo
OnJlcQ0KPj4gKzE6DQo+PiArCS5ieXRlIFNUQVRJQ19LRVlfSU5JVF9OT1ANCj4+ICsJLnB1c2hz
ZWN0aW9uIF9fanVtcF90YWJsZSwgImF3Ig0KPj4gKwlfQVNNX0FMSUdODQo+PiArCV9BU01fUFRS
IDFiLCBcbF95ZXMsIFxrZXkgKyBcYnJhbmNoDQo+PiArCS5wb3BzZWN0aW9uDQo+PiArLmVuZG0N
Cj4+ICsNCj4+ICsubWFjcm8gU1RBVElDX0JSQU5DSF9KVU1QX0dPVE8gbF95ZXM6cmVxIGtleTpy
ZXEgYnJhbmNoOnJlcQ0KPj4gKzE6DQo+PiArCS5ieXRlIDB4ZTkNCj4+ICsJLmxvbmcgXGxfeWVz
IC0gMmYNCj4+ICsyOg0KPj4gKwkucHVzaHNlY3Rpb24gX19qdW1wX3RhYmxlLCAiYXciDQo+PiAr
CV9BU01fQUxJR04NCj4+ICsJX0FTTV9QVFIgMWIsIFxsX3llcywgXGtleSArIFxicmFuY2gNCj4+
ICsJLnBvcHNlY3Rpb24NCj4+ICsuZW5kbQ0KPj4gKw0KPj4gI2VuZGlmCS8qIF9fQVNTRU1CTFlf
XyAqLw0KPj4gDQo+PiAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbWFj
cm9zLlMgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLlMNCj4+IGluZGV4IGJmOGI5YzkzZTI1NS4u
MTYxYzk1MDU5MDQ0IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL21hY3Jvcy5TDQo+
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLlMNCj4+IEBAIC0xMywzICsxMyw0IEBADQo+
PiAjaW5jbHVkZSA8YXNtL3BhcmF2aXJ0Lmg+DQo+PiAjaW5jbHVkZSA8YXNtL2FzbS5oPg0KPj4g
I2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9qdW1wX2xhYmVs
Lmg+DQo+IA0KPiBJZiB0aGUgY29kZSBzaXplIGluY3JlYXNlcywgZG8geW91IGhhdmUgYW55IG1l
dHJpY3MgZm9yIGltcHJvdmVtZW50Pw0KPiANCj4gVGhhdCBiZWluZyBzYWlkLCBJIGRvIGxpa2Ug
dGhlIHJlYWRhYmlsaXR5IGltcHJvdmVtZW50cyBhbmQgdGhlIGFiaWxpdHkgdG8NCj4gdXNlIGdh
cyBtYWNyb3MgaW4gYXNzZW1ibHkgYXMgb3Bwb3NlZCB0byBjcHAgbWFjcm9zIHdyYXBwZWQgaW4g
ZGlmZmVyZW50DQo+IHdheXMgZm9yIEMgYW5kIGFzc2VtYmx5Lg0KDQpJIGRpZG7igJl0IHRyeSB0
byBtZWFzdXJlIHRoZSBwZXJmb3JtYW5jZSBpbXBhY3Qgb2YgZWFjaCBwYXRjaCBpbmRlcGVuZGVu
dGx5Lg0KSSBtZWFzdXJlZCB0aGUgcGFyYXZpcnQgcGF0Y2ggaW1wYWN0LCBzaW5jZSBpdCB3YXMg
cmVsYXRpdmVseSBlYXN5IHRvIHNlZQ0KdGhhdCBiZWZvcmUgdGhlIGNoYW5nZSBhIGxvdCBvZiBw
YWdlLXRhYmxlIG1hbmlwdWxhdGlvbiBmdW5jdGlvbnMgd2VyZSBub3QNCmlubGluZWQsIGFuZCBp
bmRlZWQgSSBnb3QgMiUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIGEgbWljcm9iZW5jaG1h
cmsNCm9mIHJlcGVhdGVkIHBhZ2UtZmF1bHQgKyBNQURWX0RPTlRORUVELg0KDQpGb3IgdGhpcyBw
YXRjaCwgaXQgbWlnaHQgYmUgc2xpZ2h0bHkgaGFyZCB0byBzZWUgYW4gZWZmZWN0IG9uIHBlcmZv
cm1hbmNlLg0KSG93ZXZlciwgZnVuY3Rpb25zIG9mIGt2bSwgYnRyZnMsIGV4dDQsIHhlbiwgYW5k
IHhmcyBhbmQgb3RoZXIgYXJlIGFmZmVjdGVkLg0KDQpTYW1wbGluZyBzb21lIGNoYW5nZXMgc2hv
d3MgdGhhdCB0aGUgY29tcGlsZXIgbWFrZXMgcmVhc29uYWJsZSBkZWNpc2lvbnMNCnRoYXQgY2Fu
IGluY3JlYXNlIHRoZSBjb2RlIHNpemUuIEZvciBleGFtcGxlLCB3aXRoIHRoaXMgcGF0Y2gNCmt2
bV9wbWlfdHJpZ2dlcl9mbigpIGdldHMga3ZtX3BtdV9kZWxpdmVyX3BtaSgpIGlubGluZWQuIFNp
bmNlDQprdm1fcG11X2RlbGl2ZXJfcG1pKCkgaXMgdXNlZCBpbiBhIGRpZmZlcmVudCBvYmplY3Qg
KHg4Ni5vKSwgYSBub24taW5saW5lZA0KaW5zdGFuY2Ugb2YgdGhlIGZ1bmN0aW9uIGlzIHByb2R1
Y2VkIGFzIHdlbGwsIHdoaWNoIGNhdXNlcyB0aGUgYmluYXJ5IHNpemUNCnRvIChzbGlnaHRseSkg
aW5jcmVhc2UuDQoNCkkgdGhpbmsgdGhhdCB0aGUgdmFsdWUgb2YgdGhpcyBzZXJpZXMgaXMgaW4g
dGhlIG92ZXJhbGwgaW1wYWN0LiBBbGwgaXQgZG9lcw0KaXMgcHJldmVudCB0aGUgY29tcGlsZXIg
ZnJvbSBtYWtpbmcgd3JvbmcgZGVjaXNpb25zLiBUaGlzIHNlcmllcyBjYW4NCnByZXN1bWFibHkg
cHJldmVudCBfX2Fsd2F5c19pbmxpbmUgYW5ub3RhdGlvbnMgc3VjaCBhcyBpbiBhIHJlY2VudCBw
YXRjaA0KWzFdLCBpbiB3aGljaCB0aGUgZW5jb3VudGVyZWQgaXNzdWUsIEkgc3VzcGVjdCB3YXMg
Y2F1c2VkIGJ5IHRoZSB1c2Ugb2YNCnN0YXRpY19jcHVfaGFzKCkuDQoNClJlZ2FyZHMsDQpOYWRh
dg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDQ1MDAzNy8NCg0K
