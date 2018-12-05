Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10408C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3F52081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TSGRBXHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3F52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLEBWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:22:48 -0500
Received: from mail-eopbgr780082.outbound.protection.outlook.com ([40.107.78.82]:51664
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbeLEBWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f65b24dOO8ok1ix4CBPs5MaBj7pOFAOe/e82DyXfgAI=;
 b=TSGRBXHtNHP+EQ+bEzCtf42H6TFJWthOvOqdm506ZC/Sy8qXHdXUqkjJ3t+L5hd8u1aymHPtJEjProWp5CRJKRnB1f0ySUuCJPjVC1bU+fWDd8Q/IWAG2RaWKG9CJJbuqf2Gi/78TRPfL2pwLMYT7MswNjTt2mk8F9syupbubXk=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1929.namprd12.prod.outlook.com (10.175.88.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 01:22:42 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::6c3e:bc59:80d9:d17d]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::6c3e:bc59:80d9:d17d%3]) with mapi id 15.20.1404.016; Wed, 5 Dec 2018
 01:22:42 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Thread-Topic: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Thread-Index: AQHUi2DnusJaj+a2O0ee+RokxMsyrKVu4GeAgAAM94CAAC8cAIAABWMAgAA5ZQA=
Date:   Wed, 5 Dec 2018 01:22:41 +0000
Message-ID: <6960db38-3e40-d58c-c9a0-7e2fe259cac5@amd.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
 <20163c1e-00f1-7e02-82c0-7730ceabb9f2@intel.com>
 <20181204215711.GP2937@redhat.com>
In-Reply-To: <20181204215711.GP2937@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1929;20:SSiv//Slno0rBcr2H7mngGjitcNRB0hwHawxBLOCuG/Z+kZRHARl91tTMOQBh2+LhBcWLXDFrkNANCBS2yjjSHaZuYqAk4Q8598DevlgiyGM1OnN5eiz6snifPa8qh3L1vCt82C96TtsfHdufOJL1eOtGmpfQEJYAZPDUZ+Fa87CJqVQbDqmij5GJLyrlMhO4NI9OW7uDZJvjCfYzDnhBuWas4qPbR+DjVgUOUeIibU3Pf9rwQ/Hf4CclidGFElZ
x-ms-office365-filtering-correlation-id: a778d0d1-5680-4b13-4d42-08d65a5026b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1929;
x-ms-traffictypediagnostic: DM5PR12MB1929:
x-microsoft-antispam-prvs: <DM5PR12MB192911E924CB6C5877BA492892A80@DM5PR12MB1929.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501516)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1929;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1929;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(52116002)(31686004)(486006)(229853002)(93886005)(66574009)(6246003)(99286004)(81166006)(106356001)(8936002)(8676002)(7416002)(39060400002)(72206003)(4326008)(71190400001)(6512007)(71200400001)(81156014)(186003)(14444005)(256004)(64126003)(105586002)(217873002)(476003)(14454004)(53936002)(65956001)(65806001)(68736007)(66066001)(316002)(25786009)(58126008)(31696002)(446003)(6506007)(26005)(6436002)(305945005)(11346002)(53546011)(36756003)(478600001)(110136005)(6116002)(54906003)(102836004)(386003)(2616005)(86362001)(2906002)(65826007)(6486002)(5660300001)(76176011)(7736002)(97736004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1929;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: blB0+HKLqNdCJVJhArCjjyJDHXwMeu8XWdeO1BG83/gQ6AkylB1EjWmzEgkA8lttfUY3KGWHZQJPiS/BmqfTREif+fm2N5Kgeen/lVbYbQTaDDqnKfNOXU/khB3BoZrS9vpdJZO/wzwpDosdybyHG+JkM/vaz0cwhR6eEuqxC/W5SpkghMorA27gmZLxDMpd0+GQ/pMtiMH6rds2ZzsnYIFGPplae/xZUCPfKOQgWu0hv9pIbj+I/KjcdOd40Opc9oBV/cWlywFVisOf05LkKFPBW1Z/Ksw6QJ5uDxjZ6EipPAMpwpKjaAXxmTJPsKlGc7nzmmALleNIhtH1hFRWujX64eTYBC5CVXS57ThSQXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C2C78E879335428B6712D4691BFAF2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a778d0d1-5680-4b13-4d42-08d65a5026b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 01:22:41.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDE4LTEyLTA0IDQ6NTcgcC5tLiwgSmVyb21lIEdsaXNzZSB3cm90ZToNCj4gT24gVHVl
LCBEZWMgMDQsIDIwMTggYXQgMDE6Mzc6NTZQTSAtMDgwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+
PiBZZWFoLCBvdXIgTlVNQSBtZWNoYW5pc21zIGFyZSBmb3IgbWFuYWdpbmcgbWVtb3J5IHRoYXQg
dGhlIGtlcm5lbCBpdHNlbGYNCj4+IG1hbmFnZXMgaW4gdGhlICJub3JtYWwiIGFsbG9jYXRvciBh
bmQgc3VwcG9ydHMgYSBmdWxsIGZlYXR1cmUgc2V0IG9uLg0KPj4gVGhhdCBoYXMgYSBidW5jaCBv
ZiBpbXBsaWNhdGlvbnMsIGxpa2UgdGhhdCB0aGUgbWVtb3J5IGlzIGNhY2hlIGNvaGVyZW50DQo+
PiBhbmQgYWNjZXNzaWJsZSBmcm9tIGV2ZXJ5d2hlcmUuDQo+Pg0KPj4gVGhlIEhNQVQgcGF0Y2hl
cyBvbmx5IGNvbXByZWhlbmQgdGhpcyAibm9ybWFsIiBtZW1vcnksIHdoaWNoIGlzIHdoeQ0KPj4g
d2UncmUgZXh0ZW5kaW5nIHRoZSBleGlzdGluZyAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUgaW5m
cmFzdHJ1Y3R1cmUuDQo+Pg0KPj4gVGhpcyBzZXJpZXMgaGFzIGEgbXVjaCBtb3JlIGFnZ3Jlc3Np
dmUgZ29hbCwgd2hpY2ggaXMgY29tcHJlaGVuZGluZyB0aGUNCj4+IGNvbm5lY3Rpb25zIG9mIGV2
ZXJ5IG1lbW9yeS10YXJnZXQgdG8gZXZlcnkgbWVtb3J5LWluaXRpYXRvciwgbm8gbWF0dGVyDQo+
PiB3aG8gaXMgbWFuYWdpbmcgdGhlIG1lbW9yeSwgd2hvIGNhbiBhY2Nlc3MgaXQsIG9yIHdoYXQg
aXQgY2FuIGJlIHVzZWQgZm9yLg0KPj4NCj4+IFRoZW9yZXRpY2FsbHksIEhNUyBjb3VsZCBiZSB1
c2VkIGZvciBldmVyeXRoaW5nIHRoYXQgd2UncmUgZG9pbmcgd2l0aA0KPj4gL3N5cy9kZXZpY2Vz
L3N5c3RlbS9ub2RlLCBhcyBsb25nIGFzIGl0J3MgdGllZCBiYWNrIGludG8gdGhlIGV4aXN0aW5n
DQo+PiBOVU1BIGluZnJhc3RydWN0dXJlIF9zb21laG93Xy4NCj4+DQo+PiBSaWdodD8NCj4gRnVs
bHkgY29ycmVjdCBtaW5kIGlmIGkgc3RlYWwgdGhhdCBwZXJmZWN0IHN1bW1hcnkgZGVzY3JpcHRp
b24gbmV4dCB0aW1lDQo+IGkgcG9zdCA/IEkgYW0gc28gYmFkIGF0IGV4cGxhaW5pbmcgdGhpbmcg
OikNCj4NCj4gSW50ZW50aW9uIGlzIHRvIGFsbG93IHByb2dyYW0gdG8gZG8gZXZlcnl0aGluZyB0
aGV5IGRvIHdpdGggbWJpbmQoKSB0b2RheQ0KPiBhbmQgdG9tb3Jyb3cgd2l0aCB0aGUgSE1BVCBw
YXRjaHNldCBhbmQgb24gdG9wIG9mIHRoYXQgdG8gYWxzbyBiZSBhYmxlIHRvDQo+IGRvIHdoYXQg
dGhleSBkbyB0b2RheSB0aHJvdWdoIEFQSSBsaWtlIE9wZW5DTCwgUk9DbSwgQ1VEQSAuLi4gU28g
aXQgaXMgb25lDQo+IGtlcm5lbCBBUEkgdG8gcnVsZSB0aGVtIGFsbCA7KQ0KDQpBcyBmb3IgUk9D
bSwgSSdtIGxvb2tpbmcgZm9yd2FyZCB0byB1c2luZyBoYmluZCBpbiBvdXIgb3duIEFQSXMuIEl0
IHdpbGwNCnNhdmUgdXMgc29tZSB0aW1lIGFuZCB0cm91YmxlIG5vdCBoYXZpbmcgdG8gaW1wbGVt
ZW50IGFsbCB0aGUgbG93LWxldmVsDQpwb2xpY3kgYW5kIHRyYWNraW5nIG9mIHZpcnR1YWwgYWRk
cmVzcyByYW5nZXMgaW4gb3VyIGRldmljZSBkcml2ZXIuDQpHb2luZyBmb3J3YXJkLCBoYXZpbmcg
YSBjb21tb24gQVBJIHRvIG1hbmFnZSB0aGUgdG9wb2xvZ3kgYW5kIG1lbW9yeQ0KYWZmaW5pdHkg
d291bGQgYWxzbyBlbmFibGUgc2FuZSB3YXlzIG9mIGhhdmluZyBhY2NlbGVyYXRvcnMgYW5kIG1l
bW9yeQ0KZGV2aWNlcyBmcm9tIGRpZmZlcmVudCB2ZW5kb3JzIGludGVyYWN0IHVuZGVyIGNvbnRy
b2wgb2YgYQ0KdG9wb2xvZ3ktYXdhcmUgYXBwbGljYXRpb24uDQoNCkRpc2NsYWltZXI6IEkgaGF2
ZW4ndCBoYWQgYSBjaGFuY2UgdG8gcmV2aWV3IHRoZSBwYXRjaGVzIGluIGRldGFpbCB5ZXQuDQpH
b3QgY2F1Z2h0IHVwIGluIHRoZSBkb2N1bWVudGF0aW9uIGFuZCBkaXNjdXNzaW9uIC4uLg0KDQpS
ZWdhcmRzLA0KwqAgRmVsaXgNCg0KDQo+DQo+IEFsc28gYXQgZmlyc3QgaSBpbnRlbmQgdG8gc3Bl
Y2lhbCBjYXNlIHZtYSBhbGxvYyBwYWdlIHdoZW4gdGhleSBhcmUgSE1TDQo+IHBvbGljeSwgbG9u
ZyB0ZXJtIGkgd291bGQgbGlrZSB0byBtZXJnZSBjb2RlIHBhdGggaW5zaWRlIHRoZSBrZXJuZWwu
IEJ1dA0KPiBpIGRvIG5vdCB3YW50IHRvIGRpc3J1cHQgZXhpc3RpbmcgY29kZSBwYXRoIHRvZGF5
LCBpIHJhdGhlciBncm93IHRvIHRoYXQNCj4gb3JnYW5pY2FseS4gU3RlcCBieSBzdGVwLiBUaGUg
bWJpbmQoKSB3b3VsZCBzdGlsbCB3b3JrIHVuLWFmZmVjdGVkIGluDQo+IHRoZSBlbmQganVzdCB0
aGUgcGx1bWJpbmcgd291bGQgYmUgc2xpZ2h0bHkgZGlmZmVyZW50Lg0KPg0KPiBDaGVlcnMsDQo+
IErDqXLDtG1lDQo=
