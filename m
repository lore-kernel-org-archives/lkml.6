Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B8206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nUouie8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0B8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeIFAyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:54:08 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:45036
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbeIFAyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxI+fStPcnHCZ4ZjTMjyro6/RXiBKF6gX9wS8JIbR44=;
 b=nUouie8qEk1PXXxTH7UWyu1yO8CuOQ0al2G423G0ZaGwAeaxHebE36VmwivquLKRC6tk7jz/kaVmMs7qcRoGd0iaCmCyDL/0nVryr0gX7RFEGp9NWL45diBT/xKhE/yunsW5pk5ocdqZBSjzIqc8wN4k8r8AheAYo0f2qFTfKo4=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0122.namprd21.prod.outlook.com (10.173.173.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 5 Sep 2018 20:22:16 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Wed, 5 Sep 2018
 20:22:16 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
Thread-Topic: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
Thread-Index: AQHURH3S4QIBYnNfQUysPSm4cJf2u6ThOTYAgADpAACAAAETgA==
Date:   Wed, 5 Sep 2018 20:22:16 +0000
Message-ID: <ec060d9b-d313-417c-4389-2ac7b482f94c@microsoft.com>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183345.4416.76515.stgit@localhost.localdomain>
 <20180905062428.GV14951@dhcp22.suse.cz>
 <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com>
In-Reply-To: <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0122;6:OjHWHRSf7V85E6XWXjp00HKRsMx+Hjr31zl313X8nTmh7xTO29hxv8p8jcu+Dp//ooe9qdn7eRYvD0XIU0PakYtDXsWak4Ud73eDFBdAX5LrAlEGlk9Yex/etL1+td+OOl2ibWLJK0WivdnLhRfDXKs+/PKQ7lX0Gs7BCVt1cvZ8An4amzhiz6e7DXmfADxXnAfvY4luidjKOVz4HbiNUnK7j5dXf62PfhwaY8gTT9fMQkDpovG4DHSTG1IVtLOjSLpk3RgsSNllllozBA5qbTqGeurEUOeWwGPdJuQBLeYhJ8FTNqd68LaraWC4KmeLIrhCRsu3mDJW2o4UxCKvz263wvumTvp2qTQTCSRkz5r8/eTvvW5Gj1XUBi9o3LowYHTv7xawmF1DPOW5+SWlXTS9OVKZMMrWrASrPQdXoLnoyz3m4GVlOluwsDgOb338HhZtVlxQohFSGSlZ+qO+7g==;5:ga6T8iQNFmj+ma1/QWEv9eNSj7rH7XLt14KINr/Oscduv9yt0FJI/PU1Ft0VbGe9ocporaHbj09xTHqnJDQi5NSWJyF/K/CCOqxo1hQciGVZQB11PvJJbj0/nz9F2gLv4jzzBPqKHhhdFLc8Dq4MJGWzMGEdymuczDwZFt83XzM=;7:aAjmuXLYK6+M5XXGNvFnNecwsEEe6Uw/TpDZiVOT0H8Qhk0r91Ik6kgN72m/ZllzzA7wYLmhGUOc/wuU+63TJ6mv24/FVH7BeBJweFeBDJCFEawkQajb6ioA39Mny9V8E+zzvkZUTFrdYRefOwaLGNf6iz9bmB5JniWEvudWRjp537vE6xFiPFugWsQQNxk58bp0HL/ti/FUQiOQvq+CshEqpofaZHvTUC8DzpAI8pUb+LKXhdtnEPOLz/IVV38H
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f7e9b4f6-3358-4af2-4148-08d6136d45f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB0122B2AF4A126A554C04800E9D020@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0122;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(136003)(346002)(57704003)(199004)(189003)(478694002)(99286004)(3846002)(6116002)(2900100001)(6436002)(22452003)(4326008)(316002)(5660300001)(476003)(36756003)(486006)(229853002)(66066001)(31686004)(446003)(11346002)(305945005)(2616005)(10090500001)(25786009)(76176011)(2906002)(105586002)(6486002)(7736002)(106356001)(26005)(31696002)(8676002)(2501003)(53936002)(6346003)(86612001)(86362001)(68736007)(6506007)(186003)(93886005)(5250100002)(53546011)(8936002)(6246003)(256004)(478600001)(110136005)(72206003)(6512007)(102836004)(81156014)(81166006)(10290500003)(39060400002)(97736004)(14454004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0122;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: b+pzOloSghvQvicLvR/YOPWop/Bs253kTY0pL4cWIf9LO0ix5pdH32qYv7Q6FOVPxC2DIfbH9KbH3WJFy0KBW/C5RxOO6GM/1pVyjWpegmbi2kjKT7iiPGrHn1V5x+FjHAsgUBI4cQ4qHiYAEFzYRdBdNdOAaGqwpueCXSXOKYi7o1dLU0m9G3IN8FCdKtmCjur+No4nwZKeddX6lcP0hEc/YB5IdBrf06cw9MHQqrv+MCFh5+a4uc1FxGes8lE+2G6TeneDdedeSDpjFl/9+7untPgfCy9nCbDKf6zbqNcMSDp4GzXkUzh1dzjpeAnR6F80feZtGfAtVK0ORXMM/sNIxf/mOT7Bk8ymFZaQE0w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D530C61FA69D414E962C6F3BC858F096@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e9b4f6-3358-4af2-4148-08d6136d45f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 20:22:16.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNS8xOCA0OjE4IFBNLCBBbGV4YW5kZXIgRHV5Y2sgd3JvdGU6DQo+IE9uIFR1ZSwg
U2VwIDQsIDIwMTggYXQgMTE6MjQgUE0gTWljaGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gT24gVHVlIDA0LTA5LTE4IDExOjMzOjQ1LCBBbGV4YW5kZXIgRHV5Y2sg
d3JvdGU6DQo+Pj4gRnJvbTogQWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuaC5kdXlja0BpbnRl
bC5jb20+DQo+Pj4NCj4+PiBJdCBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZSB0byB1c2UgdGhlIGF0
b21pYyBTZXRQYWdlUmVzZXJ2ZWQgYXQgaW5pdCB0aW1lDQo+Pj4gd2hlbiB3ZSBhcmUgdXNpbmcg
bWVtc2V0IHRvIGNsZWFyIHRoZSBtZW1vcnkgYW5kIG1hbmlwdWxhdGluZyB0aGUgcGFnZQ0KPj4+
IGZsYWdzIHZpYSBzaW1wbGUgIiY9IiBhbmQgInw9IiBvcGVyYXRpb25zIGluIF9faW5pdF9zaW5n
bGVfcGFnZS4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5vbi1hdG9taWMgdmVyc2lvbiBf
X1NldFBhZ2VSZXNlcnZlZCB0aGF0IGNhbiBiZSB1c2VkDQo+Pj4gZHVyaW5nIHBhZ2UgaW5pdCBh
bmQgc2hvd3MgYWJvdXQgYSAxMCUgaW1wcm92ZW1lbnQgaW4gaW5pdGlhbGl6YXRpb24gdGltZXMN
Cj4+PiBvbiB0aGUgc3lzdGVtcyBJIGhhdmUgYXZhaWxhYmxlIGZvciB0ZXN0aW5nLg0KPj4NCj4+
IEkgYWdyZWUgd2l0aCBEYXZlIGFib3V0IGEgY29tbWVudCBpcyBkdWUuIEkgYW0gYWxzbyBxdWl0
ZSBzdXJwcmlzZWQgdGhhdA0KPj4gdGhpcyBsZWFkcyB0byBzdWNoIGEgbGFyZ2UgaW1wcm92ZW1l
bnQuIENvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0DQo+PiB5b3VyIHRlc3QgYW5kIG1h
Y2hpbmVzIHlvdSB3ZXJlIHRlc3Rpbmcgb24/DQo+IA0KPiBTbyBteSB0ZXN0IGNhc2UgaGFzIGJl
ZW4ganVzdCBpbml0aWFsaXppbmcgNCAzVEIgYmxvY2tzIG9mIHBlcnNpc3RlbnQNCj4gbWVtb3J5
IHdpdGggYSBmZXcgdHJhY2VfcHJpbnRrIHZhbHVlcyBhZGRlZCB0byB0cmFjayB0b3RhbCB0aW1l
IGluDQo+IG1vdmVfcGZuX3JhbmdlX3RvX3pvbmUuDQo+IA0KPiBXaGF0IEkgaGF2ZSBiZWVuIHNl
ZWluZyBpcyB0aGF0IHRoZSB0aW1lIG5lZWRlZCBmb3IgdGhlIGNhbGwgZHJvcHMgb24NCj4gYXZl
cmFnZSBmcm9tIDM1LTM2IHNlY29uZHMgZG93biB0byBhcm91bmQgMzEtMzIuDQoNCkp1c3QgY3Vy
aW91cyB3aHkgaXMgdGhlcmUgdmFyaWFuY2U/IER1cmluZyBib290IHRpbWUgaXMgdXN1YWxseSBw
cmV0dHkNCmNvbnNpc3RlbnQsIGFzIHRoZXJlIGlzIG9ubHkgb25lIHRocmVhZCBhbmQgc3lzdGVt
IGlzIGluIHByZXR0eSBtdWNoIHRoZQ0Kc2FtZSBzdGF0ZS4NCg0KQSBkbWVzZyBvdXRwdXQgaW4g
dGhlIGNvbW1pdCBsb2cgd291bGQgYmUgaGVscGZ1bC4NCg0KVGhhbmsgeW91LA0KUGF2ZWwNCg0K
PiANCj4+IE90aGVyIHRoYW4gdGhhdCB0aGUgcGF0Y2ggbWFrZXMgc2Vuc2UgdG8gbWUuDQo+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50
ZWwuY29tPg0KPj4NCj4+IFdpdGggdGhlIGFib3ZlIGFkZHJlc3NlZCwgZmVlbCBmcmVlIHRvIGFk
ZA0KPj4gQWNrZWQtYnk6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KPj4NCj4+IFRo
YW5rcyENCj4gDQo+IEFzIGZhciBhcyBhZGRpbmcgYSBjb21tZW50IGFyZSB3ZSBqdXN0IHRhbGtp
bmcgYWJvdXQgd2h5IGl0IGlzDQo+IHJlc2VydmVkLCBvciBkbyB3ZSBuZWVkIGEgZGVzY3JpcHRp
b24gb2YgdGhlIF9fU2V0UGFnZVJlc2VydmVkIHZlcnN1cw0KPiBTZXRQYWdlUmVzZXJ2ZWQuIEZv
ciBub3cgSSB3YXMgbG9va2luZyBhdCBhZGRpbmcgYSBjb21tZW50IGxpa2U6DQo+IEBAIC01NTE3
LDggKzU1MTcsMTMgQEAgdm9pZCBfX21lbWluaXQgbWVtbWFwX2luaXRfem9uZSh1bnNpZ25lZCBs
b25nDQo+IHNpemUsIGludCBuaWQsIHVuc2lnbmVkIGxvbmcgem9uZSwNCj4gIG5vdF9lYXJseToN
Cj4gICAgICAgICAgICAgICAgIHBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOw0KPiAgICAgICAgICAg
ICAgICAgX19pbml0X3NpbmdsZV9wYWdlKHBhZ2UsIHBmbiwgem9uZSwgbmlkKTsNCj4gKw0KPiAr
ICAgICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgICAqIE1hcmsgcGFnZSByZXNlcnZl
ZCBhcyBpdCB3aWxsIG5lZWQgdG8gd2FpdCBmb3Igb25saW5pbmcNCj4gKyAgICAgICAgICAgICAg
ICAqIHBoYXNlIGZvciBpdCB0byBiZSBmdWxseSBhc3NvY2lhdGVkIHdpdGggYSB6b25lLg0KPiAr
ICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAgICAgICBpZiAoY29udGV4dCA9PSBNRU1N
QVBfSE9UUExVRykNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgU2V0UGFnZVJlc2VydmVkKHBh
Z2UpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBfX1NldFBhZ2VSZXNlcnZlZChwYWdlKTsN
Cj4gDQo+ICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICogTWFyayB0aGUg
YmxvY2sgbW92YWJsZSBzbyB0aGF0IGJsb2NrcyBhcmUgcmVzZXJ2ZWQgZm9yDQo+IA0KPiBBbnkg
dGhvdWdodHMgb24gdGhpcz8NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IC0gQWxleA0KPiA=
