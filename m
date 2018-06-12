Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EBA98C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970B720891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ta/1QBKn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JPvRRyrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970B720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeFLUG0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:06:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32767 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933611AbeFLUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528833982; x=1560369982;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YrvzZTfwx1dbgSxkk0xtnwbtUFzbRxy7dQqJyzb+dSk=;
  b=Ta/1QBKn9rP/ZclbE7hTpOTVfQ2UuY1XEJIbDMjZJ5h9oRF3yZO7oZDy
   fBNZEXjNUbdlGDibiqHDmBGcN4vYIVsWDXaTSNKkuFceT8t1+l3skrdBz
   IA+Iw+M/oNizx7F5IDh/o8pLuKCB999mnH6E5zo9ylbwnYjhHHEiv8dqR
   jLbrLAouc5ZCwkHraDt5337XLPQ/N2qHfO9uwZHfE3s9G4F6VteVEiw6V
   NiALSNvSZeIZ/cM87yz+CAxegH3e35J+QKSqGCDmTZH+3EjUMpq9mxpIy
   GA3sOfqx0MEn6zcCqxiOBtAKoeMnEYLKTSFbLYu4Hwa8a9rlH/MjJ6UI6
   w==;
X-IronPort-AV: E=Sophos;i="5.51,216,1526313600"; 
   d="scan'208";a="82316730"
Received: from mail-co1nam05lp0079.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.79])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 04:06:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrvzZTfwx1dbgSxkk0xtnwbtUFzbRxy7dQqJyzb+dSk=;
 b=JPvRRyrS7jKSZTrHnsaD1bG7W8e/0nOI5yHfb4ku9W9zhncm/oS6aESKz9bxID817iGQFxxyBKBxh2hu5l/mrjKJmReBnxmYJMNfKiaAPLlApOsO3vpgrb5yTnCMMmGoh58z6RubFVYYMgMhdN4NNajlNWJForrftOCV1/vvG4Q=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0577.namprd04.prod.outlook.com (10.173.49.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 20:06:18 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 20:06:18 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "jgross@suse.com" <jgross@suse.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
Thread-Topic: [PATCH 0/3] Use sbitmap instead of percpu_ida
Thread-Index: AQHUAoCPJsHcznuht0GFAz5i7jKnpKRdDKOA
Date:   Tue, 12 Jun 2018 20:06:18 +0000
Message-ID: <27ef5cf260a14606df099ff112a7ab1b36b02395.camel@wdc.com>
References: <20180612190545.10781-1-willy@infradead.org>
In-Reply-To: <20180612190545.10781-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0577;7:6mxT4V84o453unrdiHU3a+kQAP/Mf5Zbz9g6gGB3w2L3pHL4ylZFvmCqv2N+PkdT+LIasyP7KKOh5DNpXnTsnJxQRPjN6VwxHgWYzqdXH7KlO90ACSQo/lSFM1e+7eHgiIBsfD97RVNoDzPCT8qkomDNnxgc8YIUivgwtWMPkTyr1gwYD/sDhrsOlHtQtbiZ1UTBlutnHfEqEKCOj6H6QVivQpXvEt9/c3LtdaIPDQmia2R0lymnNrOx6nE079w1;20:tYHPZUhKTmQ2PL6AhAfIwr09gzJNOg84B1rQp7YBBOPiENKopwn0erShbN7toXhrvYUGRZSN/D2gVTesnMSg0m58JpTJIygjCih6UsmpsSYCDZPUV/eTm6sgvT8+jG5xR7W+eFGIx4RGBxlZGyHrm99apxJADwideNUhOPPWgms=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0577;
x-ms-traffictypediagnostic: MWHPR04MB0577:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0577584DB64064305C4CE34F987F0@MWHPR04MB0577.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0577;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0577;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(6436002)(5660300001)(3660700001)(105586002)(186003)(26005)(68736007)(106356001)(14454004)(229853002)(7416002)(6486002)(5250100002)(118296001)(478600001)(72206003)(6512007)(8676002)(99286004)(6246003)(36756003)(53936002)(2906002)(11346002)(8936002)(81156014)(110136005)(81166006)(316002)(2501003)(305945005)(6506007)(7736002)(25786009)(2201001)(66066001)(446003)(3846002)(86362001)(76176011)(476003)(2616005)(486006)(39060400002)(3280700002)(102836004)(2900100001)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0577;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DjDUmOT6g+j0QNUNAdaH3dL/FHdn3CLcxAhU/tQKkadTsgE6aP13BWnZf+LhlZWOZUTzmWEsWlNHlHy2lTiPJU/3SKK7VWRKuDJPh2WOFQtN2b9Rsx+/8hWLxnadr890e9rfIk0snpAYvQR32vQHqtT78wgfJaT+WTxg2NyCSc77Yfk7FRaQiBKG33K6IyoR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A3C87E23D01794D89BD770501E0C037@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9516789d-ce63-4565-1c1b-08d5d09ff608
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9516789d-ce63-4565-1c1b-08d5d09ff608
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 20:06:18.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDEyOjA1IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gUmVtb3ZpbmcgdGhlIHBlcmNwdV9pZGEgY29kZSBuZXRzIG92ZXIgNDAwIGxpbmVzIG9mIHJl
bW92YWwuICBJdCdzIG5vdA0KPiBhcyBzcGVjdGFjdWxhciBhcyBkZWxldGluZyBhbiBlbnRpcmUg
YXJjaGl0ZWN0dXJlLCBidXQgaXQncyBzdGlsbCBhDQo+IHdvcnRoeSByZWR1Y3Rpb24gaW4gbGlu
ZXMgb2YgY29kZS4NCj4gDQo+IFVudGVzdGVkIGR1ZSB0byBsYWNrIG9mIGhhcmR3YXJlIGFuZCBu
b3QgdW5kZXJzdGFuZGluZyBob3cgdG8gc2V0IHVwIGENCj4gdGFyZ2V0IHBsYXRmb3JtLg0KPiAN
Cj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiAgLSBGaXhlZCBidWdzIHBvaW50ZWQgb3V0IGJ5IEplbnMg
aW4gaXNjc2l0X3dhaXRfZm9yX3RhZygpDQo+ICAtIEFic3RyYWN0ZWQgb3V0IHRhZyBmcmVlaW5n
IGFzIHJlcXVlc3RlZCBieSBCYXJ0DQo+ICAtIE1hZGUgaXNjc2l0X3dhaXRfZm9yX3RhZyBzdGF0
aWMgYXMgcG9pbnRlZCBvdXQgYnkgMGRheQ0KDQpGb3IgdGhlIHdob2xlIHNlcmllczoNCg0KUmV2
aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCg0KVGhh
bmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQo=
