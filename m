Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B08AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633C20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wIx1QV91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9633C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeGYQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:28:46 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:41861
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbeGYQ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e1FK4gdHekyvJo/cLqaolvWzHMfhRh1QhWdxi3ck8Q=;
 b=wIx1QV91eBiYqXjqPgoEcq/lTBhfsTtyqQw4/gblghi3duaPrfZfFXHLggxl/hv5enPCSR5JsHdrrZ115xejFgPPbhnNBYxCZGtFEmlYY3LejAD0cQlWyUlRwYWpW+aW10UN3UKmS52WuFDg05kt3nU2jJPk8MqQh59pbPuDO78=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3342.namprd02.prod.outlook.com (10.164.187.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Wed, 25 Jul 2018 15:14:55 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.014; Wed, 25 Jul 2018
 15:14:55 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUJA3sROLEOOfQMEemCHeBIrzYkaSgCeIAgAAA61A=
Date:   Wed, 25 Jul 2018 15:14:55 +0000
Message-ID: <MWHPR02MB2816A41E9C145BC8D89F834AA7540@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <CAHp75VfM8h9CKXO9bfmF74fcLW68Rs+1514Je=o1jOFd52Uf7A@mail.gmail.com>
In-Reply-To: <CAHp75VfM8h9CKXO9bfmF74fcLW68Rs+1514Je=o1jOFd52Uf7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3342;6:Bp0Xa0mJALjcX2vBpfNUTwHPlEFSabYfpc8+gKfyHQdGS1G/Ih4jvlKUyJCSiiDfe62DzHJddRVj+fLFXh+8g0pCNWLpAlGAYYTpDBc0gpavQu9PEzy1SxkvB2bq54Wsbrugl/yYMDJvyJ9ZAY5+3Jg054XtYp68gbA7KD6wKayCk+uqUIrlZqlqofWGL93OsEPYyh2HIifcETyGeKm0pdKaIrOO0dVd2eOLbNWqTsRAU/3/1mWbdZzZVNWmddfeEmMjzW1tr2IqGGEiUH9ndK19pM+4FKHh8Hzc6kuUuOGisGl+2xBHaHYStuJIIQF+kanixvR9z+KxO4WCOrOxkqNDL2p1JO2HuoopHa3CS0vGh4BbW5tR6fyQIlp94TVAPSiPu1k6plAzqE+qaST/te7yx6xGUpT14592rUQGVqyUEYcuWHdiMIj3orEtCEzVeHgXyYJl92w02vWE9EkBSQ==;5:FEPwkjE4e/iApqRRXTB4aWXWSyvPUOpfzel/Akd6ReqwxH6/sCcnJDThyyomacfs8mwwDDLOlmofszsYn3ym7/g1EbEf1DoAgCpJ6lDeasL+EOoN6+CEdNdpWWlagzGxSoKuzi4CZppUtXT/6TocGXXsDwD5V1a4WX+D+wCFRIo=;7:2otz0HrrSLstQGtl9CICBBuG+3Z2q6y3+ClXuqsTT09VaBBGgYqZCM7iCiPwwdyp1V44rflLaUJQtdhgDGQLEI4UNgMhWcX04zlyGfCa4wwp0xcUYLInEGQ94JADS1Z6SE7M/rflhmohZoP2HaBNwhtLKNPpiH2GRjsjbKinFZjHJOsZi02tDIGuZIxhJ7Qg4UPrnZ/3mAV06i86UHvbgsnlTPKK5reUr6GC2YapUUntTQHirLiL3ykmB34ZZ0+L
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e65937e1-e89b-41a9-667c-08d5f24160dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3342;
x-ms-traffictypediagnostic: MWHPR02MB3342:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB33428481716DA1C4C61DCC53A7540@MWHPR02MB3342.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3342;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3342;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(13464003)(8676002)(4326008)(54906003)(99286004)(5250100002)(6116002)(7736002)(305945005)(229853002)(74316002)(39060400002)(478600001)(33656002)(81166006)(81156014)(3846002)(97736004)(55236004)(186003)(86362001)(6916009)(105586002)(5660300001)(26005)(316002)(66066001)(106356001)(102836004)(53936002)(2906002)(476003)(256004)(11346002)(6436002)(55016002)(14454004)(446003)(6506007)(25786009)(9686003)(2900100001)(7696005)(68736007)(6246003)(486006)(76176011)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3342;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JnEmTV9c9yajycF8aFLyO6ycsmDbU96w8Pt/C9tg/0AHWxFEtJxJkS/KH4nqvYla2dxB24MTvfMPTwb5NOb9Aht2D4FYlLMdtduRUKqEmDWXAygAvwXNx5CsuUSDwUyyFH7Z862EaRPlKpfyT/NQmnkIpUy9lhzaE+/g0PgQ+5RIIggOKnxIFmMStfBuHMADmXlhFP1PaYca2ekUZiS6QyYtHd5UiVsAb2fxP5PEUkvvb0rohm3widLBnIF8MonHWZ5NY8mwEEEO8qx0g1BPb9N679ir8z8PHQ0SkF9E0jpNKbbiYADgm0qdGpzLCKgB6oHSjmV54cxfRl8gzeNpilWHQOtRN4FWe9q1QWT+y80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65937e1-e89b-41a9-667c-08d5f24160dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 15:14:55.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cywgcGxlYXNlIGZpbmQg
bXkgY29tbWVudHMgaW5saW5lIA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBBbmR5IFNoZXZjaGVua28gW21haWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPlNl
bnQ6IFdlZG5lc2RheSwgSnVseSAyNSwgMjAxOCA4OjM2IFBNDQo+VG86IEFudXJhZyBLdW1hciBW
dWxpc2hhIDxhbnVyYWdrdUB4aWxpbnguY29tPg0KPkNjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtl
cm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj48Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+OyB2LmFudXJhZ2t1bWFyQGdtYWlsLmNvbTsgVVNCIDxsaW51eC0NCj51c2JAdmdlci5rZXJu
ZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDQvOF0gdXNiOiBkd2MzOiBpbXBsZW1lbnQg
c3RyZWFtIHRyYW5zZmVyIHRpbWVvdXQNCj4NCj5PbiBXZWQsIEp1bCAyNSwgMjAxOCBhdCAyOjUx
IFBNLCBBbnVyYWcgS3VtYXIgVnVsaXNoYQ0KPjxhbnVyYWcua3VtYXIudnVsaXNoYUB4aWxpbngu
Y29tPiB3cm90ZToNCj4+IEFjY29yZGluZyB0byBkd2MzIGRhdGFib29rIHdoZW4gc3RyZWFtcyBh
cmUgdXNlZCwgaXQgbWF5IGJlIHBvc3NpYmxlDQo+PiBmb3IgdGhlIGhvc3QgYW5kIGRldmljZSBi
ZWNvbWUgb3V0IG9mIHN5bmMsIHdoZXJlIGRldmljZSBtYXkgd2FpdCBmb3INCj4+IGhvc3QgdG8g
aXNzdWUgcHJpbWUgdHJhbnNjYXRpb24gYW5kIGhvc3QgbWF5IHdhaXQgZm9yIGRldmljZSB0byBp
c3N1ZQ0KPj4gZXJkeS4gVG8gYXZvaWQgc3VjaCBkZWFkbG9jaywgdGltZW91dCBuZWVkcyB0byBi
ZSBpbXBsZW1lbnRlZC4gQWZ0ZXINCj4+IHRpbWVvdXQgb2NjdXJzLCBkZXZpY2Ugd2lsbCBmaXJz
dCBzdG9wIHRyYW5zZmVyIGFuZCByZXN0YXJ0IHRoZQ0KPj4gdHJhbnNmZXIgYWdhaW4uIFRoaXMg
cGF0Y2ggZG9lcyB0aGUgc2FtZS4NCj4NCj4+ICsvKg0KPj4gKyAqIFRpbWVvdXQgdmFsdWUgaW4g
bXNlY3MgdXNlZCBieSBzdHJlYW1fdGltZW91dF90aW1lciB3aGVuIHN0cmVhbXMNCj4+ICthcmUg
ZW5hYmxlZCAgKi8NCj4+ICsjZGVmaW5lIFNUUkVBTV9USU1FT1VUICAgICAgICAgNTANCj4NCj5Q
ZXJoYXBzLCBTVFJFQU1fVElNRU9VVF9NUyA1MA0KPg0KPkR1bm5vIGFib3V0IHRoaXMgZHJpdmVy
LCBidXQgaXQncyBhIHVzdWFsIHByYWN0aWNlIHRvIGhlbHAgcmVhZGVyIHdpdGggdW5kZXJzdGFu
ZGluZw0KPmNvZGUgb24gdGhlIGZpcnN0IGdsYW5jZS4NCj4NCg0KU2luY2UgSSBoYXZlIG1lbnRp
b25lZCAibXNlY3MiIGluIGNvbW1lbnQgYWJvdmUgZGVzY3JpYmluZyB0aGUgU1RSRUFNX1RJTUVP
VVQsDQp0aG91Z2h0IGl0IHdvdWxkIHN1ZmZpY2UuIEJ1dCBpZiB5b3UgZmVlbCBJIHNob3VsZCBj
aGFuZ2UgaXQsIEkgIHdpbGwgZml4IGl0IGluIHYyDQoNClRoYW5rcywNCkFudXJhZyBLdW1hciBW
dWxpc2hhDQogDQo+LS0NCj5XaXRoIEJlc3QgUmVnYXJkcywNCj5BbmR5IFNoZXZjaGVua28NCg==
