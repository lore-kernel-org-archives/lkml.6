Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A09ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B689D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="g+lLtigA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B689D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJTCWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:22:09 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com ([40.107.68.132]:60420
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbeJTCWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLRjQsF5/doc3HNKSbup0377d+wOc50epMciJFo7nDM=;
 b=g+lLtigAhEBuqmycCG1DCz7M8vyuFqVTPGEyPWY6Wpn5B3rxAhKSBvNevvYz8vjm968CalwkUTGt2MAOPfqJ4yvCQzYZuJ/85vnR+9xWWEhAQ79dbXi/YCOysnNOYDRD/kOQ6Z28RIziF2BtLuaxOhWMdumWMekNjd05sIowCeo=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2271.namprd13.prod.outlook.com (52.135.93.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.12; Fri, 19 Oct 2018 18:14:53 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475%3]) with mapi id 15.20.1273.012; Fri, 19 Oct 2018
 18:14:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "miklos@szeredi.hu" <miklos@szeredi.hu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Topic: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Index: AQHUZ6Y0R00wjCb1DkumOvVKjG/0GKUmuDWAgAAfwwCAAAf8gA==
Date:   Fri, 19 Oct 2018 18:14:53 +0000
Message-ID: <05184f29b5778563519174769c675c5f6c5b2dd3.camel@hammerspace.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
         <20181019122049.27121-5-mszeredi@redhat.com>
         <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
         <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com>
In-Reply-To: <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2271;6:yp08SLRmmIUlEegm/VIQOJbOyS0VXD//NsaP+VjsGhoFZBlDsd8+VvhaSWO5Yj1gldItEY8e0meI6jLSjl68gcC2eV2gOGS6fdM8bs4GHlI5ZQ+r0gdY8PlxJtArs0GVISfmVl0FuLlPV7XEInq4JTPqEJhFf0vje1yCctTkTf2Fkg+FUqp8aCrQpcKeHFCnUT+cTWh681M7A38uTIuwTPzOACwjqbFsF8YZk1amepZszO5T4EtuLnygu39NEW0fUn3/0p8sZ+5qWn/lTZ/4Jsq0uZGlCqL/Cjx3/ze1oNDr5h3uiRuQNfrLPh+7sUMx+MMZczSVvz1uiPSz+olARPPEqa/m4qrceQ/X671Qdz53KyVl1Z/1QCZ5mb8jRY4jU95KWuc8qSVF0HS+VbFxemhvzFU1xw/NJUL/2xlT7j5bVsWkaJFSm+zFG80znesRWAj02pDAC4oNcboOGwDUcw==;5:bccq/BYaTA1XkwEQTDoqqhgsujcI8zlhsNKOFCCkrztOE5wTDym0DoYvMVwq7FHsAlLpUOrqS2S9FHRBLp4hZuBp575g+ArvUPSmDrcieigJF2QbYRg5zHNxtUmIk1xAtKg7s92I8ZaGGPzUSTsqc2tslf6AL0tv8Lfv++DurpM=;7:fiWFCMhm7UAPL6ZbpZXiut7vANoxEWgScqk4OGOF9Ngc/+0sogv2rigjfCHoDiPUUTSI70b/wCozbDe/FPaxPreW8mIeq0aCciwBESRD1u2ZrrdYjU1UKtFeh2ng6pUmvDKBNal3j2HeabNdFg5J+A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 10037e0f-e792-46d2-712f-08d635eec49a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2271;
x-ms-traffictypediagnostic: SN6PR13MB2271:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-microsoft-antispam-prvs: <SN6PR13MB2271D6AE7CF2BE2D2DB4EC9BB8F90@SN6PR13MB2271.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR13MB2271;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2271;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(36756003)(2351001)(106356001)(2501003)(4001150100001)(14454004)(478600001)(5250100002)(105586002)(6512007)(5640700003)(316002)(39060400002)(6486002)(66066001)(81166006)(6116002)(8676002)(3846002)(2906002)(6246003)(1730700003)(229853002)(54906003)(118296001)(81156014)(8936002)(6436002)(53936002)(86362001)(2616005)(476003)(102836004)(11346002)(53546011)(7736002)(446003)(99286004)(305945005)(7416002)(6506007)(76176011)(2900100001)(4326008)(25786009)(186003)(93886005)(68736007)(26005)(71200400001)(71190400001)(5660300001)(97736004)(14444005)(6916009)(256004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2271;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vrooLhcpOTS0httpertr1jOIweyeRMa/f75olU7glIh/I2TRoBKOANYy0VeslzvCv7hZ/28tlum5U3FANq4jVgaWRF7iRYBKx7Df5t+ocwRqeLoPUqugFYdcSsvZjIs+HRMJP6ufwR1+Ogx9NAz0nWsilbjvsN4D7MZpU8UpcBYIf+RTpqiJCa8+g0QlhZUu3JYd7W/i/MldNb+PKeqyR4sMltKWetq3XpETav2EdgGQH9LbA41u4uh7b2blGzvcUTmb6pVS7TH+bA6QeyW6Q5NToR2AaIsdpwF1QIH7UIIqoimA1zJ660iP3hr9Ac9O7TV61/mjQtPdnjkWWyDiFGtKeU/dtG+qPwsh/Ciwy/0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D0C3B456D44AE4899DC58EE68CE669F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10037e0f-e792-46d2-712f-08d635eec49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 18:14:53.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTE5IGF0IDE5OjQ2ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gT24gRnJpLCBPY3QgMTksIDIwMTggYXQgNTo1MiBQTSwgVHJvbmQgTXlrbGVidXN0DQo+IDx0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTEwLTE5IGF0
IDE0OjIwICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gPiA+IEFzIHBlciBzdGF0eCgy
KSBtYW4gcGFnZSBvbmx5IGNsZWFyIG91dCBmbGFncyB0aGF0IGFyZQ0KPiA+ID4gdW5zdXBwb3J0
ZWQgYnkNCj4gPiA+IHRoZQ0KPiA+ID4gZnMgb3IgaGF2ZSBhbiB1bnJlcHJlc2VudGFibGUgdmFs
dWUuICBBdGltZSBpcyBzdXBwb3J0ZWQgYnkgTkZTDQo+ID4gPiBhcw0KPiA+ID4gbG9uZyBhcw0K
PiA+ID4gaXQncyBzdXBwb3J0ZWQgb24gdGhlIHNlcnZlci4NCj4gPiA+IA0KPiA+ID4gU28gdGhl
IFNUQVRYX0FUSU1FIGZsYWcgc2hvdWxkIG5vdCBiZSBjbGVhcmVkIGluIHRoZSByZXN1bHRfbWFz
aw0KPiA+ID4gaWYNCj4gPiA+IHRoZQ0KPiA+ID4gb3BlcmF0aW9uIHdhcyByZXF1ZXN0ZWQgb24g
YSBNTlRfTk9BVElNRSBvciBNTlRfTk9ESVJBVElNRSBtb3VudC4NCj4gPiA+IA0KPiA+ID4gVGhp
cyBwYXRjaCBkb2Vzbid0IGNoYW5nZSB0aGUgcmV2YWxpZGF0aW9uIGFsZ29yaXRobSBpbiBhbnkg
d2F5LA0KPiA+ID4ganVzdA0KPiA+ID4gdGhlDQo+ID4gPiBjbGVhcmluZyBvZiBmbGFncyBpbiBz
dGF0LT5yZXN1bHRfbWFzay4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6
ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+DQo+ID4gPiBGaXhlczogOWNjZWU5NDBiZDViICgi
U3VwcG9ydCBzdGF0eCgpIG1hc2sgYW5kIHF1ZXJ5IGZsYWdzDQo+ID4gPiBwYXJhbWV0ZXJzIikN
Cj4gPiA+IENjOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBwcmltYXJ5ZGF0YS5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICBmcy9uZnMvaW5vZGUuYyB8IDUgKy0tLS0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9pbm9kZS5jDQo+ID4gPiBp
bmRleCBiNjVhZWU0ODFkMTMuLjM0YmIzZTU5MTcwOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25m
cy9pbm9kZS5jDQo+ID4gPiArKysgYi9mcy9uZnMvaW5vZGUuYw0KPiA+ID4gQEAgLTgxMSw3ICs4
MTEsNyBAQCBpbnQgbmZzX2dldGF0dHIoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsDQo+ID4gPiBz
dHJ1Y3QNCj4gPiA+IGtzdGF0ICpzdGF0LA0KPiA+ID4gICAgICAgaWYgKCEocmVxdWVzdF9tYXNr
ICYNCj4gPiA+IChTVEFUWF9NT0RFfFNUQVRYX05MSU5LfFNUQVRYX0FUSU1FfFNUQVRYX0NUSU1F
fA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTVEFUWF9NVElN
RXxTVEFUWF9VSUR8U1RBVFgNCj4gPiA+IF9HSUQNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1RBVFhfU0laRXxTVEFUWF9CTE9D
S1MpKSkNCj4gPiA+IC0gICAgICAgICAgICAgZ290byBvdXRfbm9fcmV2YWxpZGF0ZTsNCj4gPiA+
ICsgICAgICAgICAgICAgZ290byBvdXRfbm9fdXBkYXRlOw0KPiA+ID4gDQo+ID4gPiAgICAgICAv
KiBDaGVjayB3aGV0aGVyIHRoZSBjYWNoZWQgYXR0cmlidXRlcyBhcmUgc3RhbGUgKi8NCj4gPiA+
ICAgICAgIGRvX3VwZGF0ZSB8PSBmb3JjZV9zeW5jIHx8DQo+ID4gPiBuZnNfYXR0cmlidXRlX2Nh
Y2hlX2V4cGlyZWQoaW5vZGUpOw0KPiA+ID4gQEAgLTgzMyw5ICs4MzMsNiBAQCBpbnQgbmZzX2dl
dGF0dHIoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsDQo+ID4gPiBzdHJ1Y3QNCj4gPiA+IGtzdGF0
ICpzdGF0LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gICAg
ICAgfSBlbHNlDQo+ID4gPiAgICAgICAgICAgICAgIG5mc19yZWFkZGlycGx1c19wYXJlbnRfY2Fj
aGVfaGl0KHBhdGgtPmRlbnRyeSk7DQo+ID4gPiAtb3V0X25vX3JldmFsaWRhdGU6DQo+ID4gPiAt
ICAgICAvKiBPbmx5IHJldHVybiBhdHRyaWJ1dGVzIHRoYXQgd2VyZSByZXZhbGlkYXRlZC4gKi8N
Cj4gPiA+IC0gICAgIHN0YXQtPnJlc3VsdF9tYXNrICY9IHJlcXVlc3RfbWFzazsNCj4gPiA+ICBv
dXRfbm9fdXBkYXRlOg0KPiA+ID4gICAgICAgZ2VuZXJpY19maWxsYXR0cihpbm9kZSwgc3RhdCk7
DQo+ID4gPiAgICAgICBzdGF0LT5pbm8gPSBuZnNfY29tcGF0X3VzZXJfaW5vNjQoTkZTX0ZJTEVJ
RChpbm9kZSkpOw0KPiA+IA0KPiA+IE5BQ0suDQo+ID4gDQo+ID4gV2hlbiB3ZSBkb24ndCByZXZh
bGlkYXRlIHRoZSBhdHRyaWJ1dGUsIHRoZW4gdGhlIGNvbnRlbnQgb2YgdGhlDQo+ID4gZmllbGQN
Cj4gPiBjb250YWlucyBqdW5rIHZhbHVlcy4gVGhlIGFib3ZlIGNvZGUgaXMgdmVyeSBpbnRlbnRp
b25hbC4NCj4gDQo+IEhvdyBpcyBpdCB0aGVuIHRoYXQgb25seSBTVEFUWF9BVElNRSBpcyBjbGVh
cmVkIGFuZCBub3QgdGhlIG90aGVyDQo+IGZpZWxkcz8NCg0KSXQgaXNuJ3QganVzdCB0aGUgYXRp
bWUuIFdlIGNhbiBhbHNvIGZhaWwgdG8gcmV2YWxpZGF0ZSB0aGUgY3RpbWUgYW5kDQptdGltZSBp
ZiB0aGV5IGFyZSBub3QgYmVpbmcgcmVxdWVzdGVkIGJ5IHRoZSB1c2VyLg0KDQo+IA0KPiBOb3Rl
OiBqdW5rICE9IHN0YWxlLiAgVGhlIHN0YXR4IGRlZmluaXRpb24gZG9lc24ndCB0YWxrIGFib3V0
IHRoZQ0KPiBmaWVsZHMgYmVpbmcgdXAtdG8tZGF0ZSwgZXhjZXB0IGZvciBBVF9TVEFUWF9GT1JD
RV9TWU5DLCBzbyBzdGFsZQ0KPiBhdHRyaWJ1dGVzIGFyZSBva2F5LCBhbmQgZG8gbm90IHdhcnJh
bnQgY2xlYXJpbmcgdGhlIHJlc3VsdF9tYXNrLg0KPiANCg0KSSBkaXNhZ3JlZS4gc3RhbGUgPT0g
anVuayBoZXJlLCBiZWNhdXNlIHRoZSBkZWZhdWx0IG9mDQpBVF9TVEFUWF9TWU5DX0FTX1NUQVQg
aXMgZGVzY3JpYmVkIGJ5IHRoZSBtYW5wYWdlIGFzICJEbyAgd2hhdGV2ZXINCnN0YXQoMikgZG9l
cy4iIHdoaWNoIHRoaXMgaXMgbm90Lg0KDQpUaGUgZGVmYXVsdCBiZWhhdmlvdXIgZm9yICJzdGF0
KDIpIiBpcyB0byByZXZhbGlkYXRlIGF0dHJpYnV0ZXMgdGhhdCB3ZQ0Ka25vdyBvciBzdXNwZWN0
IGFyZSBzdGFsZS4gV2UgbmV2ZXIga25vd2luZ2x5IHJldHVybiBzdGFsZSBhdHRyaWJ1dGVzLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
