Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15980ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526862154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JrFXKbfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526862154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbeIVBnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:43:08 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:28843
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391160AbeIVBnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aavpDit87lE/8z09JJOXzvmi0LfvZfzhiHBuN5apJdk=;
 b=JrFXKbfC9VrivFCRicm6OtT6eNtDtxlpzWNeDMINQ8Q65VHPfuhXRoXkeVFWgdAJwsP6MLNCvwnVmh6tIGs/mjDK6qfFg13raWlRRxSTazRMk9Dv9SW3VWWPhc81npRwf1rvcdz5KODA8llRqleFGRUULNR/lavNUaKlo5g493I=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0745.namprd21.prod.outlook.com (10.173.172.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Fri, 21 Sep 2018 19:52:42 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 19:52:42 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 1/5] mm: Provide kernel parameter to allow disabling
 page init poisoning
Thread-Topic: [PATCH v4 1/5] mm: Provide kernel parameter to allow disabling
 page init poisoning
Thread-Index: AQHUUTEJUetFnXyPxkiXMreNCU4+e6T7GXWAgAAKQwCAAAM1gA==
Date:   Fri, 21 Sep 2018 19:52:42 +0000
Message-ID: <3c045f79-c18b-47dd-4017-a024edc9aa46@microsoft.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222415.19464.38400.stgit@localhost.localdomain>
 <a40a78c0-207b-03b7-344c-847b12a4f896@microsoft.com>
 <4d984974-ff16-35e4-76ff-f5e43e5e90da@deltatee.com>
In-Reply-To: <4d984974-ff16-35e4-76ff-f5e43e5e90da@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0745;6:CETR4paoFyca1BqTgzfb6mf0EHt2OGXREPzfuILsI1on+kIcbRa2uysvpJH3u2CYJJ0rPql5axyYqAi0iuVSmHYEmopudrmutaB2jMmOlrxmjGLQqUDJNJbyy+/PX9DP8dWXHQ8jz2IwwKV3DmtudCcjnFToTNw5FeUHq2ArroKtbv2qKV1lBxFpdDjv61rUSrRMZREiZFoqum18h5wKZ+WkVsxymUPd10iom7BQ/Wi08/y1uq0fj2yYm/CBolX5CJ5ippEFb0mEpvfQMBJG/QKt2cH5/iICRSNwzm35HXcFu69intPPFVRbHQEEsDILcCWDC3ZKPhL8mm6MZFqP7qY0nRjRT1De6XmdgEVZzTcicjjv8OAvaxZCOFeWKodAeCt7SCY4w6vbKeCzkGnM+zcT1gvfCqbM7mM9veTaKn9LOYJMoj/jZLWHtiOO3jpDQ1/fh1T4D0/TIM9aPYVzAw==;5:A/XvcgDmhuy/gYIwFx2NMBeIB0Cp0e5Oq1GsDk/Wf51htDFsJNV0vsxISd4MhAa5R/RW/OR89XUCEeoifI2phQ2zGIkOCGjqtUhM3NyKiuiyR5YAVJIU4dgMk55+M4iiEYuGwyPasB7oj3KqPKT07R7No7r9dsu8Xv6PvVLgOMU=;7:5UkYy2W1tWDADmSS1zyLTGRiUj9ab/S/29hUtp1962rvylKVdFgnjNkJY2KKwppPsUydqkEl7GiHXaPRhlwgmY9LUakp6MAMzAmaxw2czBHNOio0a3isSYp7VOKiuWyGm7+LgvwK7Zxli5rrHKqaQ7JG3DQ47ZoqKCW+XZz8pPuNaDHOQLeNG6m7LAXu2qNdGSxqDDmevAggfv0en9ibxxyQXZqbfQxZCzcPdOW2Mk9NLQvJX+Mj3MDtm5f8pIxG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d897436c-93f8-4deb-35e5-08d61ffbcb4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0745;
x-ms-traffictypediagnostic: DM5PR21MB0745:
x-microsoft-antispam-prvs: <DM5PR21MB074580DB75DAFF049AC55A479D120@DM5PR21MB0745.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149051)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0745;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0745;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(5660300001)(7736002)(68736007)(81156014)(81166006)(110136005)(66066001)(54906003)(99286004)(97736004)(14444005)(446003)(2616005)(256004)(11346002)(486006)(186003)(476003)(31696002)(5250100002)(86362001)(10090500001)(71190400001)(71200400001)(6506007)(53546011)(86612001)(2201001)(345774005)(14454004)(6246003)(36756003)(316002)(22452003)(2501003)(72206003)(6512007)(31686004)(6346003)(25786009)(7416002)(8936002)(2906002)(4326008)(93886005)(229853002)(6436002)(305945005)(8676002)(26005)(76176011)(2900100001)(478600001)(6486002)(53936002)(10290500003)(102836004)(3846002)(6116002)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0745;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: vpyd+ARbuYjiSyX8mpGGbPm330dMgZYS3s21N1TCaXbXDcZ+a0a59Q4jDFhreKSsiXZoy3av0I3ISntsX3yZposA6X+r6JiGlcVn6gXwp+J9C4Uw4weFGhQlHdchvPWs2+Z+bK7CLwWyGocBUPt9GYQ8eL/QzjMiRd6g79ZzS/EqBIP3Lm3EzAG1ein3pEGgsspQ5S8L7A8yyWRHMCZ5V4G4sg4YzQ+GfgkmdhWbirhy4kmccK3uXjumWMY1EfRrYuwP6Xs8H22a/s4Xr1paEERPVr1NYsO27RyGcKqWr/QCKTKc8ksM8ResFGCgEtwY+fJLvxA3tlArmJUGFm4UzKnsjJ+TUiLYz7aYxL+kvFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEF40F3EFDE49F42BBBFD042E5E9A767@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d897436c-93f8-4deb-35e5-08d61ffbcb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:52:42.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjEvMTggMzo0MSBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiAyMDE4
LTA5LTIxIDE6MDQgUE0sIFBhc2hhIFRhdGFzaGluIHdyb3RlOg0KPj4NCj4+PiArCQkJcHJfZXJy
KCJ2bV9kZWJ1ZyBvcHRpb24gJyVjJyB1bmtub3duLiBza2lwcGVkXG4iLA0KPj4+ICsJCQkgICAg
ICAgKnN0cik7DQo+Pj4gKwkJfQ0KPj4+ICsNCj4+PiArCQlzdHIrKzsNCj4+PiArCX0NCj4+PiAr
b3V0Og0KPj4+ICsJaWYgKHBhZ2VfaW5pdF9wb2lzb25pbmcgJiYgIV9fcGFnZV9pbml0X3BvaXNv
bmluZykNCj4+PiArCQlwcl93YXJuKCJQYWdlIHN0cnVjdCBwb2lzb25pbmcgZGlzYWJsZWQgYnkg
a2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb24gJ3ZtX2RlYnVnJ1xuIik7DQo+Pg0KPj4gTmV3IGxp
bmVzICdcbicgY2FuIGJlIHJlbW92ZWQsIHRoZXkgYXJlIG5vdCBuZWVkZWQgZm9yIGtwcmludGZz
Lg0KPiANCj4gTm8sIHRoYXQncyBub3QgY29ycmVjdC4NCj4gDQo+IEEgcHJpbnRrIHdpdGhvdXQg
YSBuZXdsaW5lIHRlcm1pbmF0aW9uIGlzIG5vdCBlbWl0dGVkDQo+IGFzIG91dHB1dCB1bnRpbCB0
aGUgbmV4dCBwcmludGsgY2FsbC4gKFRvIHN1cHBvcnQgS0VSTl9DT05UKS4NCj4gVGhlcmVmb3Jl
IHJlbW92aW5nIHRoZSAnXG4nIGNhdXNlcyBhIHByaW50ayB0byBub3QgYmUgcHJpbnRlZCB3aGVu
IGl0IGlzDQo+IGNhbGxlZCB3aGljaCBjYW4gY2F1c2UgbG9uZyBkZWxheWVkIG1lc3NhZ2VzIGFu
ZCBzdWJ0bGUgcHJvYmxlbXMgd2hlbg0KPiBkZWJ1Z2dpbmcuIEFsd2F5cyBrZWVwIHRoZSBuZXds
aW5lIGluIHBsYWNlIGV2ZW4gdGhvdWdoIHRoZSBrZXJuZWwgd2lsbA0KPiBhZGQgb25lIGZvciB5
b3UgaWYgaXQncyBtaXNzaW5nLg0KDQpPSy4gVGhhbmsgeW91IGZvciBjbGFyaWZ5aW5nIExvZ2Fu
LiBJJ3ZlIHNlZW4gbmV3IGxpbmVzIGFyZSBiZWluZw0KcmVtb3ZlZCBpbiBvdGhlciBwYXRjaGVz
LA0KDQpQYXZlbA==
