Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5128AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D2221568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jCPj7Qp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D2221568
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391438AbeIVCFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:05:02 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:38816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391251AbeIVCFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4nuhWsptdAK6eg7LSp10iS0kasBEM5FsrCtQk3flnU=;
 b=jCPj7Qp9o5RLWQyUrOg8V7te2cL34oYEuGQTKLveXJvZNiXAUWV2tJv6OcHkdVFzHVfySfHGIJdexPwUOmgVuLKwk6ZCT86WnQ2e2cPjR6i5A0D40HdseV6ja8JzlIqNrr844e6RHrWHzuKTyg5wmqjxB3/2HePsqUH2WSkUybY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0826.namprd21.prod.outlook.com (10.173.172.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Fri, 21 Sep 2018 20:14:32 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 20:14:32 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/5] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Topic: [PATCH v4 3/5] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Index: AQHUUTFwJuKfr51oTUOI402VMkePkKT7JkGAgAADwgCAAAMCAA==
Date:   Fri, 21 Sep 2018 20:14:32 +0000
Message-ID: <0d9a970c-bec2-e350-be9e-52029282da30@microsoft.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222758.19464.83992.stgit@localhost.localdomain>
 <2254cfe1-5cd3-eedc-1f24-8e011dcf3575@microsoft.com>
 <f4d5ace6-9657-746b-9448-064a4b7cfb8d@linux.intel.com>
In-Reply-To: <f4d5ace6-9657-746b-9448-064a4b7cfb8d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0826;6:SRgNZWDbvk3cNpcpvZPnfjjlzCdkJ1PQPFg7Ksu1iFJqcKy1L/qpF5/8liykphxqMKg7OuNZGGb/fC99KFLSPJG9fH6x8Lt+4QeUhz0+WrxHASqLqL2FsdijdzDQ4L50xoTmlfIp+62urJEikb47MVi2q9u59rek6dx9df7CWpohre7E+VphvgVNGWK8A1j9Iaq7G1ArrCiA5vR2o2l4ykLr9zkP4TDsyOaQSFgNRo/NNft8k+Mxz4B54x6BAG5u7LAXeqt7O+uHvg7I4Y3Y2sMb+x00ySk4Qo79S772zDN3bI6LQ/i38jYoGJwyJXSzzJmCSaYXSqdOLxysO6tOtPtsAjO++u9SLTsc4OCVVTp1qzGnOFcWcH7YIftRgeDEnsDjB9cZR8W3KXcUobYfELlpEJK3EmmGasEJygMGjG4tCIS45s9FO0ySqpDWJqxpKqjJF/iKCBIbbqrUS6Ze1A==;5:o1ZnXVkBK6OEZxJTzEgeE3YEX9nlMEt2mwtbNAbzs7xrRtgwq6pB02yJwvxxMYo+6ypihc8AHGXJTDZueTbs25SXhxt++TwkFwVx3qZ0TPne1fcoioEf7XyvzH+lZYeQEU2I7Lsxmj3TS7hm6CnZSn3NsYAmxKeJTLpCQDvhWgY=;7:MypjciV+zjHNj3jQ+g2BJXfRnk/7ms9aPyC5C4MzZ0Wp+Yuhbdobj9tp4K1XXK33+sCKo6Kjx6lxmTiOjJOZYxmRM9pJuMmsGzItb6PaZF7v5TG3+RoU25vKgEkIqs3FSkf93Z9IVbj1+fRhqM3Rpo9AcZLh1C+0uHZhSZWwvqhBqoeDmY36/ij+eTImaadAVl8T9+u6cCzM1HvzUsdtwgAnjP641u+fxkW8n8ks7NYuJxDW6qeE+kiHEU8gbIyh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: daf70bdb-50f8-47d3-b6ae-08d61ffed7c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0826;
x-ms-traffictypediagnostic: DM5PR21MB0826:
x-microsoft-antispam-prvs: <DM5PR21MB082689E7454AAD9F637D934A9D120@DM5PR21MB0826.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149051)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0826;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0826;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(51914003)(189003)(199004)(11346002)(446003)(476003)(486006)(6486002)(186003)(4326008)(316002)(229853002)(6512007)(53936002)(6436002)(305945005)(6506007)(26005)(7736002)(81156014)(76176011)(71200400001)(71190400001)(106356001)(8936002)(105586002)(478600001)(81166006)(8676002)(10290500003)(2906002)(5250100002)(72206003)(97736004)(14454004)(31686004)(2616005)(6116002)(99286004)(3846002)(110136005)(54906003)(6346003)(102836004)(36756003)(68736007)(2501003)(2201001)(256004)(7416002)(2900100001)(86362001)(25786009)(10090500001)(6246003)(93886005)(86612001)(22452003)(31696002)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0826;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: eFr3DH3ua3uSxDC9nAfaob6TI+x8nMmNMiL+62KINjwIhVOrMuNqGA7fFyl2K+YJ0rTmjdhX7UBxwwT29mNZgmz/TJgsG32N1Z5dKVN27vd9PtpBw2rh8bJthG6x8UOq4aa+qPSbBZ3cf/H/NNhwZUKuurVMWDiz5fKiqVnEABKu3gkHGf/W5qtFtqLKkU0RPOoeesNy6nvUfketdeNJoFw85UEBAOGSDJS8Pu8ez3MGBAU4m2K9bekGirbl5VNzLCD1940MPFkmKI6HqVF8RAF2mnHmNtIicUI/cEsNs3IW0Bm95HkCtsfAF09YBEJJy3GxzhrMfsqNKKtoTFYyTQVqqi0LVenx9dkqCIUU/5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0664749558304189A8B9EA61198D88@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf70bdb-50f8-47d3-b6ae-08d61ffed7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 20:14:32.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHBhZ2UtPnBnbWFwID0gcGdtYXA7DQo+Pj4gK8KgwqDCoMKg
wqDCoMKgIHBhZ2UtPmhtbV9kYXRhID0gMDsNCj4+DQo+PiBfX2luaXRfc2luZ2xlX3BhZ2UoKQ0K
Pj4gwqDCoCBtbV96ZXJvX3N0cnVjdF9wYWdlKCkNCj4+DQo+PiBUYWtlcyBjYXJlIG9mIHplcm9p
bmcsIG5vIG5lZWQgdG8gZG8gYW5vdGhlciBzdG9yZSBoZXJlLg0KPiANCj4gVGhlIHByb2JsZW0g
aXMgX19pbml0X3NpbmdlX3BhZ2UgYWxzbyBjYWxscyBJTklUX0xJU1RfSEVBRCB3aGljaCBJDQo+
IGJlbGlldmUgc2V0cyB0aGUgcHJldiBwb2ludGVyIHdoaWNoIG92ZXJsYXBzIHdpdGggaG1tX2Rh
dGEuDQoNCkluZGVlZCBpdCBkb2VzOg0KDQpJTklUX0xJU1RfSEVBRCgmcGFnZS0+bHJ1KTsgb3Zl
cmxhcHMgd2l0aCBobW1fZGF0YSwgYW5kIGJlZm9yZQ0KbGlzdF9kZWwoJnBhZ2UtPmxydSk7IHdh
cyBjYWxsZWQgdG8gcmVtb3ZlIGZyb20gdGhlIGxpc3QuDQoNCkFuZCBub3cgSSBzZWUgeW91IGFs
c28gbWVudGlvbmVkIGFib3V0IHRoaXMgaW4gY29tbWVudHMuIEkgYWxzbyBwcmVmZXINCmhhdmlu
ZyBpdCB6ZXJvZWQgaW5zdGVhZCBvZiBsZWZ0IHBvaXNvbmVkIG9yIHVuaW5pdGlhbGl6ZWQuIFRo
ZSBjaGFuZ2UNCmxvb2tzIGdvb2QuDQoNClRoYW5rIHlvdSwNClBhdmVsDQoNCj4gDQo+Pg0KPj4g
TG9va3MgZ29vZCBvdGhlcndpc2UuDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGlu
IDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KPj4NCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IHJldmlldy4NCj4g
