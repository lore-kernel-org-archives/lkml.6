Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC076C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F573208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="R1yaVZyN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C6aPngBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F573208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeGFUeB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:34:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39499 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530910252; x=1562446252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hkTh7/52sASaqcXx48O3RvdJEYK/C3raVLIWHK7ZwZE=;
  b=R1yaVZyNx2mBVCp1LRwqys6focFe0GdOHoSvUemHW6enRPHETIAmP8eo
   bbHUk7ZoXbaURskmeEEgkYbFAKZaCIjN3Kqqs9KSXJ4pYO/Um2Oa2fPwS
   HeHk6s7vqo5HWVzJtouQuQxZ/pZ41rqxN+v2zGgqRmp1k59I8L0OOJnwR
   14Yyz0zHPU3+ni8+e1STdPMOm2H1+fmXeVOpnf0kazKEdYav/3LVZDgE9
   RoWhdPGoGjq/cB+UCDYDZYfNVG/ige9oX1MkrYDAcslzSVtiBGIRUeEuq
   gusXV15zylXZnNPqRr+RGRTRaWzyiBmMLneVGi9IwCCf76U5XjQJRC7tw
   g==;
X-IronPort-AV: E=Sophos;i="5.51,318,1526313600"; 
   d="scan'208";a="180421590"
Received: from mail-by2nam03lp0049.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.49])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2018 04:50:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkTh7/52sASaqcXx48O3RvdJEYK/C3raVLIWHK7ZwZE=;
 b=C6aPngBs24fn65/cqu3rZe8RGNIlmeNDrRJ/9Imt15NV62OBJOElk82noAthWUCypY9ahEJ71yXD/Th5OrdEe73Gz1X+IWFexikmcumQLg63Qu4YDya+1K6gA6iqGhAER2nHLaMU58czvo17DKRBC+WrbD073eSZKNzaBM+rzWc=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1247.namprd04.prod.outlook.com (10.174.175.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 6 Jul 2018 20:33:55 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Fri, 6 Jul 2018
 20:33:55 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] [v2] sbitmap, scsi/target: add seq_file forward
 declaration
Thread-Topic: [PATCH] [v2] sbitmap, scsi/target: add seq_file forward
 declaration
Thread-Index: AQHUFWbrrRwNdL4liUOTXc2apTP0fKSCpoIA
Date:   Fri, 6 Jul 2018 20:33:55 +0000
Message-ID: <1f0a1f94071fec75f511aeab8d5da15fef68ff69.camel@wdc.com>
References: <20180706201920.2185565-1-arnd@arndb.de>
In-Reply-To: <20180706201920.2185565-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1247;7:N7eQLw0LrxNFM3za/cDDgYvWwOGp/ADh3ogyv08yC2Mg6SI7aYIXaJ9+DPBigRNEpGw1H+zNPRvNamK7JIYhxo0jTZAswYHycAWePPIS2fEXIb8814dAWTxQApIYQ0yw1hMQccvU9SwcYvy5VoW2yw3pXEIWCy7yzDppppYuH9NTbzI8vpl1/4vKc7S73/NYnRjE2DoWp1rgDQAYdfK5flxj2icAsqnp9scM4JyBYXlQrLQT2DnKdfBHldvyaGOE;20:VIe3R1+G8bUlvNx1wXPox8j8xMv4QNqwFxTDIU1HLcxKXNHy2ZXbTuHqc7LakNdX8zvAgQX296Ce6uhBmCUYwO865GZZJbStlp2LE93/V8lq0TLVkHsAvucwcXofzGJnxanhzuctWmHxYnPp3TzX/mESEEfGZRQt3VHxHkSMtP4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e0db7130-0059-4ce0-9202-08d5e37fcb48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1247;
x-ms-traffictypediagnostic: MWHPR04MB1247:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1247AD7DFF90EA946D0E52D198470@MWHPR04MB1247.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1247;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1247;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(2616005)(6506007)(102836004)(186003)(478600001)(7416002)(5660300001)(2906002)(305945005)(72206003)(97736004)(14454004)(25786009)(105586002)(86362001)(6512007)(7736002)(256004)(26005)(2900100001)(53936002)(118296001)(11346002)(446003)(316002)(81156014)(6486002)(6436002)(8936002)(81166006)(106356001)(4326008)(2501003)(5250100002)(54906003)(3846002)(6116002)(476003)(36756003)(76176011)(486006)(8676002)(99286004)(68736007)(66066001)(229853002)(110136005)(6246003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1247;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kZGfIlqZJVI7tIOHPQX+oVr7FRXOfjMDRI54yyEAbyGIEr06Ksx/r2qFflmk27LxcTjUGg4vJWvc40RJyD2wFWod4bGNnlCiSZEOO/mjetW9NAdvjBOjuIgeX6iWMnDKQ1J8njP6BTUZmpXxPcBUIT2HFb567KMkgHxPvVSESn8YaCMPnrXpPZfpH+UZtznHt3tqFHS9ZvLKZhHwGpeqt+pKGcDC0HLIU5vvrdbLBkZBvK5ik8RFc+6Beuw2+dEWhoqPW3LxdORph7PCQ1DMEtLzxMwIGz67a+5ss2WND03iK9e3no/0o2zsccMwRM8fDUbH/gD7fkR3JEMi2i/wWr9GLslxeDYVxHEPGPIfHVM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <97C74474849952488F2E4E6ED8E90F2D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0db7130-0059-4ce0-9202-08d5e37fcb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 20:33:55.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDIyOjE5ICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBUaGUgdGFyZ2V0IGNvcmUgcnVucyBpbnRvIGEgd2FybmluZyBpbiB0aGUgbGludXgvc2JpdG1h
cC5oDQo+IGZpbGUgaW4gc29tZSBjb25maWd1cmF0aW9uczoNCj4gDQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSBpbmNsdWRlL3RhcmdldC90YXJnZXRfY29yZV9iYXNlLmg6NywNCj4gICAgICAgICAg
ICAgICAgICBmcm9tIGRyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2ZhYnJpY19saWIuYzo0MToN
Cj4gaW5jbHVkZS9saW51eC9zYml0bWFwLmg6MzMxOjQ2OiBlcnJvcjogJ3N0cnVjdCBzZXFfZmls
ZScgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0
c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24gWy1XZXJyb3JdDQo+ICB2b2lk
IHNiaXRtYXBfc2hvdyhzdHJ1Y3Qgc2JpdG1hcCAqc2IsIHN0cnVjdCBzZXFfZmlsZSAqbSk7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fg0K
PiANCj4gSW4gZ2VuZXJhbCwgaGVhZGVycyBzaG91bGQgbm90IGRlcGVuZCBvbiBvdGhlcnMgYmVp
bmcgaW5jbHVkZWQgZmlyc3QsDQo+IHNvIHRoaXMgZml4ZXMgaXQgd2l0aCBhIGZvcndhcmQgZGVj
bGFyYXRpb24gZm9yIHRoYXQgc3RydWN0IG5hbWUsIGJ1dA0KPiB3ZSBwcm9iYWJseSB3YW50IHRv
IG1lcmdlIHRoZSBwYXRjaCB0aHJvdWdoIHRoZSBzY3NpIHRyZWUgdG8gaGVscA0KPiBiaXNlY3Rp
b24uDQo+IA0KPiBGaXhlczogMTBlOWNiYjZiNTMxICgic2NzaTogdGFyZ2V0OiBDb252ZXJ0IHRh
cmdldCBkcml2ZXJzIHRvIHVzZSBzYml0bWFwIikNCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJn
bWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gLS0tDQo+IHYyOiBtb3ZlIGRlY2xhcmF0aW9uIHRvIHRo
ZSBzdGFydCBvZiB0aGUgaGVhZGVyLCBhcyBzdWdnZXN0ZWQgYnkgQmFydA0KPiAtLS0NCj4gIGlu
Y2x1ZGUvbGludXgvc2JpdG1hcC5oIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2JpdG1hcC5oIGIvaW5j
bHVkZS9saW51eC9zYml0bWFwLmgNCj4gaW5kZXggZTY1Mzk1MzZkZWE5Li44MDRhNTA5ODNlYzUg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc2JpdG1hcC5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvc2JpdG1hcC5oDQo+IEBAIC0yMyw2ICsyMyw4IEBADQo+ICAjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgDQo+ICtzdHJ1Y3Qgc2Vx
X2ZpbGU7DQo+ICsNCj4gIC8qKg0KPiAgICogc3RydWN0IHNiaXRtYXBfd29yZCAtIFdvcmQgaW4g
YSAmc3RydWN0IHNiaXRtYXAuDQo+ICAgKi8NCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2No
ZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4NCg0KDQoNCg0KDQoNCg==
