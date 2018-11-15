Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1422145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GBRZylie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1422145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeKOLsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:48:23 -0500
Received: from mail-eopbgr800077.outbound.protection.outlook.com ([40.107.80.77]:4352
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3/hID9+mCQePqwGDyx1La86b5F6mDM2gCTFv2rbSAg=;
 b=GBRZylie0rBHz6D9j3aqSuZsFP8CFtXgGkojD3gN38D7bB3twtZbOMvW0xn5zii40/fGq47NF5cb4XXJENDOuEPdjSn2sMfMN2g6bWz9jx5gWnWtIqfR7rB7Npio0l1cr6XEx2kkrevxWZudRtHAOc+7k4pqZcfCxCSArFwKKi8=
Received: from BYAPR05MB5143.namprd05.prod.outlook.com (20.177.231.25) by
 BYAPR05MB5382.namprd05.prod.outlook.com (20.177.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Thu, 15 Nov 2018 01:42:30 +0000
Received: from BYAPR05MB5143.namprd05.prod.outlook.com
 ([fe80::55cc:e4e8:ed5f:27b2]) by BYAPR05MB5143.namprd05.prod.outlook.com
 ([fe80::55cc:e4e8:ed5f:27b2%5]) with mapi id 15.20.1339.021; Thu, 15 Nov 2018
 01:42:30 +0000
From:   Julien Freche <jfreche@vmware.com>
To:     Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian Hansen <chansen3@cisco.com>,
        Dave Young <dyoung@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>,
        Kairui Song <kasong@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Omar Sandoval <osandov@fb.com>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Topic: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Index: AQHUfG14AtUUXm8lq0WDadIpB+L9naVP5EIAgAAJ9AD//5vDAA==
Date:   Thu, 15 Nov 2018 01:42:30 +0000
Message-ID: <B6456717-0A6F-4957-A7F2-11599701226A@vmware.com>
References: <20181114211704.6381-1-david@redhat.com>
 <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
 <63c5f4b6-828a-764e-f64d-e603dc4b104e@redhat.com>
 <63214D36-14FD-4080-8E35-CF2A392D6507@vmware.com>
In-Reply-To: <63214D36-14FD-4080-8E35-CF2A392D6507@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.13.0.181109
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5382;20:LnkdiDmlaylnZy/yYqTAmTlZb/iV7uD7tcN6klkpX9f5TLFHfNMZ+tc7VBK10e3ciHGwMsIBdNfGjTemokhKSqxeSWhRdeATNNHeJKo058oM2SuUlTBwc429bChpf65XxBuDQTuS3G469XVbb6Ha3SiIBlVM2H0n9slYnjqwVKY=
x-ms-office365-filtering-correlation-id: 4ee1f84e-eabf-4afc-d8d9-08d64a9b9b6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5382;
x-ms-traffictypediagnostic: BYAPR05MB5382:
x-microsoft-antispam-prvs: <BYAPR05MB538251FEB215061C40EABCEBDADC0@BYAPR05MB5382.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5382;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5382;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(33656002)(39060400002)(316002)(58126008)(186003)(36756003)(54906003)(110136005)(82746002)(229853002)(6116002)(93886005)(3846002)(478600001)(97736004)(106356001)(217873002)(105586002)(66066001)(2900100001)(256004)(71200400001)(83716004)(71190400001)(53936002)(6436002)(6512007)(14454004)(6246003)(2616005)(476003)(446003)(486006)(11346002)(81156014)(8676002)(6486002)(8936002)(25786009)(86362001)(68736007)(26005)(5660300001)(7736002)(305945005)(99286004)(4326008)(2906002)(81166006)(7406005)(6506007)(102836004)(76176011)(6346003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5382;H:BYAPR05MB5143.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jfreche@vmware.com; 
x-microsoft-antispam-message-info: DJEhXk8muJFAKBx7fZAgdTNB+0fn3oBYc96awvg96aOMGsp0zgl8ITwDuNmEnq9LymIo5jriZDfWXIUUz3GJRCousX1vYRBhXVfGh1Qk7P2e7paBVQtEjN8SIbkkGoO5oaB+gFwz0uyD14nHqKkjg/JDVdLyITbVi9uQAUXRDl8o3skBuNzl6vaHQtTM8498UBv/AF1IYvYUIYHyWOaNJrSbNffhpBCfQf1b+3U7Ui7F9i+lvp+k+wlYTQh+ylStvRZ/AQ0nwwzv5QUxUa9mUd4iqrXYBxkStjcVaSP1hjH/btnr8a7wOuijrq+UQVnmlQ62avmwnHj3exb4JhAu3YWmmQcXrIyNr52PED0rLx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20FFFB53594D84E87A1E97CF4FFF55A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee1f84e-eabf-4afc-d8d9-08d64a9b9b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 01:42:30.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDExLzE0LzE4LCAzOjQxIFBNLCAiTmFkYXYgQW1pdCIgPG5hbWl0QHZtd2FyZS5jb20+IHdy
b3RlOg0KPj5Gcm9tOiBEYXZpZCBIaWxkZW5icmFuZA0KPj5TZW50OiBOb3ZlbWJlciAxNCwgMjAx
OCBhdCAxMTowNTozOCBQTSBHTVQNCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDAvNl0gbW0v
a2R1bXA6IGFsbG93IHRvIGV4Y2x1ZGUgcGFnZXMgdGhhdCBhcmUgbG9naWNhbGx5IG9mZmxpbmUN
Cj4+IA0KPj4gDQo+PiBDYW4geW91IHNoYXJlIGlmIHNvbWV0aGluZyBsaWtlIHRoaXMgaXMgYWxz
byBkZXNpcmVkIGZvciB2bXdhcmUncw0KPj4gaW1wbGVtZW50YXRpb24/IChJIHRhZ2dlZCB0aGlz
IGFzIFJGQyB0byBnZXQgc29tZSBtb3JlIGZlZWRiYWNrKQ0KPj4gDQo+PiBJdCBzaG91bGQgaW4g
dGhlb3J5IGJlIGFzIHNpbXBsZSBhcyBhZGRpbmcgYSBoYW5kZnVsIG9mDQo+PiBfU2V0UGFnZU9m
ZmxpbmUoKS9fQ2xlYXJQYWdlT2ZmbGluZSgpIGF0IHRoZSByaWdodCBzcG90cy4NCj4gICAgDQo+
IFRoYW5rcywgSSB3YXMganVzdCBzdXNwZWN0aW5nIGl0IGlzIHBlcnNvbmFsIDstKQ0KPg0KPiBJ
IHdvdWxkIG9idmlvdXNseSBwcmVmZXIgdGhhdCB5b3VyIGNoYW5nZXMgd291bGQgYmUgZG9uZSBv
biB0b3Agb2YgdGhvc2UNCj4gdGhhdCB3ZXJlIHNraXBwZWQuIFRoaXMgcGF0Y2gtc2V0IHNvdW5k
cyB2ZXJ5IHJlYXNvbmFibGUgdG8gbWUsIGJ1dCBJIHByZWZlcg0KPiB0aGF0IEp1bGllbiAoY2Pi
gJlkKSB3b3VsZCBhbHNvIGdpdmUgaGlzIG9waW5pb24uDQogICAgDQpJIHRoaW5rIHRoaXMgaXMg
ZGVzaXJhYmxlIGZvciBWTXdhcmUncyBpbXBsZW1lbnRhdGlvbiBhbHNvLiBZb3UgYXJlIHJpZ2h0
LA0KZHVtcGluZyBkYXRhIHRoYXQgaXMgbm90IHJlbGV2YW50IGlzIGEgd2FzdGUgOi0pIA0KSSBo
YXZlbid0IGhlYXJkIG9mIGFueSBwYW5pYy9pc3N1ZSBkdWUgdG8gdGhpcyBidXQgdGhhdCdzIHN0
aWxsIGEgZ29vZCBvcHRpbWl6YXRpb24uDQoNCk5hZGF2IG9yIEkgY291bGQgaGVscCB0byB0ZXN0
IHRoYXQgb24gRVNYIGlmIHJlcXVpcmVkLg0KDQpSZWdhcmRzLA0KDQotLSANCkp1bGllbiBGcmVj
aGUNCg0K
