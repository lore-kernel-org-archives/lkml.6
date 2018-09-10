Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42358C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nbP/VkMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EF720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeIJT1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:27:21 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:18975
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIJT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0vMdu/7Z6EU4Q/WrE5s9jU/CViv8kaxKvaumOJrzOA=;
 b=nbP/VkMaZdmMsoVJs6lAffo5W1Hn7XQCZIeQbeZnIjeXtgWHwSrqw+pk/8zonXp4MiQMBQaEDEMJpt8uE8KNDbTdzAXL1gi7ZemhW9H1hIXKvtVMMJ0R0xxeOX7U8vkch16F1b8iagIiAFGyun0Bjl6h/doB2TpYWtYGYYBvqxg=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0476.namprd21.prod.outlook.com (10.172.92.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 14:32:17 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 14:32:16 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Topic: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Index: AQHUSQLFF/mQjCkfKkuMMO7HZfKu+6Tpf1cAgAAIDwCAAAOzgIAAAx4AgAACaQCAAANSgA==
Date:   Mon, 10 Sep 2018 14:32:16 +0000
Message-ID: <CAGM2reZ5OD9SRW8j9iaQAk9jpr86pF2NqpBjv-dxH+1vJZs0=g@mail.gmail.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
 <20180910135959.GI10951@dhcp22.suse.cz>
 <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
 <20180910141946.GJ10951@dhcp22.suse.cz>
In-Reply-To: <20180910141946.GJ10951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0476;6:HSU2BVbLyGrm+DI40JGf9m/gYdfpsffo3ZoE6iam0vrHLtq0ag6lAULxqow2N7usW72U42vBWI2QsXXs2rjG9SUw2Q3muyPBGMSdSf1LDBOVB6qncEwSi/TWxI25MMGQRZK7shQIUubJbt/8hzI589eUnP//sQZHLXvCZR2K/p/nVgFLg80pzyLJVLJQq74WLOXbs/txUzAGbvuDy+lfg+nbvovfDGCUgfBud2XLw7k1kH2BpTDAUIdsSu+0ZKJVhwIFqtUtgp5+ljMy0cm7nR7Tzfm1zLJRQn52TgGouuM9bmR2NtNOnXoV8drJPofiWwDo47IUs5aZM+iOkmlGT6FoBYBO4Gwh/l6seFGck5W4HEMUa8Ar7sB8OyhyATmiy4PCxt5CymwMm6rwTxkw97R9N2Yu7qwiBqrFtzo5ZLVeWQP+TiGFTO2maz/WvHBRu4/5JECLxj85gEev7pmE4w==;5:cxpESLGtj4PxgYiGo/NCQ2cxZ8+fBJ5o16hgYbOOeJ8ytTNzDIwPfwuyn+CcmvAPzpTbJFdBZhm0oJjo6VYfnOhcV6cKLdBde0Z5KW54iIsJ0rcHZU+j3ycNg6XsXEMOe8TH3QP3ql9tYbjqGf2Uv5vMpyk2BbGu9R1n4TYaYa4=;7:CecGh5gaGeb0VZAf7CTUGxqIy++BUXyJ/XyCHBpd/hRHVTh+9RbUirlPexZGMurpeC+Ah6xG89ykQ/1snvHjv6SU3oEWJNueepmaUzgT7DCZI92SRGz8vU4/OFxteka06qOrwf7PGq7sMUmzxTWqobYxhjSf9S6Ke29dxXh54m0AEe+Kvrb4bP9HnuuwiaWsZTNR5U/uXu5sJ8O9go37xmRgVHmwJ7LeI5WWVhTE0G9NW7XbLsPtaiw7Dj4jPKDC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc248028-8efa-4ced-56ee-08d6172a3549
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0476;
x-ms-traffictypediagnostic: DM5PR21MB0476:
x-microsoft-antispam-prvs: <DM5PR21MB0476D8789E9771E69AF577B39D050@DM5PR21MB0476.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0476;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0476;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(186003)(316002)(6346003)(26005)(102836004)(9686003)(25786009)(61726006)(6512007)(8936002)(1730700003)(22452003)(53546011)(66066001)(54906003)(6246003)(68736007)(81156014)(81166006)(256004)(5250100002)(8676002)(6506007)(14444005)(86362001)(55446002)(93886005)(2900100001)(2351001)(61266001)(86612001)(6916009)(3846002)(106356001)(229853002)(97736004)(305945005)(5640700003)(4326008)(10090500001)(7736002)(105586002)(478600001)(486006)(498394004)(14454004)(2501003)(2906002)(33896004)(476003)(10290500003)(6486002)(76176011)(446003)(5660300001)(6116002)(99286004)(8990500004)(53936002)(11346002)(6436002)(72206003)(98316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0476;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: taXqIst6VTu/cUs21ykiLXvKq1WQIvy8MFKQtfKChremlZ8JUNNxvQUQP7mINWNgT8dJchN8/lfryGSbAyB9axt1ru8VP23r+RvB43gWkFgnkz8n0yWJpb26hsdG5F2f88tnVklgChYSj8mmqYpd6jtRQnpXMmXAXwJnuD2PL6V0sl0TIg3r0whh/6KedGaGs9+fF5alEHsvXrA5JIi4isSnGlUPlvf54G2a7B+LSCdbhDfqlVLgWwO5jWBf6HkXFfewk/EwxSkAd6r5fXh2uvZxZwQhT+skMxvqhWP0QJnD3N2BOucZRVr3MH/Fi8aXqZiBjPRK2cMoo3X0yZP6740fW1TbgeWnCs7bYKbIHoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5AC2E24D7AED4EA6437DE74B7EC4FC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc248028-8efa-4ced-56ee-08d6172a3549
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 14:32:16.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMTAsIDIwMTggYXQgMTA6MTkgQU0gTWljaGFsIEhvY2tvIDxtaG9ja29Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+DQo+IE9uIE1vbiAxMC0wOS0xOCAxNDoxMTo0NSwgUGF2ZWwgVGF0
YXNoaW4gd3JvdGU6DQo+ID4gSGkgTWljaGFsLA0KPiA+DQo+ID4gSXQgaXMgdHJpY2t5LCBidXQg
cHJvYmFibHkgY2FuIGJlIGRvbmUuIEVpdGhlciBjaGFuZ2UNCj4gPiBtZW1tYXBfaW5pdF96b25l
KCkgb3IgaXRzIGNhbGxlciB0byBhbHNvIGNvdmVyIHRoZSBlbmRzIGFuZCBzdGFydHMgb2YNCj4g
PiB1bmFsaWduZWQgc2VjdGlvbnMgdG8gaW5pdGlhbGl6ZSBhbmQgcmVzZXJ2ZSBwYWdlcy4NCj4g
Pg0KPiA+IFRoZSBzYW1lIHRoaW5nIHdvdWxkIGFsc28gbmVlZCB0byBiZSBkb25lIGluIGRlZmVy
cmVkX2luaXRfbWVtbWFwKCkgdG8NCj4gPiBjb3ZlciB0aGUgZGVmZXJyZWQgaW5pdCBjYXNlLg0K
Pg0KPiBXZWxsLCBJIGFtIG5vdCBzdXJlIFRCSC4gSSBoYXZlIHRvIHRoaW5rIGFib3V0IHRoYXQg
bXVjaCBtb3JlLiBNYXliZSBpdA0KPiB3b3VsZCBiZSBtdWNoIG1vcmUgc2ltcGxlIHRvIG1ha2Ug
c3VyZSB0aGF0IHdlIHdpbGwgbmV2ZXIgYWRkIGluY29tcGxldGUNCj4gbWVtYmxvY2tzIGFuZCBz
aW1wbHkgcmVmdXNlIHRoZW0gZHVyaW5nIHRoZSBkaXNjb3ZlcnkuIEF0IGxlYXN0IGZvciBub3cu
DQoNCk9uIHg4NiBtZW1ibG9ja3MgY2FuIGJlIHVwdG8gMkcgb24gbWFjaGluZXMgd2l0aCBvdmVy
IDY0RyBvZiBSQU0uDQpBbHNvLCBtZW1vcnkgc2l6ZSBpcyB3YXkgdG8gZWFzeSB0b28gY2hhbmdl
IHZpYSBxZW11IGFyZ3VtZW50cyB3aGVuIFZNDQpzdGFydHMuIElmIHdlIHNpbXBseSBkaXNhYmxl
IHVuYWxpZ25lZCB0cmFpbGluZyBtZW1ibG9ja3MsIEkgYW0gc3VyZQ0Kd2Ugd291bGQgZ2V0IHRv
bnMgb2Ygbm9pc2Ugb2YgbWlzc2luZyBtZW1vcnkuDQoNCkkgdGhpbmssIGFkZGluZyBjaGVja19o
b3RwbHVnX21lbW9yeV9yYW5nZSgpIHdvdWxkIHdvcmsgdG8gZml4IHRoZQ0KaW1tZWRpYXRlIHBy
b2JsZW0uIEJ1dCwgd2UgZG8gbmVlZCB0byBmaWd1cmUgb3V0ICBhIGJldHRlciBzb2x1dGlvbi4N
Cg0KbWVtYmxvY2sgZGVzaWduIGlzIGJhc2VkIG9uIGFyY2hhaWMgYXNzdW1wdGlvbiB0aGF0IGhv
dHBsdWcgdW5pdHMgYXJlDQpwaHlzaWNhbCBkaW1tcy4gVk1zIGFuZCBoeXBlcnZpc29ycyBjaGFu
Z2VkIGFsbCBvZiB0aGF0LCBhbmQgd2UgY2FuDQpoYXZlIG11Y2ggZmluZXIgaG90cGx1ZyByZXF1
ZXN0cyBvbiBtYWNoaW5lcyB3aXRoIGh1Z2UgRElNTXMuIFlldCwgd2UNCmRvIG5vdCB3YW50IHRv
IHBvbGx1dGUgc3lzZnMgd2l0aCBtaWxsaW9ucyBvZiB0aW55IG1lbW9yeSBkZXZpY2VzLiBJDQph
bSBub3Qgc3VyZSB3aGF0IGEgbG9uZyB0ZXJtIHByb3BlciBzb2x1dGlvbiBmb3IgdGhpcyBwcm9i
bGVtIHNob3VsZA0KYmUsIGJ1dCBJIHNlZSB0aGF0IGxpbnV4IGhvdHBsdWcvaG90cmVtb3ZlIHN1
YnN5c3RlbXMgbXVzdCBiZQ0KcmVkZXNpZ25lZCBiYXNlZCBvbiB0aGUgbmV3IHJlcXVpcmVtZW50
cy4NCg0KUGF2ZWw=
