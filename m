Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24F920645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="RHN3nnJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24F920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJHONt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:13:49 -0400
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:31568
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbeJHONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v11nLzLayG3wI4lIvQLu8Ul2w2tUHpAZre9WNbB5+54=;
 b=RHN3nnJ7TuYiYSVgFtFbRwaLYwhRyxxl0F8IKs144Hhv53JDymSWBNpxU9CWgjJF5n/3MJqDLyOAiNkEf9C6rS9koaoTcNgUp6yafKVrhWqJrhkTxC9Qkhewk0fv+mw775iNKVVOZHIvoC9QrPPD5U6lcLjT421YQTZal0hD+54=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB602.namprd06.prod.outlook.com (10.141.229.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 07:03:30 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::6129:91b3:d75e:2a2f]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::6129:91b3:d75e:2a2f%4]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 07:03:29 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [V2 PATCH 0/2] lightnvm: pblk: retrieve chunk metadata on erase
Thread-Topic: [V2 PATCH 0/2] lightnvm: pblk: retrieve chunk metadata on erase
Thread-Index: AQHUXRHJvKtl7Q30HE2uH26/56kQvqUU7+TJ
Date:   Mon, 8 Oct 2018 07:03:29 +0000
Message-ID: <B49B713F-1E73-44B1-BFB1-34D91EC6A88C@cnexlabs.com>
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>,<afc7d53c-b514-293d-f876-f2bdaa3c5dbb@lightnvm.io>
In-Reply-To: <afc7d53c-b514-293d-f876-f2bdaa3c5dbb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [77.241.142.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB602;6:wTPLzi94joQaZMUrNrT0ABjCHpydPUHA1dhtgr9gdDYMACUfqwFlHzCofbnfPbex2CR8CD1aOIiIbxJk9UTHnwOHLCj3tJkYy4asVsaA4ChCqMgee9w6/bWvDT6Q4zRMr/Jan2HJBnBtYQIAB/RmQhUXIrdlrs55AtkaiPw55XoIUdbbc8izhsVlI3yKtytuAgJ5ET8J1csO+Q/UupEohAQ2ZLAv9nozjBS/I/ApfrFaH5ZqSks12o3h+qcuXAZoC/aQV9Zvv/RLSCLrwBAJZiQhZjYEOJ/dLhF5F5/39e0j2s8445x/J/5Qv9RZ5AjswREtMDLlmawXveQzzKu8ZpDwtbaW8Hg3KimGGkA5IjBhDH+l/BvYetyTvUDRTncYieaSdbTfxICDwmHy9T2defviO4V9ubLZO+QwSznRZXj6F+oGSR08loPMthwT4EVTRog1s6YqYGprtjOGi9jxbQ==;5:OGh4kuUoGhtrFnCuVqa06neMQgypRPZ5zTa0WJUCPut2OPr5a/KCIfAkTZT20JqRWunXxU77S0Rbv1RxbhKMSywcZhfC5AZg2tFxSkZkRl9fPp106RAGvisNwMAN7eZWf3ZefLg3pwhYDgHQDS7Rab066VJdKQr+wfvmqEsi7bE=;7:69/uMyuW/WKugDxHPxez0hePUQrdNujB1pxAejXBGBW3pkwmp9AlwjSeA/maiOEI6Euxp5vXVKhV1OIJnc6bzoq3kJce1kwxYuP3R35pjsuiFsjeOLb0W6QHiBP48QAFdlAdvgxgRUUHqVsc8VVWpKi2F567SKlVKZRcuGE2G0znJBYdv9RyNGvWtbmWMOxKHrBzftFEIhrVyRQ7VWFfc+seNpdAEsl6RXNt16QYr6ZlUXL76l3znBx32cKtQvjR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7deac2ca-cba7-49d7-eae7-08d62cec2713
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB602;
x-ms-traffictypediagnostic: CO2PR06MB602:
x-microsoft-antispam-prvs: <CO2PR06MB602EC49EE3F06647A2E65BDBAE60@CO2PR06MB602.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CO2PR06MB602;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB602;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39830400003)(376002)(366004)(346002)(396003)(189003)(199004)(52314003)(26005)(6436002)(5660300001)(102836004)(66574009)(6506007)(53546011)(76176011)(6246003)(7736002)(305945005)(256004)(14444005)(6116002)(3846002)(229853002)(33656002)(186003)(68736007)(83716004)(71190400001)(105586002)(53936002)(8936002)(81166006)(81156014)(8676002)(71200400001)(106356001)(316002)(54906003)(2616005)(5250100002)(11346002)(446003)(99286004)(486006)(6512007)(6916009)(66066001)(25786009)(2900100001)(4326008)(14454004)(478600001)(97736004)(82746002)(86362001)(2906002)(476003)(6486002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB602;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n6sgob0AGf4S2VP+7l1d7J1FtIVXydoGxyP+i6gM5YrCUXTOjJnA4eJ79qWwM7wXOpWzMsHI/9bdwVHx/fAmXASS94+ItYgMwbsHhscOwZuzM7SNLkqJzeK/Qf9kHo86xktuYIy7zqAiPgfoGGAplJPLt05Z1MSDHWSRDhxOr9a9bkyiu9p8ABASfUCvGGfv2CUuBSMqVuq1ATkBsNw+S4dI03LLa+UYS0CD3FysHZwMFUvBls+GVtiU6KcJrfGJ8mu4j9MhEJgIZELJ4UqWAFt7b8CH2lwtmjAhnbIJc/QJcandBIZOGKGnqhpGDqBtcL20J2ac0qSSP4P88eKWugWeXCEsaSl81dOYaL/cRhs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deac2ca-cba7-49d7-eae7-08d62cec2713
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 07:03:29.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDYgT2N0IDIwMTgsIGF0IDAzLjEzLCBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdodG52
bS5pbz4gd3JvdGU6DQo+IA0KPj4gT24gMTAvMDQvMjAxOCAwOToxMyBBTSwgSmF2aWVyIEdvbnrD
oWxleiB3cm90ZToNCj4+IENoYW5nZXMgc2luZ2UgVjE6DQo+PiAgIC0gcmVtb3ZlIHNhbml0eSBj
aGVja3Mgb24gdGhlIGZhc3QgcGF0aA0KPj4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBv
cnQgZm9yIHJldHJpZXZpbmcgY2h1bmsgbWV0YWRhdGEgb24gcmVzZXQuDQo+PiBUaGlzIGlzIHRo
ZSBiYXNlIGZvciBpbXBsZW1lbnRpbmcgd2Vhci1sZXZlbGluZyBhbmQgYWxsb3dpbmcgY2h1bmtz
IHRvDQo+PiBzaHJpbmsgYXQgcnVudGltZS4NCj4+IEphdmllcg0KPj4gSmF2aWVyIEdvbnrDoWxl
eiAoMik6DQo+PiAgIGxpZ2h0bnZtOiBwYmxrOiBhZGQgaGVscGVyIGZvciBwcmludGluZyBjaHVu
ayBzdGF0ZQ0KPj4gICBsaWdodG52bTogcGJsazogcmV0cmlldmUgY2h1bmsgbWV0YWRhdGEgb24g
ZXJhc2UNCj4+ICBkcml2ZXJzL2xpZ2h0bnZtL2NvcmUuYyAgICAgIHwgNDQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+PiAgZHJpdmVycy9saWdodG52bS9wYmxrLWNvcmUu
YyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+PiAg
ZHJpdmVycy9saWdodG52bS9wYmxrLmggICAgICB8ICA5ICsrKysrKysrDQo+PiAgMyBmaWxlcyBj
aGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IFJpZ2h0IG5v
dyB0aGVyZSBpc24ndCBhIHdheSBpbiB0aGUgc3BlYyB0byB0ZWxsIGlmIHRoZSBkcml2ZSBzdXBw
b3J0cyB0aGlzIGZlYXR1cmUgb3Igbm90LCBhbmQgRFNNIFJlc2V0IGRvZXNuJ3Qgc3VwcG9ydCBp
dCBlaXRoZXIuIE1ha2luZyBpdCBhIGJ1ZyBpbiB0aGUgc3BlYy4gVW50aWwgdGhlIHVwZGF0ZWQg
c3BlYyBpcyBvdXQsIEkgbGlrZSB0byBhdm9pZCBhZGRpbmcgdGhpcyBmZWF0dXJlIGludG8gdGhl
IGtlcm5lbC4NCg0KU3VyZS4gSXQgaXMgdGhlIHNhbWUgYnVnIHdlIGhhdmUgd2hlbiB0aGUgcmVh
ZC93cml0ZSBjb21tYW5kcyBkbyBub3Qgc2lnbmFsIGlmIHRoZSBtZXRhZGF0YSBwb2ludGVyIGlz
IHNldCBvciBub3QuIFRoaXMgaGFzIG5vdCBwcmV2ZW50ZWQgY3VycmVudCBpbXBsZW1lbnRhdGlv
bnMgb2YgdGhpcyBmZWF0dXJlIHRob3VnaC4gDQoNCkFueXdheSwgSSBzZWUgdGhlIHBvaW50OyB0
aGlzIG5vdCBhIGNyaXRpY2FsIHRoaW5nLCBzbyBsZXQgd2FpdCBhbmQgZ2V0IHRoaXMgZml4ZWQg
aW4gdGhlIG5ldyBzcGVjIHJlbGVhc2UuIFRoZXJlIGlzIGEgY291cGxlIG1vcmUgYnVncyB0aGF0
IEkgd291bGQgbGlrZSB0byBmaXguIEnigJlsbCBzZW5kIHlvdSBhbiBlbWFpbCBsYXRlciB0aGlz
IHdlZWsuICANCg0KRm9yIHRoZSBEU00gY29tbWFuZCBzZWVtcyBtb3JlIGRpZmZpY3VsdCBhcyBp
dCB3b3VsZCByZXF1aXJlIGNoYW5nZXMgdG8gdGhlIG52bWUgc3BlYy4gDQoNCj4gDQo+IFRoZSBH
ZXQgTG9nIFBhZ2UgYXBwcm9hY2ggY2FuIGJlIHVzZWQgZm9yIHdlYXItbGV2ZWxsaW5nIGluZm9y
bWF0aW9uLg0KDQpXZWxsLCBpdCBpcyBhbiB1bm5lY2Vzc2FyeSBvdmVyaGVhZCB0byBzZW5kIGEg
bG9nIHBhZ2UgdG8gcHVsbCB0aGUgZGF0YS4gU28gbGV04oCZcyBnZXQgaXQgZml4ZWQuIA0KDQo+
IFNpbWlsYXJseSBmb3Iga25vd2luZyB3aGVuIGEgY2h1bmsgc2hyaW5rLCBwYmxrIGNhbid0IHJl
bHkgb24gYSBjaHVuayBub3Qgc2hyaW5raW5nIGF0IHJ1bnRpbWUgKGFuZCByZXBvcnRpbmcgZWFy
bHkgY2xvc2UgZXJyb3IpLCBzbyBpbiB0aGUgY2FzZSB0aGlzIGhhcHBlbnMsIHBibGsgY2FuIGVp
dGhlciBjb250aW51ZSBidXNpbmVzcyBhcyB1c3VhbCwgb3IgcmVzeW5jIHdpdGggdGhlIGRyaXZl
Lg0KDQpTdXJlLCBpdOKAmXMgZGlmZmVyZW50IGxldmVscyBvZiBoYW5kbGluZyBhbmQgYWxsIHBh
dGhzIHNob3VsZCBiZSBpbXBsZW1lbnRlZC4NCg0KVGhhbmtzLA0KSmF2aWVyDQoNCg==
