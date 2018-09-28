Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24962173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bK0ySjc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24962173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeI1M72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:59:28 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:43088
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeI1M72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T2BGm3ufxWdgNd9AWaSIwGarCk8HixfdMF84eybTWQ=;
 b=bK0ySjc4HDva02hNC1M568wC6xa36YwnQhFFFczHFamkjrZu3pIuVVZ0ZOzf37JpperXNTmPbtTKA36edAsB+Fg307aIpgiFe+snAQSvk3p4zfVC/vvcppo+411NaDqJgM9t0fcqFzBp0t+uuFgeVDrMrO2k7BJw62PTi0LVsUk=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4455.eurprd04.prod.outlook.com (20.176.242.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.19; Fri, 28 Sep 2018 06:37:11 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 06:37:11 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFR5vA
Date:   Fri, 28 Sep 2018 06:37:11 +0000
Message-ID: <AM6PR04MB4357D5C59CBCD3A628B2F7B197EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
In-Reply-To: <20180921070628.35153-1-chuanhua.han@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4455;6:9Dn3h0LPcklBbbUX0/grd632mBhJPCkqVme1KC2XOTmT522+JvQbfnps5+jjsRe3j4IHwpgT5IVZ5FfkkuTyRmjBg0ZjwcqGqhuhjEZ3DJoV+NBNTs+v3saNLAoohQK/2QmJHoxJSgNXcRjJZHN/FTUKYu7xsjp90lZWGtNSZU9aFjFiq870N6PsORudej6SQlNTjR34igjzcO492WXy+jQI+l/vc23slRd+Nxw7t2R5Px44t+mhTJA7e8nOOug3u76cjxVoqd35VDK8sbegXrzIOtJ3tol5At9W7IP9EukOuWYG8vrxyqY3z/zKWAoo+DFmc8uwjnDrEeWBnZxVjpF42mZnlRdzV9GgpatA+vRc0vPtPmzQTCZc8LTlT6JFI2V47u13it/pnMSquFf7hjh0wsV9bFWG6iDxp2rl65TSadj7xTKjzY4akIwBvlXQBx712V21Pg4s33wc/XlcHg==;5:q5hXc4yYkc+QuYhqsMnQjNLK2eD6HFlAnPcchEXvAzi8QMpdv/M4Wr360YCqQVIxDGy3vC8fTHtLVGOMqyb+rnEcbSfYiPoSCqxVoIF78He3z5ub4cwSSOV1raXEJH8tLiLEo9+x56w1L3m1hIFg5xVz1SZdM1b6OGbjRAw+Blo=;7:jN12ROI8lR/I4MV6dW3/LXEpTG+ciYIoUf6mqRK21DaL2vuNj1AdKK6J5qsWWEQqUrENqL+qgOFutioUNdcLz1vf+7kJ/OWUX3fNtflXQf7L/6PRRnq14Yn/vWvimumcgomRu+YPl0nWCia2QSr/yqkhn1uIL0SNdgQyAJgj0Hv57UP4sK5OuagmvNdci93a07S4svULt2bcwgDJF//qY1ar85cops2EB+wLo8gjmEkPnBPjR9kf5UI4kejDhNkc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: db8f237c-d2e4-4f6b-b4fe-08d6250cd259
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4455;
x-ms-traffictypediagnostic: AM6PR04MB4455:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB4455A29DEEEF52F90F1A4F0797EC0@AM6PR04MB4455.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4455;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(53474002)(199004)(13464003)(54906003)(6506007)(105586002)(76176011)(5660300001)(97736004)(53546011)(4326008)(25786009)(2900100001)(478600001)(86362001)(110136005)(5250100002)(229853002)(106356001)(33656002)(8676002)(2501003)(486006)(256004)(44832011)(55016002)(446003)(9686003)(11346002)(34290500001)(7736002)(8936002)(81166006)(81156014)(305945005)(14454004)(74316002)(3846002)(66066001)(6116002)(476003)(7696005)(6246003)(71200400001)(6436002)(71190400001)(99286004)(26005)(316002)(53936002)(68736007)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4455;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XehCDjHZVX8IT1yDZ/J1PWhWribDiiJ4phYnQylh4XLcRvBapnrwRpRMWYoDUWmpwUBU2+chMCwfUCPcgdElwapqaNMCbQGMZpzTYA5Xx0Dj5TfYQkMHJqUrIAff6uEhumSyD+aI6SmhLCqHeJNNUIE3t3EHUkrsNHVr+lkqEhO/dJcm7kspLRQ+p/waj1ZRkleuPIEi6SwHVRWQijbpi+KzC6EFVL+Fw7QgNWVem9zPVKqHjV+Kmcgn/ot2z+oUHsOLgHqQsWr4HzinVGPQY5E6xG94IpZI8oDxUPnUqfNRoW4MtFEnVnCZ3vSD7ay4NfgyVKMYL5tTCFkNybmHG5n7IjqaCmsiv2EIYvO0CQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f237c-d2e4-4f6b-b4fe-08d6250cd259
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 06:37:11.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1YW5odWEgSGFuIDxj
aHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gU2VudDogMjAxOMTqOdTCMjHI1SAxNTowNg0KPiBUbzog
YnJvb25pZUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBlaGFAZGVpZi5jb207DQo+IGJvcmlzLmJyZXppbGxv
bkBib290bGluLmNvbTsgQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIDEvMl0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcg
ZnVuY3Rpb24NCj4gDQo+IEJlZm9yZSB3ZSBhZGQgdGhpcyBzcGlfdHJhbnNmZXIgdG8gdGhlIHNw
aV9tZXNzYWdlIGNoYWluIHRhYmxlLCB3ZSBuZWVkDQo+IGJpdHNfcGVyX3dvcmRfbWFzayBiYXNl
ZCBvbiBzcGlfY29udHJvbCB0byBzZXQgdGhlIGJpdHNfcGVyX3dvcmQgb2YgdGhpcw0KPiBzcGlf
dHJhbnNmZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhh
bkBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1tZW0uYyB8IDM5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMgYi9k
cml2ZXJzL3NwaS9zcGktbWVtLmMgaW5kZXgNCj4gZWI3MmRiYTcxZDgzLi43MTdlNzExYzA5NTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPiArKysgYi9kcml2ZXJzL3Nw
aS9zcGktbWVtLmMNCj4gQEAgLTE3NSw2ICsxNzUsNDEgQEAgYm9vbCBzcGlfbWVtX3N1cHBvcnRz
X29wKHN0cnVjdCBzcGlfbWVtICptZW0sDQo+IGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkg
IH0NCj4gRVhQT1JUX1NZTUJPTF9HUEwoc3BpX21lbV9zdXBwb3J0c19vcCk7DQo+IA0KPiArLyoq
DQo+ICsgKiBzcGlfc2V0X3hmZXJfYnB3KCkgLSBTZXQgdGhlIGJpdHNfcGVyX3dvcmQgZm9yIGVh
Y2ggdHJhbnNmZXIgYmFzZWQgb24NCj4gKyAqCQkJdGhlIGJpdHNfcGVyX3dvcmRfbWFzayBvZiB0
aGUgc3BpIGNvbnRyb2xsZXINCj4gKyAqIEBjdHJsOiB0aGUgc3BpIGNvbnRyb2xsZXINCj4gKyAq
IEB4ZmVyOiB0aGUgc3BpIHRyYW5zZmVyDQo+ICsgKg0KPiArICogVGhpcyBmdW5jdGlvbiBzZXRz
IHRoZSBiaXRzX3Blcl93b3JkIGZvciBlYWNoIHRyYW5zZmVyIGJhc2VkIG9uIHRoZQ0KPiArc3Bp
DQo+ICsgKiBjb250cm9sbGVyJ3MgYml0c19wZXJfd29yZF9tYXNrIHRvIGltcHJvdmUgdGhlIGVm
ZmljaWVuY3kgb2Ygc3BpIHRyYW5zcG9ydC4NCj4gKyAqDQo+ICsgKiBSZXR1cm46IDAgaW4gY2Fz
ZSBvZiBzdWNjZXNzLCBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KPiArICovDQo+
ICtpbnQgc3BpX3NldF94ZmVyX2JwdyhzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIHN0cnVj
dCBzcGlfdHJhbnNmZXINCj4gKyp4ZmVyKSB7DQo+ICsJaWYgKCFjdGxyIHx8ICF4ZmVyKSB7DQo+
ICsJCWRldl9lcnIoJmN0bHItPmRldiwNCj4gKwkJCSJGYWlsIHRvIHNldCBiaXRzX3Blcl93b3Jk
IGZvciBzcGkgdHJhbnNmZXJcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsN
Cj4gKwlpZiAoY3Rsci0+Yml0c19wZXJfd29yZF9tYXNrKSB7DQo+ICsJCWlmICghKHhmZXItPmxl
biAlIDQpKSB7DQo+ICsJCQlpZiAoY3Rsci0+Yml0c19wZXJfd29yZF9tYXNrICYgU1BJX0JQV19N
QVNLKDMyKSkNCj4gKwkJCQl4ZmVyLT5iaXRzX3Blcl93b3JkID0gMzI7DQo+ICsJCX0gZWxzZSBp
ZiAoISh4ZmVyLT5sZW4gJSAyKSkgew0KPiArCQkJaWYgKGN0bHItPmJpdHNfcGVyX3dvcmRfbWFz
ayAmIFNQSV9CUFdfTUFTSygxNikpDQo+ICsJCQkJeGZlci0+Yml0c19wZXJfd29yZCA9IDE2Ow0K
PiArCQl9IGVsc2Ugew0KPiArCQkJeGZlci0+Yml0c19wZXJfd29yZCA9IDg7DQo+ICsJCX0NCj4g
Kwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHNwaV9z
ZXRfeGZlcl9icHcpOw0KPiArDQo+ICAvKioNCj4gICAqIHNwaV9tZW1fZXhlY19vcCgpIC0gRXhl
Y3V0ZSBhIG1lbW9yeSBvcGVyYXRpb24NCj4gICAqIEBtZW06IHRoZSBTUEkgbWVtb3J5DQo+IEBA
IC0yNTIsNiArMjg3LDcgQEAgaW50IHNwaV9tZW1fZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVt
LCBjb25zdA0KPiBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ICAJeGZlcnNbeGZlcnBvc10udHhf
YnVmID0gdG1wYnVmOw0KPiAgCXhmZXJzW3hmZXJwb3NdLmxlbiA9IHNpemVvZihvcC0+Y21kLm9w
Y29kZSk7DQo+ICAJeGZlcnNbeGZlcnBvc10udHhfbmJpdHMgPSBvcC0+Y21kLmJ1c3dpZHRoOw0K
PiArCXNwaV9zZXRfeGZlcl9icHcoY3RsciwgJnhmZXJzW3hmZXJwb3NdKTsNCj4gIAlzcGlfbWVz
c2FnZV9hZGRfdGFpbCgmeGZlcnNbeGZlcnBvc10sICZtc2cpOw0KPiAgCXhmZXJwb3MrKzsNCj4g
IAl0b3RhbHhmZXJsZW4rKzsNCj4gQEAgLTI2Niw2ICszMDIsNyBAQCBpbnQgc3BpX21lbV9leGVj
X29wKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0DQo+IHN0cnVjdCBzcGlfbWVtX29wICpvcCkN
Cj4gIAkJeGZlcnNbeGZlcnBvc10udHhfYnVmID0gdG1wYnVmICsgMTsNCj4gIAkJeGZlcnNbeGZl
cnBvc10ubGVuID0gb3AtPmFkZHIubmJ5dGVzOw0KPiAgCQl4ZmVyc1t4ZmVycG9zXS50eF9uYml0
cyA9IG9wLT5hZGRyLmJ1c3dpZHRoOw0KPiArCQlzcGlfc2V0X3hmZXJfYnB3KGN0bHIsICZ4ZmVy
c1t4ZmVycG9zXSk7DQo+ICAJCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ4ZmVyc1t4ZmVycG9zXSwg
Jm1zZyk7DQo+ICAJCXhmZXJwb3MrKzsNCj4gIAkJdG90YWx4ZmVybGVuICs9IG9wLT5hZGRyLm5i
eXRlczsNCj4gQEAgLTI3Niw2ICszMTMsNyBAQCBpbnQgc3BpX21lbV9leGVjX29wKHN0cnVjdCBz
cGlfbWVtICptZW0sIGNvbnN0DQo+IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4gIAkJeGZlcnNb
eGZlcnBvc10udHhfYnVmID0gdG1wYnVmICsgb3AtPmFkZHIubmJ5dGVzICsgMTsNCj4gIAkJeGZl
cnNbeGZlcnBvc10ubGVuID0gb3AtPmR1bW15Lm5ieXRlczsNCj4gIAkJeGZlcnNbeGZlcnBvc10u
dHhfbmJpdHMgPSBvcC0+ZHVtbXkuYnVzd2lkdGg7DQo+ICsJCXNwaV9zZXRfeGZlcl9icHcoY3Rs
ciwgJnhmZXJzW3hmZXJwb3NdKTsNCj4gIAkJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJzW3hm
ZXJwb3NdLCAmbXNnKTsNCj4gIAkJeGZlcnBvcysrOw0KPiAgCQl0b3RhbHhmZXJsZW4gKz0gb3At
PmR1bW15Lm5ieXRlczsNCj4gQEAgLTI5MSw2ICszMjksNyBAQCBpbnQgc3BpX21lbV9leGVjX29w
KHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0DQo+IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4g
IAkJfQ0KPiANCj4gIAkJeGZlcnNbeGZlcnBvc10ubGVuID0gb3AtPmRhdGEubmJ5dGVzOw0KPiAr
CQlzcGlfc2V0X3hmZXJfYnB3KGN0bHIsICZ4ZmVyc1t4ZmVycG9zXSk7DQo+ICAJCXNwaV9tZXNz
YWdlX2FkZF90YWlsKCZ4ZmVyc1t4ZmVycG9zXSwgJm1zZyk7DQo+ICAJCXhmZXJwb3MrKzsNCj4g
IAkJdG90YWx4ZmVybGVuICs9IG9wLT5kYXRhLm5ieXRlczsNCj4gLS0NCj4gMi4xNy4xDQpIaSxh
bGwNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSB0byBzZWUgdGhlIGZpeCBvZiB0aGlzIHBhdGNo
PyBXaGF0IGNoYW5nZXMgbmVlZCB0byBiZSBtYWRlPyANCkxvb2tpbmcgZm9yd2FyZCB0byB5b3Vy
IHZhbHVhYmxlIGNvbW1lbnRzIGFuZCBjcml0aWNpc20sIHRoYW5rIHlvdSB2ZXJ5IG11Y2ghISEN
ClRoYW5rcywNCkNodWFuaHVhDQoNCg==
