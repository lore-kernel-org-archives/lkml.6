Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDACC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NMGiIXKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD9020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLIV5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:57:55 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:4800
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbeLIV5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPAdUBjFva2G02Lm+vyfVMcGhaBUdVlfB7k8mhTA7hg=;
 b=NMGiIXKsp/f5ewNNixBv7C1CMUhZN2+bcKg5pYb67tsNnRbCdZHGFtT6hk8SQ+DeG4Hi7C/mLF7Ab0gWUYMFASiAuPKqmvwQC/1CvosrTDKjf1nH6bzvKUK2YcjXxlIb258GzIqw9E10YimdJbnmJE6rFFwqnlXg9Kx488CSiFU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5269.namprd05.prod.outlook.com (20.177.231.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.8; Sun, 9 Dec 2018 21:57:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.014; Sun, 9 Dec 2018
 21:57:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3.16 226/328] x86/mm: Use WRITE_ONCE() when setting PTEs
Thread-Topic: [PATCH 3.16 226/328] x86/mm: Use WRITE_ONCE() when setting PTEs
Thread-Index: AQHUkAnuhGjNcxz3cEecH2g/fFerXaV29FqA
Date:   Sun, 9 Dec 2018 21:57:46 +0000
Message-ID: <F12A5F9B-770F-4D1A-90B5-C1873F383B03@vmware.com>
References: <lsq.1544392233.685418412@decadent.org.uk>
In-Reply-To: <lsq.1544392233.685418412@decadent.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5269;20:qrJYvdaCXU0ozyoonkI/QmQ2iOUcs4bU7ANo2FVUlXpB4Cof9C8guuG6Prc7XWKpWLfv8A4kV/Xse3URK6sNRIRNTQLvvAyEfGADayl7yFfvp4FTgsFjzLBxhU6y193PlT51YeLBh4ABjSSr9NZiLXjndgV8DjuaRj9wRZahRdM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0262eeae-e788-471e-db21-08d65e215a6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5269;
x-ms-traffictypediagnostic: BYAPR05MB5269:
x-microsoft-antispam-prvs: <BYAPR05MB5269869278535AB5C6270A0DD0A40@BYAPR05MB5269.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5269;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5269;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(71200400001)(476003)(2616005)(71190400001)(25786009)(11346002)(446003)(36756003)(97736004)(6506007)(86362001)(83716004)(575784001)(76176011)(186003)(66066001)(53546011)(2906002)(26005)(3846002)(82746002)(6116002)(7736002)(6436002)(486006)(102836004)(305945005)(106356001)(14444005)(33656002)(4326008)(256004)(6486002)(8676002)(229853002)(68736007)(6916009)(8936002)(54906003)(45080400002)(5660300001)(966005)(478600001)(81166006)(99286004)(6306002)(81156014)(53936002)(6512007)(14454004)(6246003)(7416002)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5269;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BaBNnqc+qzBfnC/lxjDbdh25WYrDhFpBrWSQ4L8CrtbYBGT+9ygJoyzt9JqMfEnKxX7Y2ySJY6gayXiyrjyeradVL9AlkYQDrrfLM8UEzBs/pOSuwr7Mm6dXK6n37WpZIORWpapHazf8V05bk6oHOFkpp5qN3DgzIJcdeGzAtCuH5XthY8ryN6gr3O17wTOxy9kdvSTNLPHS8jF8VvBlDkG9bqmpK9lGhM4loEMZl2pbM0hXOJx9L13D5oYjxiOl0clBaPNLQKQ6H4HjVBxLAqdXreYrGym2QGhzIEwT5vNquxorDtHN6m3zCFgkbpqIGN2bkSbVuGwoX7FqBLF2mdcW3Zjtt8gSwGxG9M8/4sU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EABB5F8C120CF4792AAE3B458E53D9A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0262eeae-e788-471e-db21-08d65e215a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 21:57:46.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBjYXVzZXMgc29tZSBzcGFyc2Ugd2FybmluZ3MuIElmIHlvdSB3YW50IHRvIHdh
aXQsIEnigJlsbCBzZW5kIGENCnBhdGNoIHRvIGZpeCBpdC4gKE5vIGV4cGVjdGVkIGZ1bmN0aW9u
YWwgaW1wYWN0IHRob3VnaCkuDQoNCg0KPiBPbiBEZWMgOSwgMjAxOCwgYXQgMTo1MCBQTSwgQmVu
IEh1dGNoaW5ncyA8YmVuQGRlY2FkZW50Lm9yZy51az4gd3JvdGU6DQo+IA0KPiAzLjE2LjYyLXJj
MSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0
IG1lIGtub3cuDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEZyb206IE5hZGF2IEFt
aXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+IA0KPiBjb21taXQgOWJjNGYyOGFmNzVhOTFhZWEwYWUz
ODNmNTBiMGE0MzBjNDUwOTMwMyB1cHN0cmVhbS4NCj4gDQo+IFdoZW4gcGFnZS10YWJsZSBlbnRy
aWVzIGFyZSBzZXQsIHRoZSBjb21waWxlciBtaWdodCBvcHRpbWl6ZSB0aGVpcg0KPiBhc3NpZ25t
ZW50IGJ5IHVzaW5nIG11bHRpcGxlIGluc3RydWN0aW9ucyB0byBzZXQgdGhlIFBURS4gVGhpcyBt
aWdodA0KPiB0dXJuIGludG8gYSBzZWN1cml0eSBoYXphcmQgaWYgdGhlIHVzZXIgc29tZWhvdyBt
YW5hZ2VzIHRvIHVzZSB0aGUNCj4gaW50ZXJpbSBQVEUuIEwxVEYgZG9lcyBub3QgbWFrZSBvdXIg
bGl2ZXMgZWFzaWVyLCBtYWtpbmcgZXZlbiBhbiBpbnRlcmltDQo+IG5vbi1wcmVzZW50IFBURSBh
IHNlY3VyaXR5IGhhemFyZC4NCj4gDQo+IFVzaW5nIFdSSVRFX09OQ0UoKSB0byBzZXQgUFRFcyBh
bmQgZnJpZW5kcyBzaG91bGQgcHJldmVudCB0aGlzIHBvdGVudGlhbA0KPiBzZWN1cml0eSBoYXph
cmQuDQo+IA0KPiBJIHNraW1tZWQgdGhlIGRpZmZlcmVuY2VzIGluIHRoZSBiaW5hcnkgd2l0aCBh
bmQgd2l0aG91dCB0aGlzIHBhdGNoLiBUaGUNCj4gZGlmZmVyZW5jZXMgYXJlIChvYnZpb3VzbHkp
IGdyZWF0ZXIgd2hlbiBDT05GSUdfUEFSQVZJUlQ9biBhcyBtb3JlDQo+IGNvZGUgb3B0aW1pemF0
aW9ucyBhcmUgcG9zc2libGUuIEZvciBiZXR0ZXIgYW5kIHdvcnNlLCB0aGUgaW1wYWN0IG9uIHRo
ZQ0KPiBiaW5hcnkgd2l0aCB0aGlzIHBhdGNoIGlzIHByZXR0eSBzbWFsbC4gU2tpbW1pbmcgdGhl
IGNvZGUgZGlkIG5vdCBjYXVzZQ0KPiBhbnl0aGluZyB0byBqdW1wIG91dCBhcyBhIHNlY3VyaXR5
IGhhemFyZCwgYnV0IGl0IHNlZW1zIHRoYXQgYXQgbGVhc3QNCj4gbW92ZV9zb2Z0X2RpcnR5X3B0
ZSgpIGNhdXNlZCBzZXRfcHRlX2F0KCkgdG8gdXNlIG11bHRpcGxlIHdyaXRlcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBBY2tlZC1ieTogUGV0
ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IENjOiBEYXZlIEhh
bnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogQW5kaSBLbGVlbiA8YWtA
bGludXguaW50ZWwuY29tPg0KPiBDYzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5j
b20+DQo+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4gQ2M6IFZsYXN0aW1p
bCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQo+IENjOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
LmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRv
QGtlcm5lbC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5rZXJuZWwub3JnJTJGciUyRjIwMTgw
OTAyMTgxNDUxLjgwNTIwLTEtbmFtaXQlNDB2bXdhcmUuY29tJmFtcDtkYXRhPTAyJTdDMDElN0Nu
YW1pdCU0MHZtd2FyZS5jb20lN0M3MTRhODVlNTYyNzQ0OTE3MDZhNDA4ZDY1ZTIxMGVkZCU3Q2Iz
OTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY3OTk4OTM0MzYxOTI1
MzkmYW1wO3NkYXRhPVFOQTlqWCUyRlNBYWk3enBaZU5uJTJGb3NYTCUyQnJqa0cybFlmRFZWVU45
RXRtMEElM0QmYW1wO3Jlc2VydmVkPTANCj4gW2J3aDogQmFja3BvcnRlZCB0byAzLjE2Og0KPiAt
IFVzZSBBQ0NFU1NfT05DRSgpIGluc3RlYWQgb2YgV1JJVEVfT05DRSgpDQo+IC0gRHJvcCBjaGFu
Z2VzIGluIHBtZHBfZXN0YWJsaXNoKCksIG5hdGl2ZV9zZXRfcDRkKCksIHB1ZHBfc2V0X2FjY2Vz
c19mbGFncygpXQ0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gSHV0Y2hpbmdzIDxiZW5AZGVjYWRlbnQu
b3JnLnVrPg0KPiAtLS0NCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5o
DQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBAQCAtNDQsMTUg
KzQ0LDE1IEBAIHN0cnVjdCBtbV9zdHJ1Y3Q7DQo+IHZvaWQgc2V0X3B0ZV92YWRkcl9wdWQocHVk
X3QgKnB1ZF9wYWdlLCB1bnNpZ25lZCBsb25nIHZhZGRyLCBwdGVfdCBuZXdfcHRlKTsNCj4gDQo+
IA0KPiAtc3RhdGljIGlubGluZSB2b2lkIG5hdGl2ZV9wdGVfY2xlYXIoc3RydWN0IG1tX3N0cnVj
dCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gLQkJCQkgICAgcHRlX3QgKnB0ZXApDQo+ICtz
dGF0aWMgaW5saW5lIHZvaWQgbmF0aXZlX3NldF9wdGUocHRlX3QgKnB0ZXAsIHB0ZV90IHB0ZSkN
Cj4gew0KPiAtCSpwdGVwID0gbmF0aXZlX21ha2VfcHRlKDApOw0KPiArCUFDQ0VTU19PTkNFKCpw
dGVwKSA9IHB0ZTsNCj4gfQ0KPiANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBuYXRpdmVfc2V0X3B0
ZShwdGVfdCAqcHRlcCwgcHRlX3QgcHRlKQ0KPiArc3RhdGljIGlubGluZSB2b2lkIG5hdGl2ZV9w
dGVfY2xlYXIoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gKwkJ
CQkgICAgcHRlX3QgKnB0ZXApDQo+IHsNCj4gLQkqcHRlcCA9IHB0ZTsNCj4gKwluYXRpdmVfc2V0
X3B0ZShwdGVwLCBuYXRpdmVfbWFrZV9wdGUoMCkpOw0KPiB9DQo+IA0KPiBzdGF0aWMgaW5saW5l
IHZvaWQgbmF0aXZlX3NldF9wdGVfYXRvbWljKHB0ZV90ICpwdGVwLCBwdGVfdCBwdGUpDQo+IEBA
IC02Miw3ICs2Miw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBuYXRpdmVfc2V0X3B0ZV9hdG9taWMN
Cj4gDQo+IHN0YXRpYyBpbmxpbmUgdm9pZCBuYXRpdmVfc2V0X3BtZChwbWRfdCAqcG1kcCwgcG1k
X3QgcG1kKQ0KPiB7DQo+IC0JKnBtZHAgPSBwbWQ7DQo+ICsJQUNDRVNTX09OQ0UoKnBtZHApID0g
cG1kOw0KPiB9DQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgbmF0aXZlX3BtZF9jbGVhcihwbWRf
dCAqcG1kKQ0KPiBAQCAtOTgsNyArOTgsNyBAQCBzdGF0aWMgaW5saW5lIHBtZF90IG5hdGl2ZV9w
bWRwX2dldF9hbmRfDQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgbmF0aXZlX3NldF9wdWQocHVk
X3QgKnB1ZHAsIHB1ZF90IHB1ZCkNCj4gew0KPiAtCSpwdWRwID0gcHVkOw0KPiArCUFDQ0VTU19P
TkNFKCpwdWRwKSA9IHB1ZDsNCj4gfQ0KPiANCj4gc3RhdGljIGlubGluZSB2b2lkIG5hdGl2ZV9w
dWRfY2xlYXIocHVkX3QgKnB1ZCkNCj4gQEAgLTEzMSw3ICsxMzEsNyBAQCBzdGF0aWMgaW5saW5l
IHBnZF90ICpuYXRpdmVfZ2V0X3NoYWRvd19wDQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgbmF0
aXZlX3NldF9wZ2QocGdkX3QgKnBnZHAsIHBnZF90IHBnZCkNCj4gew0KPiAtCSpwZ2RwID0ga2Fp
c2VyX3NldF9zaGFkb3dfcGdkKHBnZHAsIHBnZCk7DQo+ICsJQUNDRVNTX09OQ0UoKnBnZHApID0g
a2Fpc2VyX3NldF9zaGFkb3dfcGdkKHBnZHAsIHBnZCk7DQo+IH0NCj4gDQo+IHN0YXRpYyBpbmxp
bmUgdm9pZCBuYXRpdmVfcGdkX2NsZWFyKHBnZF90ICpwZ2QpDQo+IC0tLSBhL2FyY2gveDg2L21t
L3BndGFibGUuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gQEAgLTI0Miw3ICsy
NDIsNyBAQCBzdGF0aWMgdm9pZCBwZ2RfbW9wX3VwX3BtZHMoc3RydWN0IG1tX3N0DQo+IAkJaWYg
KHBnZF92YWwocGdkKSAhPSAwKSB7DQo+IAkJCXBtZF90ICpwbWQgPSAocG1kX3QgKilwZ2RfcGFn
ZV92YWRkcihwZ2QpOw0KPiANCj4gLQkJCXBnZHBbaV0gPSBuYXRpdmVfbWFrZV9wZ2QoMCk7DQo+
ICsJCQlwZ2RfY2xlYXIoJnBnZHBbaV0pOw0KPiANCj4gCQkJcGFyYXZpcnRfcmVsZWFzZV9wbWQo
cGdkX3ZhbChwZ2QpID4+IFBBR0VfU0hJRlQpOw0KPiAJCQlwbWRfZnJlZShtbSwgcG1kKTsNCj4g
QEAgLTM1Miw3ICszNTIsNyBAQCBpbnQgcHRlcF9zZXRfYWNjZXNzX2ZsYWdzKHN0cnVjdCB2bV9h
cmVhDQo+IAlpbnQgY2hhbmdlZCA9ICFwdGVfc2FtZSgqcHRlcCwgZW50cnkpOw0KPiANCj4gCWlm
IChjaGFuZ2VkICYmIGRpcnR5KSB7DQo+IC0JCSpwdGVwID0gZW50cnk7DQo+ICsJCXNldF9wdGUo
cHRlcCwgZW50cnkpOw0KPiAJCXB0ZV91cGRhdGVfZGVmZXIodm1hLT52bV9tbSwgYWRkcmVzcywg
cHRlcCk7DQo+IAl9DQo+IA0KPiBAQCAtMzY5LDcgKzM2OSw3IEBAIGludCBwbWRwX3NldF9hY2Nl
c3NfZmxhZ3Moc3RydWN0IHZtX2FyZWENCj4gCVZNX0JVR19PTihhZGRyZXNzICYgfkhQQUdFX1BN
RF9NQVNLKTsNCj4gDQo+IAlpZiAoY2hhbmdlZCAmJiBkaXJ0eSkgew0KPiAtCQkqcG1kcCA9IGVu
dHJ5Ow0KPiArCQlzZXRfcG1kKHBtZHAsIGVudHJ5KTsNCj4gCQlwbWRfdXBkYXRlX2RlZmVyKHZt
YS0+dm1fbW0sIGFkZHJlc3MsIHBtZHApOw0KPiAJCS8qDQo+IAkJICogV2UgaGFkIGEgd3JpdGUt
cHJvdGVjdGlvbiBmYXVsdCBoZXJlIGFuZCBjaGFuZ2VkIHRoZSBwbWQNCg0KDQo=
