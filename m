Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84382C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2BC208C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z9rPET6N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kOy5NTjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2BC208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935678AbeFMNL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:11:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18742 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeFMNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528895485; x=1560431485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Uitf1jZleCwh7rD1w9pIolr4r4r6pQzzToNh1Gtj4Xo=;
  b=Z9rPET6NKNM3eGgnxG8/4kVksv+PsTQEqo++tLhCSll9RUl/z8/MJXcx
   bT3MptqsSBYWkpglClyeBEE/dyFfNEQa4XTJWVWtci+AJ+stvBBrc8S5G
   UfMJA3MTVS07Dt4KHB5/VyU+iSNWd5WhrUwYmly32Z4H1FMkwKwVojCfW
   /mLSixk/kftQo5Ae0S3d9rM/CT2fIev/5lTtN4W76hWncAqdlMWUdk2AP
   LZZTVqpqEqEoRh45+m+DYQCOqiXnlvp3ZYx3MDqo+SIFQtHKxNtd+3Dw2
   +YhoeabcefBDKhomJFdW7bQQW8orR5IT0hCi57dGRvPMAp0cdWSfpEK+C
   g==;
X-IronPort-AV: E=Sophos;i="5.51,218,1526313600"; 
   d="scan'208";a="82408822"
Received: from mail-bl2nam02lp0079.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.79])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 21:11:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uitf1jZleCwh7rD1w9pIolr4r4r6pQzzToNh1Gtj4Xo=;
 b=kOy5NTjzvVfeslRAmQfGYT0i5mkZbxFVImzV44n5P6u2dKfDXnQvWcdpQFim0e4i62WTo4tLfnEZXFOlwt6G/Ycuh1bNQqH+eDbOVO3VavB4bSHfacw1PKEfm3npWIRwxwueafWOvF6goNACrF3sFKKjBqu85tySbRQV36VlJx0=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0433.namprd04.prod.outlook.com (10.173.48.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Wed, 13 Jun 2018 13:11:19 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Wed, 13 Jun 2018
 13:11:19 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/3] scsi: don't add scsi command result bytes
Thread-Topic: [PATCH v2 3/3] scsi: don't add scsi command result bytes
Thread-Index: AQHUAuvzvEj5/zBGu0mBzpDKIWnc5aReFh+AgAAUEAA=
Date:   Wed, 13 Jun 2018 13:11:19 +0000
Message-ID: <1c08057c85227d07013b9e3a9d8b9e574c62a068.camel@wdc.com>
References: <20180613075349.7509-1-jthumshirn@suse.de>
         <20180613075349.7509-4-jthumshirn@suse.de>
         <20180613115929.GC12438@infradead.org>
In-Reply-To: <20180613115929.GC12438@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0433;7:DnUjS59STUhwoWoL1sRsK9aTPLvaB/mDj73zjfRK3jT0xG3Lh9JyIqE4WYqjQRUs4IC9LRKbfC81zGj3kvGaLZInBgYUFkXeTJjVPGmTuxaDJHUOHZGU04f/INGk5LZ2Cl99XVfISDwd+H6SWz8pIgglYZ0YttVFV6q1b//rxbcI3PW9ZSf7kUJSvHZ+lGDsOH4So11Gk8vq/MPWw1lkLomWp5QjwxJ1cKXqZWusf0P2SlF+wvy2VUAUsJ5RRYaZ;20:fC4BzmXH7i9TATKv8D/djddffdN9JK4Onlz5DW10Mt+ktLRUGPFNXaVJ7WuXN2kYsk3SAg8zEJW5C8Drxi4aJVYmUoHqOwTG1tpY5AkggCn11eKYB/kkiyH47CKYuaprJmb5e0cVWf77BKivYfecQBleUxbI7xf5F1smp3oGNIE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c475613-9ade-451a-f0a5-08d5d12f274c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0433;
x-ms-traffictypediagnostic: MWHPR04MB0433:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0433255744F5401D42F1F092987E0@MWHPR04MB0433.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0433;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0433;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(72206003)(66066001)(36756003)(11346002)(305945005)(86362001)(186003)(446003)(7736002)(2900100001)(26005)(3280700002)(118296001)(476003)(2616005)(4326008)(6246003)(8936002)(5660300001)(6512007)(3660700001)(478600001)(53936002)(8676002)(81166006)(81156014)(5250100002)(54906003)(76176011)(68736007)(97736004)(3846002)(106356001)(2906002)(2501003)(6506007)(110136005)(14454004)(102836004)(6116002)(99286004)(486006)(25786009)(6486002)(316002)(229853002)(105586002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0433;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Yg7MVZllpRk91MxHCJC4JW97A8l/OA37f217+5JHroaUIuC5DU5LVLimDCkaGVWVZ5l/X0M4PiMFscV8qvsVB7QnXfRkMELyNhAmZKHODGTBtlRYwm056zTyEAVZbLireq+z9AYE9Tbcqin/CRJbxDXE9x5iDOxm8kU6ktOchzw/PtX4JpwJhFaZ3lNEJzOl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9BD69C245029F4ABEE91EDABB200936@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c475613-9ade-451a-f0a5-08d5d12f274c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 13:11:19.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTEzIGF0IDA0OjU5IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBKdW4gMTMsIDIwMTggYXQgMDk6NTM6NDlBTSArMDIwMCwgSm9oYW5uZXMg
VGh1bXNoaXJuIHdyb3RlOg0KPiA+IFNvbWUgZHJpdmVycyBhcmUgQUREaW5nIHRoZSBzY3NpIGNv
bW1hbmQncyByZXN1bHQgYnl0ZXMgaW5zdGVhZCBvZg0KPiA+IE9SaW5nIHRoZW0uDQo+ID4gDQo+
ID4gV2hpbGUgdGhpcyBjYW4gcHJvZHVjZSBjb3JyZWN0IHJlc3VsdHMgaXQgaGFzIHVuZXhwZWN0
ZWQgc2lkZSBlZmZlY3RzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8anRodW1zaGlybkBzdXNlLmRlPg0KPiANCj4gTG9va3MgZ29vZCwNCj4gDQo+IFJldmll
d2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQo+ID4gLQkJCWNtZC0+
cmVzdWx0ID0gKERJRF9PSyA8PCAxNikgKyAobCAmIFNUQVRVU19NQVNLKTsNCj4gPiArCQkJY21k
LT5yZXN1bHQgPSBESURfT0sgPDwgMTYgfCAobCAmIFNUQVRVU19NQVNLKTsNCj4gDQo+IEFsdGhv
dWdoIEkgd291bGQgaGF2ZSBrZWVwIHRoZSBicmFjZXMgYXJvdW5kIHRoZSBzaGlmdCBvcGVyYXRv
cnMNCj4gdG8gc3RpY2sgY2xvc2VyIHRvIHRoZSBvcmlnaW5hbCBjb2RlLiAgQnV0IHRoZSBjb2Rl
IHNob3VsZCBiZSBmaW5lDQo+IGV2ZW4gd2l0aG91dCB0aGVtLg0KDQpJIHNoYXJlIENocmlzdG9w
aCdzIG9waW5pb246IEkgcHJlZmVyIHRoYXQgdGhlIHBhcmVudGhlc2VzIHdvdWxkIGJlIGtlcHQg
YnV0DQpJJ20gYWxzbyBmaW5lIHdpdGhvdXQuIEhlbmNlOg0KDQpSZXZpZXdlZC1ieTogQmFydCBW
YW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KDQoNCg0K
