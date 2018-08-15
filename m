Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6856B21546
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fcb9XTMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6856B21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeHOQ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:57:59 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:30752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729239AbeHOQ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fHPxNIK6KEytgv06qAWC/dbHp1o3cOqRPStA/D5t0Q=;
 b=Fcb9XTMA2atrWI/jCZQ3sGOFqU/4ShKEIXsV7+JgNaWuL7f6P6M4hWhoNCWStghxU2VBBRq+l9k/A5mjKslI3G3brxIFKTUeD9a16MRN3ViGDeseba8ZSr+ryCNJA3n4i2L8fYELS+A+/Aw4ul7rRqObRf5O65g2oNidcd8q9pE=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.5; Wed, 15 Aug 2018 14:05:35 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.007; Wed, 15 Aug 2018
 14:05:35 +0000
From:   Pavel Tatashin <Pavel.Tatashin@microsoft.com>
To:     "osalvador@techadventures.net" <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: RE: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Thread-Topic: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Thread-Index: AQNQGbiWgUZuKSLz17fvDcH9ixlb+aHJDhgw
Date:   Wed, 15 Aug 2018 14:05:35 +0000
Message-ID: <DM5PR21MB0508CEC7F586EBC89D2CCFBB9D3F0@DM5PR21MB0508.namprd21.prod.outlook.com>
References: <20180807133757.18352-1-osalvador@techadventures.net>
In-Reply-To: <20180807133757.18352-1-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [209.119.211.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0137;6:5jRjcsmrBNvzRAsgLKgrCcARz6vXAsZ4OweBYLrmAH0MJmN6itwAfXySGnxu6KwzX3SnrkSs2s+hQr8SCYYIokz4QSkK5l4rWpFrHrDr5ekn64WSWAZcscUJgxQnfCWurQxCxskOGO+3xI5pphBPXNuA13+/bZIOX5N58dfGVpjilTC8plLazDd6zd+fm7zQlbn4OL15y5B5y9wUv2Hl5hHV0HKBWaUgprUekpyWNwam+cKdX2LYUlB4dl8FFFwA+uGmAh0pvllHaPPg8q74HEQELh5WnnBQyy6dKN53Q99Hf9YjEhZ2he+AOpLeuIQDK4Kh5sq2n7JGKXcJXuW/F6DkhA4wDaKIZdAgjDBCRxgf2fPoRiPVPdwTPx48iayE4lfPvze3akUb+nXBHcPqUuy/mZyLoXyMl9PWidGxS9vS4oplzci3bsCAgqSJVXcBHB7F8StJ//FqEgs2a5obdw==;5:g4l+oW5WozoqC5Odh8+ao7FhCGBqCNVtkvWoNIi68pvR1Y7CIyhvSVXUUqqGvBQ+whR4Zrt/T8hBrcH3sJWmMZrV2xbEIG3wF4BSRBLfGN1WV1flG5mJ8hYYvmzmQvRMBr9WoaoZSDVgtmIHXBKpISXjzQuNDeyRdgMHK0otz4U=;7:9OCcleWXbtnIHVG6smexkHdyyNGyULQJyq4fazZzBg5ONXYuqpZJiQYZrWw+SRaC1Rd/VBZrSbo12QI3aki5RYpaBNBARwcGCqMkkKu/k23b547SLnSGzYPY6iArLFobUhVq9mUbAbrVGbGxK7UgVNO0TRl9ilyOjplRc6X/kQMckFp9BJ7H3UB52KddyymgqfnIzf6EoALByhEpytbXd0tkFXWdagdXGQUC23Dix05SmUKEWYvChcNRFVQ2l6VV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aef8bfce-9f4b-4746-2610-08d602b82c2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0137;
x-ms-traffictypediagnostic: DM5PR21MB0137:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB013796F10BA7BF24E9DE91BD9D3F0@DM5PR21MB0137.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231328)(8210008)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0137;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0137;
x-forefront-prvs: 07658B8EA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(2906002)(229853002)(5660300001)(478600001)(966005)(97736004)(72206003)(8936002)(316002)(22452003)(53936002)(9686003)(54906003)(7416002)(110136005)(10090500001)(6246003)(105586002)(14454004)(66066001)(106356001)(55016002)(6436002)(6306002)(33656002)(2501003)(5250100002)(8990500004)(3846002)(217873002)(6116002)(81166006)(186003)(81156014)(256004)(14444005)(8676002)(2900100001)(26005)(305945005)(68736007)(476003)(74316002)(10290500003)(39060400002)(4326008)(7736002)(25786009)(6506007)(76176011)(446003)(99286004)(11346002)(86362001)(86612001)(7696005)(102836004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0137;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ca3s7ARm4d3mGh0xiWHMpzDPK0xlIUlFWGOSF+sFvTPIuG78ordzmBm04b+xNnPpBiuWUIpBdUVDMiGUjW8NYfq8UVCrDN4BeRG4oc+vE+2tdlTr6Ux/LIbohxUj+foxcSyt6YdPfnOJ6GraNJI74srlUCCK/wjCYW7lxSGdRg2tKDFYiKi7coeFa7biJqHs28i2y/p3DG9dx8iVudPPOUYAYcpyvTFAsYRnjZ+c59nYIaY6Px9owXRYkEgmZvSUwFUl0Yom25SGS5ATl0aXQQZxzUuP8OSSiJehlZ0MeEQEDYmNN+6zj4ojnWQNRgweEq62JsEt+vULKZYsQh69OtyjlweuJDGkG88eyFDYYCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef8bfce-9f4b-4746-2610-08d602b82c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2018 14:05:35.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This tries to fix [1], which was reported by David Hildenbrand, and also
> does some cleanups/refactoring.

Hi Oscar,

I would like to review this work. Are you in process of sending a new versi=
on? If so, I will wait for it.

Thank you,
Pavel

>=20
> I am sending this as RFC to see if the direction I am going is right befo=
re
> spending more time into it.
> And also to gather feedback about hmm/zone_device stuff.
> The code compiles and I tested it successfully with normal memory-hotplug
> operations.
>=20
> Here we go:
>=20
> With the following scenario:
>=20
> 1) We add memory
> 2) We do not online it
> 3) We remove the memory
>=20
> an invalid access is being made to those pages.
>=20
> The reason is that the pages are initialized in online_pages() path:
>=20
>         /   online_pages
>         |    move_pfn_range
> ONLINE  |     move_pfn_range_to_zone
> PAGES   |      ...
>         |      memmap_init_zone
>=20
> But depending on our policy about onlining the pages by default, we might=
 not
> online them right after having added the memory, and so, those pages migh=
t
> be
> left unitialized.
>=20
> This is a problem because we access those pages in arch_remove_memory:
>=20
> ...
> if (altmap)
>         page +=3D vmem_altmap_offset(altmap);
>         zone =3D page_zone(page);
> ...
>=20
> So we are accessing unitialized data basically.
>=20
>=20
> Currently, we need to have the zone from arch_remove_memory to all the
> way down
> because
>=20
> 1) we call __remove_zone zo shrink spanned pages from pgdat/zone
> 2) we get the pgdat from the zone
>=20
> Number 1 can be fixed by moving __remove_zone back to offline_pages(),
> where it should be.
> This, besides fixing the bug, will make the code more consistent because =
all
> the reveserse
> operations from online_pages() will be made in offline_pages().
>=20
> Number 2 can be fixed by passing nid instead of zone.
>=20
> The tricky part of all this is the hmm code and the zone_device stuff.
>=20
> Fixing the calls to arch_remove_memory in the arch code is easy, but
> arch_remove_memory
> is being used in:
>=20
> kernel/memremap.c: devm_memremap_pages_release()
> mm/hmm.c:          hmm_devmem_release()
>=20
> I did my best to get my head around this, but my knowledge in that area i=
s 0,
> so I am pretty sure
> I did not get it right.
>=20
> The thing is:
>=20
> devm_memremap_pages(), which is the counterpart of
> devm_memremap_pages_release(),
> calls arch_add_memory(), and then calls move_pfn_range_to_zone() (to
> ZONE_DEVICE).
> So it does not go through online_pages().
> So there I call shrink_pages() (it does pretty much as __remove_zone) bef=
ore
> calling
> to arch_remove_memory.
> But as I said, I do now if that is right.
>=20
> [1] https://patchwork.kernel.org/patch/10547445/
>=20
> Oscar Salvador (3):
>   mm/memory_hotplug: Add nid parameter to arch_remove_memory
>   mm/memory_hotplug: Create __shrink_pages and move it to offline_pages
>   mm/memory_hotplug: Refactor shrink_zone/pgdat_span
>=20
>  arch/ia64/mm/init.c            |   6 +-
>  arch/powerpc/mm/mem.c          |  13 +--
>  arch/s390/mm/init.c            |   2 +-
>  arch/sh/mm/init.c              |   6 +-
>  arch/x86/mm/init_32.c          |   6 +-
>  arch/x86/mm/init_64.c          |  10 +--
>  include/linux/memory_hotplug.h |   8 +-
>  kernel/memremap.c              |   9 +-
>  mm/hmm.c                       |   6 +-
>  mm/memory_hotplug.c            | 190 +++++++++++++++++++++--------------=
------
>  mm/sparse.c                    |   4 +-
>  11 files changed, 127 insertions(+), 133 deletions(-)
>=20
> --
> 2.13.6

