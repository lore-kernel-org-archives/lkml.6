Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B26C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B32324300
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B32324300
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeGDOzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:55:33 -0400
Received: from smtp-out6.electric.net ([192.162.217.181]:64807 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeGDOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:55:32 -0400
Received: from 1fajBn-0007v8-TO by out6a.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fajBo-00085n-V9; Wed, 04 Jul 2018 07:55:28 -0700
Received: by emcmailer; Wed, 04 Jul 2018 07:55:28 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6a.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fajBn-0007v8-TO; Wed, 04 Jul 2018 07:55:27 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Jul 2018 15:57:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Jul 2018 15:57:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Neal Cardwell' <ncardwell@google.com>,
        Jonathan Maxwell <jmaxwell37@gmail.com>
CC:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jmaxwell@redhat.com" <jmaxwell@redhat.com>
Subject: RE: [net-next,v2] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Thread-Topic: [net-next,v2] tcp: Improve setsockopt() TCP_USER_TIMEOUT
 accuracy
Thread-Index: AQHUE6GITG1Yyx96e0+vOBao1IhTiaR/JQww
Date:   Wed, 4 Jul 2018 14:57:06 +0000
Message-ID: <2a78c5cbb53248289b54505aece15584@AcuMS.aculab.com>
References: <20180704000608.17360-1-jmaxwell37@gmail.com>
 <CADVnQykfvmWyOJxT7_nHPOvfNEwi7+Hz2qJPooPpNLmdMWChYw@mail.gmail.com>
In-Reply-To: <CADVnQykfvmWyOJxT7_nHPOvfNEwi7+Hz2qJPooPpNLmdMWChYw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmVhbCBDYXJkd2VsbA0KPiBTZW50OiAwNCBKdWx5IDIwMTggMTU6MTQNCj4gDQo+IE9u
IFR1ZSwgSnVsIDMsIDIwMTggYXQgODowNiBQTSBKb24gTWF4d2VsbCA8am1heHdlbGwzN0BnbWFp
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uIE1heHdlbGwgPGptYXh3
ZWxsMzdAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvaXB2NC90Y3BfdGltZXIuYyB8IDQ4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfdGltZXIuYyBiL25ldC9pcHY0L3RjcF90aW1lci5j
DQo+ID4gaW5kZXggM2IzNjExNzI5OTI4Li5kMTI5ZTY3MGQwMmEgMTAwNjQ0DQo+ID4gLS0tIGEv
bmV0L2lwdjQvdGNwX3RpbWVyLmMNCj4gPiArKysgYi9uZXQvaXB2NC90Y3BfdGltZXIuYw0KLi4u
DQo+ID4gK3N0YXRpYyBfX3UzMiB0Y3BfY2xhbXBfcnRvX3RvX3VzZXJfdGltZW91dChzdHJ1Y3Qg
c29jayAqc2spDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29j
ayAqaWNzayA9IGluZXRfY3NrKHNrKTsNCj4gPiArICAgICAgIF9fdTMyIHJ0byA9IGljc2stPmlj
c2tfcnRvOw0KDQpXaHkgY2FjaGUgcnRvIHBhc3QgYWxsIHRoZSBmdW5jdGlvbiBjYWxscyB1bnRp
bCBpdCBpcyBuZWVkZWQ/DQoNCj4gPiArICAgICAgIF9fdTMyIGVsYXBzZWQsIHVzZXJfdGltZW91
dDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBzdGFydF90czsNCj4gDQo+IEknZCBzdWdnZXN0
IHUzMiBoZXJlIGZvciBzdGFydF90cyAocGVyIHRoZSByYXRpb25hbGUgYWJvdmUpLg0KPiANCj4g
PiArDQo+ID4gKyAgICAgICBzdGFydF90cyA9IHRjcF9yZXRyYW5zbWl0X3N0YW1wKHNrKTsNCj4g
PiArICAgICAgIGlmICghaWNzay0+aWNza191c2VyX3RpbWVvdXQgfHwgIXN0YXJ0X3RzKQ0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gcnRvOw0KPiA+ICsgICAgICAgZWxhcHNlZCA9IHRjcF90
aW1lX3N0YW1wKHRjcF9zayhzaykpIC0gc3RhcnRfdHM7DQo+ID4gKyAgICAgICB1c2VyX3RpbWVv
dXQgPSBqaWZmaWVzX3RvX21zZWNzKGljc2stPmljc2tfdXNlcl90aW1lb3V0KTsNCj4gPiArICAg
ICAgIGlmIChlbGFwc2VkID49IHVzZXJfdGltZW91dCkNCj4gPiArICAgICAgICAgICAgICAgcnRv
ID0gMTsgIC8qIHVzZXIgdGltZW91dCBoYXMgcGFzc2VkOyBmaXJlIEFTQVAgKi8NCj4gPiArICAg
ICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgcnRvID0gbWluKHJ0bywgKF9fdTMyKW1zZWNz
X3RvX2ppZmZpZXModXNlcl90aW1lb3V0IC0gZWxhcHNlZCkpOw0KPiANCj4gTXkgc2Vuc2UgaXMg
dGhhdCBtaW5fdCB3b3VsZCBiZSBwcmVmZXJyZWQgaGVyZSwgZS5nOg0KPiANCj4gICBydG8gPSBt
aW5fdChfX3UzMiwgcnRvLCBtc2Vjc190b19qaWZmaWVzKHVzZXJfdGltZW91dCAtIGVsYXBzZWQp
KTsNCg0KVGhpbmsgSSdkIGp1c3Qgd3JpdGUgdGhlIGNvbmRpdGlvbmFsLi4uDQoNCj4gPiArICAg
ICAgIHJldHVybiBydG87DQo+ID4gK30NCg0KTG9va3MgdG8gbWUgbGlrZSBpdCBkb2Vzbid0IGNv
cnJlY3RseSBhbGxvdyBmb3IgdGhlIGNvbnZlcnNpb25zDQpiZXR3ZWVuIG1pbGxpc2Vjb25kIGFu
ZCBqaWZmaWVzIGVpdGhlci4NCkkgc3VzcGVjdCB0aGUgbXNlY3NfdG9famlmZmllcygpIGNhbGwg
Y2FuIHJldHVybiB6ZXJvICh1bmxlc3MgaXQgcm91bmRzIHVwKS4NCkNvZGluZyB3aXRoIGEgc2ln
bmVkICd0aW1lIHVudGlsIHVzZXIgdGltZW91dCcgbWlnaHQgbWFrZSBpdCBzaW1wbGVyLg0KDQoJ
RGF2aWQNCg0KDQo=
