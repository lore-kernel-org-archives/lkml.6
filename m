Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898DBC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PvK+yUNr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OLjBOPzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeFTBfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:35:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1297 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529458551; x=1560994551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A50QjFGBhdOzI9wtsnWPiFMi10F1JLuhWwsd4klL3o8=;
  b=PvK+yUNrlUJ2/wDSp5eQsot3r09wU+OHlFXA9C5YhrmaIF+euEpnasRj
   3a7AEgoxK5wgbROuAoFLomqWs9FfuyrejxSriyqjX4sy5CjKuw6Oz2bQ2
   xsSGxqTNo3DFboAkCVG7ESpOY8fmIw9v9621ooJyKxmEzO9UZwCWOPXij
   +7Lq+ul/LsBHhQ53A6AJ+vOH44SW5kSXZiks6XbcK4udTG5cUSQX0mbc4
   1IINx4E4rZDk8mHnKQhDqaSvEM1SIEGQ+7qXBvyFT3l/uiC+a7qLkkLXi
   gOHmrdV9rXvjwqjou4/+FXjOK17lt9j8S1lC9xDaPIqcEAFY5ZbOmNBbP
   g==;
X-IronPort-AV: E=Sophos;i="5.51,245,1526313600"; 
   d="scan'208";a="83243181"
Received: from mail-by2nam01lp0175.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2018 09:35:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A50QjFGBhdOzI9wtsnWPiFMi10F1JLuhWwsd4klL3o8=;
 b=OLjBOPzCODLdjx0sPA5/imzv06MrUXPxGHhlXDrxPchMv7pwqstGpkbEkPVVp0Uxts6SmCxYZH1DSvFWa/obaXgTCwypVDl+vFOC7tJqNnu79ev/RmgUb7zlgOjCgYFEIXQIoEZhBXMowZzbQo605ytTy0tQariQSbmZ/85WUk8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0782.namprd04.prod.outlook.com (10.172.168.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 01:35:48 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 01:35:48 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
Thread-Topic: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
Thread-Index: AQHUB5sHt3Tm1rT3wE6GHzvCbSQoQaRnsjkAgACqdgCAAAIhgA==
Date:   Wed, 20 Jun 2018 01:35:48 +0000
Message-ID: <08b5a3e94f2265815a98abae7a8dde0894512d4e.camel@wdc.com>
References: <1529391610-1654-1-git-send-email-jianchao.w.wang@oracle.com>
         <884a5cbb5622ca5c890585a8d5dff0e3a1d60cfe.camel@wdc.com>
         <dd0484f6-ad41-5607-107f-4c487a739478@oracle.com>
In-Reply-To: <dd0484f6-ad41-5607-107f-4c487a739478@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0782;7:G7w76rqzMo7VLxoNIwzPjcdrpQ+KIn1ht7Wd27WQrPXjnWj8rxrvpJ5LikRPhEeLneXmgVc1h6oEF9duSZ33rgCgQuBp8rZgX1YNapCwKKqgJtlTJcwdPrjDlQInGmTOMVnF0v+HrseC+JpACEjCCxtWZt1zKpdw50//5TJ9PauDU4urOOPvqIw3QSBBjsdRehbbbnJ0AjjN/4h7ueVOOd9D9X3bczEaOMMWGb4fO5def05IM/td0IKQtLM9kwiq;20:YXEPKwX3GnKyfOaOGMygaYg7jI2cmHrKT1jeD5c3Rdtb+83wiwWFSgSxldBCaPQkNBhU8Nijsy43n6lDVj7LkQSCObhfaZ+4LkgDQ5BLtV2FcdccJO+Y2E3O7WVB8j0t/5KxqkbQbQ1LVF+1aDQX/xeKiryjcnAoeFnCl5ih/Mo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 250185e5-1177-4503-a746-08d5d64e266a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0782;
x-ms-traffictypediagnostic: MWHPR04MB0782:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0782DEEC40F0C5C009F2BFC398770@MWHPR04MB0782.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0782;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0782;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(39860400002)(376002)(199004)(189003)(6506007)(6486002)(76176011)(7736002)(4326008)(97736004)(8676002)(6246003)(102836004)(53546011)(305945005)(2616005)(11346002)(26005)(478600001)(81156014)(53936002)(6436002)(486006)(8936002)(476003)(6512007)(186003)(81166006)(446003)(72206003)(36756003)(3660700001)(54906003)(59450400001)(118296001)(2501003)(229853002)(86362001)(5250100002)(25786009)(6116002)(3846002)(68736007)(2900100001)(14454004)(5660300001)(3280700002)(110136005)(105586002)(2906002)(316002)(106356001)(99286004)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0782;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FlHLpMbsA8/KOPAC133dY5oy+eQOUlhM2iXoqhNdEgQB8BBLnfZ+ZIoy4j4nu4OlXNjNq1KCKayhz2ygNQx/GP8ozThSzDOn3RcnPJ26b+Gw8TDJl5HHa6ojqsm4KE+jO0vspuyvzbRp1ecvSiYPma34pFfLAsBRncmR8OAG09DBrJVpvzyBCH7wW0BapUkGTJsWtqpoYGSi7EZowiRaZhqzgoVrb0RPaFfBn5jJCktcAk42gAMkRKaJdk6eS89OaoUosinIJD3uD+7EqHf9J2DxRkc6oxQ15Uwgsbf0+wOYSskTVJ2tnv5nZBJGrLGc2UEutQsnTL/Z9b0eAat+pw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A533FF31A4F8A64FA3EBFC0233643469@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250185e5-1177-4503-a746-08d5d64e266a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 01:35:48.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTIwIGF0IDA5OjI4ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBIaSBCYXJ0DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIga2luZGx5IHJlc3BvbnNlLg0KPiANCj4g
T24gMDYvMTkvMjAxOCAxMToxOCBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAxOC0wNi0xOSBhdCAxNTowMCArMDgwMCwgSmlhbmNoYW8gV2FuZyB3cm90ZToNCj4gPiA+
IGJsa19ycV90aW1lb3V0IGlzIG5lZWRlZCB0byBsaW1pdCB0aGUgbWF4IHRpbWVvdXQgdmFsdWUs
IG90aGVyd2lzZSwNCj4gPiA+IGEgaWRsZSBoY3R4IGNhbm5vdCBiZSBkZWFjdGl2YXRlZCB0aW1l
bHkgaW4gc2hhcmVkLXRhZyBjYXNlLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogMTJmNWI5MzEgKGJs
ay1tcTogUmVtb3ZlIGdlbmVyYXRpb24gc2VxZXVuY2UpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBK
aWFuY2hhbyBXYW5nIDxqaWFuY2hhby53LndhbmdAb3JhY2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gIGJsb2NrL2Jsay1tcS5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYmxvY2sv
YmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiA+ID4gaW5kZXggNzBjNjViYi4uY2NlYmU3YiAx
MDA2NDQNCj4gPiA+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jDQo+ID4gPiArKysgYi9ibG9jay9ibGst
bXEuYw0KPiA+ID4gQEAgLTg2OCw3ICs4NjgsNyBAQCBzdGF0aWMgdm9pZCBibGtfbXFfdGltZW91
dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+ICAJYmxrX21xX3F1ZXVlX3Rh
Z19idXN5X2l0ZXIocSwgYmxrX21xX2NoZWNrX2V4cGlyZWQsICZuZXh0KTsNCj4gPiA+ICANCj4g
PiA+ICAJaWYgKG5leHQgIT0gMCkgew0KPiA+ID4gLQkJbW9kX3RpbWVyKCZxLT50aW1lb3V0LCBu
ZXh0KTsNCj4gPiA+ICsJCW1vZF90aW1lcigmcS0+dGltZW91dCwgYmxrX3JxX3RpbWVvdXQocm91
bmRfamlmZmllc191cChuZXh0KSkpOw0KPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gIAkJLyoNCj4g
PiA+ICAJCSAqIFJlcXVlc3QgdGltZW91dHMgYXJlIGhhbmRsZWQgYXMgYSBmb3J3YXJkIHJvbGxp
bmcgdGltZXIuIElmDQo+ID4gDQo+ID4gSGVsbG8gSmlhbmNoYW8sDQo+ID4gDQo+ID4gV2hhdCBt
YWtlcyB5b3UgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBuZWNlc3NhcnkgdG8gY2FsbCBibGtfcnFf
dGltZW91dCgpIGZyb20NCj4gPiBibGtfbXFfdGltZW91dF93b3JrKCk/IEhhdmUgeW91IG5vdGlj
ZWQgdGhhdCBibGtfYWRkX3RpbWVyKCkgYWxyZWFkeSBjYWxscyB0aGF0DQo+ID4gZnVuY3Rpb24/
IEkgdGhpbmsgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBjYWxsIGJsa19ycV90aW1lb3V0KCkgZnJv
bQ0KPiA+IGJsa19tcV90aW1lb3V0X3dvcmsoKSBiZWNhdXNlIGl0IGlzIGd1YXJhbnRlZWQgaW4g
dGhhdCBmdW5jdGlvbiB0aGF0IHRoZSBuZXh0DQo+ID4gdGltZW91dCBpcyBsZXNzIHRoYW4gQkxL
X01BWF9USU1FT1VUIGppZmZpZXMgaW4gdGhlIGZ1dHVyZS4NCj4gPiANCj4gDQo+IGJsa19hZGRf
dGltZXIgd2lsbCBub3QgcmUtYXJtIHRoZSB0aW1lciBpZiB0aGUgdGltZXIncyBleHBpcmUgdmFs
dWUgaXMgYmVmb3JlIHRoZSBuZXcgcnEncyBleHBpcmUgdmFsdWUuDQo+IA0KPiBMZXQncyBsb29r
IGF0IHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8uDQo+IA0KPiAwICAgICAgICAgICAgICAgICAgICAr
MzBzDQo+ID4gX19fX19fX19fX19fX19fX19ffF9fX3wNCj4gDQo+IFQwICAgICAgICAgICAgICAg
IFQxICAgVDINCj4gDQo+IFQxID0gVDIgLSAxIGppZmZpZXMgDQo+IA0KPiBUMDogIHJxX2EgaXMg
aXNzdWVkIGFuZCBxLT50aW1lciBpcyBhcm1lZCBhbmQgd2lsbCBleHBpcmUgYXQgVDINCj4gICAg
ICB0aGVuIHJxX2EgaXMgY29tcGxldGVkLg0KPiBUMTogIHJxX2IgaXMgaXNzdWVkIGFuZCBxLT50
aW1lciBpcyBub3QgcmUtYXJtZWQsIGJlY2F1c2UgaXRzIG5leHQgZXhwaXJlIHRpbWUgaXMgVDIg
PCAoVDEgKyAzMHMpDQo+IA0KPiBUMjogIGlmIHJxX2IgaGF2ZSBub3QgYmVlbiBjb21wbGV0ZWQg
d2hlbiB0aW1lciBleHBpcmVzIGF0IFQyLCB0aW1lciB3b3VsZCBiZSByZS1hcm1lZCBiYXNlZCBv
biB0aGUgcnFfYiANCj4gICAgICBJZiB3ZSBkb24ndCBoYXZlIGJsa19ycV90aW1lb3V0IGhlcmUs
IHRoZSBuZXh0IGV4cGlyZSB0aW1lIGlzIGFib3V0IFQyICsgMzBzLg0KDQpIZWxsbyBKaWFuY2hh
bywNCg0KSSBkaXNhZ3JlZSB3aXRoIHRoZSBsYXN0IHNlbnRlbmNlIGFib3ZlLiBJIHRoaW5rIGZv
ciB5b3VyIGV4YW1wbGUgYmxrX21xX3JlcV9leHBpcmVkKCkNCndpbGwgc2V0IG5leHQgdG8gVDEg
KyAzMHMgaW5zdGVhZCBvZiBUMiArIDMwcy4NCg0KQmFydC4NCg0KDQo=
