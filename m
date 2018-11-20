Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71806C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QmAWin4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeKTT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:26:46 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:25010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeKTT0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdGA9XOO0xNqyO+ScxKn/jIbTgqEgUSSLK2l32wklOg=;
 b=QmAWin4tE4/41geHZht7l8A/mk1BNTNHr1Lv6zF+CYLCc+jsR+I0nWYeDzAIGRSecHY9sYNDVpsKPWWqdseyOkTo8Pu4cBgD7wX8XXf9W9Gp7vdM4EmwJZ98cRqTfdJpmdFlsqznQvxzDCw87qBjIQi5/3P4Jg6FpEj77Z2Gp4E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3932.eurprd04.prod.outlook.com (52.134.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Tue, 20 Nov 2018 08:58:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 08:58:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUa2Ref+fMFTxEzkOrPUZd06/1XqVYg7oAgAAAdNCAAAJUgIAAAGJw
Date:   Tue, 20 Nov 2018 08:58:39 +0000
Message-ID: <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
 <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
In-Reply-To: <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3932;6:wLJgbRn6wt0AhqfxyEE2ei3ioASk7OCJdwG081py/Wk91CtGh4jMKHRHFpOMnJFaQIfEwJhCtCzPFD8iIbN2NTCpQ1pIX066dQiBWzVjoYzpxsSeiA0jXYJ/f+3Gae9pcuOWXQQdk/n47PBUNWAnkVHZfVaS7rxQERImxbI3FHJGa6Ui5fARxtlFjvZSS9uxAwYEtVZJyaS0F/lTFfJnIqkuAclGPLl8k8vFlEyMz1Mur+F05pH9tvvKGOgO/ZsZLz6HuE6qBkG3bqPL8c7Q1fFFHhlHyhQJbJzuoCHrDteDHduokSe6WXgdTSlKTlxSWZ3c50kQ9a9flSWTaBFTunsA9XxKVjxZAf4fi63DFeI2qNUUREAQdNYmmFuW/zuLcAliKrbg0Wud3D7BSk3wQebutHByb9Cnphd04U4xACqEwplCFs/Cu6OOKNYQAOd/c2Xb+DRwGlEj33vnzk6GVg==;5:eKF1s2uXeXkM+bRpHiXZbb5rzBXFGXbX5DRyPgbTtuFerUkx2z7l1ElCTHWdQRjob4LgkGHcihZyhbVkNgr9m5FmB7qbZ/AaJ4VFupYMTHAHaWiIl+rOvt9oMsbZOtqIvrf+dd/iLIwR57qecqSUiU6TWtaO/MiV9DjUc2peaH0=;7:qhp5Y1vE8An2kzOkUXghINFQEmYt4Vuux9zF36810EwH8PD29eLYDsc3dNUaPPeof6R8DIj7gLIZ1OiwFuRw1vKpX8RdnqzhDtgrtUchinWLhb2pBNBY2crbGWAsUldkABJqjHyzpTDGXi94azx7NQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9e504140-9b85-49e0-df87-08d64ec65d74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3932;
x-ms-traffictypediagnostic: DB3PR0402MB3932:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3932B6C99AA27E97BBB262CDF5D90@DB3PR0402MB3932.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3932;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3932;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(13464003)(7736002)(5660300001)(74316002)(305945005)(2900100001)(106356001)(105586002)(81166006)(110136005)(55016002)(33656002)(2201001)(86362001)(9686003)(81156014)(53936002)(6306002)(39060400002)(575784001)(229853002)(8676002)(68736007)(8936002)(6436002)(6246003)(4326008)(2501003)(97736004)(2906002)(71200400001)(71190400001)(93886005)(14454004)(76176011)(6506007)(53546011)(478600001)(26005)(3846002)(102836004)(186003)(316002)(99286004)(44832011)(11346002)(256004)(446003)(476003)(486006)(25786009)(7696005)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3932;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DDXi5EROt23IyGTnJxFn0XfAfP4pY/MTNFxV+t7wRcff9vZcjirAs0yNZURIR75xJvF+Dl8gbwhatXK7oi7vfu4DFtGi7/KWeb4Su5Qakmsg2j+e3g/XlM/XJ14W8oyMihD3th5gxecoK3TAqsWtYsuxft+yeni3vdzGL+VcjwnCDDj+1NGS59hFVG4AVCZKp6txxGJqHc5XyZv5A+HCy38dQ25cTVKiniy9jsq/0xlpA21CyR5TR7mgg8QwYP+2arhAAwo2kfAO25CDlir5NwAYWUFmhh1yQncIOs4jBBw7gMP2M08Yy8mdChF1v1NW8a0r0VyU77cC0zVby0rauZ7igeMxTspeKtHvbix1gdw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e504140-9b85-49e0-df87-08d64ec65d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 08:58:39.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIFttYWlsdG86ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZ10NCj4gU2VudDogMjAxOOW5tDEx5pyIMjDml6UgMTY6NTQNCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcnVpLnpoYW5nQGludGVsLmNvbTsN
Cj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0aGVybWFsOiBpbXg6IGZpeCBmb3IgZGVw
ZW5kZW5jeSBvbiBjcHUtZnJlcQ0KPiANCj4gT24gMjAvMTEvMjAxOCAwOTo0NywgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gSGksIERhbmllbA0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+IEFu
c29uIEh1YW5nDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogRGFuaWVsIExlemNhbm8gW21haWx0bzpkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnXQ0KPiA+
PiBTZW50OiAyMDE45bm0MTHmnIgyMOaXpSAxNjo0NQ0KPiA+PiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+OyBydWkuemhhbmdAaW50ZWwuY29tOw0KPiA+PiBlZHViZXp2YWxA
Z21haWwuY29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDogZml4IGZvciBkZXBlbmRl
bmN5IG9uIGNwdS1mcmVxDQo+ID4+DQo+ID4+IE9uIDI0LzEwLzIwMTggMDg6MzksIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+Pj4gVGhlIHRoZXJtYWwgZHJpdmVyIGlzIGEgc3RhbmRhbG9uZSBkcml2
ZXIgZm9yIG1vbml0b3JpbmcgU29DDQo+ID4+PiB0ZW1wZXJhdHVyZSBieSBlbmFibGluZyB0aGVy
bWFsIHNlbnNvciwgc28gaXQgY2FuIGJlIGVuYWJsZWQgZXZlbg0KPiA+Pj4gd2hlbiBDT05GSUdf
Q1BVX0ZSRVEgaXMgTk9UIHNldC4gU28gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IHdpdGgNCj4gPj4g
Q1BVX1RIRVJNQUwuDQo+ID4+Pg0KPiA+Pj4gQWRkIENPTkZJR19DUFVfRlJFUSBjaGVjayBmb3Ig
Y3B1LWZyZXEgcmVsYXRlZCBvcGVyYXRpb24gaW4gdGhlcm1hbA0KPiA+Pj4gZHJpdmVyIHRvIG1h
a2UgdGhlcm1hbCBkcml2ZXIgcHJvYmUgc3VjY2Vzc2Z1bGx5IHdoZW4NCj4gPj4+IENPTkZJR19D
UFVfRlJFUSBpcyBOT1Qgc2V0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+DQo+ID4+IFdoeSBub3Qg
c2ltcGx5IGtpbGwgdGhpcyBsZWdhY3kgY29kZSA/DQo+ID4NCj4gPiBCZWNhdXNlIGtpbGxpbmcg
bGVnYWN5IGNvZGUgd2lsbCBoYXZlIG9sZCBkdGIgY29tcGF0aWJsZSBpc3N1ZSwgb2xkDQo+ID4g
ZHRiIHdpbGwgTk9UIGhhdmUgY3B1ZnJlcSBjb29saW5nIGZ1bmN0aW9uLg0KPiANCj4gWWVhaCwg
SSBpbWFnaW5lIHRoYXQgaXMgdGhlIHJlYXNvbiB3aHkgeW91IHdhbnQgdG8ga2VlcCB0aGUgbGVn
YWN5IGNvZGUgYnV0IGRvDQo+IHlvdSByZWFsbHkgY2FyZSBhYm91dCBvbGQgRFRCIGJhc2VkIGJv
YXJkcz8gQXJlIHRoZXkgc3RpbGwgdXBkYXRlZCB3aXRoIG5ld2VyDQo+ICp1cHN0cmVhbSB2YW5p
bGxhKiBrZXJuZWxzPw0KDQpJIGFtIE5PVCBzdXJlIGlmIHRoZXJlIGlzIHNvbWVvbmUgY2FyZSBh
Ym91dCBpdCwgYnV0IEkgZGlkIHJlY2VpdmUgbWFueSBjb21tZW50cw0KYWJvdXQgb2xkIGR0YiBj
b21wYXRpYmxlIHdoZW4gSSBzZW50IG91dCBvdGhlciBwYXRjaGVzLCBzbyBpcyBpdCBhIHNvbGlk
IHJlcXVpcmVtZW50DQpvZiBvbGQgZHRiIGNvbXBhdGlibGUgd2hlbiBkb2luZyB1cHN0cmVhbSwg
b3IgZWFjaCBzdWItc3lzdGVtIG9yIG1haW50YWluZXIgaGFzDQpkaWZmZXJlbnQgcmVxdWlyZW1l
bnQgYWJvdXQgaXQ/IEFjdHVhbGx5IEkgYW0gaGFwcHkgdG8ganVzdCByZW1vdmUgdGhlIGxlZ2Fj
eQ0KY29kZSwgYmVjYXVzZSBpdCBtYWtlcyB0aGUgY29kZSBtb3JlIGNsZWFuIGFuZCBlYXN5IHJl
YWRpbmcuIFdobyBjYW4gbWFrZSB0aGUNCmRlY2lzaW9uPw0KDQpBbnNvbi4NCg0KPiANCj4gDQo+
IC0tDQo+IA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+IC5saW5hcm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdD
MDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0NiYjhjZGQNCj4gNDE1NWZiNGMwMmRhYjMwOGQ2
NGVjNWM5Y2QlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3DQo+IEMwJTdDMCU3
QzYzNjc4MzAwODczOTM3MzUzNyZhbXA7c2RhdGE9eDZxSERURlliM1NOQVJJQ3MxNUtrTEw3DQo+
ICUyRnBwN2VuWVprWkpIUm9Ka3NYcyUzRCZhbXA7cmVzZXJ2ZWQ9MD4gTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2UNCj4gc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBGb2xsb3cgTGluYXJv
Og0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGd3d3DQo+IC5mYWNlYm9vay5jb20lMkZwYWdlcyUyRkxpbmFybyZhbXA7
ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDANCj4gbnhwLmNvbSU3Q2JiOGNkZDQxNTVmYjRj
MDJkYWIzMDhkNjRlYzVjOWNkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5DQo+IDJjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzY3ODMwMDg3MzkzNzM1MzcmYW1wO3NkYXRhPUpKNEg5WjANCj4gUkFZJTJG
MXVMbGNLWE5RTjM2TDBBcEZJd005JTJGdVBPVTlVQlVjSSUzRCZhbXA7cmVzZXJ2ZWQ9MD4NCj4g
RmFjZWJvb2sgfA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGdHdpdHQNCj4gZXIuY29tJTJGJTIzISUyRmxpbmFyb29y
ZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuYw0KPiBvbSU3Q2JiOGNkZDQx
NTVmYjRjMDJkYWIzMDhkNjRlYzVjOWNkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOQ0KPiA5YzVj
MzAxNjM1JTdDMCU3QzAlN0M2MzY3ODMwMDg3MzkzNzM1MzcmYW1wO3NkYXRhPW8wbzdoOEdZQUx0
DQo+IG82TnV1SSUyQkF4Rnp4NnJjcjNWRmc2Q1d3aDNmZUdnZ0klM0QmYW1wO3Jlc2VydmVkPTA+
IFR3aXR0ZXIgfA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+IC5saW5hcm8ub3JnJTJGbGluYXJvLWJsb2cl
MkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4gb20lN0NiYjhjZGQ0
MTU1ZmI0YzAyZGFiMzA4ZDY0ZWM1YzljZCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDkNCj4gOWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzgzMDA4NzM5MzczNTM3JmFtcDtzZGF0YT02cjJiYUI1Wmlt
Qw0KPiB6SkVrcktUdkNCSDk4JTJCQmxudzBaSGlZT2RHNUpsaW1BJTNEJmFtcDtyZXNlcnZlZD0w
PiBCbG9nDQoNCg==
