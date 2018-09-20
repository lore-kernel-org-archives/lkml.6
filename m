Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D430C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CC021532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EYjXTQsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeIUCjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:39:13 -0400
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:7224
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727232AbeIUCjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI9REYn4xnElFaM3MMA5l+VcKZPEvraacJRWaYrMNes=;
 b=EYjXTQsDpj0qxcUvDfCdWA2jJNYgSbQiQ15KX8vP/oiWhFXrq49449dNUenadkVAm2Gv6AZgjZd8qHJJHOVeraPCtLNOJGHVy07xlDO5ShGNbGSKPBUnTFbPunfDELn02HrApRF8XcLTRiay8UF3NBaz+rqZVxgx3uv1GHXIX2w=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0764.namprd21.prod.outlook.com (10.173.172.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.12; Thu, 20 Sep 2018 20:53:48 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 20:53:48 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/5] mm/memory_hotplug: Spare unnecessary calls to
 node_set_state
Thread-Topic: [PATCH 1/5] mm/memory_hotplug: Spare unnecessary calls to
 node_set_state
Thread-Index: AQHUUAC++BZLZOJuLki8FghpcPqq/aT5qAuA
Date:   Thu, 20 Sep 2018 20:53:48 +0000
Message-ID: <b04deb3f-bc3c-c78d-2774-125fa450ac42@microsoft.com>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-2-osalvador@techadventures.net>
In-Reply-To: <20180919100819.25518-2-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0764;6:4zF61khfAHjhy0UYvvzqzho4KH0a41as2HkhxP6ARIGaprG3v6yYpshR/6vBgP+qsfFtqD5ycBUpNuGqHbH52UCRJq8Oj9bTU0LTr0qfT9tZfTIc0dxCGkWW8AStQbJJkHYvadeYz+UQE2vfNabHkkmcWpKvuTdT00GyZ7zE6e4IrYoxHEmJKmx8dTPLqoHfXJR1+IVJ+xyYlnWzq9U3id5HR85ygkbLBAY5UOpowsa8/4/Usxa9NkG+Z6fSETNyBTeY83z2dKvUmdRoicQ1e3RJ89sw4171Oz1HCrrQvCbdi98xu+xha+hYqS68cQhaGu/B7DlFh9Q5ZT124oG1bJT95EKH4GS1REfXcx1sSsFFV+eE1gjKoH3nn5c/+2x3mar4wJew17vfe8jJ4XmdlhVc9Q9bxK50QxYZwLxQbZ7zyXaWHyvD97MUzJzvURMFGZLXfJr10aa6djtDs67veQ==;5:98vOOz0okJCxR+HaTSH9MPT4OkrDXkTKLPmhNy5cYeb2F4mkTn2oqS5nPDaZ5zqHC0c2zlYfv2K3sW1migBklz+s19hPDiJT7tsG8iavpswXxdbOUMBKNIb9Qjbk9eKwUhSYXLMpiGIYjLVcPNotySGe+Q6HPygpl1doPKv6oyE=;7:hWnRZZlj8xjohIU5vY7Q1jO3HfmHf7EN1STRl7FsT+PYiKzrgVQvvGwnGAQx+qfSaTbS+9N/lYyRZppJd/VLbJHY/PCvsTv9vKlVByOsOVIv1EEwstE/lF1VQVZEEoHs7/0UHLqRno/VoxNRlUypP/Bvm5oFssyirj/gGVjdZOQjZWNfYvfMh5mof5AisStu0yke5Xt0bTgsC4jKRbIvbeQDMgv5BVe2Vd4voK6GWNO7MZumuDmMc0dFsBULizxm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1f0cbb79-61b6-4b69-050b-08d61f3b29ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0764;
x-ms-traffictypediagnostic: DM5PR21MB0764:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07649769A4C3B00AAE26FD889D130@DM5PR21MB0764.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0764;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0764;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(54906003)(110136005)(14454004)(14444005)(256004)(97736004)(39060400002)(7736002)(99286004)(76176011)(7416002)(478600001)(6506007)(8676002)(72206003)(8936002)(81156014)(6246003)(81166006)(31696002)(5250100002)(36756003)(66066001)(68736007)(86612001)(2501003)(10290500003)(105586002)(486006)(25786009)(22452003)(102836004)(6436002)(316002)(86362001)(2900100001)(6486002)(10090500001)(229853002)(186003)(6512007)(2906002)(4326008)(5660300001)(305945005)(53936002)(26005)(6116002)(3846002)(53546011)(31686004)(106356001)(2616005)(11346002)(476003)(71200400001)(71190400001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0764;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bqPOJyLmuuyV2DJB6DZMInjih/VNkiQtEMhcwvKQJaoStlaJ4Eke7LCS5iWT+M4+8BlfEfcwFchUSgluDUbZx0r6fZfKgjHpmpgMGUCsNycEKwayhIxnHqgraBQMuuGv9DZerkR6raBTrEIytWVIYNSyWUEHpp1YNd6jggL1tApHQ9faFJ+xMGNgj1PIzW7o8NCn/xhgDoj6hRAFqZSeDg6ygMn2NI4z71KRzPFQ59w+TibIdUFwxWrUE+wDK+7HCLI+GMwFOIpgssgq+CJkl8fndBFYNBV0Jdyu7TqXigrJbTLL/SSy7x1+cNsFWivpa2fQfH2KgovWSge8gPOtbZDS/aoOopGYEp++mm/AJjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <482BA3A9FCB2114BB20BA8C62017EB83@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0cbb79-61b6-4b69-050b-08d61f3b29ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:53:48.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTkvMTggNjowOCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IEluIG5vZGVfc3RhdGVzX2No
ZWNrX2NoYW5nZXNfb25saW5lLCB3ZSBjaGVjayBpZiB0aGUgbm9kZSB3aWxsDQo+IGhhdmUgdG8g
YmUgc2V0IGZvciBhbnkgb2YgdGhlIE5fKl9NRU1PUlkgc3RhdGVzIGFmdGVyIHRoZSBwYWdlcw0K
PiBoYXZlIGJlZW4gb25saW5lZC4NCj4gDQo+IExhdGVyIG9uLCB3ZSBwZXJmb3JtIHRoZSBhY3Rp
dmF0aW9uIGluIG5vZGVfc3RhdGVzX3NldF9ub2RlLg0KPiBDdXJyZW50bHksIGluIG5vZGVfc3Rh
dGVzX3NldF9ub2RlIHdlIHNldCB0aGUgbm9kZSB0byBOX01FTU9SWQ0KPiB1bmNvbmRpdGlvbmFs
bHkuDQo+IFRoaXMgbWVhbnMgdGhhdCB3ZSBjYWxsIG5vZGVfc2V0X3N0YXRlIGZvciBOX01FTU9S
WSBldmVyeSB0aW1lDQo+IHBhZ2VzIGdvIG9ubGluZSwgYnV0IHdlIG9ubHkgbmVlZCB0byBkbyBp
dCBpZiB0aGUgbm9kZSBoYXMgbm90IHlldCBiZWVuDQo+IHNldCBmb3IgTl9NRU1PUlkuDQo+IA0K
PiBGaXggdGhpcyBieSBjaGVja2luZyBzdGF0dXNfY2hhbmdlX25pZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCg0KUmV2aWV3ZWQtYnk6
IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQo+IC0tLQ0K
PiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5X2hv
dHBsdWcuYyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gaW5kZXggMzhkOTRiNzAzZTlkLi42M2Zh
Y2ZjNTcyMjQgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gKysrIGIvbW0v
bWVtb3J5X2hvdHBsdWcuYw0KPiBAQCAtNzUzLDcgKzc1Myw4IEBAIHN0YXRpYyB2b2lkIG5vZGVf
c3RhdGVzX3NldF9ub2RlKGludCBub2RlLCBzdHJ1Y3QgbWVtb3J5X25vdGlmeSAqYXJnKQ0KPiAg
CWlmIChhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPj0gMCkNCj4gIAkJbm9kZV9zZXRfc3Rh
dGUobm9kZSwgTl9ISUdIX01FTU9SWSk7DQo+ICANCj4gLQlub2RlX3NldF9zdGF0ZShub2RlLCBO
X01FTU9SWSk7DQo+ICsJaWYgKGFyZy0+c3RhdHVzX2NoYW5nZV9uaWQgPj0gMCkNCj4gKwkJbm9k
ZV9zZXRfc3RhdGUobm9kZSwgTl9NRU1PUlkpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBf
X21lbWluaXQgcmVzaXplX3pvbmVfcmFuZ2Uoc3RydWN0IHpvbmUgKnpvbmUsIHVuc2lnbmVkIGxv
bmcgc3RhcnRfcGZuLA0KPiA=
