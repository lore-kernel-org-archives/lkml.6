Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A67C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C002083A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CEfflABy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C002083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeH3Xke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:40:34 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:3136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuKD4waK+99Nj5BRXsPc+ZqjqDY5Anwej2qPBHDprzs=;
 b=CEfflAByYcuhYieivaTh70fRi6pQgVM0PZm8r8PImjs85LMJIUZ4/9YwOeKcmjc0dJAgpdR87VaW29xh7qcLH7YeWPqJXbdF4J4vyQ5rJu5ZsFPL7mKaXeeanNOm4JCR5VhYES5/TJRfKF4bdv1Vp6jvXh/cwn+gfY3OLfus7F4=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0506.namprd21.prod.outlook.com (10.172.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 19:36:43 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:36:43 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH RFCv2 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Thread-Topic: [PATCH RFCv2 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Thread-Index: AQHUQJjISidGVdzS1UKB5Gtk22Lj+A==
Date:   Thu, 30 Aug 2018 19:36:43 +0000
Message-ID: <b535ed4a-faa1-9281-e759-ef4b599298ae@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-3-david@redhat.com>
In-Reply-To: <20180821104418.12710-3-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0506;6:okjrt5LUR2HnHUbQrS8MEYIdS7Wb3u6r5hfIfLXlRVCrqNJUJ1/wsLPk1/F2/knFw9VyQksbI57qR4DfQCMwoD7xSV+VDWNakdCQ0xu33U8sorGkbairyPq1uA7/jml5MD2azCixlfKycf7ub3Dvxr5NLJkxaRtpUvtDW3uQ2p7n3s2dniVumIr9UYvxc0/ydQ+lCqwEL0SWn49iFZiRYtQ7g99oeqPQADttnecGwK9FfPlONhnXTXL7C3jwdwK+PGhZTGhUXBMXFxsLheSO2NAQ561b3b8Mv9UIvARaH1+pB5na6VdhILSCWebCdeFX3IxmT9rHGWOXQa/YZeM8bowYWrc8WyJHz1e7RkDPmCfkfLYcqO2X6weDFI0ldxXUwMphR/pUjA3aJi8OxDJatkneT7uXrgYaxg1Z4bsyeyFBFH1rbYHDbObumWvu8SmNop5c9CzUDutUwm/nbvs8HA==;5:CGucknbX8qJKmrhYMB88Cw06wgUxWA1KfUyexHhJ4/G2z851MnVR1TZRPKjruKaFwXuwc5+RB3/L2mDDVjj80Ed3Ldbi2bllwFfDrb87cc7/YtOPky0bYtbSX6gFnG8SNpCkZ2tOKc0JYcI1FBMI4p+8evq7IMerLwrU78Ombuc=;7:YW65MWwFrbPmVXwh/HDReqmj2P/Kz3xRQsIKsv8vOBA0BQCyOrBdeEHiQAYxCbsciOZDaRk/kXwN75lt1bMVhz4Y9meRLP1A9vxpfIESf4qL8t+V33tN3GiQgHBVCx33j+3yHa+UnLvWd2Mnhz/dwpBxP4oESO7kQ+WbHyK1N8cm5sjUo2iuMdljztZCEB6AXypFTFxdJBoT20VXWYe2Pooc8kx9QnJXODmFZO0BIwd/OALnRs0XzCV2o6/97uZG
x-ms-office365-filtering-correlation-id: 3f0baf6e-6227-43fc-061e-08d60eafeab9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0506;
x-ms-traffictypediagnostic: DM5PR21MB0506:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0506A53CB9CF4BCD52E2790D9D080@DM5PR21MB0506.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0506;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0506;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(316002)(6486002)(54906003)(53546011)(99286004)(102836004)(22452003)(110136005)(486006)(4326008)(2616005)(6436002)(476003)(229853002)(11346002)(14444005)(256004)(6512007)(53936002)(6506007)(36756003)(186003)(97736004)(2501003)(2900100001)(5250100002)(26005)(446003)(76176011)(6246003)(2906002)(6116002)(3846002)(72206003)(14454004)(7416002)(86612001)(31696002)(39060400002)(106356001)(10290500003)(86362001)(575784001)(5660300001)(31686004)(8936002)(8676002)(7736002)(305945005)(105586002)(10090500001)(81156014)(81166006)(68736007)(66066001)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0506;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cv9P00EWykeiQ1GFAh37H+kO/9/QqEj4T/Tt4s5cC3MeW/vKX3xm/L9SpfElXc+sZM6/n7hqaYcb/zU4ovwy7t3P6jZ3dhdTiwLuGb9eyT1IJjcWfBpfLyP8bkEoVX7VZmtgGhApQsednzQYEVuYEBI2BO4YfXEqb0P2qzwhYg7ix8SgZv4zL/LB1zZ4w6FVS2rfdhG61vHzwj6QeV3pawuJwm8X4y/HLn3D9Uu9mYYsunpVtc2QQ7AFvOzT9IjPqXj8kiaEIaHPBshFL6d1AKS4uQgu8gf9SGBv8ZqVj4WUbPkLJDLeRrnRgFdCDLpgZIX7HFZkmGcUyhKVBAQqWK4lPeyrTQu5MrBGRKVki9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7952786F61346438E390595BBDF6E0B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0baf6e-6227-43fc-061e-08d60eafeab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:36:43.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8xOCA2OjQ0IEFNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gYWRkX21lbW9y
eSgpIGN1cnJlbnRseSBkb2VzIG5vdCB0YWtlIHRoZSBkZXZpY2VfaG90cGx1Z19sb2NrLCBob3dl
dmVyDQo+IGlzIGFsZWFkeSBjYWxsZWQgdW5kZXIgdGhlIGxvY2sgZnJvbQ0KPiAJYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9wc2VyaWVzL2hvdHBsdWctbWVtb3J5LmMNCj4gCWRyaXZlcnMvYWNwaS9h
Y3BpX21lbWhvdHBsdWcuYw0KPiB0byBzeW5jaHJvbml6ZSBhZ2FpbnN0IENQVSBob3QtcmVtb3Zl
IGFuZCBzaW1pbGFyLg0KPiANCj4gSW4gZ2VuZXJhbCwgd2Ugc2hvdWxkIGhvbGQgdGhlIGRldmlj
ZV9ob3RwbHVnX2xvY2sgd2hlbiBhZGRpbmcgbWVtb3J5DQo+IHRvIHN5bmNocm9uaXplIGFnYWlu
c3Qgb25saW5lL29mZmxpbmUgcmVxdWVzdCAoZS5nLiBmcm9tIHVzZXIgc3BhY2UpIC0NCj4gd2hp
Y2ggYWxyZWFkeSByZXN1bHRlZCBpbiBsb2NrIGludmVyc2lvbnMgZHVlIHRvIGRldmljZV9sb2Nr
KCkgYW5kDQo+IG1lbV9ob3RwbHVnX2xvY2sgLSBzZWUgMzA0NjdlMGIzYmUgKCJtbSwgaG90cGx1
ZzogZml4IGNvbmN1cnJlbnQgbWVtb3J5DQo+IGhvdC1hZGQgZGVhZGxvY2siKS4gYWRkX21lbW9y
eSgpL2FkZF9tZW1vcnlfcmVzb3VyY2UoKSB3aWxsIGNyZWF0ZSBtZW1vcnkNCj4gYmxvY2sgZGV2
aWNlcywgc28gdGhpcyByZWFsbHkgZmVlbHMgbGlrZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uDQo+
IA0KPiBIb2xkaW5nIHRoZSBkZXZpY2VfaG90cGx1Z19sb2NrIG1ha2VzIHN1cmUgdGhhdCBhIG1l
bW9yeSBibG9jayBkZXZpY2UNCj4gY2FuIHJlYWxseSBvbmx5IGJlIGFjY2Vzc2VkIChlLmcuIHZp
YSAub25saW5lLy5zdGF0ZSkgZnJvbSB1c2VyIHNwYWNlLA0KPiBvbmNlIHRoZSBtZW1vcnkgaGFz
IGJlZW4gZnVsbHkgYWRkZWQgdG8gdGhlIHN5c3RlbS4NCj4gDQo+IFRoZSBsb2NrIGlzIG5vdCBo
ZWxkIHlldCBpbg0KPiAJZHJpdmVycy94ZW4vYmFsbG9vbi5jDQo+IAlhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bvd2VybnYvbWVtdHJhY2UuYw0KPiAJZHJpdmVycy9zMzkwL2NoYXIvc2NscF9jbWQu
Yw0KPiAJZHJpdmVycy9odi9odl9iYWxsb29uLmMNCj4gU28sIGxldCdzIGVpdGhlciB1c2UgdGhl
IGxvY2tlZCB2YXJpYW50cyBvciB0YWtlIHRoZSBsb2NrLg0KPiANCj4gRG9uJ3QgZXhwb3J0IGFk
ZF9tZW1vcnlfcmVzb3VyY2UoKSwgYXMgaXQgb25jZSB3YXMgZXhwb3J0ZWQgdG8gYmUgdXNlZA0K
PiBieSBYRU4sIHdoaWNoIGlzIG5ldmVyIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzb21lYm9keSBy
ZXF1aXJlcyBpdCwgd2UNCj4gYWxzbyBoYXZlIHRvIGV4cG9ydCBhIGxvY2tlZCB2YXJpYW50IChh
cyBkZXZpY2VfaG90cGx1Z19sb2NrIGlzIG5ldmVyDQo+IGV4cG9ydGVkKS4NCg0KUmV2aWV3ZWQt
Ynk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg==
