Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D60C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1AE2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t1oWUxZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbeLQU12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:27:28 -0500
Received: from mail-eopbgr790049.outbound.protection.outlook.com ([40.107.79.49]:17076
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeLQU12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm9UxiHshxZvjwFLl6O4ozvj3O+EEVZ6iR2G+K8dvUI=;
 b=t1oWUxZs4CZdBsm/ohfkglaXZ+ikhvi0kzRRqlAvO2kZuq2E7ulORTDzD1MI5uwBztk1GjRVbxECiA/3mZ/ZLYGFtXtLOVCslVDjcHoy0OY2pkqGd6N2HUuqVK231hcybOEB5WtAYeZ8fiyVbgncsTpGhu2bQYpxc4qFWfypGSk=
Received: from BY2PR12MB0178.namprd12.prod.outlook.com (10.162.82.27) by
 BY2PR12MB0119.namprd12.prod.outlook.com (10.160.66.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 20:27:19 +0000
Received: from BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81]) by BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81%8]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 20:27:19 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [WIP PATCH 02/15] drm/dp_mst: Refactor
 drm_dp_update_payload_part1()
Thread-Topic: [WIP PATCH 02/15] drm/dp_mst: Refactor
 drm_dp_update_payload_part1()
Thread-Index: AQHUk0wLF6+auempak6ddBvSSdtXCKV97MKAgAV6cYA=
Date:   Mon, 17 Dec 2018 20:27:19 +0000
Message-ID: <b04abc2c-3e9e-f4c8-d444-a7aebde01719@amd.com>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-3-lyude@redhat.com>
 <20181214084743.GM21184@phenom.ffwll.local>
In-Reply-To: <20181214084743.GM21184@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0119;20:T04v23dlylTcFqWRIXJFrFpO+3hsN7SR4M6uYta4nNOi81tdgeJDblQpdxmLiMNboqAiUldFkvHoLtPKEpzM1Ky88MVkMFscZ9dZjXu59lqajooJj0QnwSLbL5/NDV4dPFP7cBOSeaFxog+VZP+5IIJkdxMbGV1ZcO/USuD5dTvO1qitxMO/FFuJPTFy/tx9obcxS8BhDLbQ7+vUyF6SzEBWPlAxsPTLeQecEBVvhrQ0YNWn4S7Xt32OzGlAwKDs
x-ms-office365-filtering-correlation-id: 6ae4ec2d-1540-4039-ca37-08d6645e0a8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0119;
x-ms-traffictypediagnostic: BY2PR12MB0119:
x-microsoft-antispam-prvs: <BY2PR12MB0119FBD17CCCB15966F3D5698CBC0@BY2PR12MB0119.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0119;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0119;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(2616005)(53936002)(68736007)(6486002)(76176011)(476003)(53546011)(316002)(386003)(31696002)(97736004)(8936002)(217873002)(71190400001)(6506007)(305945005)(486006)(2201001)(229853002)(6436002)(4001150100001)(36756003)(7416002)(66066001)(65806001)(65956001)(26005)(2906002)(6116002)(7736002)(72206003)(58126008)(6346003)(256004)(11346002)(25786009)(14444005)(446003)(71200400001)(64126003)(81156014)(86362001)(186003)(2501003)(105586002)(6512007)(106356001)(110136005)(102836004)(3846002)(39060400002)(65826007)(5660300001)(6246003)(31686004)(14454004)(81166006)(52116002)(99286004)(478600001)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0119;H:BY2PR12MB0178.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-microsoft-antispam-message-info: k09ZyjAJqRs+PYZ9q6e7QQMovKD7JKPgA8IF48q9N3YQBFps6kC0BSTteMS4aYE4rBWKr3lmItZ26Qd0c50vi3wC6kpFCAvNoMggsANTHK5zUYVSfj9BYaiMBCDGuAd1pusp6FLz0Gllr9VZ/zCz7uJfyfpAjA35+OR/ubqbbUXlmrGi5U6zQNHEJXlpVjm60kjtzBB1p2oxBK+yfw3el8zR2hIiUNjLx905Vyf9xSOi//x/yRioZVV8MFQNGXbDXXhHj1uLVyeaUwUoNee5pGi7UKflCwJVcFPpgJ/cpe02Lmtt0YY0119iEk9gawP7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C393D6EFF058F645ABCBEF8F9F91CE74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae4ec2d-1540-4039-ca37-08d6645e0a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 20:27:19.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xNCAzOjQ3IGEubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6DQo+IE9uIFRodSwg
RGVjIDEzLCAyMDE4IGF0IDA4OjI1OjMxUE0gLTA1MDAsIEx5dWRlIFBhdWwgd3JvdGU6DQo+PiBU
aGVyZSBzaG91bGQgYmUgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGhlcmUNCj4gDQo+IFdvdWxkIGJl
IGdvb2QgdG8gZXhwbGFpbiB3aGF0IHlvdSBkaWQgcmVmYWN0b3IgaGVyZSwgaW5zdGVhZCBvZiBt
ZSB0cnlpbmcNCj4gdG8gcmVjb25zdHJ1Y3QgaXQgZnJvbSB0aGUgcGF0Y2guIEVzcGVjaWFsbHkg
cHJlLWNvZmZlZSB0aGF0IGhlbHBzIDotKQ0KDQpJIGNvbmN1ci4gU29tZXRoaW5nIGxpa2UgInVz
ZSBsb2NhbCB2YXJpYWJsZXMgdG8gaW1wcm92ZSByZWFkYWJpbGl0eSIuDQoNCldpdGggdGhhdCBm
aXhlZCB0aGlzIGlzDQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5k
QGFtZC5jb20+DQoNCkhhcnJ5DQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxs
eXVkZUByZWRoYXQuY29tPg0KPj4gQ2M6IEp1c3RvbiBMaSA8anVzdG9uLmxpQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCA3MSAr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0
aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90
b3BvbG9neS5jDQo+PiBpbmRleCA5YjFiNWM5YjFmYTAuLjJhYjE2YzllNjI0MyAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMNCj4+IEBAIC0xODc5LDM5ICsxODc5
LDQ4IEBAIGludCBkcm1fZHBfdXBkYXRlX3BheWxvYWRfcGFydDEoc3RydWN0IGRybV9kcF9tc3Rf
dG9wb2xvZ3lfbWdyICptZ3IpDQo+PiAgDQo+PiAgCW11dGV4X2xvY2soJm1nci0+cGF5bG9hZF9s
b2NrKTsNCj4+ICAJZm9yIChpID0gMDsgaSA8IG1nci0+bWF4X3BheWxvYWRzOyBpKyspIHsNCj4+
ICsJCXN0cnVjdCBkcm1fZHBfdmNwaSAqdmNwaSA9IG1nci0+cHJvcG9zZWRfdmNwaXNbaV07DQo+
PiArCQlzdHJ1Y3QgZHJtX2RwX3BheWxvYWQgKnBheWxvYWQgPSAmbWdyLT5wYXlsb2Fkc1tpXTsN
Cj4+ICsNCj4+ICAJCS8qIHNvbHZlIHRoZSBjdXJyZW50IHBheWxvYWRzIC0gY29tcGFyZSB0byB0
aGUgaHcgb25lcw0KPj4gIAkJICAgLSB1cGRhdGUgdGhlIGh3IHZpZXcgKi8NCj4+ICAJCXJlcV9w
YXlsb2FkLnN0YXJ0X3Nsb3QgPSBjdXJfc2xvdHM7DQo+PiAtCQlpZiAobWdyLT5wcm9wb3NlZF92
Y3Bpc1tpXSkgew0KPj4gLQkJCXBvcnQgPSBjb250YWluZXJfb2YobWdyLT5wcm9wb3NlZF92Y3Bp
c1tpXSwgc3RydWN0IGRybV9kcF9tc3RfcG9ydCwgdmNwaSk7DQo+PiArCQlpZiAodmNwaSkgew0K
Pj4gKwkJCXBvcnQgPSBjb250YWluZXJfb2YodmNwaSwgc3RydWN0IGRybV9kcF9tc3RfcG9ydCwN
Cj4+ICsJCQkJCSAgICB2Y3BpKTsNCj4+ICAJCQlwb3J0ID0gZHJtX2RwX2dldF92YWxpZGF0ZWRf
cG9ydF9yZWYobWdyLCBwb3J0KTsNCj4+ICAJCQlpZiAoIXBvcnQpIHsNCj4+ICAJCQkJbXV0ZXhf
dW5sb2NrKCZtZ3ItPnBheWxvYWRfbG9jayk7DQo+PiAgCQkJCXJldHVybiAtRUlOVkFMOw0KPj4g
IAkJCX0NCj4+IC0JCQlyZXFfcGF5bG9hZC5udW1fc2xvdHMgPSBtZ3ItPnByb3Bvc2VkX3ZjcGlz
W2ldLT5udW1fc2xvdHM7DQo+PiAtCQkJcmVxX3BheWxvYWQudmNwaSA9IG1nci0+cHJvcG9zZWRf
dmNwaXNbaV0tPnZjcGk7DQo+PiArCQkJcmVxX3BheWxvYWQubnVtX3Nsb3RzID0gdmNwaS0+bnVt
X3Nsb3RzOw0KPj4gKwkJCXJlcV9wYXlsb2FkLnZjcGkgPSB2Y3BpLT52Y3BpOw0KPj4gIAkJfSBl
bHNlIHsNCj4+ICAJCQlwb3J0ID0gTlVMTDsNCj4+ICAJCQlyZXFfcGF5bG9hZC5udW1fc2xvdHMg
PSAwOw0KPj4gIAkJfQ0KPj4gIA0KPj4gLQkJbWdyLT5wYXlsb2Fkc1tpXS5zdGFydF9zbG90ID0g
cmVxX3BheWxvYWQuc3RhcnRfc2xvdDsNCj4+ICsJCXBheWxvYWQtPnN0YXJ0X3Nsb3QgPSByZXFf
cGF5bG9hZC5zdGFydF9zbG90Ow0KPj4gIAkJLyogd29yayBvdXQgd2hhdCBpcyByZXF1aXJlZCB0
byBoYXBwZW4gd2l0aCB0aGlzIHBheWxvYWQgKi8NCj4+IC0JCWlmIChtZ3ItPnBheWxvYWRzW2ld
Lm51bV9zbG90cyAhPSByZXFfcGF5bG9hZC5udW1fc2xvdHMpIHsNCj4+ICsJCWlmIChwYXlsb2Fk
LT5udW1fc2xvdHMgIT0gcmVxX3BheWxvYWQubnVtX3Nsb3RzKSB7DQo+PiAgDQo+PiAgCQkJLyog
bmVlZCB0byBwdXNoIGFuIHVwZGF0ZSBmb3IgdGhpcyBwYXlsb2FkICovDQo+PiAgCQkJaWYgKHJl
cV9wYXlsb2FkLm51bV9zbG90cykgew0KPj4gLQkJCQlkcm1fZHBfY3JlYXRlX3BheWxvYWRfc3Rl
cDEobWdyLCBtZ3ItPnByb3Bvc2VkX3ZjcGlzW2ldLT52Y3BpLCAmcmVxX3BheWxvYWQpOw0KPj4g
LQkJCQltZ3ItPnBheWxvYWRzW2ldLm51bV9zbG90cyA9IHJlcV9wYXlsb2FkLm51bV9zbG90czsN
Cj4+IC0JCQkJbWdyLT5wYXlsb2Fkc1tpXS52Y3BpID0gcmVxX3BheWxvYWQudmNwaTsNCj4+IC0J
CQl9IGVsc2UgaWYgKG1nci0+cGF5bG9hZHNbaV0ubnVtX3Nsb3RzKSB7DQo+PiAtCQkJCW1nci0+
cGF5bG9hZHNbaV0ubnVtX3Nsb3RzID0gMDsNCj4+IC0JCQkJZHJtX2RwX2Rlc3Ryb3lfcGF5bG9h
ZF9zdGVwMShtZ3IsIHBvcnQsIG1nci0+cGF5bG9hZHNbaV0udmNwaSwgJm1nci0+cGF5bG9hZHNb
aV0pOw0KPj4gLQkJCQlyZXFfcGF5bG9hZC5wYXlsb2FkX3N0YXRlID0gbWdyLT5wYXlsb2Fkc1tp
XS5wYXlsb2FkX3N0YXRlOw0KPj4gLQkJCQltZ3ItPnBheWxvYWRzW2ldLnN0YXJ0X3Nsb3QgPSAw
Ow0KPj4gKwkJCQlkcm1fZHBfY3JlYXRlX3BheWxvYWRfc3RlcDEobWdyLCB2Y3BpLT52Y3BpLA0K
Pj4gKwkJCQkJCQkgICAgJnJlcV9wYXlsb2FkKTsNCj4+ICsJCQkJcGF5bG9hZC0+bnVtX3Nsb3Rz
ID0gcmVxX3BheWxvYWQubnVtX3Nsb3RzOw0KPj4gKwkJCQlwYXlsb2FkLT52Y3BpID0gcmVxX3Bh
eWxvYWQudmNwaTsNCj4+ICsNCj4+ICsJCQl9IGVsc2UgaWYgKHBheWxvYWQtPm51bV9zbG90cykg
ew0KPj4gKwkJCQlwYXlsb2FkLT5udW1fc2xvdHMgPSAwOw0KPj4gKwkJCQlkcm1fZHBfZGVzdHJv
eV9wYXlsb2FkX3N0ZXAxKG1nciwgcG9ydCwNCj4+ICsJCQkJCQkJICAgICBwYXlsb2FkLT52Y3Bp
LA0KPj4gKwkJCQkJCQkgICAgIHBheWxvYWQpOw0KPj4gKwkJCQlyZXFfcGF5bG9hZC5wYXlsb2Fk
X3N0YXRlID0NCj4+ICsJCQkJCXBheWxvYWQtPnBheWxvYWRfc3RhdGU7DQo+PiArCQkJCXBheWxv
YWQtPnN0YXJ0X3Nsb3QgPSAwOw0KPj4gIAkJCX0NCj4+IC0JCQltZ3ItPnBheWxvYWRzW2ldLnBh
eWxvYWRfc3RhdGUgPSByZXFfcGF5bG9hZC5wYXlsb2FkX3N0YXRlOw0KPj4gKwkJCXBheWxvYWQt
PnBheWxvYWRfc3RhdGUgPSByZXFfcGF5bG9hZC5wYXlsb2FkX3N0YXRlOw0KPj4gIAkJfQ0KPj4g
IAkJY3VyX3Nsb3RzICs9IHJlcV9wYXlsb2FkLm51bV9zbG90czsNCj4+ICANCj4+IEBAIC0xOTIw
LDIyICsxOTI5LDI2IEBAIGludCBkcm1fZHBfdXBkYXRlX3BheWxvYWRfcGFydDEoc3RydWN0IGRy
bV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IpDQo+PiAgCX0NCj4+ICANCj4+ICAJZm9yIChpID0g
MDsgaSA8IG1nci0+bWF4X3BheWxvYWRzOyBpKyspIHsNCj4+IC0JCWlmIChtZ3ItPnBheWxvYWRz
W2ldLnBheWxvYWRfc3RhdGUgPT0gRFBfUEFZTE9BRF9ERUxFVEVfTE9DQUwpIHsNCj4+IC0JCQlE
Uk1fREVCVUdfS01TKCJyZW1vdmluZyBwYXlsb2FkICVkXG4iLCBpKTsNCj4+IC0JCQlmb3IgKGog
PSBpOyBqIDwgbWdyLT5tYXhfcGF5bG9hZHMgLSAxOyBqKyspIHsNCj4+IC0JCQkJbWVtY3B5KCZt
Z3ItPnBheWxvYWRzW2pdLCAmbWdyLT5wYXlsb2Fkc1tqICsgMV0sIHNpemVvZihzdHJ1Y3QgZHJt
X2RwX3BheWxvYWQpKTsNCj4+IC0JCQkJbWdyLT5wcm9wb3NlZF92Y3Bpc1tqXSA9IG1nci0+cHJv
cG9zZWRfdmNwaXNbaiArIDFdOw0KPj4gLQkJCQlpZiAobWdyLT5wcm9wb3NlZF92Y3Bpc1tqXSAm
JiBtZ3ItPnByb3Bvc2VkX3ZjcGlzW2pdLT5udW1fc2xvdHMpIHsNCj4+IC0JCQkJCXNldF9iaXQo
aiArIDEsICZtZ3ItPnBheWxvYWRfbWFzayk7DQo+PiAtCQkJCX0gZWxzZSB7DQo+PiAtCQkJCQlj
bGVhcl9iaXQoaiArIDEsICZtZ3ItPnBheWxvYWRfbWFzayk7DQo+PiAtCQkJCX0NCj4+IC0JCQl9
DQo+PiAtCQkJbWVtc2V0KCZtZ3ItPnBheWxvYWRzW21nci0+bWF4X3BheWxvYWRzIC0gMV0sIDAs
IHNpemVvZihzdHJ1Y3QgZHJtX2RwX3BheWxvYWQpKTsNCj4+IC0JCQltZ3ItPnByb3Bvc2VkX3Zj
cGlzW21nci0+bWF4X3BheWxvYWRzIC0gMV0gPSBOVUxMOw0KPj4gLQkJCWNsZWFyX2JpdChtZ3It
Pm1heF9wYXlsb2FkcywgJm1nci0+cGF5bG9hZF9tYXNrKTsNCj4+ICsJCWlmIChtZ3ItPnBheWxv
YWRzW2ldLnBheWxvYWRfc3RhdGUgIT0gRFBfUEFZTE9BRF9ERUxFVEVfTE9DQUwpDQo+PiArCQkJ
Y29udGludWU7DQo+PiArDQo+PiArCQlEUk1fREVCVUdfS01TKCJyZW1vdmluZyBwYXlsb2FkICVk
XG4iLCBpKTsNCj4+ICsJCWZvciAoaiA9IGk7IGogPCBtZ3ItPm1heF9wYXlsb2FkcyAtIDE7IGor
Kykgew0KPj4gKwkJCW1nci0+cGF5bG9hZHNbal0gPSBtZ3ItPnBheWxvYWRzW2ogKyAxXTsNCj4+
ICsJCQltZ3ItPnByb3Bvc2VkX3ZjcGlzW2pdID0gbWdyLT5wcm9wb3NlZF92Y3Bpc1tqICsgMV07
DQo+PiAgDQo+PiArCQkJaWYgKG1nci0+cHJvcG9zZWRfdmNwaXNbal0gJiYNCj4+ICsJCQkgICAg
bWdyLT5wcm9wb3NlZF92Y3Bpc1tqXS0+bnVtX3Nsb3RzKSB7DQo+PiArCQkJCXNldF9iaXQoaiAr
IDEsICZtZ3ItPnBheWxvYWRfbWFzayk7DQo+PiArCQkJfSBlbHNlIHsNCj4+ICsJCQkJY2xlYXJf
Yml0KGogKyAxLCAmbWdyLT5wYXlsb2FkX21hc2spOw0KPj4gKwkJCX0NCj4+ICAJCX0NCj4+ICsN
Cj4+ICsJCW1lbXNldCgmbWdyLT5wYXlsb2Fkc1ttZ3ItPm1heF9wYXlsb2FkcyAtIDFdLCAwLA0K
Pj4gKwkJICAgICAgIHNpemVvZihzdHJ1Y3QgZHJtX2RwX3BheWxvYWQpKTsNCj4+ICsJCW1nci0+
cHJvcG9zZWRfdmNwaXNbbWdyLT5tYXhfcGF5bG9hZHMgLSAxXSA9IE5VTEw7DQo+PiArCQljbGVh
cl9iaXQobWdyLT5tYXhfcGF5bG9hZHMsICZtZ3ItPnBheWxvYWRfbWFzayk7DQo+IA0KPiBXaXRo
IHRoZSBjb21taXQgbWVzc2FnZSBpbXByb3ZlZCB0byBtZW50aW9uDQo+IC0gQWRkIGxvY2FsIHZh
cmlhYmxlcyBpbiB0aGUgZmlyc3QgbG9vcA0KPiAtIEVhcmx5IGNvbnRpbnVlIHRvIHJlZHVjZSAx
IGluZGVudCBpbiB0aGUgMm5kIGxvb3ANCj4gDQo+IHRoaXMgaXMgUmV2aWV3ZWQtYnk6IERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+DQo+IA0KPj4gIAl9DQo+PiAgCW11dGV4
X3VubG9jaygmbWdyLT5wYXlsb2FkX2xvY2spOw0KPj4gIA0KPj4gLS0gDQo+PiAyLjE5LjINCj4+
DQo+IA0K
