Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcT4yeuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4BF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeIXO4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:56:09 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:30752
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbeIXO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS+OVSntm1YT8qh6gNZl/4opvLQnheXEBzRn31SODT4=;
 b=gcT4yeuh+v6YqI103y5lF2pkProWjbKgWqGMWZ21m3ilkT39Svc4HaXnJ7LoDCc4PYIS4Gd8MfeOZGeFIpPehKaEJwR7wS5qIBHQRThomiWR90hMD+buGoLeZDHMj5nKh1Tk4WDPkIZj4L8dpY/Mh5lgsPloC0+KQFO+UWuBNwg=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4824.eurprd04.prod.outlook.com (20.177.33.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Mon, 24 Sep 2018 08:54:58 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::acea:2e54:277d:6e77]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::acea:2e54:277d:6e77%5]) with mapi id 15.20.1143.017; Mon, 24 Sep 2018
 08:54:58 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
CC:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
Thread-Topic: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
Thread-Index: AQHUUPOZfOgW7XM+S0+jA/Uq5t0JL6T7TzuAgAPSo9A=
Date:   Mon, 24 Sep 2018 08:54:58 +0000
Message-ID: <AM6PR04MB400829AD9740850D5EF93E51EC170@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
 <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
In-Reply-To: <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4824;6:no8LgGPXuhIOVU5qcELswHCyZf4DBn7rThZFqdTbJzyJ9m0k+9fysyxR9uU2a/EwrAAIGkK2L5/wi+iYCfZqHobPhdA61z+WuEKOY7dcXXFeJuT7aaxtaIKf1Y87Rrgi1UzwuGQ0FbZiQmgTpgni8ROlo3o5C23PG+q0YMzvs72LMETRLyi+kpQnZuaxTT9rNAxzT15kutB9Tn+oV45g+FrIyxnvOM8E+9/+RbASUL2HNEGvJyUFLL6Xe2fUGFXOoHycKQmyK2V/PcWIgR2137E1BDDpsNzRsC20N3QMZbVbG6Upl5NhdBt6MQ5EL2wigOygXEuB4o4evsVagSiKAzPsJafZnW9VMwXyaLEG0slwBYQybjGzNYdk+58gwP0ySemO0gQd2E1sKAvVU+yYk+n38uSsYfxqa3KOJ8qv4U9vgRhIs2tYxXI9hhzazkal/W6N0Xds9kzI8fUR8QRfmg==;5:k4kx3M+mBOQ/Yn7V5bzFu7SpS/kVByNItQbel5h8EbU7nMtLx1rHWsVrIRxAcHiMcG6iS6W0L+r/EaWWobpQo9omHK0rRDnBIi9bvQo/cxkqOIgUc9h3rpKNOpW8ldQt+qnszJDqR0pq7KbqCtLZjReOWkQgrjAlNoq3uIAFSes=;7:2ZZlJsR0aAWhGaewrQ5v0cGF8cbsr85bblPCcGliJlt3m8U2yhMILSqScA+09i0ZxoawItWGcvXyR26fejaXs/+4G+J7QWUdMdePPmRLGX7MArE/fLzj+zWgbV+Sj8iWW1vnQlFvp3IiUCqfs3rZ6gqe+RhsKtbBP84qxjU7TgrBU1zmtbkqwxIpRRtJl3INFjv5l3AWxDY6XvG4Z4N9EQMOK1B8gAVgixkWIS0lcw27YeLBGBkOFwSdHlAGpxld
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 584645b5-c03a-4c80-b498-08d621fb683d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4824;
x-ms-traffictypediagnostic: AM6PR04MB4824:
x-microsoft-antispam-prvs: <AM6PR04MB4824D0A14E60BCFA53680734EC170@AM6PR04MB4824.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(185117386973197)(275809806118684)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:AM6PR04MB4824;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4824;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(13464003)(189003)(26005)(8676002)(2900100001)(3846002)(6116002)(478600001)(486006)(76176011)(7696005)(575784001)(446003)(11346002)(476003)(54906003)(110136005)(81166006)(86362001)(53546011)(102836004)(14444005)(256004)(81156014)(2906002)(6506007)(99286004)(316002)(33656002)(6246003)(68736007)(8936002)(6636002)(14454004)(25786009)(4326008)(5660300001)(71190400001)(71200400001)(105586002)(97736004)(5250100002)(7736002)(305945005)(74316002)(6436002)(229853002)(106356001)(9686003)(55016002)(53936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4824;H:AM6PR04MB4008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PvFgSAlHJ+PZna8jW1knB6B/pzk8eSNp0oKK4im5UCtg8+aRXSWvYiS6vK0kqBmxcNm9rWrFbHAitKYJQ8whd7Y17vyBSAPtbfBkqGEx6WsR94x11kHV7zDueQ/R3dkBLG2hdq6fvCnXRD4HORft0bp2cb/3gKaC5ItGJC0mzqz++uRYfCzgAvjqE4McyyihtRbrc0vUmFs+IfWPPAftPoxf0dVeVi9lgi2qcJwlL/MuCn9hGeDgfMdCUEWOvO41Me1un8DtoAlpHrHI5+5HYoulnFqbf0Eww5NhA2Z2hYVfWx1nKbB84EbY3gHpTFsv3WfNIitwPwaLnlp0WQyjyyAJkRWWZQLzNOldc1iEa80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584645b5-c03a-4c80-b498-08d621fb683d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 08:54:58.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaSBZYW5nIFttYWlsdG86bGVv
eWFuZy5saUBueHAuY29tXQ0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDIyLCAyMDE4IDE6
MTUgQU0NCj4gVG86IE1hZGFsaW4tY3Jpc3RpYW4gQnVjdXIgPG1hZGFsaW4uYnVjdXJAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIHNvYy9mc2wvcWJtYW46IENoZWNrIGlmIENQ
VSBpcyBvZmZsaW5lIHdoZW4NCj4gaW5pdGlhbGl6aW5nIHBvcnRhbHMNCj4gDQo+IE9uIFRodSwg
U2VwIDIwLCAyMDE4IGF0IDEwOjA5IEFNIE1hZGFsaW4gQnVjdXIgPG1hZGFsaW4uYnVjdXJAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBSb3kgUGxlZGdlIDxyb3kucGxlZGdlQG54
cC5jb20+DQo+ID4NCj4gPiBJZiB0aGUgYWZmaW5lIHBvcnRhbCBmb3IgYSBzcGVjaWZpYyBDUFUg
aXMgb2ZmbGluZSBhdCBib290IHRpbWUNCj4gPiBhZmZpbmUgaXRzIGludGVycnVwdCB0byBDUFUg
MC4gSWYgdGhlIENQVSBpcyBsYXRlciBicm91Z2h0IG9ubGluZQ0KPiA+IHRoZSBob3RwbHVnIGhh
bmRsZXIgd2lsbCBjb3JyZWN0bHkgYWRqdXN0IHRoZSBhZmZpbml0eS4NCj4gDQo+IEFsdGhvdWdo
IHRoaXMgZG9lcyBwcm92aWRlIGJldHRlciBjb21wYXRpYmlsaXR5IHdpdGggY3B1IGhvdHBsdWcs
IHdlDQo+IHN0aWxsIGhhdmUgYSBwcm9ibGVtLiAgWW91IGFyZSBhc3N1bWluZyB0aGUgQ1BVMCBp
cyBhbHdheXMgb25saW5lDQo+IHdoaWNoIGlzIG5vdCB0aGUgY2FzZSBmb3IgYXJtNjQuICBIb3cg
YWJvdXQgbm90IHNldHRpbmcgdGhlIGFmZmluaXR5DQo+IGFuZCBsZXQgdGhlIHN5c3RlbSBkZWNp
ZGUgaWYgdGhlIGRlZGljYXRlZCBDUFUgaXMgb2ZmbGluZT8NCg0KSSBjYW4gY2hhbmdlIHRoZSBo
YXJkY29kaW5nIG9mIENQVSAwIHdpdGggcmF3X3NtcF9wcm9jZXNzb3JfaWQoKS4NCldoaWxlIHdl
J3JlIGF0IGl0LCBJJ2QgbW92ZSB0aGUgaW50cm9kdWNlZCBjb2RlIGludG8gYSBoZWxwZXIgZnVu
Y3Rpb24NCnRvIGF2b2lkIGR1cGxpY2F0aW9uOg0KDQpzdGF0aWMgaW5saW5lIHZvaWQgZHBhYV9z
ZXRfcG9ydGFsX2lycV9hZmZpbml0eShzdHJ1Y3QgZGV2aWNlKiBkZXYsDQoJCQkJCQkJCWludCBj
cHUsIGludCBpcnEpDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJveSBQbGVkZ2UgPHJveS5w
bGVkZ2VAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYWRhbGluIEJ1Y3VyIDxtYWRhbGlu
LmJ1Y3VyQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFu
LmMgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1h
bi5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9mc2wvcWJtYW4vYm1hbi5jIGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW4uYw0KPiA+
IGluZGV4IGY5NDg1Y2VkYzY0OC4uMmU2ZTY4MmJmMTZiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvc29jL2ZzbC9xYm1hbi9ibWFuLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4v
Ym1hbi5jDQo+ID4gQEAgLTU2MiwxMCArNTYyLDE5IEBAIHN0YXRpYyBpbnQgYm1hbl9jcmVhdGVf
cG9ydGFsKHN0cnVjdCBibWFuX3BvcnRhbA0KPiAqcG9ydGFsLA0KPiA+ICAgICAgICAgICAgICAg
ICBkZXZfZXJyKGMtPmRldiwgInJlcXVlc3RfaXJxKCkgZmFpbGVkXG4iKTsNCj4gPiAgICAgICAg
ICAgICAgICAgZ290byBmYWlsX2lycTsNCj4gPiAgICAgICAgIH0NCj4gPiAtICAgICAgIGlmIChj
LT5jcHUgIT0gLTEgJiYgaXJxX2Nhbl9zZXRfYWZmaW5pdHkoYy0+aXJxKSAmJg0KPiA+IC0gICAg
ICAgICAgIGlycV9zZXRfYWZmaW5pdHkoYy0+aXJxLCBjcHVtYXNrX29mKGMtPmNwdSkpKSB7DQo+
ID4gLSAgICAgICAgICAgICAgIGRldl9lcnIoYy0+ZGV2LCAiaXJxX3NldF9hZmZpbml0eSgpIGZh
aWxlZFxuIik7DQo+ID4gLSAgICAgICAgICAgICAgIGdvdG8gZmFpbF9hZmZpbml0eTsNCj4gPiAr
ICAgICAgIGlmIChjcHVfb25saW5lKGMtPmNwdSkgJiYgYy0+Y3B1ICE9IC0xICYmDQo+ID4gKyAg
ICAgICAgICAgaXJxX2Nhbl9zZXRfYWZmaW5pdHkoYy0+aXJxKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICBpZiAoaXJxX3NldF9hZmZpbml0eShjLT5pcnEsIGNwdW1hc2tfb2YoYy0+Y3B1KSkpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGMtPmRldiwgImlycV9zZXRfYWZm
aW5pdHkoKSBmYWlsZWQNCj4gJWRcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjLT5jcHUpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbF9hZmZp
bml0eTsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICAgICAgICAgLyogQ1BVIGlzIG9mZmxpbmUsIGRpcmVjdCBJUlEgdG8gQ1BVIDAgKi8N
Cj4gPiArICAgICAgICAgICAgICAgaWYgKGlycV9zZXRfYWZmaW5pdHkoYy0+aXJxLCBjcHVtYXNr
X29mKDApKSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYy0+ZGV2LCAi
aXJxX3NldF9hZmZpbml0eSgpIGNwdSAwDQo+IGZhaWxlZFxuIik7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBmYWlsX2FmZmluaXR5Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+
ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIC8qIE5lZWQgUkNSIHRvIGJlIGVtcHR5IGJl
Zm9yZSBjb250aW51aW5nICovDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9xYm1h
bi9xbWFuLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbi5jDQo+ID4gaW5kZXggZWNiMjI3
NDlkZjBiLi43ZGJjYjQ3NWE1OWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL3Fi
bWFuL3FtYW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuLmMNCj4gPiBA
QCAtOTM1LDcgKzkzNSw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHFtX21jX3Jlc3VsdF90aW1lb3V0
KHN0cnVjdA0KPiBxbV9wb3J0YWwgKnBvcnRhbCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiAgICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPiA+ICAgICAgICAgfSB3
aGlsZSAoLS10aW1lb3V0KTsNCj4gPiAtDQo+ID4gICAgICAgICByZXR1cm4gdGltZW91dDsNCj4g
PiAgfQ0KPiA+DQo+ID4gQEAgLTEyMTAsMTAgKzEyMDksMTkgQEAgc3RhdGljIGludCBxbWFuX2Ny
ZWF0ZV9wb3J0YWwoc3RydWN0IHFtYW5fcG9ydGFsDQo+ICpwb3J0YWwsDQo+ID4gICAgICAgICAg
ICAgICAgIGRldl9lcnIoYy0+ZGV2LCAicmVxdWVzdF9pcnEoKSBmYWlsZWRcbiIpOw0KPiA+ICAg
ICAgICAgICAgICAgICBnb3RvIGZhaWxfaXJxOw0KPiA+ICAgICAgICAgfQ0KPiA+IC0gICAgICAg
aWYgKGMtPmNwdSAhPSAtMSAmJiBpcnFfY2FuX3NldF9hZmZpbml0eShjLT5pcnEpICYmDQo+ID4g
LSAgICAgICAgICAgaXJxX3NldF9hZmZpbml0eShjLT5pcnEsIGNwdW1hc2tfb2YoYy0+Y3B1KSkp
IHsNCj4gPiAtICAgICAgICAgICAgICAgZGV2X2VycihjLT5kZXYsICJpcnFfc2V0X2FmZmluaXR5
KCkgZmFpbGVkXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBmYWlsX2FmZmluaXR5Ow0K
PiA+ICsgICAgICAgaWYgKGNwdV9vbmxpbmUoYy0+Y3B1KSAmJiBjLT5jcHUgIT0gLTEgJiYNCj4g
PiArICAgICAgICAgICBpcnFfY2FuX3NldF9hZmZpbml0eShjLT5pcnEpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGlmIChpcnFfc2V0X2FmZmluaXR5KGMtPmlycSwgY3B1bWFza19vZihjLT5jcHUp
KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYy0+ZGV2LCAiaXJxX3Nl
dF9hZmZpbml0eSgpIGZhaWxlZA0KPiAlZFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGMtPmNwdSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWls
X2FmZmluaXR5Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9IGVsc2Ugew0K
PiA+ICsgICAgICAgICAgICAgICAvKiBDUFUgaXMgb2ZmbGluZSwgZGlyZWN0IElSUSB0byBDUFUg
MCAqLw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoaXJxX3NldF9hZmZpbml0eShjLT5pcnEsIGNw
dW1hc2tfb2YoMCkpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihjLT5k
ZXYsICJpcnFfc2V0X2FmZmluaXR5KCkgY3B1IDANCj4gZmFpbGVkXG4iKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGZhaWxfYWZmaW5pdHk7DQo+ID4gKyAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgLyogTmVlZCBFUUNSIHRvIGJlIGVt
cHR5IGJlZm9yZSBjb250aW51aW5nICovDQo+ID4gLS0NCj4gPiAyLjEuMA0KPiA+DQo=
