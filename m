Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE78C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXspORhx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M+waBQL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbeGJStj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:49:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22400 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeGJSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531248561; x=1562784561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hu2Ou6/Lry9hhlV3zWJbqb9JSy/ZwWNyRDNEc0VcLkA=;
  b=iXspORhx2zJZ3bfAtdY6zQgJsu2+GXK4SIOmd2xq7AZdFGmn0S2OWk/A
   Han2l01aRXcS25P/y8NdxJKmOnQw9AZr9YrsX1P93l1ESXrzGIKHCycNG
   llo3W+DxL7rRCO4anmKIZtDBLBv1xrnR+HbwJ2ZLBjeOIFmVMNnX7yG1J
   Hk6KhWBnPsLvQ3mh7u3lyKWmNYDrEuX2xQz3QMpTRG1v5VbyykK+a9YZW
   FsfGBfrWvsAuj6F+kMou6aELzAFssgBLwRND+EzEuJ665xZzwWSvMTUgs
   IBIhwq7r6vdX5P8cq5MTbDlXKHaJV02k/Szh7nYZTU3ynKPFsB9C7QOSd
   A==;
X-IronPort-AV: E=Sophos;i="5.51,335,1526313600"; 
   d="scan'208";a="83642406"
Received: from mail-dm3nam05lp0111.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.111])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2018 02:49:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu2Ou6/Lry9hhlV3zWJbqb9JSy/ZwWNyRDNEc0VcLkA=;
 b=M+waBQL2jduWHlhZ/JLtREud8KjnR/nwPWlBcY3PTrRP2ZZQ8KzmJl0sRBRf6eIi1wpVxtk6e8PzlXXBihzlD6eG0GUnYR7G1w7TuCq7m8lkcVRJpHGmfbIRWy61hrirYUrD1p9Z/pqlTactMdQnLgV4zcoRBE2V4zXhUKawJnI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1120.namprd04.prod.outlook.com (10.173.51.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 18:49:18 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 18:49:18 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "loberman@redhat.com" <loberman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
Thread-Topic: [PATCH 0/2] null_blk: zone support
Thread-Index: AQHUFVBFT/qkypCZAUO1k/LTlwEax6SCd5QAgAQSDYCAAJEkAIAAfhCAgAD2KoCAACHDgIAAIQuAgAAA+QA=
Date:   Tue, 10 Jul 2018 18:49:17 +0000
Message-ID: <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
         <1530899118.31977.1.camel@redhat.com>
         <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
         <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
         <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
         <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
         <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
         <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
In-Reply-To: <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1120;7:3R2p2595I111rzyjXPdCYX9Sh/FgSuomlOSoAKbcAMypFitGBc7ij/IBhXtmM34sWIqa9cHk18z4XoSN+g8tvwQWCggRWuLWNpkxv0nhkxhmBS8fOFFP3HkBbhT6r49kvTYo+kPIhBTLx1in12b6O49SPy4duDglYSQp6Y/pwIH06aOvC21uHsjvMKXZHjroS25baF8cp7f2+LUImdYp+b2z42Xw+VfYwlVqdEYMLs38ZEkkAcFAHUD6TPHawNzw;20:bIEXDFwtIbmPhDBRFxQL11pOyN0oUxQVKn7v4P8LA6NwLfOsgqOYu277E2PO5LYpUZIVm6sgbH6HeB/SVd2ZKy9UYOjAZQ5LRHwATITHvLkQHPG9xRwd3UxNX6liOdQ27WEB8l0A7CWrhuawf6DGdK7zsPOvyvEBT71KzIDHxsA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c9de3887-7273-4b3d-9f1e-08d5e695d764
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1120;
x-ms-traffictypediagnostic: MWHPR04MB1120:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1120A9936B8E26AC059EEC3E985B0@MWHPR04MB1120.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1120;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1120;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(99286004)(118296001)(6506007)(26005)(6246003)(53936002)(102836004)(7736002)(76176011)(5660300001)(25786009)(229853002)(36756003)(97736004)(305945005)(66066001)(14454004)(4326008)(478600001)(68736007)(6116002)(3846002)(72206003)(86362001)(316002)(8676002)(54906003)(106356001)(256004)(14444005)(5250100002)(6512007)(2900100001)(486006)(2201001)(446003)(2616005)(11346002)(6436002)(476003)(81156014)(105586002)(81166006)(186003)(8936002)(2501003)(93886005)(110136005)(6486002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1120;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7GvQi9htMn8AoOrvTMsvZzmxU5CwYTos8dmVJ20dB3/I+Wuk+/GAr9a2afubooTQzmH6YZQnQwYXOQj1onHKZVRIN8/SEcXpc9JIR0+gt3PW2NS5GNr1FYfS/jU955SOcxnstLUq/S5HzCVqul4fODjWifMM8RoQPeZfPaF2PpeIH5W9riBoT3JKkXMaVUl905iZVPf6/b0GPhxu8wCiZCKNJ9fBtGXwg2pd8UQmuS9zuhTBnxws97cYwz8aRDVG+jJ0eQTSKPP15BhRWnhzg78hxhQ5FQcOWcZpBWist195Gjnw2ihEjz2rH+xM9fZHW1PpdZcsubskcT2n7qEfnIGXY9HIR1uh6765+SpOziI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B64AF95B74A39141946D321551AB60BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9de3887-7273-4b3d-9f1e-08d5e695d764
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 18:49:17.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDEyOjQ1IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBU
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBqb2IgZmlsZSBhbmQgdGhlDQo+IHdvcmtsb2FkIHJ1
biBjYW4gYmUgaHVnZS4gQ29uc2lkZXIgc29tZXRoaW5nIHJlYWxseSBiYXNpYzoNCj4gDQo+IFty
YW5kd3JpdGVzXQ0KPiBicz00aw0KPiBydz1yYW5kd3JpdGUNCj4gDQo+IHdoaWNoIHdvdWxkIGJl
IDEwMCUgcmFuZG9tIDRrIHdyaXRlcy4gSWYgSSBydW4gdGhpcyBvbiBhIHpvbmVkIGRldmljZSwN
Cj4gdGhlbiB0aGF0J2QgdHVybiBpbnRvIDEwMCUgc2VxdWVudGlhbCB3cml0ZXMuDQoNClRoYXQn
cyBub3QgY29ycmVjdC4gVGhlIFpCRCBjb2RlIGluIHRoZSBnaXRodWIgcHVsbCByZXF1ZXN0IHNl
cmlhbGl6ZXMgd3JpdGVzDQpwZXIgem9uZSwgbm90IGdsb2JhbGx5Lg0KDQo+ID4gV2hhdCBJIGRl
cml2ZWQgZnJvbSB0aGUgZmlvIHNvdXJjZSBjb2RlIGlzIGFzIGZvbGxvd3MgKHBsZWFzZSBjb3Jy
ZWN0IG1lDQo+ID4gaWYgSSBnb3QgYW55dGhpbmcgd3JvbmcpOg0KPiA+ICogVGhlIHB1cnBvc2Ug
b2YgdGhlIHpvbmVzaXplLCB6b25lcmFuZ2UgYW5kIHpvbmVza2lwIGpvYiBvcHRpb25zIGlzIHRv
DQo+ID4gICBsaW1pdCB0aGUgSS9PIHJhbmdlIHRvIGEgc2luZ2xlIHpvbmUgd2l0aCBzaXplICJ6
b25lc2l6ZSIuIFRoZSBJL08NCj4gPiAgIHBhdHRlcm4gZm9yIHpvbmVkIGJsb2NrIGRldmljZXMg
aXMgZGlmZmVyZW50OiBJL08gaGFwcGVucyBpbiBtdWx0aXBsZQ0KPiA+ICAgem9uZXMgc2ltdWx0
YW5lb3VzbHkuIFRoZSBudW1iZXIgb2Ygem9uZXMgdG8gd2hpY2ggSS9PIGhhcHBlbnMgaXMNCj4g
PiAgIGNhbGxlZCB0aGUgbnVtYmVyIG9mIG9wZW4gem9uZXMuDQo+IA0KPiBUaGUgb25seSBkaWZm
ZXJlbmNlIGlzIHRoYXQgZmlvIGN1cnJlbnRseSBvbmx5IGhhcyBvbmUgem9uZSBhY3RpdmUuIFdo
ZW4NCj4gaXQgZmluaXNoZXMgb25lLCBpdCBnb2VzIHRvIHRoZSBuZXh0LiBTZWUgbXkgYWJvdmUg
c3VnZ2VzdGlvbiBvbiBhZGRpbmcNCj4gdGhlIG5vdGlvbiBvZiBvcGVuIHpvbmVzLCB3aGljaCB3
b3VsZCBleHRlbmQgdGhpcyB0byBtb3JlIHRoYW4gMS4NCg0KVGhhbmtzLCBJIHdpbGwgbG9vayBp
bnRvIHRoaXMuDQoNCkJhcnQuDQoNCg0KDQoNCg0K
