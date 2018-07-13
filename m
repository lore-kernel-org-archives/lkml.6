Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB337208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="rcOr+bkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB337208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeGMP5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:57:51 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com ([40.107.1.101]:6896
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729725AbeGMP5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvjggsgZJL82kBPPZlAilhNeGCHK6g7Eu21T7gVFiQY=;
 b=rcOr+bkU0SWT2STWFhPs1neJgg3UJMMaAKFBFcM0swbiB/ebjtXBzVoxgeF/xemON7wM268l5ToOEllj22UQ3+tGexTgvOn5l9mn/2A9Xf2+bNkw1vn+YLgTzUUE4vFIi/YoavqQByvwYUq1qlPkfYL1ZubpIYpx04nmVt5jDFg=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2383.eurprd05.prod.outlook.com (10.168.135.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 13 Jul 2018 15:42:37 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0930.022; Fri, 13 Jul
 2018 15:42:36 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "avienamo@nvidia.com" <avienamo@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Thread-Topic: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Thread-Index: AQHUGqvsd0jEo9zEdEWjel39VayzlKSNSuQA
Date:   Fri, 13 Jul 2018 15:42:36 +0000
Message-ID: <1531496554.5479.37.camel@toradex.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
In-Reply-To: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2383;7:uBR0/mcTJzYMYZXuKrdu4r0tEgxDcKXJ600MhOi3Om/ospHGoDUxOrUzMgXN5gl8XYR1vD/sBfBhstYkr4WPZMh91kn4j9s5R/PszKPxO3r5sbCZc036SirWCO7cxuEJOvIy5mXbUNhhgEsspguYMQ5fyFw8DaJgslQnhZITENY4g3R58uyspQiIhHNHKg6LQ+v+AXTUBms5ISKViJ52twnxlvcnryDrRsz5xR+sAdzRXjr9RPnIiHwtrojEP/Yf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39850400004)(366004)(396003)(189003)(199004)(316002)(5250100002)(6486002)(25786009)(2900100001)(2906002)(6506007)(256004)(53936002)(54906003)(2201001)(6436002)(3846002)(11346002)(81156014)(6512007)(81166006)(110136005)(36756003)(6116002)(106356001)(8936002)(102836004)(6246003)(229853002)(305945005)(6306002)(966005)(8676002)(26005)(7736002)(86362001)(14454004)(2501003)(66066001)(99286004)(446003)(476003)(478600001)(2616005)(103116003)(5660300001)(486006)(107886003)(44832011)(68736007)(97736004)(4326008)(186003)(105586002)(76176011)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2383;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 39baa300-7c92-416c-8be4-08d5e8d74217
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2383;
x-ms-traffictypediagnostic: VI1PR0501MB2383:
x-microsoft-antispam-prvs: <VI1PR0501MB238383024CB35CF529E1E1D2FB580@VI1PR0501MB2383.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2383;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2383;
x-forefront-prvs: 07326CFBC4
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RgfzaYTeESLok61WKRsb+I6kfENF2ISivkrbUMK7pDs/BndnnrtJTVnbxoepqLeprLCvWyIrEwHO61uLSAr2S244+UVzAN5JglMgNYqbWG8H3KkbMDprdJN+YU1WyTlpLtnMK/Rr528DlcFN7Qu5RXdZtkTBfI9RokYZmc93l7rcAom6Pu5F8u2SfuUWejALHDdUT+Oq33k67amGlSGN9eoMSDEuj1XZtRISEHG3hGioISBHQ/uT3gUTmJV6AjH5ys/0Ef8UDCqKZ4WWammMKpqQq2d5qCx0U4OwcNfrGb4WLSra1CCrjtisip4/7amePfQXWbXOnrs1g3NkFn0bxoWsfpRiBiBOM1s873U0C9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <70698C4AA526F74D8CE98F940EB91637@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39baa300-7c92-416c-8be4-08d5e8d74217
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 15:42:36.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTEzIGF0IDE2OjE3ICswMzAwLCBBYXBvIFZpZW5hbW8gd3JvdGU6DQo+
IEltcGxlbWVudCBhbmQgdXNlIHRlZ3JhX3NkaGNpX2dldF9tYXhfY2xvY2soKSB3aGljaCByZXR1
cm5zIHRoZSB0cnVlDQo+IG1heGltdW0gaG9zdCBjbG9jayByYXRlLiBUaGUgaXNzdWUgd2l0aCB0
ZWdyYV9zZGhjaV9nZXRfbWF4X2Nsb2NrKCkNCj4gaXMNCj4gdGhhdCBpdCByZXR1cm5zIHRoZSBj
dXJyZW50IGNsb2NrIHJhdGUgb2YgdGhlIGhvc3QgaW5zdGVhZCBvZiB0aGUNCj4gbWF4aW11bSBv
bmUsIHdoaWNoIGNhbiBsZWFkIHRvIHVubmVjZXNzYXJpbHkgc21hbGwgY2xvY2sgcmF0ZXMuDQo+
IA0KPiBUaGlzIGRpZmZlcnMgZnJvbSB0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24gb2YNCj4g
dGVncmFfc2RoY2lfZ2V0X21heF9jbG9jaygpIGluIHRoYXQgaXQgZG9lc24ndCBkaXZpZGUgdGhl
IHJlc3VsdCBieQ0KPiB0d28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBYXBvIFZpZW5hbW8gPGF2
aWVuYW1vQG52aWRpYS5jb20+DQoNClRoZSB3aG9sZSBzZXJpZXMgc3RyZXNzLXRlc3RlZCBvbiB2
YXJpb3VzIEFwYWxpcyBUMzAgYXMgd2VsbCBhcyBDb2xpYnJpDQpUMzAgbW9kdWxlczoNCg0KVGVz
dGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyB8IDExICsrKysrKysrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktDQo+IHRlZ3JhLmMNCj4gaW5kZXggMjhiOThlMi4uZGRmMDAxNjYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMNCj4gQEAgLTIzNSw2ICsyMzUsMTMgQEAgc3RhdGlj
IHZvaWQgdGVncmFfc2RoY2lfc2V0X3Voc19zaWduYWxpbmcoc3RydWN0DQo+IHNkaGNpX2hvc3Qg
Kmhvc3QsDQo+ICAJc2RoY2lfc2V0X3Voc19zaWduYWxpbmcoaG9zdCwgdGltaW5nKTsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIHVuc2lnbmVkIGludCB0ZWdyYV9zZGhjaV9nZXRfbWF4X2Nsb2NrKHN0
cnVjdCBzZGhjaV9ob3N0DQo+ICpob3N0KQ0KPiArew0KPiArCXN0cnVjdCBzZGhjaV9wbHRmbV9o
b3N0ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4gKw0KPiArCXJldHVybiBjbGtf
cm91bmRfcmF0ZShwbHRmbV9ob3N0LT5jbGssIFVJTlRfTUFYKTsNCj4gK30NCj4gKw0KPiAgc3Rh
dGljIHZvaWQgdGVncmFfc2RoY2lfc2V0X3RhcChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5z
aWduZWQNCj4gaW50IHRhcCkNCj4gIHsNCj4gIAl1MzIgcmVnOw0KPiBAQCAtMjk5LDcgKzMwNiw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHRlZ3JhX3NkaGNpX29wcyA9IHsNCj4g
IAkucGxhdGZvcm1fZXhlY3V0ZV90dW5pbmcgPSB0ZWdyYV9zZGhjaV9leGVjdXRlX3R1bmluZywN
Cj4gIAkuc2V0X3Voc19zaWduYWxpbmcgPSB0ZWdyYV9zZGhjaV9zZXRfdWhzX3NpZ25hbGluZywN
Cj4gIAkudm9sdGFnZV9zd2l0Y2ggPSB0ZWdyYV9zZGhjaV92b2x0YWdlX3N3aXRjaCwNCj4gLQku
Z2V0X21heF9jbG9jayA9IHNkaGNpX3BsdGZtX2Nsa19nZXRfbWF4X2Nsb2NrLA0KPiArCS5nZXRf
bWF4X2Nsb2NrID0gdGVncmFfc2RoY2lfZ2V0X21heF9jbG9jaywNCj4gIH07DQo+ICANCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV90ZWdyYTIwX3BkYXRhID0g
ew0KPiBAQCAtMzU2LDcgKzM2Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHRl
Z3JhMTE0X3NkaGNpX29wcw0KPiA9IHsNCj4gIAkucGxhdGZvcm1fZXhlY3V0ZV90dW5pbmcgPSB0
ZWdyYV9zZGhjaV9leGVjdXRlX3R1bmluZywNCj4gIAkuc2V0X3Voc19zaWduYWxpbmcgPSB0ZWdy
YV9zZGhjaV9zZXRfdWhzX3NpZ25hbGluZywNCj4gIAkudm9sdGFnZV9zd2l0Y2ggPSB0ZWdyYV9z
ZGhjaV92b2x0YWdlX3N3aXRjaCwNCj4gLQkuZ2V0X21heF9jbG9jayA9IHNkaGNpX3BsdGZtX2Ns
a19nZXRfbWF4X2Nsb2NrLA0KPiArCS5nZXRfbWF4X2Nsb2NrID0gdGVncmFfc2RoY2lfZ2V0X21h
eF9jbG9jaywNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1f
ZGF0YSBzZGhjaV90ZWdyYTExNF9wZGF0YSA9IHsNCg0KV29ya3MgcXVpdGUgbmljZWx5IG9uIHRv
ZGF5J3MgbmV4dCB0b2dldGhlciB3aXRoIFN0ZWZhbidzIHBhdGNoIHNldCBbMV06DQoNCnJvb3RA
YXBhbGlzLXQzMDp+IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbW1jMS9pb3MgDQpjbG9jazogICAg
ICAgICAgNTIwMDAwMDAgSHoNCmFjdHVhbCBjbG9jazogICA1MTAwMDAwMCBIeg0KdmRkOiAgICAg
ICAgICAgIDIxICgzLjMgfiAzLjQgVikNCmJ1cyBtb2RlOiAgICAgICAyIChwdXNoLXB1bGwpDQpj
aGlwIHNlbGVjdDogICAgMCAoZG9uJ3QgY2FyZSkNCnBvd2VyIG1vZGU6ICAgICAyIChvbikNCmJ1
cyB3aWR0aDogICAgICAzICg4IGJpdHMpDQp0aW1pbmcgc3BlYzogICAgOCAobW1jIEREUjUyKQ0K
c2lnbmFsIHZvbHRhZ2U6IDEgKDEuODAgVikNCmRyaXZlciB0eXBlOiAgICAwIChkcml2ZXIgdHlw
ZSBCKQ0Kcm9vdEBhcGFsaXMtdDMwOn4jIGhkcGFybSAtdCAvZGV2L21tY2JsazENCg0KL2Rldi9t
bWNibGsxOg0KIFRpbWluZyBidWZmZXJlZCBkaXNrIHJlYWRzOiAyMzYgTUIgaW4gIDMuMDEgc2Vj
b25kcyA9ICA3OC40MiBNQi9zZWMNCg0Kcm9vdEBjb2xpYnJpLXQzMDp+IyBjYXQgL3N5cy9rZXJu
ZWwvZGVidWcvbW1jMC9pb3MgDQpjbG9jazogICAgICAgICAgNTIwMDAwMDAgSHoNCmFjdHVhbCBj
bG9jazogICA1MTAwMDAwMCBIeg0KdmRkOiAgICAgICAgICAgIDIxICgzLjMgfiAzLjQgVikNCmJ1
cyBtb2RlOiAgICAgICAyIChwdXNoLXB1bGwpDQpjaGlwIHNlbGVjdDogICAgMCAoZG9uJ3QgY2Fy
ZSkNCnBvd2VyIG1vZGU6ICAgICAyIChvbikNCmJ1cyB3aWR0aDogICAgICAzICg4IGJpdHMpDQp0
aW1pbmcgc3BlYzogICAgOCAobW1jIEREUjUyKQ0Kc2lnbmFsIHZvbHRhZ2U6IDEgKDEuODAgVikN
CmRyaXZlciB0eXBlOiAgICAwIChkcml2ZXIgdHlwZSBCKQ0Kcm9vdEBjb2xpYnJpLXQzMDp+IyBo
ZHBhcm0gLXQgL2Rldi9tbWNibGswDQoNCi9kZXYvbW1jYmxrMDoNCiBUaW1pbmcgYnVmZmVyZWQg
ZGlzayByZWFkczogMTY4IE1CIGluICAzLjAwIHNlY29uZHMgPSAgNTUuOTkgTUIvc2VjDQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgwNzEyMDczOTA0LjQ3MDUtMS1zdGVm
YW5AYWduZXIuY2g=
