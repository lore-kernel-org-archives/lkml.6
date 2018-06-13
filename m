Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBAB5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A83E2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N8d0U1eg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nM+TsL94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A83E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935241AbeFMKMX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:12:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55414 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935009AbeFMKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528884740; x=1560420740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kle0MxA0HtbqySnJsF4/67idWtniSq6Mer2hVHtUOXM=;
  b=N8d0U1egCPO4m92iOJ0mUPAwoeMU+73+Vn21ae7MWR1MEH/qsUkT9hGA
   yenKAAb+XR8lfxSzrkqe2mmgwUU/kvdEKxsea2vIMolgZN1M8btNHaAt9
   7LE6OWTeqWXiOz1R4Ispwvf8tbC9scbarzUQHnSYudqdoZ/HApHYbiPUe
   4TxU5+PIa3/yIW18EX2n8U9ZsjKZcs2BzEoGdEuUqb9zhrFnyNtfO+VL/
   7hKPEmb76PxmI5nO7d/dc5OXhH+RXAbuwYehAEIxnsUxqH0JRHNLuc2ec
   j7M2/BsavEFFbwCke0224VmvTLBfURHLDz7ZWSOsmqGOdbXcSHSzcBUDd
   w==;
X-IronPort-AV: E=Sophos;i="5.51,218,1526313600"; 
   d="scan'208";a="82390912"
Received: from mail-dm3nam03lp0017.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.17])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 18:12:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kle0MxA0HtbqySnJsF4/67idWtniSq6Mer2hVHtUOXM=;
 b=nM+TsL94x7hYXIMy6vlnxEDQPl0UQ/tAHaAPGu7XPuofByUQoapffYuEM/2khx/L1ecT9S9loKnrr9kOuZHqcdNErRncLuQhiwuRppBAU4dkaHyYoKxRU2DkPIeryazghaN0PzXp9NrFeC4G3cX6BmOkJdvdCc5ozxnvpBv9n0o=
Received: from MWHPR04MB1137.namprd04.prod.outlook.com (10.173.51.151) by
 MWHPR04MB1166.namprd04.prod.outlook.com (10.173.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Wed, 13 Jun 2018 10:12:12 +0000
Received: from MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::b928:3117:cd49:eae]) by MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::b928:3117:cd49:eae%2]) with mapi id 15.20.0863.016; Wed, 13 Jun 2018
 10:12:12 +0000
From:   Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To:     Evan Green <evgreen@chromium.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Topic: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Index: AQHT93lpGmTFqrK/4k6nSxRetFdr1aRJmw1AgAHj/gCAAtT7sIAB5jsAgAYf3wCAAuSwoIAD3UsAgADusvA=
Date:   Wed, 13 Jun 2018 10:12:12 +0000
Message-ID: <MWHPR04MB1137E1BB83293DE6B44ACCE39A7E0@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
 <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
 <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
 <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com>
 <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
In-Reply-To: <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1166;7:enEPci86LHtWAe6NDmtdFAZaPW7qK1Ci7LODSxAiTtBJcdZWxhpy6dcGiVPfKy2qqztB9KSeXIUqrvszzZ95LAtx+n7Dj8+rCrhSv933SCR49CpsAyIc8J77MuFRvqcrKOlq66DtK6LEKYdCmwqi/R3KeKRD+SL4DAXNFcQ2JlfM327NRlpsQJctXO7+3j2Xbr/G7Rj3QPCXRb/y/Ga8kllvo8LPA8JwGuXEDrZJYOAk1RwpK17vT/DAfNyFVs+3;20:KnA0CSoa4RVrvkPBjWOq3+h2SkltxWDR1aRsthvW8Mua71+zyj8ahVp4Xa+4jxuWRAQ0k6M94XHeLHTRhgzVRpAyUUCfPgIqlKeRWFx68slihaVlOl7Jr6PIBmOrwYZZSKdrJFGeXb16Zu9rVxfqLKSr+RuPM/jKSy8ALI2nSfw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 228137ff-7b4c-46a3-c5b4-08d5d11621bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1166;
x-ms-traffictypediagnostic: MWHPR04MB1166:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB116652A7A3FFD1F75D2529A19A7E0@MWHPR04MB1166.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1166;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(199004)(189003)(13464003)(7696005)(2900100001)(76176011)(6506007)(59450400001)(102836004)(478600001)(53546011)(106356001)(186003)(5890100001)(26005)(5250100002)(486006)(476003)(446003)(11346002)(9686003)(53936002)(6916009)(14454004)(72206003)(5660300001)(6246003)(3660700001)(99286004)(66066001)(93886005)(33656002)(54906003)(8676002)(316002)(97736004)(81156014)(3280700002)(81166006)(86362001)(39060400002)(105586002)(2906002)(4326008)(305945005)(7736002)(8936002)(229853002)(25786009)(6436002)(3846002)(6116002)(55016002)(74316002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1166;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y6rAv9FYHJVL0AVq0sN+13hWo4lz1QjUGBbuqoxQ2qIdCpUlkay5UZwCzVxWuu94VU/CoKcwm/PfjTavYZKy15KBmY6hzPYZIwaX9+/gDAgmQ8ayzXp71VbV7OZMGpXZ8td9raKQtYdT94TuCoGLSqYbnkLu1In21nGY5iMJr0gyBQvGWV3A93VlOjI9jyCC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228137ff-7b4c-46a3-c5b4-08d5d11621bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 10:12:12.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtc2NzaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXNjc2ktb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgRXZhbiBHcmVlbg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDEyLCAyMDE4IDEwOjQz
IFBNDQo+IFRvOiBTdGFuaXNsYXYgTmlqbmlrb3YgPFN0YW5pc2xhdi5OaWpuaWtvdkB3ZGMuY29t
Pg0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IFZpbmF5YWsgSG9saWthdHRpIDx2aW5o
b2xpa2F0dGlAZ21haWwuY29tPjsgamVqYkBsaW51eC52bmV0LmlibS5jb207IG1hcnRpbi5wZXRl
cnNlbkBvcmFjbGUuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1z
Y3NpQHZnZXIua2VybmVsLm9yZzsgR3dlbmRhbCBHcmlnbm91IDxnd2VuZGFsQGNocm9taXVtLm9y
Zz47IEFsZXggTGVtYmVyZw0KPiA8QWxleC5MZW1iZXJnQHdkYy5jb20+OyBBdnJpIEFsdG1hbiA8
QXZyaS5BbHRtYW5Ad2RjLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzddIEVuYWJsZSBV
RlMgcHJvdmlzaW9uaW5nIHZpYSBMaW51eA0KPiANCj4gT24gU3VuLCBKdW4gMTAsIDIwMTggYXQg
MjozMSBBTSBTdGFuaXNsYXYgTmlqbmlrb3YNCj4gPFN0YW5pc2xhdi5OaWpuaWtvdkB3ZGMuY29t
PiB3cm90ZToNCj4gPg0KPiA+IEhpIEFkcmlhbiwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBKdW5lIDgsIDIwMTggMzozMSBQTQ0KPiA+ID4g
VG86IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPjsgU3RhbmlzbGF2IE5pam5pa292
IDxTdGFuaXNsYXYuTmlqbmlrb3ZAd2RjLmNvbT4NCj4gPiA+IENjOiBWaW5heWFrIEhvbGlrYXR0
aSA8dmluaG9saWthdHRpQGdtYWlsLmNvbT47IGplamJAbGludXgudm5ldC5pYm0uY29tOyBtYXJ0
aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgR3dlbmRhbCBHcmlnbm91IDxnd2VuZGFs
QGNocm9taXVtLm9yZz47IEFsZXggTGVtYmVyZw0KPiA+ID4gPEFsZXguTGVtYmVyZ0B3ZGMuY29t
PjsgQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIDAvN10gRW5hYmxlIFVGUyBwcm92aXNpb25pbmcgdmlhIExpbnV4DQo+ID4gPg0KPiA+
ID4gT24gMDQvMDYvMTggMTc6NTksIEV2YW4gR3JlZW4gd3JvdGU6DQo+ID4gPiA+IE9uIFN1biwg
SnVuIDMsIDIwMTggYXQgMzoyMSBBTSBTdGFuaXNsYXYgTmlqbmlrb3YNCj4gPiA+ID4gPFN0YW5p
c2xhdi5OaWpuaWtvdkB3ZGMuY29tPiB3cm90ZToNCj4gPiA+ID4+DQo+ID4gPiA+Pg0KPiA+ID4g
Pj4NCj4gPiA+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPj4+IEZyb206
IGxpbnV4LXNjc2ktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1zY3NpLW93bmVyQHZnZXIu
a2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEV2YW4gR3JlZW4NCj4gPiA+ID4+PiBTZW50OiBGcmlk
YXksIEp1bmUgMSwgMjAxOCA1OjQ0IFBNDQo+ID4gPiA+Pj4gVG86IFN0YW5pc2xhdiBOaWpuaWtv
diA8U3RhbmlzbGF2Lk5pam5pa292QHdkYy5jb20+DQo+ID4gPiA+Pj4gQ2M6IFZpbmF5YWsgSG9s
aWthdHRpIDx2aW5ob2xpa2F0dGlAZ21haWwuY29tPjsgamVqYkBsaW51eC52bmV0LmlibS5jb207
IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaW51eC0NCj4gPiA+ID4+PiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgR3dlbmRhbCBHcmlnbm91
IDxnd2VuZGFsQGNocm9taXVtLm9yZz47IEFsZXggTGVtYmVyZw0KPiA+ID4gPj4+IDxBbGV4Lkxl
bWJlcmdAd2RjLmNvbT47IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3ZGMuY29tPg0KPiA+ID4g
Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC83XSBFbmFibGUgVUZTIHByb3Zpc2lvbmluZyB2aWEg
TGludXgNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IEhpIFN0YW5pc2xhdi4gVGhhbmtzIGZvciB0YWtp
bmcgYSBsb29rLiBSZXNwb25zZXMgYmVsb3cuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBPbiBUaHUs
IE1heSAzMSwgMjAxOCBhdCAzOjA0IEFNIFN0YW5pc2xhdiBOaWpuaWtvdg0KPiA+ID4gPj4+IDxT
dGFuaXNsYXYuTmlqbmlrb3ZAd2RjLmNvbT4gd3JvdGU6DQo+ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+
IEhpIEV2YW4sDQo+ID4gPiA+Pj4+IEkgaGF2ZSBzb21lIGdlbmVyaWMgbm90ZXM6DQo+ID4gPiA+
Pj4+IC0gV2h5IHRvIGNyZWF0ZSBuZXcgc3lzZnMgZW50cmllcyBmb3IgdGhlIGNvbmZpZ3VyYXRp
b24gZGVzY3JpcHRvciBmaWVsZHMgaWYgdGhleSBhcmUganVzdCBkdXBsaWNhdGlvbiBvZiBmaWVs
ZHMgaW4gdGhlIGRldmljZSBhbmQNCj4gdW5pdA0KPiA+ID4gPj4+IGRlc2NyaXB0b3JzPyBBbmQg
dGhlIHN5c2ZzIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBkZXZpY2UgYW5kIHVuaXQgZGVzY3JpcHRv
cnMgaXMgZXhpc3RpbmcgYWxyZWFkeS4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IFdlbGwsIFVGUyBk
ZXNjcmliZXMgdGhlbSBhcyBkaWZmZXJlbnQgZGVzY3JpcHRvcnMuIEkgd29ycnkgdGhhdCBpZiBJ
DQo+ID4gPiA+Pj4gYWRkIGEgYnVuY2ggb2YgY2xldmVyIGxvZ2ljIHRvIGhpZGUgdGhlIGNvbmZp
ZyBkZXNjcmlwdG9yIGJlaGluZCBvdGhlcg0KPiA+ID4gPj4+IGRlc2NyaXB0b3JzLCB0aGVyZSBt
aWdodCBiZSB0cm91YmxlIGxhdGVyIGlmIDEpIHRoZXJlIGlzIGEgcXVpcmt5DQo+ID4gPiA+Pj4g
ZGV2aWNlIHRoYXQgZG9lc24ndCByZWZsZWN0IHRoZSB2YWx1ZXMgYmV0d2VlbiBkZXNjcmlwdG9y
cyBxdWl0ZSB0aGUNCj4gPiA+ID4+PiBzYW1lIHdheSBvciBhdCB0aGUgc2FtZSB0aW1lLCBvciAy
KSBpZiBhIGxhdGVyIFVGUyBzcGVjIGFkZHMgbW9yZQ0KPiA+ID4gPj4+IGNvbmZpZ3VyYXRpb24g
ZGVzY3JpcHRvciBmaWVsZHMgdGhhdCBkb24ndCBleGFjdGx5IHJlZmxlY3QgaW50byBvdGhlcg0K
PiA+ID4gPj4+IG5vbi1jb25maWcgZGVzY3JpcHRvcnMsIHRoZSBjbGV2ZXJuZXNzIHdpbGwgbG9v
ayBhd2t3YXJkLg0KPiA+ID4gPj4NCj4gPiA+ID4+IE5vIGFkZGl0aW9uYWwgbG9naWMgd2lsbCBi
ZSByZXF1aXJlZCB0byBhdHRhY2ggd3JpdGUgZnVuY3Rpb25hbGl0eSB0byB0aGUNCj4gPiA+ID4+
IGV4aXN0aW5nIGVudHJpZXMgaW5zdGVhZCBvZiBuZXcgZGVmaW5lZCBvbmVzLiBJdCB3aWxsIHJl
ZHVjZSB0aGUgcGF0Y2gNCj4gPiA+ID4+IHNpemUgc2lnbmlmaWNhbnRseS4gQW5kIHRoZXJlIHdp
bGwgYmUgbm8gbmVlZCBmb3IgdGhlIHVuaXQgc2VsZWN0b3INCj4gPiA+ID4+IG1lY2hhbmlzbSB3
aGljaCBJJ20gbm90IHN1cmUgd2lsbCBiZSBhY2NlcHRlZCBieSB0aGUgU0NTSSBjb21tdW5pdHku
DQo+ID4gPiA+Pg0KPiA+ID4gPg0KPiA+ID4gPiBTbyB0aGlzIHdvdWxkIGJlIG1vZGlmeWluZyB0
aGUgZXhpc3Rpbmcgc3lzZnMgZW50cmllcyBzbyB0aGF0IHJlYWRzDQo+ID4gPiA+IHN0aWxsIGNv
bWUgZnJvbSB0aGUgZGV2aWNlIGFuZCB1bml0IGRlc2NyaXB0b3JzLCBidXQgd3JpdGVzIGdvIHRv
DQo+ID4gPiA+IGVxdWl2YWxlbnQgZmllbGRzIGluIHRoZSBjb25maWcgZGVzY3JpcHRvcj8gSSBj
YW4gZXhwbG9yZSB0aGF0DQo+ID4gPiA+IGFwcHJvYWNoLiBBbHRlcm5hdGl2ZWx5LCBpZiB0aGUg
dW5pdCBzZWxlY3RvciBtZWNoYW5pc20gaXMgbm90DQo+ID4gPiA+IGRlc2lyZWQsIEkgY291bGQg
ZHluYW1pY2FsbHkgY3JlYXRlIHN5c2ZzIGRpcmVjdG9yaWVzIGZvciBlYWNoIHVuaXQgaW4NCj4g
PiA+ID4gdGhlIGNvbmZpZyBkZXNjcmlwdG9yLCBidXQgc3RpbGwgYnJpbmcgb3V0IHRoZSBjb25m
aWcgZGVzY3JpcHRvcg0KPiA+ID4gPiB2YWx1ZXMgYXMgc2VwYXJhdGUgZW50cmllcy4gKEkgc3Rp
bGwgd29ycnkgYSBiaXQgYWJvdXQgc21hc2hpbmcgdGhlDQo+ID4gPiA+IGRlc2NyaXB0b3JzIHRv
Z2V0aGVyIGFzIHRoZSBVRlMgc3BlYyBjYWxsZWQgdGhlbSBvdXQgYXMgZGlmZmVyZW50KS4NCj4g
PiA+DQo+ID4gPiBJZiB5b3UgdXNlIHRoZSB1bml0IGF0dHJpYnV0ZXMsIGhvdyBkbyB5b3UgY29u
ZmlndXJlIHVuaXRzIHRoYXQgZG8gbm90IHlldA0KPiA+ID4gZXhpc3Q/DQo+ID4NCj4gPiBGb3Ig
ZXhhbXBsZSBieSBhZGRpbmcgdGhlIGVuYWJsZV9sdW4gd3JpdGVhYmxlIHN5c2ZzIGVudHJ5LiBJ
IHRoaW5rIGJvdGggd2F5cyBhcmUNCj4gPiB2aWFibGUgYW5kIHRoZXJlIGFyZSBzZXZlcmFsIHBp
dGZhbGxzIGluIGVhY2ggb2YgdGhlbS4gTm93IGl0J3MgdXAgdG8gRXZhbiB0byBkZWNpZGUNCj4g
PiBob3cgdG8gaW1wbGVtZW50IHRoaXMuDQo+ID4NCj4gPiA+DQo+ID4gPiBQZXJoYXBzIGl0IGlz
IGJldHRlciB0byByZXByZXNlbnQgdGhlIGNvbmZpZ3VyYXRpb24gZGVzY3JpcHRvcnMgZXhhY3Rs
eSBhcw0KPiA+ID4gdGhleSBhcmUgZGVmaW5lZCBpbiB0aGUgc3BlY2lmaWNhdGlvbi4gIFByb2Jh
Ymx5IG5vdCB3b3J0aCBleHBvc2luZyB0aGVtIGF0DQo+ID4gPiBhbGwgaWYgdGhlIGNvbmZpZ3Vy
YXRpb24gaXMgbG9ja2VkIChhdHRyaWJ1dGUgYkNvbmZpZ0Rlc2NyTG9jayA9PSAxKS4NCj4gPiA+
DQo+ID4gPiBOb3RlIGFsc28gdGhhdCB0aGUgMi4xIHNwZWMuIGRlZmluZXMgIGJDb25mRGVzY0Nv
bnRpbnVlIHdoaWNoIGFsbG93cyB1cGRhdGVzDQo+ID4gPiB0byBiZSBncm91cGVkIGFuZCBjb21t
aXR0ZWQgdG9nZXRoZXIuDQo+ID4NCj4gPiBUaGUgb25seSBxdWVzdGlvbiBpcyBob3cgbWFueSBk
ZXZpY2VzIGFyZSByZWFkeSB0byBnZXQgZG96ZW5zIG9mIGNvbmZpZ3VyYXRpb24NCj4gPiBkZXNj
cmlwdG9ycyByZWxhdGVkIHRvIGZpcnN0IGVpZ2h0IExVTnMgaW5zdGVhZCBqdXN0IG9uZSB3aGVu
IHRoaXMgbG9jayBpcyBlbmFibGVkLg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IFN0YW5pc2xhdg0K
PiANCj4gQWN0dWFsbHkgSSBjb3VsZCB1c2Ugc29tZSBhZHZpY2Ugb24gdGhpcy4gSXQgc2VlbXMg
bGlrZSBmb2xrcyBhcmUNCj4gb3Bwb3NlZCB0byB0aGUgaWRlYSBvZiBoYXZpbmcgYSBjZmdfdW5p
dCBmaWxlLCB3aG9zZSB2YWx1ZSBkZXRlcm1pbmVzDQo+IHdoaWNoIGluZGV4IHRvIHRhbGsgdG8g
aW4gdGhlIHVuaXRfKiBmaWxlcy4gKEkgcGVyc29uYWxseSBsaWtlZCB0aGF0DQo+IGFwcHJvYWNo
LCBhcyBpdCB3YXMgc2ltcGxlLCBoYXMgcHJlY2VkZW5jZSwgYW5kIGZpdCB0aGUgcmVxdWlyZW1l
bnRzLA0KPiBidXQgb2ggd2VsbCkuIE15IGluc3RpbmN0IGZhdm9ycyBBZHJpYW4ncyBhcHByb2Fj
aCBvZiBrZWVwaW5nIHRoZQ0KPiBjb25maWd1cmF0aW9uIGRlc2NyaXB0b3Igc2VwYXJhdGUsIHJh
dGhlciB0aGFuIGhpZGluZyBpdCBiZWhpbmQgdGhlDQo+IGRldmljZSBhbmQgdW5pdCBkZXNjcmlw
dG9ycywgYXMgSSB0aGluayBpdCdzIG1vcmUgdHJ1ZSB0byB0aGUgVUZTIHNwZWMNCj4gYW5kIGxl
c3MgbGlrZWx5IHRvIGNhdXNlIHByb2JsZW1zIGluIHRoZSBmdXR1cmUuIEhvd2V2ZXIgSSdtIHRy
eWluZyB0bw0KPiBmaWd1cmUgb3V0IHRoZSBiZXN0IHdheSB0byBkbyB0aGF0Lg0KPiANCj4gV2hh
dCBJIF93YW50XyB0byBkbyBpcyBiYXNpY2FsbHkgY3JlYXRlIE4gc3lzZnMgZ3JvdXBzLCB3aGVy
ZSBlYWNoDQo+IGdyb3VwIHBvaW50cyB0byB0aGUgc2FtZSBhcnJheSBvZiBhdHRyaWJ1dGVzLiBU
aGVuIGluIHRoZSBzaG93L3N0b3JlDQo+IG1ldGhvZHMsIGxvb2sgdXAgd2hpY2ggZ3JvdXAgSSdt
IGluIGFuZCB1c2UgdGhhdCBhcyBhbiBpbmRleC4gQnV0IHRoZQ0KPiBzaG93L3N0b3JlIGZ1bmN0
aW9ucyBvbmx5IHBhc3MgdGhlIGF0dHJpYnV0ZXMgdGhlbXNlbHZlcywgYW5kIHRoZXJlDQo+IHNl
ZW1zIHRvIGJlIG5vIHdheSBmb3IgbWUgdG8gZ2V0IHRoZSBwYXJlbnQgbm9kZS4gU28gbXkgbmV4
dCBwbGFuIGlzDQo+IHRvIGNyZWF0ZSBhIHdyYXBwZXIgYXJvdW5kIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlIHdoZXJlIEkgY2FuIHN0b3JlDQo+IG15IGluZGV4LCBjcmVhdGUgYSB0ZW1wbGF0ZSBv
ZiBhdHRyaWJ1dGVzLCBhbmQgdGhlbiBjcmVhdGUgTiBjb3BpZXMgb2YNCj4gdGhpcyB0ZW1wbGF0
ZS4gVGhlIHNob3cvc3RvcmUgbWV0aG9kIGlzIHRoZW4gYSBzaW5nbGUgbWV0aG9kLCB3aGljaA0K
PiB1c2VzIGNvbnRhaW5lcl9vZiBvbiB0aGUgYXR0cmlidXRlIHRvIGdldCB0aGUgaW5kZXgsIG9m
ZnNldCwgYW5kIHNpemUNCj4gb2YgdGhlIGRlc2NyaXB0b3IgdG8gY2hhbmdlLiBUaGlzIHNlZW1z
IGxlc3MgdGhhbiBpZGVhbCB0byBtZSwgYXMgaXQncw0KPiBuZXZlciBmdW4gdG8gZmVlbCBsaWtl
IHlvdSdyZSB3YXN0aW5nIG1lbW9yeSwgZXZlbiB0aG91Z2ggaXQncw0KPiBwcm9iYWJseSBvbiB0
aGUgb3JkZXIgb2YgYSBraWxvYnl0ZSBvciB0d28uDQo+IA0KPiBTdGFuaXNsYXYsIHlvdSd2ZSBn
b3QgdGhlIHVuaXQgZGVzY3JpcHRvcnMgb2ZmIGluIHRoZSBzY3NpX2RldmljZSwNCj4gd2hpY2gg
d291bGQgbWFrZSBhIGxvdCBvZiBzZW5zZSBmb3IgbWUgdG9vLCBleGNlcHQgdGhhdCBJIG5lZWQg
dG8NCj4gY29uZmlndXJlIGx1bnMgdGhhdCBtYXkgbm90IGV4aXN0IHlldC4gQ2FuIHlvdSBleHBh
bmQgb24geW91cg0KPiBlbmFibGVfbHVuIGlkZWE/DQo+IC1FdmFuDQoNCkl0J3MgYSB3cml0ZWFi
bGUgc3lzZnMgZW50cnkgdGhhdCByZWNlaXZlIGFuIGludGVnZXIgdmFsdWUgKGFzIGFuIGluZGV4
IA0Kb2YgYSBsdW4gdGhhdCBzaG91bGQgYmUgZW5hYmxlKS4gVGhlIHN0b3JlIGZ1bmN0aW9uIGRv
ZXMgc29tZSBzYW5pdHkNCmNoZWNrcywgcmVhZHMgdGhlIGNvbmZpZ3VyYXRpb24gZGVzY3JpcHRv
ciwgdXBkYXRlIHRoZSBzcGVjaWZpZWQNCmx1biBlbmFibGUgcGFyYW1ldGVyIGFuZCBzZW5kcyBp
dC4gQWZ0ZXIgcmVzdGFydCB0aGUgbHVuIHdpbGwgYmUgYXZhaWxhYmxlDQphbmQgcmVhZHkgZm9y
IGZ1cnRoZXIgY29uZmlndXJhdGlvbi4NCg0KU3RhbmlzbGF2DQogDQoNCg==
