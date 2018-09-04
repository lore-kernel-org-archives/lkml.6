Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D7AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577472075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XFEKge4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577472075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIEAdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:33:54 -0400
Received: from mail-eopbgr730116.outbound.protection.outlook.com ([40.107.73.116]:40246
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeIEAdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx+RMQQKDFHBeiHxcMnDEtcmzis4LyIek9U0D6b7E3I=;
 b=XFEKge4j0i7thXAcc2y1kv56Zw1Nj/7qkBjKjWijJoavqWsqGOEUsl4HYWsLwSEbx6pTZLJgQLgvvqcN8hSWrtqrD3hx+KESE0MnAItN809h2zi3YnE7ncwVDZZOHbIn4wWKDWlkcdyIDAl51yOuCOO2HANGOxchW7gf0tgV9hI=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0762.namprd21.prod.outlook.com (10.173.172.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1122.1; Tue, 4 Sep 2018 20:07:11 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Tue, 4 Sep 2018
 20:07:11 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM
 to CONFIG_DEBUG_VM_PGFLAGS
Thread-Topic: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM
 to CONFIG_DEBUG_VM_PGFLAGS
Thread-Index: AQHURH3Omk0nEFgfkkeN2k1VLXiFBKTgjL0A
Date:   Tue, 4 Sep 2018 20:07:11 +0000
Message-ID: <47657613-688d-e701-4a30-39fbd92734ba@microsoft.com>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183339.4416.44582.stgit@localhost.localdomain>
In-Reply-To: <20180904183339.4416.44582.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0762;6:XrG9i4MzLu6RdzvWbqPsGPju13zcxztT84s06vk1zM6Rnk4YVpphUki00E5C0GPzxBKVgg6U1H5UuZjRY87eEKSD6wxk+bR5bHFD8rMc1x8NNXunZ63rb34QW0CAdV9CR9nScQKFjRIJFOXoRgoNqSmo/0m3POsqg2+9HAdouWi6v3mIe/fPI2Ufqs6GvuIxGSBATv+h38h1inhp49VQReY6vtDeMOg0IKfsvTxc4tRx/cTONVrXwQO0SDmxdQv/5QcyCuKz/ZVv9y1gItRnXEqll3PXchmVFsj1RzT2IeUDqWRjRYNZsARX+c5oL4lZa3Re5mhGqfYNb9MoCM/OKbjQMJWXo3g+bNURQik6c+G0D2nkcrMRVhTfPoUMTaUGxkXcCHwNAd/ENhv3rpFT9Ayp/Cb27vN7dLdqmyM8ohBR4dzjhRHEW1w23mOpYpaDo3n0RtyMGwbWBKIV9FsPtw==;5:t++CBXYHDH8tc5rNZ35/DJCjnHY3Q5Nt7h8xLcMhOkYJ9kXQUU6hgguAo6IYW7HanzBFcTZ2I9G70mPXT9iHu2geLkeKTZBYXpE6OU2k1AbhFWzHgkQI2eP6yRUjsmIl4GvEaRKs0GCgFduzGT/iQ2CxBlRfvPe1X2F2wYFARq0=;7:VhJbIFgG4rlrrKJXxVfp1nbg9rDTvR6z0cVSMMR6O1qHQKHoT6QkR937VXMfaIs9JeQaPPzCiTYWr6cBswfAS5lTs+yNc5CJ1FPPFAYOWGB1kyvZ2RewoCB/ZyeNxqn100+/4fd+QwP2UGD6dhiO0TsUiyu96ZEC19BQA298wMEJtajerD1x7h7GiotD+GKABVSGKbdRgV5ChpCIoUwKikQQRdKZnYqq5u99PIwzCqs/RNN/KzGtIjKlGdfC+fGB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c54c5f22-13c1-4ccf-7897-08d612a2000c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0762;
x-ms-traffictypediagnostic: DM5PR21MB0762:
x-microsoft-antispam-prvs: <DM5PR21MB07623825A6BDD66B72EE997B9D030@DM5PR21MB0762.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0762;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0762;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(105586002)(2906002)(10090500001)(22452003)(31686004)(7736002)(305945005)(486006)(446003)(68736007)(11346002)(76176011)(476003)(2501003)(6512007)(54906003)(6436002)(106356001)(66066001)(2616005)(99286004)(5250100002)(26005)(53936002)(14454004)(6486002)(110136005)(102836004)(229853002)(6346003)(39060400002)(53546011)(81156014)(478600001)(81166006)(6506007)(316002)(10290500003)(36756003)(72206003)(4326008)(6246003)(25786009)(186003)(8676002)(2900100001)(3846002)(97736004)(6116002)(86612001)(31696002)(86362001)(5660300001)(2201001)(8936002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0762;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: R9BRMphrt9l47+uH7q39ice1vXNm81x1H+7r6SukUgcjdjC7pavPOCGZt+g/2npzHMNBw7hu9rSr45hLSqk85ZzQjGOQ5hw2vSH5z1HJwnm8yYf2U6VxtlJda+pEmHlmOlfAWT4kqKpP6T0wxLZcZ3jj09NND61vlIi8gP6G7kPiSn8PpmSrCK1CzjdC5yENSxJyRY4JCN0wao8NBl+k+gO7xzelT0dLkd7qSgm7opk1DTa+z4Xx4j7rqvzVT+kPKkNuMoYt8l0Evc9E4zj2yI8pjb4Ou0my+wXYbxBtV5+LZt2CiG0SsIZchCn3vniSZsKoovYg4xxO4ccT/orDDhyISF312a6G4/zv9hnF5pY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C081A26A63C4DE4785412FAE6F232CA2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54c5f22-13c1-4ccf-7897-08d612a2000c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 20:07:11.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZGVyLA0KDQpUaGlzIGlzIGEgd3Jvbmcgd2F5IHRvIGRvIGl0LiBtZW1ibG9ja192
aXJ0X2FsbG9jX3RyeV9uaWRfcmF3KCkgZG9lcyBub3QNCmluaXRpYWxpemUgYWxsb2NhdGVkIG1l
bW9yeSwgYW5kIGJ5IHNldHRpbmcgbWVtb3J5IHRvIGFsbCBvbmVzIGluIGRlYnVnDQpidWlsZCB3
ZSBlbnN1cmUgdGhhdCBubyBjYWxsZXJzIHJlbHkgb24gdGhpcyBmdW5jdGlvbiB0byByZXR1cm4g
emVyb2VkDQptZW1vcnkganVzdCBieSBhY2NpZGVudC4NCg0KQW5kLCB0aGUgYWNjaWRlbnRzIGFy
ZSBmcmVxdWVudCBiZWNhdXNlIG1vc3Qgb2YgdGhlIEJJT1NlcyBhbmQNCmh5cGVydmlzb3JzIHpl
cm8gbWVtb3J5IGZvciB1cy4gVGhlIGV4Y2VwdGlvbiBpcyBrZXhlYyByZWJvb3QuDQoNClNvLCB0
aGUgZmFjdCB0aGF0IHBhZ2UgZmxhZ3MgY2hlY2tzIHRoaXMgcGF0dGVybiwgZG9lcyBub3QgbWVh
biB0aGF0DQp0aGlzIGlzIHRoZSBvbmx5IHVzZXIuIE1lbW9yeSB0aGF0IGlzIHJldHVybmVkIGJ5
DQptZW1ibG9ja192aXJ0X2FsbG9jX3RyeV9uaWRfcmF3KCkgaXMgdXNlZCBmb3IgcGFnZSB0YWJs
ZSBhcyB3ZWxsLCBhbmQNCmNhbiBiZSB1c2VkIGluIG90aGVyIHBsYWNlcyBhcyB3ZWxsIHRoYXQg
ZG9uJ3Qgd2FudCBtZW1ibG9jayB0byB6ZXJvIHRoZQ0KbWVtb3J5IGZvciB0aGVtIGZvciBwZXJm
b3JtYW5jZSByZWFzb25zLg0KDQpJIGFtIHN1cnByaXNlZCB0aGF0IENPTkZJR19ERUJVR19WTSBp
cyB1c2VkIGluIHByb2R1Y3Rpb24ga2VybmVsLCBidXQgaWYNCnNvIHBlcmhhcHMgYSBuZXcgQ09O
RklHIHNob3VsZCBiZSBhZGRlZDogQ09ORklHX0RFQlVHX01FTUJMT0NLDQoNClRoYW5rIHlvdSwN
ClBhdmVsDQoNCk9uIDkvNC8xOCAyOjMzIFBNLCBBbGV4YW5kZXIgRHV5Y2sgd3JvdGU6DQo+IEZy
b206IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KPiANCj4g
T24gc3lzdGVtcyB3aXRoIGEgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeSBpdCBjYW4gdGFrZSBhIHNp
Z25pZmljYW50IGFtb3VudA0KPiBvZiB0aW1lIHRvIGluaXRpYWxpemUgYWxsIG9mIHRoZSBwYWdl
IHN0cnVjdHMgd2l0aCB0aGUgUEFHRV9QT0lTT05fUEFUVEVSTg0KPiB2YWx1ZS4gSSBoYXZlIHNl
ZW4gaXQgdGFrZSBvdmVyIDIgbWludXRlcyB0byBpbml0aWFsaXplIGEgc3lzdGVtIHdpdGgNCj4g
b3ZlciAxMkdCIG9mIFJBTS4NCj4gDQo+IEluIG9yZGVyIHRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1
ZSBJIGhhZCB0byBkaXNhYmxlIENPTkZJR19ERUJVR19WTSBhbmQgdGhlbg0KPiB0aGUgYm9vdCB0
aW1lIHJldHVybmVkIHRvIHNvbWV0aGluZyBtdWNoIG1vcmUgcmVhc29uYWJsZSBhcyB0aGUNCj4g
YXJjaF9hZGRfbWVtb3J5IGNhbGwgY29tcGxldGVkIGluIG1pbGxpc2Vjb25kcyB2ZXJzdXMgc2Vj
b25kcy4gSG93ZXZlciBpbg0KPiBkb2luZyB0aGF0IEkgaGFkIHRvIGRpc2FibGUgYWxsIG9mIHRo
ZSBvdGhlciBWTSBkZWJ1Z2dpbmcgb24gdGhlIHN5c3RlbS4NCj4gDQo+IEkgZGlkIGEgYml0IG9m
IHJlc2VhcmNoIGFuZCBpdCBzZWVtcyBsaWtlIHRoZSBvbmx5IGZ1bmN0aW9uIHRoYXQgY2hlY2tz
DQo+IGZvciB0aGlzIHBvaXNvbiB2YWx1ZSBpcyB0aGUgUGFnZVBvaXNvbmVkIGZ1bmN0aW9uLCBh
bmQgaXQgaXMgb25seSBjYWxsZWQNCj4gaW4gdHdvIHNwb3RzLiBPbmUgaXMgdGhlIFBGX1BPSVNP
TkVEX0NIRUNLIG1hY3JvIHRoYXQgaXMgb25seSBpbiB1c2Ugd2hlbg0KPiBDT05GSUdfREVCVUdf
Vk1fUEdGTEFHUyBpcyBkZWZpbmVkLCBhbmQgdGhlIG90aGVyIGlzIGFzIGEgcGFydCBvZiB0aGUN
Cj4gX19kdW1wX3BhZ2UgZnVuY3Rpb24gd2hpY2ggaXMgdXNpbmcgdGhlIGNoZWNrIHRvIHByZXZl
bnQgYSByZWN1cnNpdmUNCj4gZmFpbHVyZSBpbiB0aGUgZXZlbnQgb2YgZGlzY292ZXJpbmcgYSBw
b2lzb25lZCBwYWdlLg0KPiANCj4gV2l0aCB0aGlzIGJlaW5nIHRoZSBjYXNlIEkgYW0gb3B0aW5n
IHRvIG1vdmUgdGhlIHBvaXNvbmluZyBvZiB0aGUgcGFnZQ0KPiBzdHJ1Y3RzIGZyb20gQ09ORklH
X0RFQlVHX1ZNIHRvIENPTkZJR19ERUJVR19WTV9QR0ZMQUdTIHNvIHRoYXQgd2UgYXJlDQo+IG9u
bHkgcGVyZm9ybWluZyB0aGUgbWVtc2V0IGlmIGl0IHdpbGwgYmUgdXNlZCB0byB0ZXN0IGZvciBm
YWlsdXJlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVy
LmguZHV5Y2tAaW50ZWwuY29tPg0KPiAtLS0NCj4gIG1tL21lbWJsb2NrLmMgfCAgICAyICstDQo+
ICBtbS9zcGFyc2UuYyAgIHwgICAgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtYmxvY2suYyBi
L21tL21lbWJsb2NrLmMNCj4gaW5kZXggMjM3OTQ0NDc5ZDI1Li41MWU4YWU5MjcyNTcgMTAwNjQ0
DQo+IC0tLSBhL21tL21lbWJsb2NrLmMNCj4gKysrIGIvbW0vbWVtYmxvY2suYw0KPiBAQCAtMTQ0
NCw3ICsxNDQ0LDcgQEAgdm9pZCAqIF9faW5pdCBtZW1ibG9ja192aXJ0X2FsbG9jX3RyeV9uaWRf
cmF3KA0KPiAgDQo+ICAJcHRyID0gbWVtYmxvY2tfdmlydF9hbGxvY19pbnRlcm5hbChzaXplLCBh
bGlnbiwNCj4gIAkJCQkJICAgbWluX2FkZHIsIG1heF9hZGRyLCBuaWQpOw0KPiAtI2lmZGVmIENP
TkZJR19ERUJVR19WTQ0KPiArI2lmZGVmIENPTkZJR19ERUJVR19WTV9QR0ZMQUdTDQo+ICAJaWYg
KHB0ciAmJiBzaXplID4gMCkNCj4gIAkJbWVtc2V0KHB0ciwgUEFHRV9QT0lTT05fUEFUVEVSTiwg
c2l6ZSk7DQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL21tL3NwYXJzZS5jIGIvbW0vc3BhcnNl
LmMNCj4gaW5kZXggMTBiMDdlZWE5YTZlLi4wZmQ5YWQ1MDIxYjAgMTAwNjQ0DQo+IC0tLSBhL21t
L3NwYXJzZS5jDQo+ICsrKyBiL21tL3NwYXJzZS5jDQo+IEBAIC02OTYsNyArNjk2LDcgQEAgaW50
IF9fbWVtaW5pdCBzcGFyc2VfYWRkX29uZV9zZWN0aW9uKHN0cnVjdCBwZ2xpc3RfZGF0YSAqcGdk
YXQsDQo+ICAJCWdvdG8gb3V0Ow0KPiAgCX0NCj4gIA0KPiAtI2lmZGVmIENPTkZJR19ERUJVR19W
TQ0KPiArI2lmZGVmIENPTkZJR19ERUJVR19WTV9QR0ZMQUdTDQo+ICAJLyoNCj4gIAkgKiBQb2lz
b24gdW5pbml0aWFsaXplZCBzdHJ1Y3QgcGFnZXMgaW4gb3JkZXIgdG8gY2F0Y2ggaW52YWxpZCBm
bGFncw0KPiAgCSAqIGNvbWJpbmF0aW9ucy4NCj4g
