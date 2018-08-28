Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F52C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714D2208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714D2208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=live.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeH1Fvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:51:55 -0400
Received: from mail-oln040092255031.outbound.protection.outlook.com ([40.92.255.31]:20906
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbeH1Fvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:51:55 -0400
Received: from SG2APC01FT015.eop-APC01.prod.protection.outlook.com
 (10.152.250.52) by SG2APC01HT099.eop-APC01.prod.protection.outlook.com
 (10.152.251.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1101.10; Tue, 28
 Aug 2018 02:00:49 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com (10.152.250.56) by
 SG2APC01FT015.mail.protection.outlook.com (10.152.250.181) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1101.10 via
 Frontend Transport; Tue, 28 Aug 2018 02:00:49 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d]) by HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d%5]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 02:00:49 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Larry Chen <lchen@suse.com>, "mfasheh@suse.com" <mfasheh@suse.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH] fix dead lock caused by ocfs2_defrag_extent
Thread-Topic: [Ocfs2-devel] [PATCH] fix dead lock caused by
 ocfs2_defrag_extent
Thread-Index: AQHUPdxasF8xPWW9IUOKXtftZyBTYaTUaimA
Date:   Tue, 28 Aug 2018 02:00:49 +0000
Message-ID: <HK0PR06MB2561EFE93735AE62A0F5A559D50A0@HK0PR06MB2561.apcprd06.prod.outlook.com>
References: <20180827080121.31145-1-lchen@suse.com>
In-Reply-To: <20180827080121.31145-1-lchen@suse.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0154.apcprd06.prod.outlook.com
 (2603:1096:1:1f::32) To HK0PR06MB2561.apcprd06.prod.outlook.com
 (2603:1096:203:6f::10)
x-incomingtopheadermarker: OriginalChecksum:9962FB7E031E912AAEC30418652644DD82E34765A294990D06B9B4EB25DF644F;UpperCasedChecksum:2B339CEE67D86330D6FE5F6D923F17AF4B3B8906D8EF08CAF3D1D4D5DFEB79A4;SizeAsReceived:7611;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eDp6XmJiG3iYLK6ReRbOKCgg2r1WPGKr3QR0caOavDY=]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2APC01HT099;6:ZPXTKzPQXBJNBzeRA0u45wSeyUykqR6WrF7D9IL01SPzRcgUUYyKUQotpO9RHNORFkvCbifSFfs65F3LPOOrvVffUffI2dwj81jsEI/0QNyF9vsGR7oSRdCPPvCB9ZsckY0nIxZgaIb3QoJC76Z6FkTawIPHOTcp3UTt7PBWJ+DrnnSuEHxHsaqdbxRaN4V5w0XLNaMp9atoBt560Eam+Mrr5M7CoQm8yLCQmpYvlctNyzZXwdZnFb0xvpUHdCEh/E0TGIBEw+bRmVYfWFO9mY9FYElJj92hGZkf+iEoEUEIIt3XfrNnbCQSu/AvdMipYn/yn5CoBanuJtSd3Zp6TynXAyFZxD0NTbbfcXt2ZUl7bDZz7p1G4iHZfzU1vxNvJsX/IywDW3yQEjfDY6lljSbZAKJC/Zk6SdSfEMieSA7gexMcLxHYuoI/40rDEtgmqQ2twTrrG4NE/3pGIjJSdA==;5:xAL5J1bXPCJDBsV6Gerw7n69/VnRhtMa4qOs6gIIWVRcVTd7t44zED+aa4HRZBCDZNgGL5GReet628nBTJuVCGpdzTuPDAuxVDb5rty7ZNNLIHbIQM1nPj5OjT4seXz82QtBf46pIy1pazD6JmjiEmA0XhBAnIwfXpJ66nyaeac=;7:ZH31Lb5ohLnVLI69apdi6sgKNQV4Qnb4GKA9EEM4RDC0N1QajILByVSn50ZesJ4AmyM/h1qfHbP0Yuwwp2GevNpr/Ceo2McglM92wdXHhWYSXJ3CHNTQ2ABCu/Rv4v8I6Bvmg2yE+ir1X5p8LCVTOM4gZT4Al63AaQ0aH+xvECQMdtTJJXde1MlrVlQC1odQ5y/3XkdEUKC+VrrQW14/VWJp331JHJhINtrVogmchTuc+aM0mBOiZ6x2O8AS6Ypv
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:SG2APC01HT099;
x-ms-traffictypediagnostic: SG2APC01HT099:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SG2APC01HT099;BCL:0;PCL:0;RULEID:;SRVR:SG2APC01HT099;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(81156014)(476003)(106356001)(110136005)(105586002)(6246003)(25786009)(74482002)(4326008)(54906003)(14454004)(8936002)(2501003)(15760500003)(229853002)(104016004)(81612004)(97736004)(99286004)(6436002)(7696005)(33656002)(76176011)(9686003)(14444005)(256004)(53546011)(6506007)(102836004)(386003)(56003)(55016002)(11346002)(82202002)(2900100001)(2201001)(575784001)(446003)(86362001)(68736007)(486006)(5660300001)(26005)(74316002)(305945005)(5250100002)(8676002)(6346003);DIR:OUT;SFP:1901;SCL:1;SRVR:SG2APC01HT099;H:HK0PR06MB2561.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.cn does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gechangwei@live.cn; 
x-microsoft-antispam-message-info: cnbSqkntkxNfe01ClPXRF8VmbSpEVKkBKsqATOuND6dKEUqzhe2ciNefJF5UxqYu7kC4LUxb9gz1EdanGhVpgKZVnh71Teb2uo+YgzLMsNiBWVrzHde4EMzmd4xRPDSRSw2EFSwk6G7VSMt5o+l0AK9oibiA4yNLXiWagYdlY4NvxdUgi8kdMOWpcrbGz9lVburO7xLT/U4o/qXMvWDCLODl7CzTCuqzlRPBBo382ug=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B456CD6A7A3C1249B67774DFCE9710BA@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a48b16-5b40-4570-745c-08d60c8a136a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 02:00:49.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycnksDQoNCkknZCBsaWtlIHRvIHByb3Bvc2UgYW5vdGhlciB3YXkgdG8gZml4IHRoaXMg
aXNzdWUsIHdoaWNoIG1pZ2h0IGJlIGVhc2llci4NCkFjdHVhbGx5LCBvY2ZzMl9yZXNlcnZlX2Ns
dXN0ZXJzKCkgaW5zaWRlIHdpbGwgZmx1c2ggdHJ1bmNhdGUgbG9nIGlmIA0KdGhlcmUgaXMgbm8g
ZW5vdWdoIGNsdXN0ZXJzIGxlZnQuDQpTbyBob3cgYWJvdXQganVzdCByZW1vdmUgX19vY2ZzMl9m
bHVzaF90cnVuY2F0ZV9sb2coKSBpbiANCm9jZnMyX2RlZnJhZ19leHRlbnQoKT8NCg0KVGhhbmtz
LA0KQ2hhbmd3ZWkNCg0KDQpPbiAyMDE4LzgvMjcgMTY6MDEsIExhcnJ5IENoZW4gd3JvdGU6DQo+
IG9jZnMyX2RlZnJhZ19leHRlbnQgbWF5IGZhbGwgaW50byBkZWFkIGxvY2suDQo+DQo+IG9jZnMy
X2lvY3RsX21vdmVfZXh0ZW50cw0KPiAgICBvY2ZzMl9pb2N0bF9tb3ZlX2V4dGVudHMJDQo+ICAg
ICAgb2NmczJfbW92ZV9leHRlbnRzDQo+ICAgICAgICBvY2ZzMl9kZWZyYWdfZXh0ZW50DQo+ICAg
ICAgICAgIG9jZnMyX2xvY2tfYWxsb2NhdG9yc19tb3ZlX2V4dGVudHMNCj4NCj4gICAgICAgICAg
ICBvY2ZzMl9yZXNlcnZlX2NsdXN0ZXJzDQo+ICAgICAgICAgICAgICBpbm9kZV9sb2NrIEdMT0JB
TF9CSVRNQVBfU1lTVEVNX0lOT0RFDQo+DQo+IAkgIF9fb2NmczJfZmx1c2hfdHJ1bmNhdGVfbG9n
DQo+ICAgICAgICAgICAgICBpbm9kZV9sb2NrIEdMT0JBTF9CSVRNQVBfU1lTVEVNX0lOT0RFDQo+
DQo+IEFzIGJhY2sgdHJhY2Ugc2hvd3MgYWJvdmUsIG9jZnMyX3Jlc2VydmVfY2x1c3RlcnMgd2ls
bCBjYWxsIGlub2RlX2xvY2sNCj4gYWdhaW5zdCB0aGUgZ2xvYmFsIGJpdG1hcCBpZiBsb2NhbCBh
bGxvY2F0b3IgaGFzIG5vdCBzdWZmaWNpZW50IGNsdXRlcnMuDQo+IE9uY2UgZ2xvYmFsIGJpdG1h
cCBjb3VsZCBtZWV0IHRoZSBkZW1hbmQsIG9jZnMyX3Jlc2VydmVfY2x1c3RlciB3aWxsDQo+IHJl
dHVybiBzdWNjZXNzIHdpdGggZ2xvYmFsIGJpdG1hcCBsb2NrZWQuDQo+DQo+IEFmdGVyIG9jZnMy
X3Jlc2VydmVfY2x1c3RlciwgaWYgdHJ1bmNhdGUgbG9nIGlzIGZ1bGwsDQo+IF9fb2NmczJfZmx1
c2hfdHJ1bmNhdGVfbG9nIHdpbGwgZGVmaW5pdGVseSBmYWxsIGludG8gZGVhZCBsb2NrDQo+IGJl
Y2F1c2UgaXQgbmVlZHMgdG8gaW5vZGVfbG9jayBnbG9iYWwgYml0bWFwLCB3aGljaCBoYXMNCj4g
YWxyZWFkeSBiZWVuIGxvY2tlZC4NCj4NCj4gVG8gZml4IHRoaXMgYnVnLCB3ZSBjb3VsZCByZW1v
dmUgZnJvbSBvY2ZzMl9sb2NrX2FsbG9jYXRvcnNfbW92ZV9leHRlbnRzDQo+IHRoZSBjb2RlIHdo
aWNoIGludGVuZHMgdG8gbG9jayBnbG9iYWwgYWxsb2NhdG9yLCBhbmQgcHV0IHRoZSByZW1vdmVk
DQo+IGNvZGUgYWZ0ZXIgX19vY2ZzMl9mbHVzaF90cnVuY2F0ZV9sb2cNCj4NCj4gVGhlIG9jZnMy
X2xvY2tfYWxsb2NhdG9yc19tb3ZlX2V4dGVudHMgaGFzIGJlZW4gcmVmZXJlZCBieSAyIHBsYWNl
cywgb25lDQo+IGlzIGhlcmUsIHRoZSBvdGhlciBkb2VzIG5vdCBuZWVkIHRoZSBkYXRhIGFsbG9j
YXRvciBjb250ZXh0LCB3aGljaCBtZWFucw0KPiB0aGlzIHBhdGNoIGRvZXMgbm90IGFmZmVjdCB0
aGUgY2FsbGVyIHNvIGZhci4NCj4NCj4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTGFycnkgQ2hlbiA8
bGNoZW5Ac3VzZS5jb20+DQo+IC0tLQ0KPiAgIGZzL29jZnMyL21vdmVfZXh0ZW50cy5jIHwgMTMg
KysrKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9vY2ZzMi9tb3ZlX2V4dGVudHMuYyBiL2Zz
L29jZnMyL21vdmVfZXh0ZW50cy5jDQo+IGluZGV4IDdlYjNiMGE2MzQ3ZS4uMDY0ZGVkZjQwZDc0
IDEwMDY0NA0KPiAtLS0gYS9mcy9vY2ZzMi9tb3ZlX2V4dGVudHMuYw0KPiArKysgYi9mcy9vY2Zz
Mi9tb3ZlX2V4dGVudHMuYw0KPiBAQCAtMTkyLDEzICsxOTIsNiBAQCBzdGF0aWMgaW50IG9jZnMy
X2xvY2tfYWxsb2NhdG9yc19tb3ZlX2V4dGVudHMoc3RydWN0IGlub2RlICppbm9kZSwNCj4gICAJ
CWdvdG8gb3V0Ow0KPiAgIAl9DQo+ICAgDQo+IC0JaWYgKGRhdGFfYWMpIHsNCj4gLQkJcmV0ID0g
b2NmczJfcmVzZXJ2ZV9jbHVzdGVycyhvc2IsIGNsdXN0ZXJzX3RvX21vdmUsIGRhdGFfYWMpOw0K
PiAtCQlpZiAocmV0KSB7DQo+IC0JCQltbG9nX2Vycm5vKHJldCk7DQo+IC0JCQlnb3RvIG91dDsN
Cj4gLQkJfQ0KPiAtCX0NCj4gICANCj4gICAJKmNyZWRpdHMgKz0gb2NmczJfY2FsY19leHRlbmRf
Y3JlZGl0cyhvc2ItPnNiLCBldC0+ZXRfcm9vdF9lbCk7DQo+ICAgDQo+IEBAIC0yODMsNiArMjc2
LDEyIEBAIHN0YXRpYyBpbnQgb2NmczJfZGVmcmFnX2V4dGVudChzdHJ1Y3Qgb2NmczJfbW92ZV9l
eHRlbnRzX2NvbnRleHQgKmNvbnRleHQsDQo+ICAgCQl9DQo+ICAgCX0NCj4gICANCj4gKwlyZXQg
PSBvY2ZzMl9yZXNlcnZlX2NsdXN0ZXJzKG9zYiwgKmxlbiwgJmNvbnRleHQtPmRhdGFfYWMpOw0K
PiArCWlmIChyZXQpIHsNCj4gKwkJbWxvZ19lcnJubyhyZXQpOw0KPiArCQlnb3RvIG91dF91bmxv
Y2tfbXV0ZXg7DQo+ICsJfQ0KPiArDQo+ICAgCWhhbmRsZSA9IG9jZnMyX3N0YXJ0X3RyYW5zKG9z
YiwgY3JlZGl0cyk7DQo+ICAgCWlmIChJU19FUlIoaGFuZGxlKSkgew0KPiAgIAkJcmV0ID0gUFRS
X0VSUihoYW5kbGUpOw0KDQo=
