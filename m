Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61672213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RPjeYTTQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K7nLviO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfBYQpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:45:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25212 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfBYQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551113153; x=1582649153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=midV1/GCA0Ruk7N6bWDHW1NI2Dte844Sb9WHy2gL/D0=;
  b=RPjeYTTQ/9OdR4zmObX6AycWR76pux82FFZcm/+timqmDns5FPcApLeQ
   PPxuXAUFy56KAasygYox2oxvkdQq1xDb0QaRI4mwLltophtho0JK9CZnx
   ny86TGaFP3vciSQJvj5MgUa45eGz4ZesSKQUR/R9uBeIhgCxV1APf7Uep
   Q+m7s6Taepqm3SKfWs9Cw88EmlwTUdJYpTm6BK59PWqz6tXKNp8hqu/jN
   RJDXbPM1Lj8rsh9kpSXEbcSGWGEcRs9S5rrTZz/9CH3gx+a1gXm/sr6Il
   uPIM6s7ekQSNRSp9NuMgzgy83nq0ivWqzgFjl64Wdp2FEVgSVPiu9/sxK
   A==;
X-IronPort-AV: E=Sophos;i="5.58,411,1544457600"; 
   d="scan'208";a="207360685"
Received: from mail-bn3nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.59])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 00:45:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=midV1/GCA0Ruk7N6bWDHW1NI2Dte844Sb9WHy2gL/D0=;
 b=K7nLviO44S33j/NCo/GRxh/mZQFuyX1pdVcQfnM64WRGrWHM269jN2GO0HHdT5IVvP+cHKFtybtUyBYi31ScYsBkteRYHVglz0Y4AWjKCX11exbCFMRm1ec0bJWPdmOWUOD4fcpSCqMNco+K14rdVd3FRCNymjepReoJS1y6yj8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4335.namprd04.prod.outlook.com (52.135.72.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Mon, 25 Feb 2019 16:45:50 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:45:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] mmc: core: Add discard support to sd
Thread-Topic: [PATCH v2 3/3] mmc: core: Add discard support to sd
Thread-Index: AQHUvg8xJYZJmAkJmUuaUqRdwcSwoqXwo8iAgAAr8+A=
Date:   Mon, 25 Feb 2019 16:45:49 +0000
Message-ID: <SN6PR04MB4925410B68CF390757081F6EFC7A0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
 <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
 <CAPDyKFobAAGU+=H1y-nGgQXAbRh7ybQxm0zkdBi_DJqSWRApvg@mail.gmail.com>
In-Reply-To: <CAPDyKFobAAGU+=H1y-nGgQXAbRh7ybQxm0zkdBi_DJqSWRApvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b501e5f4-6b6c-4559-9009-08d69b40b2df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4335;
x-ms-traffictypediagnostic: SN6PR04MB4335:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI0MzM1OzIzOk1ZZ21MZklhREhxdzZBTloxbHgvRWxDNFd2?=
 =?utf-8?B?NmxOOHNFeHBlTFc1THdHbmk1WEw5ekI2Z2pOc3ovejNJZDJiVEVZakNjVVBP?=
 =?utf-8?B?R0h6Tks1U2JGWUpEREJmNVVYb0dmTU5lREJydDNEczZEQ2dBYTJFd0IwRXVD?=
 =?utf-8?B?cnNvMkN0VGRzajgwR3crRG5rWU4zZG50UHpQTm44TGtCNEJOU2x6MlZzbXhp?=
 =?utf-8?B?Z3JHelJuWlMrcFZNVzNXNXN5cmhMNTY2R212RXNLL0d0WVdSQStJMVdMYjlj?=
 =?utf-8?B?Wk9uVFVoR0dZNDR5aDM1dE02b2ljZ1BCakR3V3ljL215YVUyWlNuR1paWVo4?=
 =?utf-8?B?UVVoRnNuRkJ1QlJXdUI4V2U2QTkzZ3hBYjIwbWtZQVdWVStwZnFEbDlQK2No?=
 =?utf-8?B?V2EycHdTejZNN0hEUXl1WFBXc2ZWSUZyanJVYUQzWlMrVTMwZGFkTWhoL0p2?=
 =?utf-8?B?aVZrUnZoQVYxVlJBa2lSK0krbXJBYjA3UVZuSE1vcENFdVlxTjdpNnRRWmpl?=
 =?utf-8?B?aHFXa3JTSFY1SE0xQ1pwaGl1TnliVURVQkwvc2NHaGpmZXErVUUyV0JOWkJL?=
 =?utf-8?B?NEYyTmF3SG5SMWltY1BMejBzYUV5ZU9COTFqVEJEempjWmViV0hWcXlwWTVn?=
 =?utf-8?B?SlNicGRQS0J2YmFYT0ttOTBMSWVIK2VLU2RhZkRxR1VPMXJ3T3NBWS9zQ3RC?=
 =?utf-8?B?QzVuWnJMTlgwQVozWThORmVnaTNEQ3RXZjY2Y2xNN2VuQjh1SGl6UWhQeHFh?=
 =?utf-8?B?MmZlMklFWVpGUnl6d0NXV3F2NEY1dGNTQWlBMU16V2FHdm45dk5UNEVtdmhN?=
 =?utf-8?B?anpHeHhjTHVzR0dlcUR1c3gvRmpRc1h0eUNySXhBVWpTRXpjYnZ0VkVJOEYv?=
 =?utf-8?B?VUZuaHJva1ZzclVQUUY5VThGWE14WENUUEFlUFUwNUsvaWJKQnhKYzVJdzdy?=
 =?utf-8?B?L0ZuY2xpaFh3cVRieVlDYlIzaGxBb3k3RXUvQlQ1SkdIeC81VkNHLzhNMzV6?=
 =?utf-8?B?NG5tRXcvTHdxOXZnUTdXMjBPdEdJc2J3L0xkWG15YlZ6MnpOOXdHNHN6R214?=
 =?utf-8?B?ZTk4d0Z6cE94VmllQWhPbGJneGtsZFNDM2JTaU1zT0xwc0tOSDREV2JDenpR?=
 =?utf-8?B?SzF2U2pkMkpXZGl5enlKa0tEMXdIQUpZRXVYN2JCRkVlZ1VpNnh0WjZRVEJs?=
 =?utf-8?B?T0RNM3lodXJKLzJEWnUzRS9CcXVlOXdQRXRwU3NmdWIvTHhhUUw2TnhKNDhr?=
 =?utf-8?B?RlNmM3FxbVp5MGFVQzkzSzF3b3krT1ZoMURZeFk2bTNLbkIwdXFFQVVOS3or?=
 =?utf-8?B?MnhNeVY4cEZhNllsMXRQejhYc2t1ZGpFa25mbk5mb3VvMTlETDY0cExITmRa?=
 =?utf-8?B?MWYvK1ZBa05wSUp1MjA1UDN0Z3YyeXZwdGkvUHoxa2l5TXl1citQbENRdEMz?=
 =?utf-8?B?MGw3cVhBbVNHQVlvdUo5V1FPWmlodEFSY2hwbG53eXhZM0lteE9kZ1FybjhW?=
 =?utf-8?B?T3dYUmxyNythYXVyUlh2c09VL090MWt1WFUvQUZTMkgrSHNEL2lRYzA0Wndr?=
 =?utf-8?B?aDByazgzNkxwWU52RWpqZGRESXBNZEpJMzBNaGFqM1NXalQ3NkxjRHFtcldG?=
 =?utf-8?B?OEFkK055SVphZ0UxOEFtKzlTMCtOb2FzQVN4OTBUd2R3a1gxTnJhak5jbEFB?=
 =?utf-8?B?djRDUy9TWjNKWHFYYkxlbFV0d3JvVVp4NHg1WVNzenE1blRwZXcwRFY2TGJo?=
 =?utf-8?B?MDk1WkgrN0dUUzlGcGU0dz09?=
x-microsoft-antispam-prvs: <SN6PR04MB43356AB83C39722BF31A91B5FC7A0@SN6PR04MB4335.namprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(54534003)(26005)(186003)(478600001)(14454004)(66066001)(7696005)(99286004)(486006)(11346002)(2906002)(71200400001)(8676002)(86362001)(446003)(14444005)(256004)(72206003)(476003)(229853002)(8936002)(6346003)(55016002)(68736007)(102836004)(6436002)(3846002)(6506007)(76176011)(6116002)(53936002)(316002)(25786009)(7736002)(305945005)(6916009)(105586002)(9686003)(74316002)(4326008)(97736004)(81166006)(71190400001)(81156014)(33656002)(6246003)(52536013)(5660300002)(106356001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4335;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pl458fQMCcKdD4Te4p2c9vI2DFfvszm2LB8RQumO/bmsZ1ogJYxxoRORjQDgGZmzaCaQ0qE7LiI+Vc9NdCHazFJXnoKVKzxV07ZOZk8r2ZxMAju3WwovCsvhj0+xCPC7Mp3yxW/XIg3ZdJBPA6e/uuwrc0zB1YnF3xwV/IIjqQcPxCZ9xa+LC13rwhVkSSsmAXB0gkp+xkqwtwf4DIJBrkh10y5dWHKCDp2li3vJkU51cB+bvEZ5J6GRTJNgi5kc9l3544uwZ7uMsYQIJY1+bTI+E/eG+ALxb9gIF7nX0ZMuRfHb8H2JSvlrMyz7voocs55R1TGiKqTANOFYJcLC8/vDIU047rLF3jFzLdPVvMye5/sE2gaDa3ONxcEG1kshHsHlpVJIZ+jZSdD2wpi+ex/jX1xnTpWwfvjbYZ7/nVA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b501e5f4-6b6c-4559-9009-08d69b40b2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:45:49.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VWxmIGhpLA0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IA0KPiBPbiBXZWQs
IDYgRmViIDIwMTkgYXQgMTI6MjksIEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFNEIHNwZWMgdjUuMSBhZGRzIGRpc2NhcmQgc3VwcG9ydC4gVGhlIGZs
b3dzIGFuZCBjb21tYW5kcyBhcmUgc2ltaWxhciB0bw0KPiA+IG1tYywgc28ganVzdCBzZXQgdGhl
IGRpc2NhcmQgYXJnIGluIENNRDM4Lg0KPiANCj4gU28gdGhpcyBtZWFucyB0aGF0IHdlIGZyb20g
bm93IG9uLCBpZiB0aGUgU0QgY2FyZCBzdXBwb3J0cyBkaXNjYXJkLCB3ZQ0KPiBhcmUgZ29pbmcg
dG8gdXNlIGl0IGluIGZhdm9yIG9mIGVyYXNlLiBUaGlzIGlzIGNvbnNpc3RlbnQgd2l0aCBob3cg
d2UNCj4gdHJlYXQgZU1NQywgc28gSSB0aGluayBpdCBtYWtlcyBzZW5zZS4gQ291bGQgeW91IHBl
cmhhcHMgZm9sZCBpbiBzb21lDQo+IGluZm9ybWF0aW9uIGFib3V0IHRoaXMgaW4gdGhlIGNoYW5n
ZWxvZywgdG8gbWFrZSB0aGlzIGNsZWFyIG9uIHdoYXQNCj4gdGhpcyBjaGFuZ2UgbWVhbnMuDQpE
b25lLg0KDQo+IA0KPiBZb3UgbWF5IGFsc28gd2FudCB0byBleHBsYWluIGEgbGl0dGxlIGJpdCB3
aGF0IHRoZSBkaWZmZXJlbmNlIGlzIGZyb20NCj4gdGhlIFNEIGNhcmQgc3RvcmFnZSBwb2ludCBv
ZiB2aWV3LiBMaWtlIGFmdGVyIGFuIGVyYXNlLCBpdCBlaXRoZXIgMSBvcg0KPiAwcyBvbiB0aGUg
bWVkaWEsIHdoaWxlIGFmdGVyIGEgZGlzY2FyZCBpdCBjYW4gYmUgd2hhdGV2ZXIuDQpEb25lLg0K
DQo+IA0KPiA+DQo+ID4gQWN0dWFsbHksIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2hlY2sgZm9yIHRo
ZSBzcGVjIHZlcnNpb24gbGlrZSB3ZSBhcmUNCj4gPiBkb2luZywgYXMgaXQgaXMgYXNzdXJlZCB0
aGF0IHRoZSByZXNlcnZlZCBiaXRzIGluIGVhcmxpZXIgdmVyc2lvbnMgYXJlDQo+ID4gbnVsbC4g
RG8gdGhhdCBhbnl3YXkgdG8gZG9jdW1lbnQgdGhlIHNwZWMgdmVyc2lvbiB0aGF0IGludHJvZHVj
ZSBpdC4NCj4gDQo+IFRoZSBjaGVjayBpcyBuZWVkZWQgZm9yIG90aGVyIHB1cnBvc2VzLCBzbyBw
bGVhc2UganVzdCBkcm9wIHRoaXMgc3RhdGVtZW50Lg0KRG9uZS4NCg0KPiANCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyB8ICA2ICsrKysrLQ0KPiA+ICBkcml2ZXJzL21t
Yy9jb3JlL3NkLmMgICB8IDEwICsrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9tbWMvc2Qu
aCAgfCAgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+ID4gaW5kZXggZGUwZjFhMS4uNGQ2MmYyOCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvY29yZS5jDQo+ID4gQEAgLTIxNjQsNyArMjE2NCw3IEBAIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgbW1jX2FsaWduX2VyYXNlX3NpemUoc3RydWN0DQo+IG1tY19jYXJkICpjYXJkLA0KPiA+
ICAgKiBAY2FyZDogY2FyZCB0byBlcmFzZQ0KPiA+ICAgKiBAZnJvbTogZmlyc3Qgc2VjdG9yIHRv
IGVyYXNlDQo+ID4gICAqIEBucjogbnVtYmVyIG9mIHNlY3RvcnMgdG8gZXJhc2UNCj4gPiAtICog
QGFyZzogZXJhc2UgY29tbWFuZCBhcmd1bWVudCAoU0Qgc3VwcG9ydHMgb25seSAlU0RfRVJBU0Vf
QVJHKQ0KPiA+ICsgKiBAYXJnOiBlcmFzZSBjb21tYW5kIGFyZ3VtZW50DQo+ID4gICAqDQo+ID4g
ICAqIENhbGxlciBtdXN0IGNsYWltIGhvc3QgYmVmb3JlIGNhbGxpbmcgdGhpcyBmdW5jdGlvbi4N
Cj4gPiAgICovDQo+ID4gQEAgLTIxODEsNiArMjE4MSw5IEBAIGludCBtbWNfZXJhc2Uoc3RydWN0
IG1tY19jYXJkICpjYXJkLCB1bnNpZ25lZA0KPiBpbnQgZnJvbSwgdW5zaWduZWQgaW50IG5yLA0K
PiA+ICAgICAgICAgaWYgKCFjYXJkLT5lcmFzZV9zaXplKQ0KPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4NCj4gPiArICAgICAgIGlmIChtbWNfY2FyZF9zZChjYXJk
KSAmJiBhcmcgPT0gU0RfRElTQ0FSRF9BUkcpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gc2tp
cF9hcmdfdGVzdGluZzsNCj4gPiArDQo+IA0KPiBUaGlzIGlzbid0IGNvbnNpc3RlbnQgd2l0aCB0
aGUgcmVzdCBvZiB0aGUgY29kZSBwYXRoIGluIHRoaXMgZnVuY3Rpb24sDQo+IHBsZWFzZSBhZG9w
dCB0byB0aGF0Lg0KRG9uZS4NCg0KPiANCj4gPiAgICAgICAgIGlmIChtbWNfY2FyZF9zZChjYXJk
KSAmJiBhcmcgIT0gU0RfRVJBU0VfQVJHKQ0KPiANCj4gQ291bGRuJ3QgeW91IGFkZCBhIGNoZWNr
IGZvciAhU0RfRElTQ0FSRF9BUkcgaGVyZSBpbnN0ZWFkPw0KRG9uZS4NCg0KPiANCj4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+DQo+ID4gQEAgLTIyMDAsNiArMjIw
Myw3IEBAIGludCBtbWNfZXJhc2Uoc3RydWN0IG1tY19jYXJkICpjYXJkLCB1bnNpZ25lZA0KPiBp
bnQgZnJvbSwgdW5zaWduZWQgaW50IG5yLA0KPiA+ICAgICAgICAgaWYgKGFyZyA9PSBNTUNfRVJB
U0VfQVJHKQ0KPiA+ICAgICAgICAgICAgICAgICBuciA9IG1tY19hbGlnbl9lcmFzZV9zaXplKGNh
cmQsICZmcm9tLCAmdG8sIG5yKTsNCj4gPg0KPiA+ICtza2lwX2FyZ190ZXN0aW5nOg0KPiA+ICAg
ICAgICAgaWYgKG5yID09IDApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2QuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
c2QuYw0KPiA+IGluZGV4IGMyZGI5NGQuLjJiNGZjMjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tbWMvY29yZS9zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+ID4gQEAg
LTIzMSw2ICsyMzEsOCBAQCBzdGF0aWMgaW50IG1tY19yZWFkX3NzcihzdHJ1Y3QgbW1jX2NhcmQg
KmNhcmQpDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBhdSwgZXMsIGV0LCBlbzsN
Cj4gPiAgICAgICAgIF9fYmUzMiAqcmF3X3NzcjsNCj4gPiArICAgICAgIHUzMiByZXNwWzRdID0g
e307DQo+ID4gKyAgICAgICB1OCBkaXNjYXJkX3N1cHBvcnQ7DQo+ID4gICAgICAgICBpbnQgaTsN
Cj4gPg0KPiA+ICAgICAgICAgaWYgKCEoY2FyZC0+Y3NkLmNtZGNsYXNzICYgQ0NDX0FQUF9TUEVD
KSkgew0KPiA+IEBAIC0yNzYsNyArMjc4LDEzIEBAIHN0YXRpYyBpbnQgbW1jX3JlYWRfc3NyKHN0
cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAg
fQ0KPiA+DQo+ID4gLSAgICAgICBjYXJkLT5lcmFzZV9hcmcgPSBTRF9FUkFTRV9BUkc7DQo+ID4g
KyAgICAgICAvKg0KPiA+ICsgICAgICAgICogc3RhcnRpbmcgU0Q1LjEgZGlzY2FyZCBpcyBzdXBw
b3J0ZWQgaWYgRElTQ0FSRF9TVVBQT1JUIChiMzEzKSBpcw0KPiBzZXQNCj4gPiArICAgICAgICAq
Lw0KPiA+ICsgICAgICAgcmVzcFszXSA9IGNhcmQtPnJhd19zc3JbNl07DQo+ID4gKyAgICAgICBk
aXNjYXJkX3N1cHBvcnQgPSBVTlNUVUZGX0JJVFMocmVzcCwgMzEzIC0gMjg4LCAxKTsNCj4gDQo+
IENvdWxkbid0IHlvdSBqdXN0IHJlcGxhY2UgdGhpcyB3aXRoICJkaXNjYXJkX3N1cHBvcnQgPQ0K
PiBVTlNUVUZGX0JJVFMoY2FyZC0+cmF3X3NzciwgMzEzIC0gMjU2LCAxKTsiID8NClNEIHN0YXR1
cyByZWdpc3RlciBpcyAgdHJhbnNtaXR0ZWQgZnJvbSA1MTJiaXQgb253YXJkcy4gDQpUaGUgNTEy
dGggYml0IGlzIHRoZSBvbmUgdHJhbnNtaXR0ZWQgZmlyc3QgYW5kIHNvIG9uLiANClNvIHRoZSAz
MTN0aCBiaXQgaGFzIHRvIGJlIGNoZWNrZWQgYXQgYnl0ZSBvZmZzZXQgMHgxOCBpbiB3aGljaCBi
b3RoIGRpc2NhcmQgYW5kIEZVTEUgd2VyZSBlbmFibGVkLg0KQnl0ZSBvZmZzZXQgMHgxOCBtZWFu
cyBkd29yZCBvZmZzZXQgNiwgYW5kIFVOU1RVRkZfQklUUyBhY2NvdW50cyBmb3IgNCBkd29yZHMg
b25seS4NClVzaW5nIFVOU1RVRkZfQklUUyhjYXJkLT5yYXdfc3NyLC4uLi4pIHlvdSBjYW4gb25s
eSBhY2Nlc3MgYml0cyA1MTEuLjM4MywgYnV0IG5vdCAzMTMuDQoNCj4gDQo+ID4gKyAgICAgICBj
YXJkLT5lcmFzZV9hcmcgPSAoY2FyZC0+c2NyLnNkYV9zcGVjeCAmJiBkaXNjYXJkX3N1cHBvcnQp
ID8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RfRElTQ0FSRF9BUkcgOiBTRF9F
UkFTRV9BUkc7DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL3NkLmggYi9pbmNsdWRlL2xpbnV4L21tYy9zZC5oDQo+
ID4gaW5kZXggMWE2ZDEwZi4uZWM5NGE1YSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L21tYy9zZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvc2QuaA0KPiA+IEBAIC05NSw1
ICs5NSw2IEBADQo+ID4gICAqIEVyYXNlL2Rpc2NhcmQNCj4gPiAgICovDQo+ID4gICNkZWZpbmUg
U0RfRVJBU0VfQVJHICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDANCj4gPiArI2RlZmluZSBT
RF9ESVNDQVJEX0FSRyAgICAgICAgICAgICAgICAgMHgwMDAwMDAwMQ0KPiA+DQo+ID4gICNlbmRp
ZiAvKiBMSU5VWF9NTUNfU0RfSCAqLw0KPiA+IC0tDQo+ID4gMS45LjENCj4gPg0KPiANCj4gQmVz
aWRlcyB0aGUgYWJvdmUgY2hhbmdlcywgdGhlcmUgaXMgbW9yZSBpbXBvcnRhbnQgdGhpbmcgSSB0
aGluayB5b3UNCj4gaGF2ZSBsZWZ0IG91dCB0byBjb25zaWRlci4gV2l0aCBkaXNjYXJkIHRoZSBv
cGVyYXRpb24gc2hvdWxkIGJlDQo+IGNvbXBsZXRlZCBieSB0aGUgY2FyZCB3aXRoaW4gMjUwbXMs
IHdoaWxlIGZvciBlcmFzZSB0aGUgdGltZW91dA0KPiBkZXBlbmRzIG9uIHRoZSBudW1iZXIgb2Yg
YmxvY2tzIHRvIGJlIGVyYXNlZC4gSSBhbSBmaW5lIGlmIHdlIGFkZHJlc3MNCj4gdGhhdCBvbiB0
b3AgdGhpcyBjaGFuZ2UgdGhvdWdoLCBqdXN0IHdhbnQgdG8gcG9pbnQgaXQgb3V0IHNvIHdlIGRv
bid0DQo+IGZvcmdldCBpdC4NCkRvbmUuDQpXaWxsIGFkZCBhbm90aGVyIHBhdGNoIHRvIGFjY291
bnQgZm9yIHRoYXQuDQoNCg0KVGhhbmtzIGEgbG90LA0KQXZyaQ0KPiANCj4gS2luZCByZWdhcmRz
DQo+IFVmZmUNCg==
