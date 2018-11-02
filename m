Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6602081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="nFA8IF9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6602081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeKBRwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:52:11 -0400
Received: from mail-eopbgr720085.outbound.protection.outlook.com ([40.107.72.85]:7488
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbeKBRwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMwnJ6mpmZke5BhIa6XRcSeM2Sqi03ay944wNStijuc=;
 b=nFA8IF9UU0T/QrHfqgCFH5bzkIleJqNS3Xvarm6PRHMPK0saZQFrxXNXsZo9QTQFPsb4QiXw8E4AiQ/VPxViiBEj+M8MYWQkiYr2iG7wLTBnczlg4IRlC4u8hq32GuuUkIrGR+XGMbeVAuQPYWwXTqt4kxES6zn41fe9i7bg9K4=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0621.namprd10.prod.outlook.com (10.163.134.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 08:45:43 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%4]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 08:45:43 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "nkela@cisco.com" <nkela@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "rod@whitby.id.au" <rod@whitby.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Thread-Topic: [PATCH] Make JFFS2 endianness configurable
Thread-Index: AQHUcjZMh055MsdGVUKZD7TCqkpz76U8LHAA
Date:   Fri, 2 Nov 2018 08:45:43 +0000
Message-ID: <c6b51706910048b8dd0732f8963a69867542e9a4.camel@infinera.com>
References: <20181101225603.17806-1-nkela@cisco.com>
In-Reply-To: <20181101225603.17806-1-nkela@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0621;6:iUKJJZYpbF/qgV4tfEjsEqJzGTXDAWJhvTZTlTlpY1K/B7XCs+kWq1bcff/Y3kZmrJ9dlcCy1wFX8eIiz5uFwAkopZ9HDBoGF7+opUP90qaEpxOEt1TqRL6vcph9geF8/lKUjBIbvbizeERCcv0jC3dboV0morVJ4Xi4Spo2JHr2aRraWgosysPNIjCfbm/rUHpqQO/CcwEXiU1PHNVNJDPIOYfs+N+lk+J7n4JCfRtIItLHAuzyMvcAjXNHGzCLHN2J+dFxuDR6kndQUDO3p9O7EK3E06s4IGKZWc/1Oko+VYfUMg/6zfeAbdvZ5lg+RQ/M0gRaGyvh81RcHsX5LbqW0Jf4drKC0PmT7RPbCyLlT5ftIbBLC/iOXdYOZRv3i426wtcBHRwtyIrXqXqK1kd7qyNkPVIUb86XB7fIRzrr/yhBsK0cREtyLslwgG37mPl1FSLOZVMf2KJ36T8G/A==;5:c3ZXfNQToVz7UJ4XEpfeNGkrZI5qk/R6U13c6KcD63Ll0Z6bvWUkkr6kRnUg0S3ywahx72aDP0BVkw7Yv4NBaick4IWENx5wHOcT+tgAPzZe6JmqXmXSW5VQDv/cmBLhaVmdFRRn/CrBTbPBRsD+NjNVjzx5T/OWFgPmv0Pysqg=;7:mt9vsW6gC3UIIxzcDJ2Zw9uxac0h1tJ9s9VCYtJHSILRqUV14nD+gYzwWj77zmeI2qogyqr/3URiiirdck1QBLCtZs6lNCMEwIwF+LbWZzpiuQHya0MJrO4KhvR408tZJA7Iw/f5Xj3OuEMNnVkmCA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5eeb652d-e54d-4d80-bda5-08d6409f9330
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0621;
x-ms-traffictypediagnostic: SN1PR10MB0621:
x-microsoft-antispam-prvs: <SN1PR10MB06215ECC18BAEE6BCC57C761F4CF0@SN1PR10MB0621.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR10MB0621;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0621;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(11346002)(2900100001)(72206003)(102836004)(305945005)(3846002)(966005)(229853002)(118296001)(186003)(6486002)(110136005)(6116002)(6436002)(68736007)(76176011)(6506007)(5660300001)(6246003)(26005)(7736002)(316002)(54906003)(36756003)(256004)(14454004)(478600001)(86362001)(5024004)(6512007)(4326008)(106356001)(2906002)(25786009)(66066001)(2501003)(8676002)(53936002)(6306002)(8936002)(2616005)(99286004)(97736004)(486006)(81166006)(71190400001)(81156014)(71200400001)(446003)(105586002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0621;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hr0wPHItnyDLeyJVgCmw7JIwlqnVoAvAoifv8HxsfdZPThDHCEoGf4jw8/wBcmiQgYZdWDmJX5ahMptYeDIWhk1XBkiEpwOZXqObaL0tFPO9cGK8yq8bQH3P/0JoirtQm3A+kcfLKavJnGIi/+qzxOeyoZ1bgM/G3zEWaXqiqqY2ZqDdApHBBJZsBGGPGsyGEYRyfhYCcQLZ9Y0/RTDo4c8W6VbkxZP0qre7DY8L29ctkDmNbnDWbMVbPjigHzjm3LXaYZif3BV3SXXmYdGLGfVcnYR1jKmLh3DneKobT3lCtrg4hfBExkEFw+9xILVxW0gtjKC3dyblAgoCfCNWgjJKiCfbfC8Z8dUvoMQHLdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <094A24FA86A5AB499D966AE6DA70864B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeb652d-e54d-4d80-bda5-08d6409f9330
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 08:45:43.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDE1OjU2IC0wNzAwLCBOaWt1bmogS2VsYSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0K
PiANCj4gVGhpcyBwYXRjaCBhbGxvd3MgdGhlIGVuZGlhbm5lc3Mgb2YgdGhlIEpGU1MyIGZpbGVz
eXN0ZW0gdG8gYmUNCj4gc3BlY2lmaWVkIGJ5IGNvbmZpZyBvcHRpb25zLg0KPiANCj4gSXQgZGVm
YXVsdHMgdG8gbmF0aXZlLWVuZGlhbiAodGhlIHByZXZpb3VzbHkgaGFyZC1jb2RlZCBvcHRpb24p
Lg0KPiANCj4gU29tZSBhcmNoaXRlY3R1cmVzIGJlbmVmaXQgZnJvbSBoYXZpbmcgYSBzaW5nbGUg
a25vd24gZW5kaWFubmVzcw0KPiBvZiBKRkZTMiBmaWxlc3lzdGVtIChmb3IgZGF0YSwgbm90IGV4
ZWN1dGFibGVzKSBpbmRlcGVuZGVudCBvZiB0aGUNCj4gZW5kaWFubmVzcyBvZiB0aGUgcHJvY2Vz
c29yIChBUk0gcHJvY2Vzc29ycyBjYW4gYmUgc3dpdGNoZWQgdG8gZWl0aGVyDQo+IGVuZGlhbm5l
c3MgYXQgcnVuLXRpbWUpLg0KDQpJIGxpa2UgdGhpcyB0b28uIEkgaGF2ZSBvbiBzZXZlcmFsIG9j
Y2FzaW9ucyBuZWVkZWQgdG8gbW91bnQgYSBKRkZTMiBCRSBvbg0KbXkgUEMuIFRoaXMgc2F2ZXMg
bWUgZnJvbSBoYXZpbmcgdG8gaGFjayB0aGUgc3JjLg0KDQogSm9ja2UNCg0KDQo+IA0KPiBUaGlz
IHBhdGNoIGlzIHRha2VuIGZyb206DQo+IGh0dHA6Ly93d3cuaW5mcmFkZWFkLm9yZy9waXBlcm1h
aWwvbGludXgtbXRkLzIwMDYtSmFudWFyeS8wMTQ3MTcuaHRtbA0KPiANCj4gQ2M6IHhlLWxpbnV4
LWV4dGVybmFsQGNpc2NvLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBSb2QgV2hpdGJ5IDxyb2RAd2hp
dGJ5LmlkLmF1Pg0KPiBTaWduZWQtb2ZmLWJ5OiBOaWt1bmogS2VsYSA8bmtlbGFAY2lzY28uY29t
Pg0KPiAtLS0NCj4gIGZzL2pmZnMyL0tjb25maWcgICAgfCAyNSArKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICBmcy9qZmZzMi9ub2RlbGlzdC5oIHwgIDggKysrLS0tLS0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9qZmZzMi9LY29uZmlnIGIvZnMvamZmczIvS2NvbmZpZw0KPiBpbmRleCBhZDg1MGM1
YmYyY2EuLjg2ZTkzZmJjOWQ3NCAxMDA2NDQNCj4gLS0tIGEvZnMvamZmczIvS2NvbmZpZw0KPiAr
KysgYi9mcy9qZmZzMi9LY29uZmlnDQo+IEBAIC0xODIsMyArMTgyLDI4IEBAIGNvbmZpZyBKRkZT
Ml9DTU9ERV9GQVZPVVJMWk8NCj4gICAgICAgICAgIGRlY29tcHJlc3Npb24pIGF0IHRoZSBleHBl
bnNlIG9mIHNpemUuDQo+IA0KPiAgZW5kY2hvaWNlDQo+ICsNCj4gK2Nob2ljZQ0KPiArICAgICAg
IHByb21wdCAiSkZGUzIgZW5kaWFubmVzcyINCj4gKyAgICAgICBkZWZhdWx0IEpGRlMyX05BVElW
RV9FTkRJQU4NCj4gKyAgICAgICBkZXBlbmRzIG9uIEpGRlMyX0ZTDQo+ICsgICAgICAgaGVscA0K
PiArICAgICAgICAgWW91IGNhbiBzZXQgaGVyZSB0aGUgZGVmYXVsdCBlbmRpYW5uZXNzIG9mIEpG
RlMyIGZyb20NCj4gKyAgICAgICAgIHRoZSBhdmFpbGFibGUgb3B0aW9ucy4gRG8gbm90IHRvdWNo
IGlmIHVuc3VyZS4NCj4gKw0KPiArY29uZmlnIEpGRlMyX05BVElWRV9FTkRJQU4NCj4gKyAgICAg
ICBib29sICJuYXRpdmUgZW5kaWFuIg0KPiArICAgICAgIGhlbHANCj4gKyAgICAgICAgIFVzZXMg
YSBuYXRpdmUgZW5kaWFuIGJ5dGVzdHJlYW0uDQo+ICsNCj4gK2NvbmZpZyBKRkZTMl9CSUdfRU5E
SUFODQo+ICsgICAgICAgYm9vbCAiYmlnIGVuZGlhbiINCj4gKyAgICAgICBoZWxwDQo+ICsgICAg
ICAgICBVc2VzIGEgYmlnIGVuZGlhbiBieXRlc3RyZWFtLg0KPiArDQo+ICtjb25maWcgSkZGUzJf
TElUVExFX0VORElBTg0KPiArICAgICAgIGJvb2wgImxpdHRsZSBlbmRpYW4iDQo+ICsgICAgICAg
aGVscA0KPiArICAgICAgICAgVXNlcyBhIGxpdHRsZSBlbmRpYW4gYnl0ZXN0cmVhbS4NCj4gKw0K
PiArZW5kY2hvaWNlDQo+IGRpZmYgLS1naXQgYS9mcy9qZmZzMi9ub2RlbGlzdC5oIGIvZnMvamZm
czIvbm9kZWxpc3QuaA0KPiBpbmRleCAwNjM3MjcxZjM3NzAuLmExZWJmMDRmMjE3YyAxMDA2NDQN
Cj4gLS0tIGEvZnMvamZmczIvbm9kZWxpc3QuaA0KPiArKysgYi9mcy9qZmZzMi9ub2RlbGlzdC5o
DQo+IEBAIC0yNywxMiArMjcsMTAgQEANCj4gICNpbmNsdWRlICJvcy1saW51eC5oIg0KPiAgI2Vu
ZGlmDQo+IA0KPiAtI2RlZmluZSBKRkZTMl9OQVRJVkVfRU5ESUFODQo+IC0NCj4gIC8qIE5vdGUg
d2UgaGFuZGxlIG1vZGUgYml0cyBjb252ZXJzaW9uIGZyb20gSkZGUzIgKGkuZS4gTGludXgpIHRv
L2Zyb20NCj4gICAgIHdoYXRldmVyIE9TIHdlJ3JlIGFjdHVhbGx5IHJ1bm5pbmcgb24gaGVyZSB0
b28uICovDQo+IA0KPiAtI2lmIGRlZmluZWQoSkZGUzJfTkFUSVZFX0VORElBTikNCj4gKyNpZiBk
ZWZpbmVkKENPTkZJR19KRkZTMl9OQVRJVkVfRU5ESUFOKQ0KPiAgI2RlZmluZSBjcHVfdG9famUx
Nih4KSAoKGppbnQxNl90KXt4fSkNCj4gICNkZWZpbmUgY3B1X3RvX2plMzIoeCkgKChqaW50MzJf
dCl7eH0pDQo+ICAjZGVmaW5lIGNwdV90b19qZW1vZGUoeCkgKChqbW9kZV90KXtvc190b19qZmZz
Ml9tb2RlKHgpfSkNCj4gQEAgLTQzLDcgKzQxLDcgQEANCj4gICNkZWZpbmUgamUxNl90b19jcHUo
eCkgKCh4KS52MTYpDQo+ICAjZGVmaW5lIGplMzJfdG9fY3B1KHgpICgoeCkudjMyKQ0KPiAgI2Rl
ZmluZSBqZW1vZGVfdG9fY3B1KHgpIChqZmZzMl90b19vc19tb2RlKCh4KS5tKSkNCj4gLSNlbGlm
IGRlZmluZWQoSkZGUzJfQklHX0VORElBTikNCj4gKyNlbGlmIGRlZmluZWQoQ09ORklHX0pGRlMy
X0JJR19FTkRJQU4pDQo+ICAjZGVmaW5lIGNwdV90b19qZTE2KHgpICgoamludDE2X3Qpe2NwdV90
b19iZTE2KHgpfSkNCj4gICNkZWZpbmUgY3B1X3RvX2plMzIoeCkgKChqaW50MzJfdCl7Y3B1X3Rv
X2JlMzIoeCl9KQ0KPiAgI2RlZmluZSBjcHVfdG9famVtb2RlKHgpICgoam1vZGVfdCl7Y3B1X3Rv
X2JlMzIob3NfdG9famZmczJfbW9kZSh4KSl9KQ0KPiBAQCAtNTQsNyArNTIsNyBAQA0KPiAgI2Rl
ZmluZSBqZTE2X3RvX2NwdSh4KSAoYmUxNl90b19jcHUoeC52MTYpKQ0KPiAgI2RlZmluZSBqZTMy
X3RvX2NwdSh4KSAoYmUzMl90b19jcHUoeC52MzIpKQ0KPiAgI2RlZmluZSBqZW1vZGVfdG9fY3B1
KHgpIChiZTMyX3RvX2NwdShqZmZzMl90b19vc19tb2RlKCh4KS5tKSkpDQo+IC0jZWxpZiBkZWZp
bmVkKEpGRlMyX0xJVFRMRV9FTkRJQU4pDQo+ICsjZWxpZiBkZWZpbmVkKENPTkZJR19KRkZTMl9M
SVRUTEVfRU5ESUFOKQ0KPiAgI2RlZmluZSBjcHVfdG9famUxNih4KSAoKGppbnQxNl90KXtjcHVf
dG9fbGUxNih4KX0pDQo+ICAjZGVmaW5lIGNwdV90b19qZTMyKHgpICgoamludDMyX3Qpe2NwdV90
b19sZTMyKHgpfSkNCj4gICNkZWZpbmUgY3B1X3RvX2plbW9kZSh4KSAoKGptb2RlX3Qpe2NwdV90
b19sZTMyKG9zX3RvX2pmZnMyX21vZGUoeCkpfSkNCj4gLS0NCj4gMi4xOS4xDQo+IA0KPiANCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8NCg0K
