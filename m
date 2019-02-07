Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E24C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3B21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CBcGyTrI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ls3va7bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBGOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:15:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64281 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549548943; x=1581084943;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3GqCSskKnb1QG8MQLnjqWNa19fCA7BvK8tFfOSs5G0Q=;
  b=CBcGyTrIwyit77OPFoF9+2q7B1yK0pKhvNwt3rVmD4kxuEaycH0E+qgJ
   7W+lpnPxrnRLa4LHwOSKyYbDUTo0NbCAuwAf8x/k3WEXtBPPqOWtP8WPI
   JyU4aOg2eyA/t2Ssep1TDlBMHlNWA7CPpCP1wn3psdXlA0GJ1rVFe21UD
   0oFps8apVfP4zBJD8p3o5VgRpak15cuz/LaI9M96BbK1BqlHfG6zk2hNk
   ZB7QqjQ1qkTYJcmNoW22Cj8J3Zbxwc9Se2GLhBReRX5kTtiMhb2SgdsTW
   a8SWa3MHZFNl+9RptlE0nYp7vlP97HSBydSnMuFJZ7IikzQ5Oz4nf61Oq
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="205808956"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2019 22:15:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GqCSskKnb1QG8MQLnjqWNa19fCA7BvK8tFfOSs5G0Q=;
 b=ls3va7bojLs1hwqaXc0mZ+uLMPPmV2x7CEJi3Bnhf28IzWxiXdfkevAhj7ZH/oJS/0UqEA+HHmEBIEachn51TwbAvwg5DnPLg5oJqlHlujN5igKFnuCTlQi41l6VXo7Ds5sGqJxAkOWYeNCiPwOXvzXtcH89MQGG1bFgctmybtA=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4126.namprd04.prod.outlook.com (52.135.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Thu, 7 Feb 2019 14:15:40 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 14:15:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Evan Green <evgreen@chromium.org>
Subject: RE: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Topic: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Index: AQHUtg8jpd6bmkKdmkCBoLq0HKAzQaXFBk8AgAwjyaCAA0g2EA==
Date:   Thu, 7 Feb 2019 14:15:40 +0000
Message-ID: <SN6PR04MB49259233067FBEC4AFA35963FC680@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
 <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
 <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4126;6:VO6eT5Jfe/gmHgVjmoJCJhwGdX7Al5aS/6C6kcG14WLnUhY3TxbrmGH4CNZt2/YKOhbyz9yGzUtsTi4s0OF6MpCQkkvPeZozHGp9qyyi3+sboI4IriQW3P9fOmJRBQNfTxvqwThpGnL8nTZDPgPzYDjKn60Ge3FRjntyA039O0bVIzfonx5PEBy0r5wQdaTg7Wl9SOPF1sixfCtpH84kicZldX4mkrGWL0l77ogkA8gJlswxg7Ka6BXC4Lv1fUCA2IQZ3A2bJDaVq7j+b4N1XwMqnMHt+YzfHtDszwLXwrrkKvXAo0Z6NfxGFlW0TaCFJWwSCzWGvZ78q4s5PRevfQDJn0q8bVCeRe0jZxkWNX7VZQeRYv8esf6a8eYC9qaQ7BCHJ/KwVHJCL7XMNGDGdgsJ0zvYICqPDtnyhoA/s0vWU56hxpxfMc+8QbjE9vqOVI3irOODemHhJ8sBpbtuyg==;5:gSbfK32t1nNCxFwo+fEfQ3v+9eKu5ZHSki4lpPHfjBMaJws8czUKrcPs2nSMkNF4A59HVWLnnJAVdjhl90N8Um2zqdKfURyTDagCgO2A6tSV9U/ESlR2ymxMZ7ASAhPKXPubr2S6I69+11z3KVE93aSOEMSAswzcBsW/OadLgKOaakLXqA6evzKt4s8/zxB3FfvS4xLktnVSCTzuzdnETQ==;7:Id2x+L+tFrvwycDu4gBI4kKbXcbXHCTd+MndXQCDKwd/mYFoHwl8X5njGE3c2hpTJ7BVJ+JWGZshRO4lESutzAxN2QtzdOQD1VqbsRIITWz7j6Sr0E8w/qJo5La9lW4/QknnsQ3xfLhBBogYBxQZnw==
x-ms-office365-filtering-correlation-id: 717c2383-4299-462c-faa1-08d68d06bd9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4126;
x-ms-traffictypediagnostic: SN6PR04MB4126:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4126530CE1ACA67CE6904FBDFC680@SN6PR04MB4126.namprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(13464003)(74316002)(68736007)(229853002)(6116002)(3846002)(6506007)(478600001)(186003)(6916009)(9686003)(102836004)(26005)(305945005)(7736002)(53546011)(76176011)(486006)(25786009)(14454004)(446003)(54906003)(33656002)(476003)(71200400001)(71190400001)(2906002)(81166006)(81156014)(8676002)(6246003)(6436002)(8936002)(106356001)(53936002)(66066001)(72206003)(4326008)(97736004)(14444005)(86362001)(55016002)(7696005)(316002)(256004)(99286004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4126;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5JYpEenJ6ybqzzfmRbWd09CGEfrU4b1Y1NG22vsV8IKzREXAySAQwI0WAjy7et+9PaAq3CeAjWKNCmQcRFposZ69NGvmu/D44oUji32eIEQgUsx0zwbiNQItekRXvvoUvAe3QH7pDxpm7m+rQh0oRP3CE8MVFSHPNp9GTKq7uwkyyRuYoqzPPJTMwUtwbHbi7y3Vo6Ot98v6roWGiemoowTvoSJjgEU+yGJdTWo4SS1rF+UyrstgSYe/r+uFj/S9JgJLxFnFZD3iUYv61C1XmJiN5nSx7oSqwYClokMEmUy973JE1XOd8DbdTOqgP7jbJndBMDcY3aPXujjetwiq2MfZ+MRhDNp0X5jWzRA3BrKFzGpnCJkRs3FvNimXe0/xjd0b48LN/33QtvIJcthjrxB3tWPcOzMP6wm6aS+Soq0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717c2383-4299-462c-faa1-08d68d06bd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 14:15:40.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFydGluLA0KSXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgdGhpcyBzaXJlcyBpcyBub3QgYXBwbGll
ZCBmb3IgNS4xPw0KDQpUaGFua3MsDQpBdnJpDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQXZyaSBBbHRtYW4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMDUsIDIw
MTkgMjowNyBQTQ0KPiBUbzogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3Jh
Y2xlLmNvbT4NCj4gQ2M6IEphbWVzIEUuSi4gQm90dG9tbGV5IDxqZWpiQGxpbnV4LnZuZXQuaWJt
LmNvbT47IFNDU0kgPGxpbnV4LQ0KPiBzY3NpQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBBdmkNCj4gU2hjaGlzbG93c2tpIDxBdmkuU2hjaGlz
bG93c2tpQHdkYy5jb20+OyBBbGV4IExlbWJlcmcNCj4gPEFsZXguTGVtYmVyZ0B3ZGMuY29tPjsg
J0V2YW4gR3JlZW4nIDxldmdyZWVuQGNocm9taXVtLm9yZz4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCB2NCAzLzNdIHNjc2k6IHVmcy1ic2c6IEFsbG93IHJlYWRpbmcgZGVzY3JpcHRvcnMNCj4gDQo+
IE1hcnRpbiwNCj4gQW55IGZ1cnRoZXIgY29tbWVudHM/DQo+IA0KPiBUaGFua3MsDQo+IEF2cmkN
Cj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRXZhbiBH
cmVlbiA8ZXZncmVlbkBjaHJvbWl1bS5vcmc+DQo+ID4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDI4
LCAyMDE5IDg6NDIgUE0NCj4gPiBUbzogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+
DQo+ID4gQ2M6IEphbWVzIEUuSi4gQm90dG9tbGV5IDxqZWpiQGxpbnV4LnZuZXQuaWJtLmNvbT47
IE1hcnRpbiBLLiBQZXRlcnNlbg0KPiA+IDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT47IFND
U0kgPGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnPjsgTEtNTA0KPiA+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgQXZpIFNoY2hpc2xvd3NraQ0KPiA8QXZpLlNoY2hpc2xvd3NraUB3
ZGMuY29tPjsNCj4gPiBBbGV4IExlbWJlcmcgPEFsZXguTGVtYmVyZ0B3ZGMuY29tPg0KPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy8zXSBzY3NpOiB1ZnMtYnNnOiBBbGxvdyByZWFkaW5nIGRl
c2NyaXB0b3JzDQo+ID4NCj4gPiBPbiBTYXQsIEphbiAyNiwgMjAxOSBhdCAxMTowOCBQTSBBdnJp
IEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gQWRk
IHRoaXMgZnVuY3Rpb25hbGl0eSwgcGxhY2luZyB0aGUgZGVzY3JpcHRvciBiZWluZyByZWFkIGlu
IHRoZSBhY3R1YWwNCj4gPiA+IGRhdGEgYnVmZmVyIGluIHRoZSBiaW8uDQo+ID4gPg0KPiA+ID4g
VGhhdCBpcywgZm9yIGJvdGggcmVhZCBhbmQgd3JpdGUgZGVzY3JpcHRvcnMgcXVlcnkgdXBpdSwg
d2UgYXJlIHVzaW5nDQo+ID4gPiB0aGUgam9iJ3MgcmVxdWVzdF9wYXlsb2FkLiAgVGhpcyBpbiB0
dXJuLCBpcyBtYXBwZWQgYmFjayBpbiB1c2VyIGxhbmQgdG8NCj4gPiA+IHRoZSBhcHBsaWNhYmxl
IHNnX2lvX3Y0IHhmZXJwOiBkb3V0X3hmZXJwIGZvciB3cml0ZSBkZXNjcmlwdG9yLA0KPiA+ID4g
YW5kIGRpbl94ZmVycCBmb3IgcmVhZCBkZXNjcmlwdG9yLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0K
