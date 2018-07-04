Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3520AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147D2469C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kdr/pFjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C147D2469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeGDGSr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:18:47 -0400
Received: from mail-hk2apc01on0112.outbound.protection.outlook.com ([104.47.124.112]:45079
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932871AbeGDGSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+fKz0I3RKkVhhZJ71SUWni6H4NIxEFI/2uVKk0hCX4=;
 b=Kdr/pFjmz1xGZ4MOPvcKSFcEC2/gfv4OBrKmbo9IUNrcBZnreFUnhCbQczkGFYMgzs9vPxsNDfrN/t0NPskQXUbZXUy3LRdwF182Iu0ZP60xZRWet0EL9lz1d1wKMgxJYx4SH33fsajllGLnvb5VgQ2+DvDJ5Goxxc/YghjQTwA=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0118.APCP153.PROD.OUTLOOK.COM (10.170.172.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.7; Wed, 4 Jul 2018 06:18:37 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Wed, 4 Jul 2018
 06:18:37 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Topic: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Index: AQHUEg9paY7djkcpC0ykdZ+fV8ZzGaR8CWh9gAKQH4A=
Date:   Wed, 4 Jul 2018 06:18:37 +0000
Message-ID: <9b3bae04-444a-475c-1588-917c17c6cc0d@microsoft.com>
References: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
 <20180702141653.88936-4-Tianyu.Lan@microsoft.com>
 <87lgatbrne.fsf@vitty.brq.redhat.com>
In-Reply-To: <87lgatbrne.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0118;7:mKkG4NE6Lj6XYNAgi0sxIu4YRfmH/5hwYUfhj+PlX/0w6rR72fsQqKH8WFGjqosSgxyvPWlNMpdaLQciOcpsoK+5ITh1QTa1Rodi/xn2W4km/C2JjZf88LbrfiCN5JUffrTgVGeAigHhvehkIJw9nV7BEZrUpyyR9BdXIHnCuhnIbnIgBIO4oxWOj7Rzyf5dtOkX+xFJ7XvK746SSXLGhQKzZDL9UXlmhw9MsBKCebYeNG7VntIN9d32bFnhP0l4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0a8da2f-41fa-4471-0f6d-08d5e175fad4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:KU1P153MB0118;
x-ms-traffictypediagnostic: KU1P153MB0118:
x-microsoft-antispam-prvs: <KU1P153MB01182A1F97BD340A4F8D75F592410@KU1P153MB0118.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0118;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0118;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39860400002)(376002)(57704003)(199004)(189003)(106356001)(107886003)(102836004)(105586002)(36756003)(7736002)(66066001)(81156014)(6116002)(316002)(110136005)(53936002)(86612001)(53546011)(22452003)(81166006)(1511001)(72206003)(305945005)(8676002)(6506007)(54906003)(25786009)(3846002)(68736007)(10090500001)(5250100002)(5660300001)(26005)(10290500003)(31696002)(86362001)(186003)(486006)(476003)(229853002)(99286004)(6436002)(256004)(14454004)(76176011)(6486002)(478600001)(31686004)(6512007)(11346002)(14444005)(2616005)(4326008)(2900100001)(6246003)(446003)(2906002)(8936002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0118;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F9TG10H9voAR8ouFaB4uSl8Wz2S013UvHHN6ChQyWnznwSkU5VI7vU5bdIJJiaOkAzBmJQMNwQ+II3iVcYC8+LA+jOhXqa62/dPMwBy2XbCkdy0/5TuUVYV8pqsGtZBD6y1mQ/T0SQ7RaBBpMr26q1w87OqeD/ovEFMqqRAt8Qt0IXtUu/HA9ALS9ZSwXV3pYYJDcu3AwCKZVyjtkUgvu82ojcjKFpHCWUGBMAmEV3rdkWJRQz/bM1kKNNZa2CPF05Ibkj51Hh2tixxrWnfTpDfng+7YjZ7Q1k/dF7khhuAGocEzLLPolVobIu4wlIfeiPRkrxYBFu8AfZlLfg3tDYIrPAAvepcB1x+r3y8miz8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <66FE93D6A151C24C87027E68AFB4420F@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8da2f-41fa-4471-0f6d-08d5e175fad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 06:18:37.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0YWx5Og0KCVRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIDcvMi8yMDE4IDExOjA5
IFBNLCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOg0KPiBUaWFueXUgTGFuIDxUaWFueXUuTGFuQG1p
Y3Jvc29mdC5jb20+IHdyaXRlczoNCj4gDQo+PiBUaGlzIHBhdGNoIGlzIHRvIGNoZWNrIGVwdCB0
YWJsZSBwb2ludGVyIG9mIGVhY2ggY3B1cyB3aGVuIHNldCBlcHQNCj4+IHRhYmxlcyBhbmQgc3Rv
cmUgaWRlbnRpY2FsIGVwdCB0YWJsZSBwb2ludGVyIGlmIGFsbCBlcHQgdGFibGUgcG9pbnRlcnMN
Cj4+IG9mIHNpbmdsZSBWTSBhcmUgc2FtZS4gVGhpcyBpcyBmb3Igc3VwcG9ydCBvZiBwYXJhLXZp
cnQgZXB0IGZsdXNoDQo+PiBoeXBlcmNhbGwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFuIFRp
YW55dSA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2t2
bS92bXguYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC5jDQo+PiBpbmRleCAxNjg5ZjQzM2YzYTAuLjBi
MWU0ZTlmZWYyYiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2t2bS92bXguYw0KPj4gKysrIGIv
YXJjaC94ODYva3ZtL3ZteC5jDQo+PiBAQCAtMTk0LDYgKzE5NCw5IEBAIHN0cnVjdCBrdm1fdm14
IHsNCj4+ICAgCXVuc2lnbmVkIGludCB0c3NfYWRkcjsNCj4+ICAgCWJvb2wgZXB0X2lkZW50aXR5
X3BhZ2V0YWJsZV9kb25lOw0KPj4gICAJZ3BhX3QgZXB0X2lkZW50aXR5X21hcF9hZGRyOw0KPj4g
Kw0KPj4gKwl1NjQgaWRlbnRpY2FsX2VwdF9wb2ludGVyOw0KPj4gKwlzcGlubG9ja190IGVwdF9w
b2ludGVyX2xvY2s7DQo+PiAgIH07DQo+Pg0KPj4gICAjZGVmaW5lIE5SX0FVVE9MT0FEX01TUlMg
OA0KPj4gQEAgLTg1Myw2ICs4NTYsNyBAQCBzdHJ1Y3QgdmNwdV92bXggew0KPj4gICAJICovDQo+
PiAgIAl1NjQgbXNyX2lhMzJfZmVhdHVyZV9jb250cm9sOw0KPj4gICAJdTY0IG1zcl9pYTMyX2Zl
YXR1cmVfY29udHJvbF92YWxpZF9iaXRzOw0KPj4gKwl1NjQgZXB0X3BvaW50ZXI7DQo+PiAgIH07
DQo+Pg0KPj4gICBlbnVtIHNlZ21lbnRfY2FjaGVfZmllbGQgew0KPj4gQEAgLTQ5NTgsNiArNDk2
MiwyOSBAQCBzdGF0aWMgdTY0IGNvbnN0cnVjdF9lcHRwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
dW5zaWduZWQgbG9uZyByb290X2hwYSkNCj4+ICAgCXJldHVybiBlcHRwOw0KPj4gICB9DQo+Pg0K
Pj4gK3N0YXRpYyB2b2lkIGNoZWNrX2VwdF9wb2ludGVyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
dTY0IGVwdHApDQo+PiArew0KPj4gKwlzdHJ1Y3Qga3ZtICprdm0gPSB2Y3B1LT5rdm07DQo+PiAr
CXU2NCB0bXBfZXB0cCA9IElOVkFMSURfUEFHRTsNCj4+ICsJaW50IGk7DQo+PiArDQo+PiArCXNw
aW5fbG9jaygmdG9fa3ZtX3ZteChrdm0pLT5lcHRfcG9pbnRlcl9sb2NrKTsNCj4+ICsJdG9fdm14
KHZjcHUpLT5lcHRfcG9pbnRlciA9IGVwdHA7DQo+PiArDQo+PiArCWt2bV9mb3JfZWFjaF92Y3B1
KGksIHZjcHUsIGt2bSkgew0KPj4gKwkJaWYgKCFWQUxJRF9QQUdFKHRtcF9lcHRwKSkgew0KPj4g
KwkJCXRtcF9lcHRwID0gdG9fdm14KHZjcHUpLT5lcHRfcG9pbnRlcjsNCj4+ICsJCX0gZWxzZSBp
ZiAodG1wX2VwdHAgIT0gdG9fdm14KHZjcHUpLT5lcHRfcG9pbnRlcikgew0KPj4gKwkJCXRvX2t2
bV92bXgoa3ZtKS0+aWRlbnRpY2FsX2VwdF9wb2ludGVyID0gSU5WQUxJRF9QQUdFOw0KPj4gKwkJ
CXNwaW5fdW5sb2NrKCZ0b19rdm1fdm14KGt2bSktPmVwdF9wb2ludGVyX2xvY2spOw0KPj4gKwkJ
CXJldHVybjsNCj4+ICsJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gKwl0b19rdm1fdm14KGt2bSktPmlk
ZW50aWNhbF9lcHRfcG9pbnRlciA9IHRtcF9lcHRwOw0KPj4gKwlzcGluX3VubG9jaygmdG9fa3Zt
X3ZteChrdm0pLT5lcHRfcG9pbnRlcl9sb2NrKTsNCj4gDQo+IEl0IHNlZW1zIHdlIGNhbiBnZXQg
YXdheSB3aXRoIGlkZW50aWNhbF9lcHRfcG9pbnRlciBiZWluZyBqdXN0ICdib29sJzoNCj4gZ28g
dGhyb3VnaCB0aGUgdkNQVSBsaXN0IGFuZCBjb21wYXJlIGVwdF9wb2ludGVyIHdpdGggZXB0X3Bv
aW50ZXIgZm9yDQo+IHRoZSBjdXJyZW50IHZjcHUuIEl0IHdvdWxkIGFsc28gbWFrZSBzZW5zZSB0
byByZW5hbWUgaXQgdG8gc29tZXRoaW5nDQo+IGxpa2UgJ2VwdF9wb2ludGVyc19tYXRjaCcuDQoN
ClllcywgdGhhdCdzIGFub3RoZXIgYXBwcm9hY2guIEJ1dCBrdm1fZmx1c2hfcmVtb3RlX3RsYnMo
KSBvbmx5IHBhc3NlcyANCnN0cnVjdCBrdm0gYW5kIHdlIHN0aWxsIG5lZWQgdG8gcmFuZG9tbHkg
c2VsZWN0IGEgdmNwdShtYXliZSBhbHdheXMgdXNlIA0KdmNwdTApIHRvIGdldCBlcHQgcG9pbnRl
ciB3aGVuIHdlIGNhbGwgZmx1c2ggaHlwZXJjYWxsLg0KDQo+IA0KPiBJJ20gYWxzbyBub3Qgc3Vy
ZSB3ZSBuZWVkIGEgZGVkaWNhdGVkIGVwdF9wb2ludGVyX2xvY2ssIGNhbid0IHdlIGp1c3QNCj4g
dXNlIHRoZSBhbHJlYWR5IGV4aXN0ZW50IG1tdV9sb2NrIGZyb20gc3RydWN0IGt2bT8NCg0KVGhl
IGxvY2sgaXMgdG8gbWFrZSBzdXJlIHRoZSBpZGVudGljYWwgZXB0IHBvaW50ZXIgd29uJ3QgYmUg
Y2hhbmdlZCANCmR1cmluZyBjYWxsaW5nIGZsdXNoIGh5cGVyY2FsbC4ga3ZtX2ZsdXNoX3JlbW90
ZV90bGJzKCkgaXMgYWxyZWFkeSANCmNhbGxlZCB1bmRlciBtbXVfbG9jayBwcm90ZWN0aW9uKGUu
ZywgDQprdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2Vfc3RhcnQoKSkgYW5kIHNvIHdl
IGNhbid0IHJldXNlIHRoZSANCmxvY2sgaW4gaHZfcmVtb3RlX2ZsdXNoX3RsYigpIG90aGVyd2lz
ZSBpdCB3aWxsIGNhdXNlIGRlYWRsb2NrLg0KDQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgdm9p
ZCB2bXhfc2V0X2NyMyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgY3IzKQ0K
Pj4gICB7DQo+PiAgIAl1bnNpZ25lZCBsb25nIGd1ZXN0X2NyMzsNCj4+IEBAIC00OTY3LDYgKzQ5
OTQsOCBAQCBzdGF0aWMgdm9pZCB2bXhfc2V0X2NyMyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVu
c2lnbmVkIGxvbmcgY3IzKQ0KPj4gICAJaWYgKGVuYWJsZV9lcHQpIHsNCj4+ICAgCQllcHRwID0g
Y29uc3RydWN0X2VwdHAodmNwdSwgY3IzKTsNCj4+ICAgCQl2bWNzX3dyaXRlNjQoRVBUX1BPSU5U
RVIsIGVwdHApOw0KPj4gKwkJY2hlY2tfZXB0X3BvaW50ZXIodmNwdSwgZXB0cCk7DQo+IA0KPiBE
byB3ZSBhbHdheXMgZ2V0IGhlcmUgd2hlbiB3ZSBuZWVkPyBFLmcsIGRvIHdlIG5lZWQgdG8gZW5m
b3JjZQ0KPiAgQ1BVX0JBU0VEX0NSM19TVE9SRV9FWElUSU5HPw0KPiANCg0Kdm14X3NldF9jcjMo
KSBpcyBvbmx5IG9uZSBwbGFjZSB0byBzZXQgZXB0IHRhYmxlIHBvaW50ZXIgYW5kIHNvIGl0IGlz
IA0KYWx3YXlzIGNhbGxlZCB3aGVuIGVwdCB0YWJsZSBwb2ludGVyIGlzIGNoYW5nZWQuDQoNCldo
ZW4gZXB0IGlzIGVuYWJsZWQsICBDUFVfQkFTRURfQ1IzX1NUT1JFX0VYSVRJTkcgaXMgbm90IG5l
Y2Vzc2FyeS4gDQpCZWNhdXNlIHdlIGRvbid0IG5lZWQgdG8gc2hhZG93IENSMyBwYWdlIHRhYmxl
Lg0KDQo+PiArDQo+PiAgIAkJaWYgKGVuYWJsZV91bnJlc3RyaWN0ZWRfZ3Vlc3QgfHwgaXNfcGFn
aW5nKHZjcHUpIHx8DQo+PiAgIAkJICAgIGlzX2d1ZXN0X21vZGUodmNwdSkpDQo+PiAgIAkJCWd1
ZXN0X2NyMyA9IGt2bV9yZWFkX2NyMyh2Y3B1KTsNCj4+IEBAIC0xMDM4Myw2ICsxMDQxMiw4IEBA
IHN0YXRpYyBzdHJ1Y3Qga3ZtX3ZjcHUgKnZteF9jcmVhdGVfdmNwdShzdHJ1Y3Qga3ZtICprdm0s
IHVuc2lnbmVkIGludCBpZCkNCj4+DQo+PiAgIHN0YXRpYyBpbnQgdm14X3ZtX2luaXQoc3RydWN0
IGt2bSAqa3ZtKQ0KPj4gICB7DQo+PiArCXNwaW5fbG9ja19pbml0KCZ0b19rdm1fdm14KGt2bSkt
PmVwdF9wb2ludGVyX2xvY2spOw0KPj4gKw0KPj4gICAJaWYgKCFwbGVfZ2FwKQ0KPj4gICAJCWt2
bS0+YXJjaC5wYXVzZV9pbl9ndWVzdCA9IHRydWU7DQo+PiAgIAlyZXR1cm4gMDsNCj4g
