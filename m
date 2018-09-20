Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D321534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iMO0xTE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9D321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeIUCpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:45:24 -0400
Received: from mail-dm3nam03on0122.outbound.protection.outlook.com ([104.47.41.122]:53344
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbeIUCpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CynpcVpN+77oA8QhbcLs5NIzHS1bq8NhHip934CXhQ=;
 b=iMO0xTE3OOYOhtAXZVN41niTbTWlgwu+I2lIa3EaX0FKTL4SvOmAzvOteueSL82Rt65E654vOZ6nA+j37QOR+fjRnqzA3QktLqLciw9HP2TeaIRUtfsTNdzX19Kd6q33eXgImKxa6PAk0QRLq/+mEnIMws6j8wB4EhqkMxFZ7o4=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0795.namprd21.prod.outlook.com (10.175.112.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 20:59:18 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 20:59:18 +0000
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
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Avoid
 node_set/clear_state(N_HIGH_MEMORY) when !CONFIG_HIGHMEM
Thread-Topic: [PATCH 2/5] mm/memory_hotplug: Avoid
 node_set/clear_state(N_HIGH_MEMORY) when !CONFIG_HIGHMEM
Thread-Index: AQHUUAC/eJzbOlZCF0q0eePsEXz8M6T5qZSA
Date:   Thu, 20 Sep 2018 20:59:18 +0000
Message-ID: <e66c7d55-7145-dd6c-4b11-27893ed7a7d0@microsoft.com>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-3-osalvador@techadventures.net>
In-Reply-To: <20180919100819.25518-3-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0795;6:hZHZ+Ld+49+lxHbOWPzJild3XUjiVF7Atywwt8Byi58Yp6KzDB7PI4YUtxCMMGNe1L6NM0Id4vZtJjEJll8tpM0ZWhOm4sgkZ/SU+9TqSaCsKFfBqhp/L93ygREChbo6/4WVKwtqldsFNlG2Nvy1MFwBm6FhD4j6mCxJlGBKVI2a92z7k/ZTd/pADQJaaMek99QuaqqFug57caiXod4zqi8NLv/vXR8m5iieqv+z0pYSimfTeEfHdxu+1fPBuCjCgP0UOv2+PXbtsv+EexyARYFzkoho5mfesM0tFl5iFkdvNgGIdGqAIGvy/XUXtskQ8pUouYwb0qPUd3VxlIoXpgrQdQteZtdVvbrikGAfEGQUlJn16ElQ/bmHblI2wKa6NCut+/dIHCkO9bi/4fQxCTNUobPbadO6xfwhpHQQBlHWI8ZV5fV2hNfRRVru/sTEsDvlQQ0k9HPE+VEqr019pQ==;5:YYA6k9BpmyTXpmmHfyHBnJTsdVNbrXs8p6tXC9Y9AusNLeMfw2w7K+ybrtmVG26Ot3VYKWASOZl11mugV2w9ec94OllOJEjn/WXSqXuh2Z6lcvmfdHLK7TpHkkAsvw5AgA3GT6iHW6iY83ICASeHHG9bAh1wb824tikOakuExbc=;7:zZTT2Y4n5daSfJQvlOvOx987VNe22KM8O3WPsn6A04TPu0PZSfCqNtpVM6pn7h62Uu6mCV4OvvATDZafQUT76pV8oH8NwQxobNsMYqEVzN+XGimukCBJxkoFeF1MGfl19e2aV+rs0tgZPin48ElLkLLQ/i+8wfhyS1lUFiaHqkn5Yc2RAbi9bxnTnV1Oim6+QmmCCfD7/StEPf9g5OhftHTYmZUBRoWEGCISwBLMta6RemuqzyY+fSjz5qg56KnG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02b5d984-6be6-4531-92fc-08d61f3beed2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0795;
x-ms-traffictypediagnostic: DM5PR21MB0795:
x-microsoft-antispam-prvs: <DM5PR21MB07955CCBB04C943BF7E975829D130@DM5PR21MB0795.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0795;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0795;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(22452003)(105586002)(106356001)(72206003)(186003)(36756003)(316002)(68736007)(11346002)(97736004)(486006)(446003)(2616005)(476003)(4326008)(25786009)(14454004)(54906003)(256004)(31686004)(110136005)(7416002)(5660300001)(66066001)(2900100001)(6436002)(305945005)(76176011)(7736002)(5250100002)(71200400001)(2501003)(71190400001)(229853002)(6486002)(3846002)(6116002)(478600001)(6512007)(10090500001)(39060400002)(81166006)(8936002)(81156014)(6346003)(53936002)(2906002)(26005)(8676002)(31696002)(575784001)(86362001)(99286004)(10290500003)(6506007)(6246003)(86612001)(102836004)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0795;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: LcWmHsT8e/yJl617Ef268GaPbNivWFmflSS7GMQLVwYjWKMvQY0asR4yLhER0pkF4+6H6IZKTmwZF0lt/vlywj3QspMmgtb62qHO3d/H5J5xui2H/X1GMs3CPz/YwksqhpAnDHhoU/SD8wDFZhPCn282WKp3WPxorGqOuF8J8WIX5kBcoCGhe257bNImSsp7lA9gpFvzr7J4cfDXFoZwVAZofuhVW/ealVMLVXYo/Snl9jRLLCtB/Bm/I65GC/6h2pV4TNqLF+yQb6Sz6Qw8+KxfcJbWeSRCjjIoBXB6CD/St8QAj+qp36Y17BGDh0p1DHTrF71EkjFy1eKoj2k2Arg1W6CxXDPvlW/+i9QbE7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1653609D10574F41B00EBFC6D9480070@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b5d984-6be6-4531-92fc-08d61f3beed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:59:18.7811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTkvMTggNjowOCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IEN1cnJlbnRseSwgd2hlbiAh
Q09ORklHX0hJR0hNRU0sIHN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggaXMgYmVpbmcgc2V0DQo+IHRv
IHN0YXR1c19jaGFuZ2VfbmlkX25vcm1hbCwgYnV0IG9uIHN1Y2ggc3lzdGVtcyBOX0hJR0hfTUVN
T1JZIGZhbGxzDQo+IGJhY2sgdG8gTl9OT1JNQUxfTUVNT1JZLg0KPiBUaGF0IG1lYW5zIHRoYXQg
aWYgc3RhdHVzX2NoYW5nZV9uaWRfbm9ybWFsIGlzIG5vdCAtMSwNCj4gd2Ugd2lsbCBwZXJmb3Jt
IHR3byBjYWxscyB0byBub2RlX3NldF9zdGF0ZSBmb3IgdGhlIHNhbWUgbWVtb3J5IHR5cGUuDQo+
IA0KPiBTZXQgc3RhdHVzX2NoYW5nZV9uaWRfaGlnaCB0byAtMSBmb3IgIUNPTkZJR19ISUdITUVN
LCBzbyB3ZSBza2lwIHRoZQ0KPiBkb3VibGUgY2FsbCBpbiBub2RlX3N0YXRlc19zZXRfbm9kZS4N
Cj4gDQo+IFRoZSBzYW1lIGdvZXMgZm9yIG5vZGVfY2xlYXJfc3RhdGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBPc2NhciBTYWx2YWRvciA8b3NhbHZhZG9yQHN1c2UuZGU+DQoNClJldmlld2VkLWJ5
OiBQYXZlbCBUYXRhc2hpbiA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4NCg0KVGhpcyBp
cyBhIHJhcmUgY2FzZSB3aGVyZSBJIHRoaW5rIGNvbW1lbnRzIGFyZSB1bm5lY2Vzc2FyeSBhcyB0
aGUgY29kZQ0KaXMgc2VsZiBleHBsYW5hdG9yeS4gU28sIEkgd291bGQgcmVtb3ZlIHRoZSBjb21t
ZW50cyBiZWZvcmU6DQoNCj4gKwlhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPSAtMTsNCg0K
UGF2ZWwNCg0KPiAtLS0NCj4gIG1tL21lbW9yeV9ob3RwbHVnLmMgfCAxMiArKysrKysrKysrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5j
DQo+IGluZGV4IDYzZmFjZmM1NzIyNC4uYzJjNzM1OWJkMGE3IDEwMDY0NA0KPiAtLS0gYS9tbS9t
ZW1vcnlfaG90cGx1Zy5jDQo+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gQEAgLTczMSw3
ICs3MzEsMTEgQEAgc3RhdGljIHZvaWQgbm9kZV9zdGF0ZXNfY2hlY2tfY2hhbmdlc19vbmxpbmUo
dW5zaWduZWQgbG9uZyBucl9wYWdlcywNCj4gIAllbHNlDQo+ICAJCWFyZy0+c3RhdHVzX2NoYW5n
ZV9uaWRfaGlnaCA9IC0xOw0KPiAgI2Vsc2UNCj4gLQlhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hp
Z2ggPSBhcmctPnN0YXR1c19jaGFuZ2VfbmlkX25vcm1hbDsNCj4gKwkvKg0KPiArCSAqIFdoZW4g
IUNPTkZJR19ISUdITUVNLCBOX0hJR0hfTUVNT1JZIGVxdWFscyBOX05PUk1BTF9NRU1PUlkNCj4g
KwkgKiBzbyBzZXR0aW5nIHRoZSBub2RlIGZvciBOX05PUk1BTF9NRU1PUlkgaXMgZW5vdWdoLg0K
PiArCSAqLw0KPiArCWFyZy0+c3RhdHVzX2NoYW5nZV9uaWRfaGlnaCA9IC0xOw0KPiAgI2VuZGlm
DQo+ICANCj4gIAkvKg0KPiBAQCAtMTU1NSw3ICsxNTU5LDExIEBAIHN0YXRpYyB2b2lkIG5vZGVf
c3RhdGVzX2NoZWNrX2NoYW5nZXNfb2ZmbGluZSh1bnNpZ25lZCBsb25nIG5yX3BhZ2VzLA0KPiAg
CWVsc2UNCj4gIAkJYXJnLT5zdGF0dXNfY2hhbmdlX25pZF9oaWdoID0gLTE7DQo+ICAjZWxzZQ0K
PiAtCWFyZy0+c3RhdHVzX2NoYW5nZV9uaWRfaGlnaCA9IGFyZy0+c3RhdHVzX2NoYW5nZV9uaWRf
bm9ybWFsOw0KPiArCS8qDQo+ICsJICogV2hlbiAhQ09ORklHX0hJR0hNRU0sIE5fSElHSF9NRU1P
UlkgZXF1YWxzIE5fTk9STUFMX01FTU9SWQ0KPiArCSAqIHNvIGNsZWFyaW5nIHRoZSBub2RlIGZv
ciBOX05PUk1BTF9NRU1PUlkgaXMgZW5vdWdoLg0KPiArCSAqLw0KPiArCWFyZy0+c3RhdHVzX2No
YW5nZV9uaWRfaGlnaCA9IC0xOw0KPiAgI2VuZGlmDQo+ICANCj4gIAkvKg0KPiA=
