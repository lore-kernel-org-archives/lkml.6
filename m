Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C363FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6962089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W4NkjkYo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AKRbFE76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6962089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934777AbeFLQcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:32:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53510 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933640AbeFLQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528821128; x=1560357128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n7NfWsL08Oo9GPsrs83CPtzfWSlIwmyz5J4sPIGL/pI=;
  b=W4NkjkYoWqhlLv88OK0exCTv/Mvg6vlwNBjlZj89VnZEESTZmzhm0z9d
   bXk7JCrcDM1Z4X4ljxxeM5awQORVyMrcTtf60qT0P2MZQDpJpDUZd+L2L
   Rhk6R8gQ9MVyGZb7EBAvLAPuyPBfRfEcLkSmSP4e45dLzqBm52zCPkdeL
   VxEwvVbr/tfS20FevFVbgTUAPzySZlPAVIYJyVdJQcryL4szPPvCny/Ht
   V9wMTtMkvFnWtnIj95KkGgIHBGTqEvL1dEJWvtNpVwCk/lNDDG5FczwyB
   /1F+AslePCBUC7M1RRCiy/97Eo1phjdBKBw4PvatUy0OTR+rC3YUoDqai
   g==;
X-IronPort-AV: E=Sophos;i="5.51,215,1526313600"; 
   d="scan'208";a="183588942"
Received: from mail-sn1nam01lp0116.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.116])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 00:32:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7NfWsL08Oo9GPsrs83CPtzfWSlIwmyz5J4sPIGL/pI=;
 b=AKRbFE76shYOyjqzsfKEYSOylP9m78wTnZGLB0wkAsyOrUoFlhDBHSQpmKd336G9dqTAW9J6lOKuRBxWZngZm7g59InCQb4tqmEVxmQ+sQgk+pWASJxPiZTNthcfn70Z5sMplqqd8iECizrscHt9Rf3j+2HwOISktyZerddNb6A=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1120.namprd04.prod.outlook.com (10.173.51.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Tue, 12 Jun 2018 16:32:03 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 16:32:03 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "jgross@suse.com" <jgross@suse.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Thread-Topic: [PATCH 1/2] Convert target drivers to use sbitmap
Thread-Index: AQHT7GYxbT1giKZVZkSKRt4NLDSw+qRc6ZoAgAAOvgCAAASggA==
Date:   Tue, 12 Jun 2018 16:32:03 +0000
Message-ID: <0c93c72a3a339f3479f82de04223315671e07863.camel@wdc.com>
References: <20180515160043.27044-1-willy@infradead.org>
         <20180515160043.27044-2-willy@infradead.org>
         <da5220a5ed4bed210c31a7517389e787a3b1a01f.camel@wdc.com>
         <20180612161526.GE19433@bombadil.infradead.org>
In-Reply-To: <20180612161526.GE19433@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1120;7:wsDwTHj7LKFk7i/LfzW7bysQWeJwF16zN4Jeqvxil+8HfnVtGLD4DoMXRvOqTszYxxXHTyLPWkbn9Bw22D9nJEsr7U9Nla1CGfphTKArvbBaRzp0G8eUvwCSuEdQP0iwfrV5z+h6YaBzHsddJxo+LLJhtTIcrTnjB7pCWFTZXESaDNo4qLdxjcAIymfDn3+2Uk9E/LhrTndt82+/vwTo+IaxdHtAIBxWUf5/7FKKt+tGSTq39LX1nHfQuw6yj7f/;20:DG2kCTcueMshol6ApfU4MF0yWIsjy1tivrk9Ud2dfsOLNpGeiUcmSvuhb5bRHMWtomQcJ5UzHg5nDBVzpQjLy77T0ClTKD4vCdH6wXqCnAM/Cl160J4xjy8PIfwFbRcZP8PVvDzFE6xFWl527Wc2RKC3mJ75f3R+/ytpeVIh4is=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1120;
x-ms-traffictypediagnostic: MWHPR04MB1120:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1120010433C62D7C47B63318987F0@MWHPR04MB1120.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1120;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1120;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(51444003)(118296001)(3660700001)(4326008)(2900100001)(8676002)(1730700003)(6916009)(93886005)(3280700002)(229853002)(68736007)(39060400002)(54906003)(36756003)(7736002)(86362001)(2906002)(186003)(102836004)(81156014)(305945005)(7416002)(14454004)(72206003)(97736004)(478600001)(66066001)(5660300001)(26005)(76176011)(3846002)(6116002)(6246003)(59450400001)(6506007)(99286004)(106356001)(81166006)(8936002)(2351001)(53936002)(486006)(25786009)(6512007)(5640700003)(5250100002)(6436002)(446003)(476003)(105586002)(8666007)(11346002)(2616005)(6486002)(2501003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1120;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /btYgjdvqxqJZOzCoKAPVTAsWDdJJBF7S1pO31i7E5+dPvD9WjwCAfqnBADbwcEzVd5BA0c+TBAnd/5+I3kXIZuq8n7obHFoMJAAuqnM4JjZtCUoMfrBXQeIsTHsPpLWveeud0HGKv+YLt8FY9SHuq2d47/Ww7MjVLXofW7e6tNHuQUrFB1zPFSnyGlOB0Yr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AFD8DDA9AA78A4B982D4D376906EE4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 283c3f3c-8770-4154-735c-08d5d082078e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283c3f3c-8770-4154-735c-08d5d082078e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 16:32:03.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDA5OjE1IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVHVlLCBKdW4gMTIsIDIwMTggYXQgMDM6MjI6NDJQTSArMDAwMCwgQmFydCBWYW4gQXNz
Y2hlIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNS0xNSBhdCAwOTowMCAtMDcwMCwgTWF0dGhl
dyBXaWxjb3ggd3JvdGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgv
cWxhX3RhcmdldC5jIGIvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX3RhcmdldC5jDQo+ID4gPiBp
bmRleCAwMjVkYzJkM2YzZGUuLmNkZjY3MWMyYWY2MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV90YXJnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9zY3NpL3Fs
YTJ4eHgvcWxhX3RhcmdldC5jDQo+ID4gPiBAQCAtMzcxOSw3ICszNzE5LDggQEAgdm9pZCBxbHRf
ZnJlZV9jbWQoc3RydWN0IHFsYV90Z3RfY21kICpjbWQpDQo+ID4gPiAgCQlyZXR1cm47DQo+ID4g
PiAgCX0NCj4gPiA+ICAJY21kLT5qaWZmaWVzX2F0X2ZyZWUgPSBnZXRfamlmZmllc182NCgpOw0K
PiA+ID4gLQlwZXJjcHVfaWRhX2ZyZWUoJnNlc3MtPnNlX3Nlc3MtPnNlc3NfdGFnX3Bvb2wsIGNt
ZC0+c2VfY21kLm1hcF90YWcpOw0KPiA+ID4gKwlzYml0bWFwX3F1ZXVlX2NsZWFyKCZzZXNzLT5z
ZV9zZXNzLT5zZXNzX3RhZ19wb29sLCBjbWQtPnNlX2NtZC5tYXBfdGFnLA0KPiA+ID4gKwkJCWNt
ZC0+c2VfY21kLm1hcF9jcHUpOw0KPiA+ID4gIH0NCj4gPiA+ICBFWFBPUlRfU1lNQk9MKHFsdF9m
cmVlX2NtZCk7DQo+ID4gDQo+ID4gUGxlYXNlIGludHJvZHVjZSBmdW5jdGlvbnMgaW4gdGhlIHRh
cmdldCBjb3JlIGZvciBhbGxvY2F0aW5nIGFuZCBmcmVlaW5nIGEgdGFnDQo+ID4gaW5zdGVhZCBv
ZiBzcHJlYWRpbmcgdGhlIGtub3dsZWRnZSBvZiBob3cgdG8gYWxsb2NhdGUgYW5kIGZyZWUgdGFn
cyBvdmVyIGFsbA0KPiA+IHRhcmdldCBkcml2ZXJzLg0KPiANCj4gSSBjYW4ndCB3aXRob3V0IGRv
aW5nIGFuIHVucmVhc29uYWJseSBsYXJnZSBhbW91bnQgb2Ygd29yayBvbiBkcml2ZXJzIHRoYXQN
Cj4gSSBoYXZlIG5vIHdheSB0byB0ZXN0LiAgU29tZSBvZiB0aGUgZHJpdmVycyBoYXZlIHRoZSBz
ZV9jbWQgYWxyZWFkeTsgc29tZQ0KPiBvZiB0aGVtIGRvbid0LiAgSSdkIGJlIGhhcHB5IHRvIGlu
dHJvZHVjZSBhIGNvbW1vbiBmdW5jdGlvbiBmb3IgZnJlZWluZw0KPiBhIHRhZy4NCg0KV2hpY2gg
dGFyZ2V0IGRyaXZlcnMgYXJlIHlvdSByZWZlcnJpbmcgdG8/IElmIHlvdSBhcmUgcmVmZXJyaW5n
IHRvIHRoZSBzYnAgZHJpdmVyOg0KSSB0aGluayB0aGF0IGRyaXZlciBpcyBkZWFkIGFuZCBjYW4g
YmUgcmVtb3ZlZCBmcm9tIHRoZSBrZXJuZWwgdHJlZS4gSSBldmVuIGRvbid0DQprbm93IHdoZXRo
ZXIgdGhhdCBkcml2ZXIgZXZlciBoYXMgaGFkIGFueSB1c2VycyBvdGhlciB0aGFuIHRoZSBkZXZl
bG9wZXIgb2YgdGhhdA0KZHJpdmVyLg0KDQo+ID4gVGhpcyBsb29rcyB3ZWlyZCB0byBtZS4gU2hv
dWxkbid0IHRhcmdldCBjb2RlIGlnbm9yZSBzaWduYWxzIGluc3RlYWQgb2YgY2F1c2luZw0KPiA+
IHRhZyBhbGxvY2F0aW9uIHRvIGZhaWwgaWYgYSBzaWduYWwgaXMgcmVjZWl2ZWQ/DQo+IA0KPiBJ
dCdzIHdoYXQgdGhlIGN1cnJlbnQgY29kZSBkaWQ6DQo+IA0KPiAtICAgICAgICAgICAgICAgaWYg
KHNpZ25hbF9wZW5kaW5nX3N0YXRlKHN0YXRlLCBjdXJyZW50KSkgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICB0YWcgPSAtRVJFU1RBUlRTWVM7DQo+IC0gICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiAtICAgICAgICAgICAgICAgfQ0KPiANCj4gYW5kIHRoZSBjdXJyZW50IGNhbGxl
cnMgbGl0ZXJhbGx5IGluZGljYXRlIHRoYXQgdGhleSB3YW50IHNpZ25hbHM6DQo+IA0KPiBkcml2
ZXJzL2luZmluaWJhbmQvdWxwL2lzZXJ0L2liX2lzZXJ0LmM6ICAgICAgICBjbWQgPSBpc2NzaXRf
YWxsb2NhdGVfY21kKGNvbm4sIFRBU0tfSU5URVJSVVBUSUJMRSk7DQo+IGRyaXZlcnMvdGFyZ2V0
L2lzY3NpL2lzY3NpX3RhcmdldC5jOiAgICBjbWQgPSBpc2NzaXRfYWxsb2NhdGVfY21kKGNvbm4s
IFRBU0tfSU5URVJSVVBUSUJMRSk7DQoNClJpZ2h0LCB0aGUgaVNDU0kgdGFyZ2V0IGRyaXZlciB1
c2VzIHNpZ25hbHMgdG8gd2FrZSB1cCB0aHJlYWRzIChzZWUgYWxzbyB0aGUNCnNlbmRfc2lnKCkg
Y2FsbHMgaW4gdGhlIGlTQ1NJIHRhcmdldCBjb2RlKS4NCg0KQmFydC4=
