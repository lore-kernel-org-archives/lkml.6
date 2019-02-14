Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F22222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="T4qHCPnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfBNJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:28:44 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:43819 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388196AbfBNJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:28:43 -0500
Received: from pps.filterd (m0111311.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E9Osms017109;
        Thu, 14 Feb 2019 10:28:31 +0100
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
        by mx08-00287e01.pphosted.com with ESMTP id 2qmu48gkkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 10:28:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRTG0jtm1CsHFVLRVIZTcZ0E8qQ1/WPTc9qUn956bB8=;
 b=T4qHCPnwh/4oBQYJANzCQBuz3C3Xkcj+7rLQY+u3mwpV/3u9+fTl4yOg0WUP8oOyAE2U2fW5X5ZywszP7ktznolPfjg6qe3dtAqZqATnOtAcA0ROLLfezwSx2Ta64Kt0MgDe/40HlLT7A39QPq7DOumbcA0s0WFpRtK8cvYj7Eg=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB2976.eurprd04.prod.outlook.com (10.170.228.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 09:28:28 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 09:28:27 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Topic: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Index: AQHUw5aitGKSKy+IPEu9VYMAMc3KbKXfCBeA
Date:   Thu, 14 Feb 2019 09:28:27 +0000
Message-ID: <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
References: <20190213122105.14270-1-e.velu@criteo.com>
In-Reply-To: <20190213122105.14270-1-e.velu@criteo.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::24) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a4d7d4d-2fc6-42d3-ae6f-08d6925ec650
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2976;
x-ms-traffictypediagnostic: VI1PR04MB2976:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIyOTc2OzIzOmV5dVJTM29oOWdKeUdRRmJ1KysxSzFmczNG?=
 =?utf-8?B?blh4NlFlSVd3NzJzNCswcmVOUlFXNElNbVpnNHBXalZGMzZRazVwVjVUcU12?=
 =?utf-8?B?eElsUmZ2d3R5c1ZUOEdneVhMREFaOWI4ajMvZ0V6WCtwYmNnZzFRLzFqK2xS?=
 =?utf-8?B?amZJNlgrQnVLNXRrK2dqa2dhMEo0TUZueXkxK0gwVXU5bmluVDg5V0lGVmpV?=
 =?utf-8?B?c1FSWjlwMXRSL2w4ZzR6QVlBbkgrV2dCWTkxWFE5WHE0dHd6U2F6SmtFaFoz?=
 =?utf-8?B?dmpCTC8xdGFoeWx3aFR4WTJhcUxjWWR4WlVPei9XNWJjenRGdVhndHo2aGdr?=
 =?utf-8?B?dUxNcmlmQWNsQUsvZktpMkFjYXEwS21zenNSR05pU0pXWGQ5OURNazlNZ2ZP?=
 =?utf-8?B?elRteEg3dUR6bkc2VG1MY2kweGFmT1I1Ym9SSkNtcHpQWHphcFhZZGVudEJr?=
 =?utf-8?B?Z3Bsakx3aEZNV1hTanV6WjZvZkI0V2ErYzVvQ2xQYXlRb1M2Wk5IYm9kYmRQ?=
 =?utf-8?B?L29CdUJnZVNKUHBZamZIdUk4emc1N2laNWU5L1RURTFzU1Q5dnJpVTNvb0Ji?=
 =?utf-8?B?aGo0ZXNFSC9GWFNIY1ppYWxRbFNpaGVqVVB5aDRmTjh5alJkVEU3Vng5NzVH?=
 =?utf-8?B?Nk9RSGtCQlhYcml6ak1CRlZMa0RuUXgwcXJRc2xGL1lsaGFmZWtkMExsbEFJ?=
 =?utf-8?B?Y1hST0lZbzdGS0IxNngxaUMyNWo3K2hkdmdzNEpMSmhkMWdnS0ZWa0FMQTFx?=
 =?utf-8?B?MmJTd3p6TlVHZGJpLytJbUtReDQxbjdLM1ozTUpLTDRIeXV2azl3c0NEUkVE?=
 =?utf-8?B?VVZiMlowSVRxeFM5RW9RNWlwZU9TVCt2UWg1Z3VXeE5SVE9oMXFQRmZ3RzNL?=
 =?utf-8?B?eERtRlFBSTRhWWZyZ2ZmcTZhQmpNOHlKeWxYOWFOSGFXcVBNMlFQUkNidXVm?=
 =?utf-8?B?Skt0eFFVd0hIcU1rSlh4cmFZMDRZd21qalhaMlRMdmJRWXBNZExXYWxkTE00?=
 =?utf-8?B?V3NhL3lWQmtTUWtyNG5lTHVMNzluS21RdjVVWGZFQXhSS1AzcG80NU0wZzZz?=
 =?utf-8?B?enZQVnJha2k1R2F5bitQdTBmaDV6UGFYRlN5TG9IMHVGTWJQVnR6SE9kaU1t?=
 =?utf-8?B?SENLYlZNbExmZHM5UmorcFBXQVdEQTVIeTRvTXhkSEhJbDB3TFhQY241aGNp?=
 =?utf-8?B?cUZzc21PNHI4MDkwWWpKTGk2L2VkWmZONFRqZEZITUJ1QmZNZzg2YVNkK2pH?=
 =?utf-8?B?OUszSTBWN0VRbU16ZTIvVURXS083ZlFHQjdnbWplekgzcTdLTDJCcUJvZy8r?=
 =?utf-8?B?MExTdk5wUTF1RnJmZ1d4ZDluNnlOQzdvc21HWnQ5d0g5bjdxTE5rUG1TaWlW?=
 =?utf-8?B?STREc1JNNjdwczV4OWJNRUZ0c3FpWTl1RWNoVHRTQXdZVFhYUXFyLy8xamRo?=
 =?utf-8?B?VHJsY1JtODJwc1dpVzQ3dVl0Zlc5VGUyclByMjFSOTFWTHRHYnVoRU5ldTNT?=
 =?utf-8?B?VDVzaXdtcXpnWkZGc282dGF2ZU04NGNwcERYTGN2ZmdvQ0RmK0RIRnFVNEwx?=
 =?utf-8?B?WWVaWVlGblY1TWlhYlVBUVlLMlFrTEZMbnNnZ0dwWUhFY1NwWFprWnd4bm5I?=
 =?utf-8?B?R1V0Y0ZRbVpZakRDbmtKbDBjUFBhd250WndDU0hoNkhxWHZrSWo4L0VNZ3o0?=
 =?utf-8?B?RGNRT2JOQkZxZUlpNFpVN084YXVhNTQraUxKeGUxWHRZVmVSVlBzUkNkci9o?=
 =?utf-8?B?TkVleUd6VDZZdncyTHA5Rngza1ppcDFkR1dsdEVHM3N6UHRZM0F5NjVVNGo5?=
 =?utf-8?B?cVVOL01qL1M3ZTR5eHJOdXgzL1BmdEdMSkZQcFJFNFkyQnc9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB2976FE57A08E083B0571763AF2670@VI1PR04MB2976.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(76176011)(229853002)(486006)(26005)(66574012)(6916009)(2616005)(476003)(316002)(446003)(11346002)(31686004)(97736004)(102836004)(71200400001)(71190400001)(2351001)(106356001)(105586002)(305945005)(54906003)(14444005)(7736002)(256004)(36756003)(52116002)(186003)(99286004)(6436002)(5640700003)(2501003)(6512007)(386003)(6506007)(68736007)(66066001)(6486002)(31696002)(86362001)(81166006)(8676002)(81156014)(478600001)(1730700003)(6246003)(4326008)(25786009)(2906002)(3846002)(6116002)(14454004)(53936002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB2976;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EBsVccre5zGplcmaqjcDsCbsk9dI+MTqZKR1ST/T/OLk1lgFQIZyqUeID30YRfmLqIcnmlq6aJiebISRLMVunq03EGNJPDC3M8R0VbzzVwmkXPBlkMjy93YJo0f5nQ+Xeyozd1p1AzImVqXeo6sKf3siz6loJKlz0gL2y0UKd+XQTYTNto/8dH5I3buotcRUSrjpo2Oia0V/D6mMdJikhVPovkFrWVkCGRh3uov4ys0vC8uo+JGXxxtTvsbg49F6TJrCglcaVPZVTaumqDQ2YSuaBeem36IvDWGoMdSRGivyh1ZpSpbWT201/fQSnIgyYue/f3tz+jZtxfjpoEQksGKO1bL3wieCutqbNYVG6jWvOEttkFiu3DGbVuOY8xfx0h/q2gu8rm+FsJW7KBAExqA2VXbE40n998m3N1lg3Yw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65A70BF18378EF4DA33AD2EBCEEA1167@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4d7d4d-2fc6-42d3-ae6f-08d6925ec650
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:28:26.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IHJhZmFlbCwNCg0KRG9lcyB0aGUgVjYgbG9va3MgZ29vZCB0byB5b3UgPw0KDQpUaGFua3Ms
DQoNCkVyd2FuLA0KDQpMZSAxMy8wMi8yMDE5IMOgIDEzOjIxLCBFcndhbiBWZWx1IGEgw6ljcml0
wqA6DQo+IFRoZSBpbml0IGNvZGUgcGF0aCBoYXMgc2V2ZXJhbCBleGNlcHRpb25zIHdoZXJlIHRo
ZSBtb2R1bGUgY2FuIGRlY2lkZSBub3QgdG8gbG9hZC4NCj4gQXMgQ09ORklHX1g4Nl9JTlRFTF9Q
U1RBVEUgaXMgZ2VuZXJhbGx5IHNldCB0byBZLCB0aGUgcmV0dXJuIGNvZGUgaXMgbm90IHJlYWNo
YWJsZS4NCj4gVGhlIGluaXRpYWxpemF0aW9uIGNvZGUgaXMgbmVpdGhlciB2ZXJib3NlIG9mIHRo
ZSByZWFzb24gd2h5IGl0IGRpZCBjaG9vc2UgdG8gcHJlbWF0dXJlbHkgZXhpdC4NCj4NCj4gVGhp
cyBzaXR1YXRpb24gbGVhZHMgdG8gYSBzaXR1YXRpb24gd2hlcmUgaXRzIGRpZmZpY3VsdCBmb3Ig
YSB1c2VyIHRvIGRldGVybWluZSwNCj4gb24gYSBnaXZlbiBwbGF0Zm9ybSwgd2h5IHRoZSBkcml2
ZXIgZGlkbid0IGxvYWQgcHJvcGVybHkuDQo+DQo+IFRoaXMgcGF0Y2ggaXMgYWJvdXQgcmVwb3J0
aW5nIHRvIHRoZSB1c2VyIHRoZSByZWFzb24vY29udGV4dCBvZiB3aHkgdGhlIGRyaXZlciBmYWls
ZWQgdG8gbG9hZC4NCj4gVGhhdCBpcyBhIHByZWNpb3VzIGhpbnQgd2hlbiBkZWJ1Z2dpbmcgYSBw
bGF0Zm9ybS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRXJ3YW4gVmVsdSA8ZS52ZWx1QGNyaXRlby5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyB8IDI3ICsrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2lu
dGVsX3BzdGF0ZS5jIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+IGluZGV4IGRk
NjZkZWNmMjA4Ny4uZTFhZTMwOTkyM2JmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEv
aW50ZWxfcHN0YXRlLmMNCj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+
IEBAIC0yNDc1LDYgKzI0NzUsNyBAQCBzdGF0aWMgYm9vbCBfX2luaXQgaW50ZWxfcHN0YXRlX25v
X2FjcGlfcHNzKHZvaWQpDQo+ICAgCQlrZnJlZShwc3MpOw0KPiAgIAl9DQo+ICAgDQo+ICsJcHJf
ZGVidWcoIkFDUEkgX1BTUyBub3QgZm91bmRcbiIpOw0KPiAgIAlyZXR1cm4gdHJ1ZTsNCj4gICB9
DQo+ICAgDQo+IEBAIC0yNDg0LDEwICsyNDg1LDE1IEBAIHN0YXRpYyBib29sIF9faW5pdCBpbnRl
bF9wc3RhdGVfbm9fYWNwaV9wY2NoKHZvaWQpDQo+ICAgCWFjcGlfaGFuZGxlIGhhbmRsZTsNCj4g
ICANCj4gICAJc3RhdHVzID0gYWNwaV9nZXRfaGFuZGxlKE5VTEwsICJcXF9TQiIsICZoYW5kbGUp
Ow0KPiAtCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4gKwlpZiAoQUNQSV9GQUlMVVJFKHN0
YXR1cykpIHsNCj4gKwkJcHJfZGVidWcoIkFDUEkgUENDSCBub3QgZm91bmRcbiIpOw0KPiAgIAkJ
cmV0dXJuIHRydWU7DQo+ICsJfQ0KPiAgIA0KPiAtCXJldHVybiAhYWNwaV9oYXNfbWV0aG9kKGhh
bmRsZSwgIlBDQ0giKTsNCj4gKwlzdGF0dXMgPSBhY3BpX2hhc19tZXRob2QoaGFuZGxlLCAiUEND
SCIpOw0KPiArCWlmICghc3RhdHVzKQ0KPiArCQlwcl9kZWJ1ZygiQUNQSSBQQ0NIIG5vdCBmb3Vu
ZFxuIik7DQo+ICsJcmV0dXJuICFzdGF0dXM7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBib29s
IF9faW5pdCBpbnRlbF9wc3RhdGVfaGFzX2FjcGlfcHBjKHZvaWQpDQo+IEBAIC0yNTAyLDYgKzI1
MDgsNyBAQCBzdGF0aWMgYm9vbCBfX2luaXQgaW50ZWxfcHN0YXRlX2hhc19hY3BpX3BwYyh2b2lk
KQ0KPiAgIAkJaWYgKGFjcGlfaGFzX21ldGhvZChwci0+aGFuZGxlLCAiX1BQQyIpKQ0KPiAgIAkJ
CXJldHVybiB0cnVlOw0KPiAgIAl9DQo+ICsJcHJfZGVidWcoIkFDUEkgX1BQQyBub3QgZm91bmRc
biIpOw0KPiAgIAlyZXR1cm4gZmFsc2U7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMjUzOSw4ICsyNTQ2
LDEwIEBAIHN0YXRpYyBib29sIF9faW5pdCBpbnRlbF9wc3RhdGVfcGxhdGZvcm1fcHdyX21nbXRf
ZXhpc3RzKHZvaWQpDQo+ICAgCWlkID0geDg2X21hdGNoX2NwdShpbnRlbF9wc3RhdGVfY3B1X29v
Yl9pZHMpOw0KPiAgIAlpZiAoaWQpIHsNCj4gICAJCXJkbXNybChNU1JfTUlTQ19QV1JfTUdNVCwg
bWlzY19wd3IpOw0KPiAtCQlpZiAoIG1pc2NfcHdyICYgKDEgPDwgOCkpDQo+ICsJCWlmIChtaXNj
X3B3ciAmICgxIDw8IDgpKSB7DQo+ICsJCQlwcl9kZWJ1ZygiTVNSX01JU0NfUFdSX01HTVQgZW5h
YmxlZFxuIik7DQo+ICAgCQkJcmV0dXJuIHRydWU7DQo+ICsJCX0NCj4gICAJfQ0KPiAgIA0KPiAg
IAlpZHggPSBhY3BpX21hdGNoX3BsYXRmb3JtX2xpc3QocGxhdF9pbmZvKTsNCj4gQEAgLTI2MDYs
MjIgKzI2MTUsMjggQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfcHN0YXRlX2luaXQodm9pZCkN
Cj4gICAJCX0NCj4gICAJfSBlbHNlIHsNCj4gICAJCWlkID0geDg2X21hdGNoX2NwdShpbnRlbF9w
c3RhdGVfY3B1X2lkcyk7DQo+IC0JCWlmICghaWQpDQo+ICsJCWlmICghaWQpIHsNCj4gKwkJCXBy
X2luZm8oIkNQVSBJRCBpcyBub3QgaW4gdGhlIGxpc3Qgb2Ygc3VwcG9ydGVkIGRldmljZXNcbiIp
Ow0KPiAgIAkJCXJldHVybiAtRU5PREVWOw0KPiArCQl9DQo+ICAgDQo+ICAgCQljb3B5X2NwdV9m
dW5jcygoc3RydWN0IHBzdGF0ZV9mdW5jcyAqKWlkLT5kcml2ZXJfZGF0YSk7DQo+ICAgCX0NCj4g
ICANCj4gLQlpZiAoaW50ZWxfcHN0YXRlX21zcnNfbm90X3ZhbGlkKCkpDQo+ICsJaWYgKGludGVs
X3BzdGF0ZV9tc3JzX25vdF92YWxpZCgpKSB7DQo+ICsJCXByX3dhcm4oIkNhbm5vdCBlbmFibGUg
ZHJpdmVyIGFzIHBlciBpbnZhbGlkIE1TUnNcbiIpOw0KPiAgIAkJcmV0dXJuIC1FTk9ERVY7DQo+
ICsJfQ0KPiAgIA0KPiAgIGh3cF9jcHVfbWF0Y2hlZDoNCj4gICAJLyoNCj4gICAJICogVGhlIElu
dGVsIHBzdGF0ZSBkcml2ZXIgd2lsbCBiZSBpZ25vcmVkIGlmIHRoZSBwbGF0Zm9ybQ0KPiAgIAkg
KiBmaXJtd2FyZSBoYXMgaXRzIG93biBwb3dlciBtYW5hZ2VtZW50IG1vZGVzLg0KPiAgIAkgKi8N
Cj4gLQlpZiAoaW50ZWxfcHN0YXRlX3BsYXRmb3JtX3B3cl9tZ210X2V4aXN0cygpKQ0KPiArCWlm
IChpbnRlbF9wc3RhdGVfcGxhdGZvcm1fcHdyX21nbXRfZXhpc3RzKCkpIHsNCj4gKwkJcHJfaW5m
bygiUGxhdGZvcm0gYWxyZWFkeSB0YWtpbmcgY2FyZSBvZiBwb3dlciBtYW5hZ2VtZW50XG4iKTsN
Cj4gICAJCXJldHVybiAtRU5PREVWOw0KPiArCX0NCj4gICANCj4gICAJaWYgKCFod3BfYWN0aXZl
ICYmIGh3cF9vbmx5KQ0KPiAgIAkJcmV0dXJuIC1FTk9UU1VQUDsNCg==
