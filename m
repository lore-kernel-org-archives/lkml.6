Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C87C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B032089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Aj8j/sr5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LPNw36aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B032089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeGJAFq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:05:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42773 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeGJAFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531181143; x=1562717143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gN6DSkeYJzhxUhVpv78+9bx/7lNEg0UZdYaP54vNZ3s=;
  b=Aj8j/sr55Za5WRIRSiiSU30M9L3yQjaiR092COnuYnL31vdQm2HzYEZq
   Fwb+3BYtJGkoP0vS36VJhybFDfTnQf8pl+tkVg5+lqkXUMh8qaPzfm9KN
   rxyrHRRk6T7z/gw2Ofe56Jm2/kxy1QuHDCN3wv3Wx4EZnvMOjV5kL3i9K
   Hq1wfWfN3f5uh2Mi0zu4Gho88xpGIY4u9iegHz1n4P7TbLwg30+6cBq5L
   zoB1XXRTK1Ok3IKaGdEmWxa0RLUj1dFtlhTG426MX3Inqi80EfsTeIV22
   tFI8hY5s5G071/f9dUVyGByUpebOZu/8+bnh2myQtqtA8YfpelOnSWEFb
   w==;
X-IronPort-AV: E=Sophos;i="5.51,332,1526313600"; 
   d="scan'208";a="83569376"
Received: from mail-cys01nam02lp0048.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2018 08:05:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN6DSkeYJzhxUhVpv78+9bx/7lNEg0UZdYaP54vNZ3s=;
 b=LPNw36awZufz6bg6kxmel5aHuZu44P2ONQSJOfbjT6tb+kEWhduLYzp+oSelnvODrRim14Lia4bxIxhO7opL3AvCOT+YzUNsRf8wDyywWBC51rft6ov+0LoeFR+wpcNN8+5T43814ZNgnwbITTPUNlZSdbhmxSdZIf+xoZQ+5ZI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0446.namprd04.prod.outlook.com (10.173.48.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 00:05:39 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 00:05:38 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "loberman@redhat.com" <loberman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
Thread-Topic: [PATCH 0/2] null_blk: zone support
Thread-Index: AQHUFVBFT/qkypCZAUO1k/LTlwEax6SCd5QAgAQSDYCAAJEkAIAAfhCA
Date:   Tue, 10 Jul 2018 00:05:38 +0000
Message-ID: <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
         <1530899118.31977.1.camel@redhat.com>
         <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
         <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
In-Reply-To: <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0446;7:imSZZZaLk/bFkvbilYu8oIzM8CHVhMQz/ISBMy/8KmX4lwbG7sXqcRTjjw+PNubGBP3LtZCZvQDUGt+Ff+O1L8/eq4dU2G3/IOspPgtQgFEnQs88IJafHjvXEYygruvyyRRhIeXePSvehCSkKXwdb9UY/nnR6nk+XQoZjcMcoUTlXozO7bL+kuZNikgm2M2P8DgcexZA4cOJ87cnJ1kP470UdUvk3B8+s4+Foxcn4iwyvCwhFy6DRB6nkMv28qF8;20:Y2RX9VfRjaq5Rw19U0jhe6rTZlEruqU4hO3vugpLozLaBNzVjb65yWEpCpHERZ3tjsSEFw61b6alC4mUjCJHe7WwJXMDJoCPmTMbpL0RmPA4KPTrGime+Q8mu2jXtTNSKBy07IkENktgdJHELphXBmwAxIumcELFThRMvsjOtR8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c29790b8-5efb-47d4-69bb-08d5e5f8de69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0446;
x-ms-traffictypediagnostic: MWHPR04MB0446:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0446E2672AA93F7DD934CCFA985B0@MWHPR04MB0446.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0446;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0446;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(53546011)(81156014)(5250100002)(8676002)(2900100001)(446003)(256004)(11346002)(305945005)(7736002)(106356001)(5660300001)(26005)(6506007)(118296001)(81166006)(2501003)(2616005)(486006)(476003)(105586002)(186003)(8936002)(36756003)(53936002)(6116002)(3846002)(97736004)(7520500002)(99286004)(102836004)(76176011)(2906002)(229853002)(25786009)(6246003)(68736007)(93886005)(54906003)(316002)(4326008)(110136005)(66066001)(6512007)(6306002)(6486002)(6436002)(2201001)(86362001)(14454004)(478600001)(72206003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0446;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zfPCYB2LNRUpaqvw1z8uRmJF8Ie22Eq9xOYNNiM/8V2XLBI9IZ7OCCd+z4f0D6eE+DX1NGdCRiqD6jJt00nULdriqwBtadsz0uBgIVTKcNuUvFJF75UGQHRnmxsX8LZUpL2gSktBEBh7S29WOKkzUBqxZLQgczg1Ome/hqqi4Vl6dA0DWCiihW3jN6AFt8WhvA0JzyrpyqaOdsRtUnKTnUTnpEPYdlRRwxOsJ7UhjI9aLtj/Gz4CgL0g6Wz6p5yXhCNZHbdBVF0nL23RwQcquZYyy++Y0GQ4o9NRWuRueOzjRCySKZgWLmy8gVU8Oj882BaKgWgokAT9pM4G98Cy4QUYJmhMOFogaMA+FKWwmtI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F11ACFAD5B4766478F8075AACAC07786@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29790b8-5efb-47d4-69bb-08d5e5f8de69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 00:05:38.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTA5IGF0IDEwOjM0IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biA3LzkvMTggMTo1NCBBTSwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToNCj4gPiBGb3IgZmlvLCB5
b3UgY2FuIHVzZSB0aGUgem9uZSBzdXBwb3J0IGhlcmU6DQo+ID4gDQo+ID4gICAgaHR0cHM6Ly9n
aXRodWIuY29tL2J2YW5hc3NjaGUvZmlvDQo+ID4gDQo+ID4gSXQgaXMgaW4gdGhlIHByb2Nlc3Mg
b2YgYmVpbmcgdXBzdHJlYW1lZC4NCj4gDQo+IEluIHRoZSBzcGlyaXQgb2YgbWFraW5nIHNvbWUg
cHJvZ3Jlc3Mgb24gdGhpcywgSSBqdXN0IGRvbid0IGxpa2UgaG93DQo+IGl0J3MgZG9uZS4gRm9y
IGV4YW1wbGUsIGl0IHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IHRvIGFkanVzdCB3aGF0DQo+IGNv
bWVzIG91dCBvZiB0aGUgYmxvY2sgZ2VuZXJhdG9yLCBpbnN0ZWFkIHRoZSBibG9jayBnZW5lcmF0
b3Igc2hvdWxkDQo+IGJlIHRvbGQgdG8gZG8gd2hhdCB3ZSBuZWVkIG9uIHpiYy4gVGhpcyBpcyBh
IGtleSBjb25jZXB0LiBUaGUgd29ya2xvYWQNCj4gc2hvdWxkIGJlIGRlZmluZWQgYXMgc3VjaCB0
aGF0IGl0IHdvcmtzIGZvciB6b25lZCBkZXZpY2VzLg0KDQpIZWxsbyBKZW5zLA0KDQpIb3cgd291
bGQgeW91IGxpa2UgdG8gc2VlIGJsb2NrIGdlbmVyYXRpb24gd29yaz8gSSBkb24ndCBzZWUgYW4g
YWx0ZXJuYXRpdmUNCmZvciByYW5kb20gSS9PIG90aGVyIHN0YXJ0aW5nIGZyb20gdGhlIG91dHB1
dCBvZiBhIHJhbmRvbSBnZW5lcmF0b3IgYW5kDQp0cmFuc2xhdGluZyB0aGF0IG91dHB1dCBpbnRv
IHNvbWV0aGluZyB0aGF0IGlzIGFwcHJvcHJpYXRlIGZvciBhIHpvbmVkIGJsb2NrDQpkZXZpY2Uu
IFJhbmRvbSByZWFkcyBtdXN0IGhhcHBlbiBiZWxvdyB0aGUgem9uZSBwb2ludGVyIGlmIGZpbyBp
cyBjb25maWd1cmVkDQp0byByZWFkIGJlbG93IHRoZSB6b25lIHBvaW50ZXIuIFJhbmRvbSB3cml0
ZXMgbXVzdCBoYXBwZW4gYXQgdGhlIHdyaXRlDQpwb2ludGVyLiBUaGUgb25seSB3YXkgSSBzZWUg
dG8gaW1wbGVtZW50IHN1Y2ggYW4gSS9PIHBhdHRlcm4gaXMgdG8gc3RhcnQNCmZyb20gdGhlIG91
dHB1dCBvZiBhIHJhbmRvbSBnZW5lcmF0b3IgYW5kIHRvIGFkanVzdCB0aGUgb3V0cHV0IG9mIHRo
YXQNCnJhbmRvbSBnZW5lcmF0b3IuIEhvd2V2ZXIsIEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvcGlu
aW9uIHdoZXRoZXIgYWRqdXN0aW5nDQp0aGUgb3V0cHV0IG9mIGEgcmFuZG9tIGdlbmVyYXRvciBz
aG91bGQgaGFwcGVuIGJ5IHRoZSBjYWxsZXIgb2YNCmdldF9uZXh0X2J1ZmxlbigpIG9yIGluc2lk
ZSBnZXRfbmV4dF9idWZsZW4oKS4gT3IgaXMgeW91ciBjb25jZXJuIHBlcmhhcHMNCnRoYXQgdGhl
IGN1cnJlbnQgYXBwcm9hY2ggaW50ZXJmZXJlcyB3aXRoIGZpbyBqb2Igb3B0aW9ucyBsaWtlIGJz
X3VuYWxpZ25lZD8NCg0KPiBUaGUgdHJpbSBhcyB6b25lIHJlc2V0cyBzZWVtcyBvZGQuIFdoYXQg
aGFwcGVucyBpZiB5b3UgZW5kIHVwIHdpdGggYQ0KPiB6b25lZCBmbGFzaCBkZXZpY2UgaW4gdGhl
IGZ1dHVyZT8NCg0KV2UgY2FuIGxlYXZlIG91dCB0aGUgY29kZSB0aGF0IHRyYW5zbGF0ZXMgdHJp
bSBpbnRvIHpvbmUgcmVzZXRzIGZyb20gZmlvDQphbmQgZGlzY3VzcyBsYXRlciBob3cgdG8gaGFu
ZGxlIHRoaXMuIE9uZSBwb3NzaWJpbGl0eSBpcyB0byBtb2RpZnkgdGhlIHNkDQpkcml2ZXIgc3Vj
aCB0aGF0IGl0IHRyYW5zbGF0ZXMgUkVRX09QX0RJU0NBUkQgaW50byB6b25lIHJlc2V0cyB3aGVu
DQphcHByb3ByaWF0ZS4gVGhlcmUgbWF5IGJlIGJldHRlciBhbHRlcm5hdGl2ZXMuDQoNCkJhcnQu
DQoNCg0KDQoNCg==
