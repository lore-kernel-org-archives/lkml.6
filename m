Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ltGrrg7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1941D2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbeGMBz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:55:29 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com ([40.107.4.109]:51040
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732206AbeGMBz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJNXdtIFNcxpZZLzHMk38SZZrTtCr/9Y0oJz8ctSi7w=;
 b=ltGrrg7H1RSxM2LuAK622FypNF4cJPAMbgf9nRERX6NIJDU88cLOsTR6tpI+JlzeBuF/rhxSMyV9JCSAv7N1pZYRssz8cwr4bjwuChw0QfLrGiRREhty0ihDTsrSu2eqVywItRigrGahViv/nEmVykOT/MojTvDnuh1IWGRiWS4=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2543.eurprd05.prod.outlook.com (10.168.136.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 01:43:07 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0930.022; Fri, 13 Jul
 2018 01:43:06 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "avienamo@nvidia.com" <avienamo@nvidia.com>,
        Stefan Agner <stefan.agner@toradex.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: REGRESSION: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Thread-Topic: REGRESSION: [PATCH] mmc: tegra: Use
 sdhci_pltfm_clk_get_max_clock
Thread-Index: AQHUGkrXgYAMCxgNg0KoF7HcXnv1Hw==
Date:   Fri, 13 Jul 2018 01:43:05 +0000
Message-ID: <1531446183.5479.14.camel@toradex.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
         <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
In-Reply-To: <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2543;7:gt31BOOe3xgnlOW/AexWfBqzlfZUVMuYLWbbMQSg1dGa4qWsY8YJp8rtxtVs5O5anHLSqG5t3eN8XP97irkAi1P9qqQUEtvWJBU72D+fdGW5qM8Fwwr+bOY6t5xvCbvjKPVXfsSxficteQbZbZmZCWr4qqHabyqoWzIV+pyYyLl7gM7vwOg4pUjFHxTIROxg49X/zvXkhcaBxIjyyLdF4pWIksFuxpbnOqT11GxOS6OWPkhk44J5qx/w9R+8B6Sb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(346002)(366004)(136003)(189003)(199004)(7736002)(54906003)(305945005)(186003)(76176011)(110136005)(26005)(6506007)(97736004)(53546011)(102836004)(316002)(36756003)(4326008)(6116002)(3846002)(2900100001)(53936002)(105586002)(106356001)(103116003)(25786009)(6306002)(6512007)(6486002)(99286004)(6436002)(39060400002)(66066001)(8676002)(81156014)(81166006)(2906002)(86362001)(5250100002)(8936002)(2501003)(478600001)(6636002)(44832011)(446003)(11346002)(14454004)(486006)(5660300001)(966005)(68736007)(2616005)(476003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2543;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 782bb1c9-8048-4700-3c2a-08d5e861fb00
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2543;
x-ms-traffictypediagnostic: VI1PR0501MB2543:
x-microsoft-antispam-prvs: <VI1PR0501MB2543ED7BE3E413F72728CE65FB580@VI1PR0501MB2543.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2543;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2543;
x-forefront-prvs: 07326CFBC4
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6UV12guH8/3UpfnVJd/v3eIfoBLqxfL+9KK8mlqpcFQ3ZSmwCtNfiQKW4kvF3Q5Mv17ToY7THdWZ7Miqj6rvKZ/J9jBEel7ReDE93MSMhX9ASu/eR618s9HO2DHcfrGpUhr2TsgE5waOWe4vAZHgpmx+jNkELOCmBJ0AtLmZADQgWoiyLNKeG7jwPPVYQhYSMBbBu4df3G+AtLqW6z/wzekSPbnxQ0LX6EZkJnqsXmdUC3jMEdY2sbD2kFoVQf2sNotBjT60cQCZmXl3D9FDBgJ91ZyBIU1t5DfmwXAGTrWLLCyILDLSD7FbxYTs8qeWTc6GbFw5OvJhKVBXYMCa5Y5n8xSK8BGH9oZabYrpblA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F5FCC96CB214F4A8EB39CE0D1FEDCB8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782bb1c9-8048-4700-3c2a-08d5e861fb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 01:43:06.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDE1OjE2ICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gNCBKdW5lIDIwMTggYXQgMTc6MzUsIEFhcG8gVmllbmFtbyA8YXZpZW5hbW9AbnZpZGlhLmNv
bT4gd3JvdGU6DQo+ID4gVGhlIHNkaGNpIGdldF9tYXhfY2xvY2sgY2FsbGJhY2sgaXMgc2V0IHRv
DQo+ID4gc2RoY2lfcGx0Zm1fY2xrX2dldF9tYXhfY2xvY2sNCj4gPiBhbmQgdGVncmFfc2RoY2lf
Z2V0X21heF9jbG9jayBpcyByZW1vdmVkLiBJdCBhcHBlYXJzIHRoYXQgdGhlDQo+ID4gc2hkY2kt
dGVncmEgc3BlY2lmaWMgY2FsbGJhY2sgd2FzIG9yaWdpbmFsbHkgaW50cm9kdWNlZCBkdWUgdG8g
dGhlDQo+ID4gcmVxdWlyZW1lbnQgdGhhdCB0aGUgaG9zdCBjbG9jayBoYXMgdG8gYmUgdHdpY2Ug
dGhlIGJ1cyBjbG9jayBvbg0KPiA+IEREUjUwDQo+ID4gbW9kZS4gQXMgZmFyIGFzIEkgY2FuIHRl
bGwgdGhlIG9ubHkgZWZmZWN0IHRoZSByZW1vdmFsIGhhcyBvbiBERFI1MA0KPiA+IG1vZGUNCj4g
PiBpcyBpbiBjYXNlcyB3aGVyZSB0aGUgcGFyZW50IGNsb2NrIGlzIHVuYWJsZSB0byBzdXBwbHkg
dGhlDQo+ID4gcmVxdWVzdGVkDQo+ID4gY2xvY2sgcmF0ZSwgY2F1c2luZyB0aGUgRERSNTAgbW9k
ZSB0byBydW4gYXQgYSBsb3dlciBmcmVxdWVuY3kuDQo+ID4gQ3VycmVudGx5IHRoZSBERFI1MCBt
b2RlIGlzbid0IGVuYWJsZWQgb24gYW55IG9mIHRoZSBTb0NzIGFuZCB3b3VsZA0KPiA+IGFsc28N
Cj4gPiByZXF1aXJlIGNvbmZpZ3VyaW5nIHRoZSBTREhDSSBjbG9jayBkaXZpZGVyIHJlZ2lzdGVy
IHRvIGZ1bmN0aW9uDQo+ID4gcHJvcGVybHkuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0gd2l0aCB0
ZWdyYV9zZGhjaV9nZXRfbWF4X2Nsb2NrIGlzIHRoYXQgaXQgZGl2aWRlcyB0aGUNCj4gPiBjbG9j
aw0KPiA+IHJhdGUgYnkgdHdvIGFuZCB0aHVzIGFydGlmaWNpYWxseSBsaW1pdHMgdGhlIG1heGlt
dW0gZnJlcXVlbmN5IG9mDQo+ID4gZmFzdGVyDQo+ID4gc2lnbmFsaW5nIG1vZGVzIHdoaWNoIGRv
bid0IGhhdmUgdGhlIGhvc3QtYnVzIGZyZXF1ZW5jeSByYXRpbw0KPiA+IHJlcXVpcmVtZW50DQo+
ID4gb2YgRERSNTAgc3VjaCBhcyBTRFIxMDQgYW5kIEhTMjAwLiBGdXJ0aGVybW9yZSwgdGhlIGNh
bGwgdG8NCj4gPiBjbGtfcm91bmRfcmF0ZSgpIG1heSByZXR1cm4gYW4gZXJyb3Igd2hpY2ggaXNu
J3QgaGFuZGxlZCBieQ0KPiA+IHRlZ3JhX3NkaGNpX2dldF9tYXhfY2xvY2suDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQWFwbyBWaWVuYW1vIDxhdmllbmFtb0BudmlkaWEuY29tPg0KPiANCj4g
VGhhbmtzLCBhcHBsaWVkIGZvciBuZXh0IQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4g
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyB8IDE1ICsrLS0t
LS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10
ZWdyYS5jDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMNCj4gPiBpbmRleCA5
NzBkMzhmNi4uYzg3NDViNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXRlZ3JhLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMNCj4gPiBA
QCAtMjM0LDE3ICsyMzQsNiBAQCBzdGF0aWMgdm9pZA0KPiA+IHRlZ3JhX3NkaGNpX3NldF91aHNf
c2lnbmFsaW5nKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiA+ICAgICAgICAgc2RoY2lfc2V0
X3Voc19zaWduYWxpbmcoaG9zdCwgdGltaW5nKTsNCj4gPiAgfQ0KPiA+IA0KPiA+IC1zdGF0aWMg
dW5zaWduZWQgaW50IHRlZ3JhX3NkaGNpX2dldF9tYXhfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QN
Cj4gPiAqaG9zdCkNCj4gPiAtew0KPiA+IC0gICAgICAgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3Qg
KnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiA+IC0NCj4gPiAtICAgICAgIC8qDQo+
ID4gLSAgICAgICAgKiBERFIgbW9kZXMgcmVxdWlyZSB0aGUgaG9zdCB0byBydW4gYXQgZG91Ymxl
IHRoZSBjYXJkDQo+ID4gZnJlcXVlbmN5LCBzbw0KPiA+IC0gICAgICAgICogdGhlIG1heGltdW0g
cmF0ZSB3ZSBjYW4gc3VwcG9ydCBpcyBoYWxmIG9mIHRoZSBtb2R1bGUNCj4gPiBpbnB1dCBjbG9j
ay4NCj4gPiAtICAgICAgICAqLw0KPiA+IC0gICAgICAgcmV0dXJuIGNsa19yb3VuZF9yYXRlKHBs
dGZtX2hvc3QtPmNsaywgVUlOVF9NQVgpIC8gMjsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgc3RhdGlj
IHZvaWQgdGVncmFfc2RoY2lfc2V0X3RhcChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWdu
ZWQNCj4gPiBpbnQgdGFwKQ0KPiA+ICB7DQo+ID4gICAgICAgICB1MzIgcmVnOw0KPiA+IEBAIC0z
MDksNyArMjk4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9vcHMgdGVncmFfc2RoY2lf
b3BzID0NCj4gPiB7DQo+ID4gICAgICAgICAucGxhdGZvcm1fZXhlY3V0ZV90dW5pbmcgPSB0ZWdy
YV9zZGhjaV9leGVjdXRlX3R1bmluZywNCj4gPiAgICAgICAgIC5zZXRfdWhzX3NpZ25hbGluZyA9
IHRlZ3JhX3NkaGNpX3NldF91aHNfc2lnbmFsaW5nLA0KPiA+ICAgICAgICAgLnZvbHRhZ2Vfc3dp
dGNoID0gdGVncmFfc2RoY2lfdm9sdGFnZV9zd2l0Y2gsDQo+ID4gLSAgICAgICAuZ2V0X21heF9j
bG9jayA9IHRlZ3JhX3NkaGNpX2dldF9tYXhfY2xvY2ssDQo+ID4gKyAgICAgICAuZ2V0X21heF9j
bG9jayA9IHNkaGNpX3BsdGZtX2Nsa19nZXRfbWF4X2Nsb2NrLA0KPiA+ICB9Ow0KPiA+IA0KPiA+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgc2RoY2lfdGVncmEyMF9wZGF0
YSA9IHsNCj4gPiBAQCAtMzU3LDcgKzM0Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lf
b3BzDQo+ID4gdGVncmExMTRfc2RoY2lfb3BzID0gew0KPiA+ICAgICAgICAgLnBsYXRmb3JtX2V4
ZWN1dGVfdHVuaW5nID0gdGVncmFfc2RoY2lfZXhlY3V0ZV90dW5pbmcsDQo+ID4gICAgICAgICAu
c2V0X3Voc19zaWduYWxpbmcgPSB0ZWdyYV9zZGhjaV9zZXRfdWhzX3NpZ25hbGluZywNCj4gPiAg
ICAgICAgIC52b2x0YWdlX3N3aXRjaCA9IHRlZ3JhX3NkaGNpX3ZvbHRhZ2Vfc3dpdGNoLA0KPiA+
IC0gICAgICAgLmdldF9tYXhfY2xvY2sgPSB0ZWdyYV9zZGhjaV9nZXRfbWF4X2Nsb2NrLA0KPiA+
ICsgICAgICAgLmdldF9tYXhfY2xvY2sgPSBzZGhjaV9wbHRmbV9jbGtfZ2V0X21heF9jbG9jaywN
Cj4gPiAgfTsNCj4gPiANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRh
IHNkaGNpX3RlZ3JhMTE0X3BkYXRhID0gew0KPiA+IC0tDQo+ID4gMi43LjQNCg0KSG0sIGZvciB1
cyB0aGlzIGRlZmluaXRlbHkgYnJlYWtzIHN0dWZmLiBXaGlsZSB1c2luZyBTdGVmYW4ncyBwYXRj
aCBzZXQNClsxXSB3ZSBtYXkgbm90IG9ubHkgcnVuIGVNTUMgYXQgRERSNTIgZXZlbiBTRCBjYXJk
cyBydW4gc3RhYmxlIGF0DQpTRFIxMDQuIFdpdGggdGhpcyBwYXRjaCBob3dldmVyIHRoZSBjbG9j
ayBnZXRzIGNyaXBwbGVkIHRvIDQ1LjMzIHJlc3AuDQo0OCBNSHogYWx3YXlzLiBUaGlzIGlzIG9i
c2VydmVkIGJvdGggb24gQXBhbGlzL0NvbGlicmkgVDMwIGFzIHdlbGwgYXMNCkFwYWxpcyBUSzEu
DQoNCkN1cnJlbnQgbmV4dC0yMDE4MDcxMiBqdXN0IHdpdGggU3RlZmFuJ3MgMyBwYXRjaGVzOg0K
DQpyb290QGFwYWxpcy10MzA6fiMgY2F0IC9zeXMva2VybmVsL2RlYnVnL21tYzEvaW9zIA0KY2xv
Y2s6ICAgICAgICAgIDQ4MDAwMDAwIEh6DQphY3R1YWwgY2xvY2s6ICAgNDUzMzMzMzMgSHoNCnZk
ZDogICAgICAgICAgICAyMSAoMy4zIH4gMy40IFYpDQpidXMgbW9kZTogICAgICAgMiAocHVzaC1w
dWxsKQ0KY2hpcCBzZWxlY3Q6ICAgIDAgKGRvbid0IGNhcmUpDQpwb3dlciBtb2RlOiAgICAgMiAo
b24pDQpidXMgd2lkdGg6ICAgICAgMyAoOCBiaXRzKQ0KdGltaW5nIHNwZWM6ICAgIDggKG1tYyBE
RFI1MikNCnNpZ25hbCB2b2x0YWdlOiAxICgxLjgwIFYpDQpkcml2ZXIgdHlwZTogICAgMCAoZHJp
dmVyIHR5cGUgQikNCnJvb3RAYXBhbGlzLXQzMDp+IyBoZHBhcm0gLXQgL2Rldi9tbWNibGsxDQoN
Ci9kZXYvbW1jYmxrMToNCiBUaW1pbmcgYnVmZmVyZWQgZGlzayByZWFkczogMjE4IE1CIGluICAz
LjAzIHNlY29uZHMgPSAgNzEuOTUgTUIvc2VjDQoNCnJvb3RAYXBhbGlzLXQzMDp+IyBjYXQgL3N5
cy9rZXJuZWwvZGVidWcvbW1jMi9pb3MgDQpjbG9jazogICAgICAgICAgNDgwMDAwMDAgSHoNCmFj
dHVhbCBjbG9jazogICA0ODAwMDAwMCBIeg0KdmRkOiAgICAgICAgICAgIDIxICgzLjMgfiAzLjQg
VikNCmJ1cyBtb2RlOiAgICAgICAyIChwdXNoLXB1bGwpDQpjaGlwIHNlbGVjdDogICAgMCAoZG9u
J3QgY2FyZSkNCnBvd2VyIG1vZGU6ICAgICAyIChvbikNCmJ1cyB3aWR0aDogICAgICAyICg0IGJp
dHMpDQp0aW1pbmcgc3BlYzogICAgNiAoc2QgdWhzIFNEUjEwNCkNCnNpZ25hbCB2b2x0YWdlOiAx
ICgxLjgwIFYpDQpkcml2ZXIgdHlwZTogICAgMCAoZHJpdmVyIHR5cGUgQikNCnJvb3RAYXBhbGlz
LXQzMDp+IyBoZHBhcm0gLXQgL2Rldi9tbWNibGsyDQoNCi9kZXYvbW1jYmxrMjoNCiBUaW1pbmcg
YnVmZmVyZWQgZGlzayByZWFkczogIDY2IE1CIGluICAzLjA2IHNlY29uZHMgPSAgMjEuNjAgTUIv
c2VjDQoNCkFuZCB3aXRoIHRoaXMgcGF0Y2ggcmV2ZXJ0ZWQgaXQgd29ya3MgYXMgZXhwZWN0ZWQg
YWdhaW46DQoNCnJvb3RAYXBhbGlzLXQzMDp+IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbW1jMS9p
b3MgDQpjbG9jazogICAgICAgICAgNTIwMDAwMDAgSHoNCmFjdHVhbCBjbG9jazogICA1MTAwMDAw
MCBIeg0KdmRkOiAgICAgICAgICAgIDIxICgzLjMgfiAzLjQgVikNCmJ1cyBtb2RlOiAgICAgICAy
IChwdXNoLXB1bGwpDQpjaGlwIHNlbGVjdDogICAgMCAoZG9uJ3QgY2FyZSkNCnBvd2VyIG1vZGU6
ICAgICAyIChvbikNCmJ1cyB3aWR0aDogICAgICAzICg4IGJpdHMpDQp0aW1pbmcgc3BlYzogICAg
OCAobW1jIEREUjUyKQ0Kc2lnbmFsIHZvbHRhZ2U6IDEgKDEuODAgVikNCmRyaXZlciB0eXBlOiAg
ICAwIChkcml2ZXIgdHlwZSBCKQ0Kcm9vdEBhcGFsaXMtdDMwOn4jIGhkcGFybSAtdCAvZGV2L21t
Y2JsazENCg0KL2Rldi9tbWNibGsxOg0KIFRpbWluZyBidWZmZXJlZCBkaXNrIHJlYWRzOiAyNDAg
TUIgaW4gIDMuMDIgc2Vjb25kcyA9ICA3OS41MCBNQi9zZWMNCg0Kcm9vdEBhcGFsaXMtdDMwOn4j
IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9tbWMyL2lvcyANCmNsb2NrOiAgICAgICAgICAyMDQwMDAw
MDAgSHoNCmFjdHVhbCBjbG9jazogICAyMDQwMDAwMDAgSHoNCnZkZDogICAgICAgICAgICAyMSAo
My4zIH4gMy40IFYpDQpidXMgbW9kZTogICAgICAgMiAocHVzaC1wdWxsKQ0KY2hpcCBzZWxlY3Q6
ICAgIDAgKGRvbid0IGNhcmUpDQpwb3dlciBtb2RlOiAgICAgMiAob24pDQpidXMgd2lkdGg6ICAg
ICAgMiAoNCBiaXRzKQ0KdGltaW5nIHNwZWM6ICAgIDYgKHNkIHVocyBTRFIxMDQpDQpzaWduYWwg
dm9sdGFnZTogMSAoMS44MCBWKQ0KZHJpdmVyIHR5cGU6ICAgIDAgKGRyaXZlciB0eXBlIEIpDQpy
b290QGFwYWxpcy10MzA6fiMgaGRwYXJtIC10IC9kZXYvbW1jYmxrMg0KDQovZGV2L21tY2JsazI6
DQogVGltaW5nIGJ1ZmZlcmVkIGRpc2sgcmVhZHM6IDI1OCBNQiBpbiAgMy4wMSBzZWNvbmRzID0g
IDg1LjU4IE1CL3NlYw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MDcx
MjA3MzkwNC40NzA1LTEtc3RlZmFuQGFnbmVyLmNo
