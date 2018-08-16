Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE8DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8D820B80
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XtUZQM+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8D820B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeHPWDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:03:13 -0400
Received: from mail-by2nam03on0093.outbound.protection.outlook.com ([104.47.42.93]:42832
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbeHPWDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIPO0BAHf9CVsugwtAiz8dFA3FE1mP0K7kNbO2XwK8U=;
 b=XtUZQM+JKz+w5zrtNS+CSO5aTBi8BTLTUrElz3uvK4rpCxrPuQsjgugmK856XofIuCAFe4Ku1Q5mZci2E3gpT+UYwve79z+3Qf5EWD/+uLNfT8wTofkWFaz8uX7+djaxkDxMFKviDGyT9+Xhb8H3AUjLNEzt5TspLVC7cHNggDo=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0156.namprd21.prod.outlook.com (10.173.173.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Thu, 16 Aug 2018 19:02:42 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 19:02:42 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jia He <hejianet@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RESEND PATCH v10 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
Thread-Topic: [RESEND PATCH v10 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
Thread-Index: AQHUNZO1/cRNVxmBf0uQR82FDfwseg==
Date:   Thu, 16 Aug 2018 19:02:42 +0000
Message-ID: <20180816190241.o6ctjypmbd65jdpl@xakep.localdomain>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <20180815153456.974798c62dd5a5e4628db8f5@linux-foundation.org>
In-Reply-To: <20180815153456.974798c62dd5a5e4628db8f5@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0156;6:7hmXq73k4sET0d1yQmoojtnqmQqtbfePLgnP+U42dnscFXvQF04HdSxJYKMHHN7FtMXzIu4y+YsJEdQN91NkvxlJSJNVQbJ9brJHpjRut43Pbz2yQ9/UP+HXrn9iw/uJ7J1RYyZrkyQcnxV/ha7M6hHgLE2FHCf9TL1zLteDsS5mubxJ1m00FQc6QDpwrJy1whVwdscamgv3YVcxK1Xt+9XA7dpCDB/MyiTsC7P5dGokDG6QNpCNlACcpjfJ/TxYZ6EhaWUQ7fQbgeAUm4FzHCR60BERvaPW7+nlI6Cl0o4EK5jbtbszAM7vtwjI/RVm/r1H+Z+QUCL4zTHdXkvtdCq7BtCkCAPt7Z267VCjw1+gPis11xn90wJtkt6tjPl+PD3TzT/ab+WL4KOvtLfmC+6Qn00qH9xgLqcY/vJOWGzML26fBy1agkVm/nHdLt5vAE0Z1kkRacOnLMjjSIlYCQ==;5:niiPpoeVsEEvuwlxPTGZDIJlw1J98frzxRZmb/Lt3TgEn1J1MKTBDs4cKC/AURRYJJR8gXlgvsYt6tM25z6QKc9aKyzN4+izRImK0QsL7QvQPBTEDpk+WO1RCGlxSw9SSvGFX4qO+B71vC7P2up1vU3CiXRc3Ll0JeYEs7RmaCs=;7:p9uFS+vnwuyXU2cZf/13KqFEBjr8XErhAPeRxrwvt/Bz8ivxnuAc7b1jMy3bpTqwBAvvWJH3K9ETAgV0tQHGH1AuZEHKTV7VaLp/NF215yc+kk63iQMEJrek+9+H8y+7UnHBC2Jqni0NXja+wsV4Dz60hMEBjiZrZ1iTl89bbykNdYtDQdy0F61d1o4+EUWtth+JfGjbP7hUlfQfr7yO8RSYqToy66ZMfQWTGGaaetF+50oo1Hy45a5g/0kuk93G
x-ms-office365-filtering-correlation-id: c6fa661d-1cbd-4f18-07f3-08d603aad814
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0156;
x-ms-traffictypediagnostic: DM5PR21MB0156:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0156328163CF2D8C972AD5FD9D3E0@DM5PR21MB0156.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231336)(8214008)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR21MB0156;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0156;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(22452003)(6506007)(53546011)(8676002)(97736004)(76176011)(99286004)(33896004)(10090500001)(6512007)(68736007)(229853002)(9686003)(102836004)(26005)(7736002)(106356001)(105586002)(2900100001)(7416002)(5250100002)(305945005)(186003)(6486002)(7406005)(6436002)(8936002)(3846002)(6116002)(66066001)(54906003)(11346002)(316002)(10290500003)(72206003)(478600001)(476003)(486006)(14454004)(1076002)(39060400002)(6246003)(86612001)(4326008)(86362001)(5660300001)(53936002)(256004)(446003)(25786009)(81156014)(217873002)(6916009)(81166006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0156;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6u3hyOQP8ePEZ8Vkd5gFNnZ02Bf7yuekLSNztcdLRU+NPWAeIf9kU1IUu482hCXAKhwyFQCI4PXjlNEyibn3gBQJUvaNMeiTAupi9b3Pax5mZE+Ey9LieYWMFIFn1PSMzUYFKofBRpUaZa/+H50Bza80GI0DgktI6p4zXEI6pBCw/abR7wB1DXUIHtiH8MQcTR+4Sof3XhBnxi8cLfPxg5ozrpFhuCZUKAv2vpXxWPh4UuFC04dkxN+oc1iAk74/lQZyz0UYH4Mc/aHdj5mT8zzYt8hGwC8xgst7YwsB4z8PIGWuHQMmFw5stdY8DtV38aUUTKIeWZfz14eiBxNd8pzRoG5S37BEap2KFAdHXWRLxMV0yItc5e1T2AhiAaLaVqIYxlULdSu8+Yl9Eka1bBGmQXsG7zX43HvPcX7YJj/rc05Oz8/rJkKglgmCiSWtD2kINT6DNJU6ZDmZCVjmlnlPD2tWnt6E6y/gu1PWJus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE246A9D7221774B82A7884946F326DF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fa661d-1cbd-4f18-07f3-08d603aad814
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 19:02:42.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-15 15:34:56, Andrew Morton wrote:
> On Fri,  6 Jul 2018 17:01:09 +0800 Jia He <hejianet@gmail.com> wrote:
>=20
> > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> > where possible") optimized the loop in memmap_init_zone(). But it cause=
s
> > possible panic bug. So Daniel Vacek reverted it later.
> >=20
> > But as suggested by Daniel Vacek, it is fine to using memblock to skip
> > gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> >=20
> > More from what Daniel said:
> > "On arm and arm64, memblock is used by default. But generic version of
> > pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> > not always return the next valid one but skips more resulting in some
> > valid frames to be skipped (as if they were invalid). And that's why
> > kernel was eventually crashing on some !arm machines."
> >=20
> > About the performance consideration:
> > As said by James in b92df1de5,
> > "I have tested this patch on a virtual model of a Samurai CPU with a
> > sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> > Thus it would be better if we remain memblock_next_valid_pfn on arm/arm=
64.
> >=20
> > Besides we can remain memblock_next_valid_pfn, there is still some room
> > for improvement. After this set, I can see the time overhead of memmap_=
init
> > is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> > memory, pagesize 64k). I believe arm server will benefit more if memory=
 is
> > larger than TBs
>=20
> This patchset is basically unreviewed at this stage.  Could people
> please find some time to check it carefully?

Working on it.

Pavel=
