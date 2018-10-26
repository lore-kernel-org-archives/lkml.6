Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86649C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A5C20831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DeqsV6gk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kVQgNHcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A5C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJ0Ac6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:32:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbeJ0Ac6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:32:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QFsp6l010391;
        Fri, 26 Oct 2018 08:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=V5Txsd/w18xvgLWJXaI+XHxk/U3gbrT4INnBgU0yKjI=;
 b=DeqsV6gkJC8hkxO/al8qDXyhJrOHSBEAxY9bV0t87zvukI+Dc0+A3ZOix3cZcab0qoDG
 NJQl5yGK7KH8awXcX1ydD6tPQNDEzn5fW2MO/GsT1BJhpPlSOsW1vKuAs8LH2i1eT+bv
 rAaPNOKaP4OipJy+/gjSD59qnayXwneSqYI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nc4t3r7tf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Oct 2018 08:54:53 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 26 Oct 2018 08:54:51 -0700
Received: from FRC-CHUB06.TheFacebook.com (2620:10d:c021:18::25) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 26 Oct 2018 08:54:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 26 Oct 2018 11:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Txsd/w18xvgLWJXaI+XHxk/U3gbrT4INnBgU0yKjI=;
 b=kVQgNHcY2qumsh3bkNZ9QFdc/0mLVYs5g/XSClY0CQCwfUVSjRkW/z+LwgbVuhqkHoEVvSBR6HyewyEoDkHvJuikgcTGn0yGIUH5x+1fxFj4l/STVNPR2OmV4DUXoB2EvITWVLWusDgnJuTjxX1rMS8bcIk+hBRymBtlZpm3OnA=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0342.namprd15.prod.outlook.com (10.163.109.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 15:54:46 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Fri, 26 Oct 2018
 15:54:46 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Topic: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6Uu+XwAgAC5iACAAK11AIAACe4A//+OJICAAS3XgIAAjCkA
Date:   Fri, 26 Oct 2018 15:54:46 +0000
Message-ID: <20181026155438.GA6019@tower.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
 <20181025202014.GA216405@sasha-vm>
 <20181025203240.GA2504@tower.DHCP.thefacebook.com>
 <20181026073303.GW18839@dhcp22.suse.cz>
In-Reply-To: <20181026073303.GW18839@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:301:4b::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:4473]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0342;20:GSCN2bOoRrda5BGeAFO8Ptj2I6z0vXe3JtsQZcR3jXlTNluJAAZzrqgF1GbnJxintcORJfhiQ7OeGluI3y5dJ7hRlRY0LIb9eKeAQLq6dM+nwMZ/ZIFfmObJ2SQ7nSioy1N8AhKR8/NJ9nuNB7nbELkLA4OryPY23cCvwXq+Iv0=
x-ms-office365-filtering-correlation-id: 29893533-3995-4801-43b1-08d63b5b5a1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0342;
x-ms-traffictypediagnostic: BY2PR15MB0342:
x-microsoft-antispam-prvs: <BY2PR15MB03426805AB69208FCF4BBAB3BEF00@BY2PR15MB0342.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0342;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0342;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(39860400002)(396003)(376002)(43544003)(199004)(189003)(76176011)(9686003)(386003)(2900100001)(54906003)(86362001)(6506007)(5250100002)(105586002)(106356001)(316002)(6512007)(11346002)(33896004)(25786009)(6436002)(446003)(102836004)(229853002)(6246003)(99286004)(486006)(97736004)(52116002)(476003)(53936002)(186003)(4326008)(46003)(7736002)(2906002)(14454004)(305945005)(5660300001)(478600001)(33656002)(8936002)(71190400001)(71200400001)(1076002)(6916009)(81166006)(93886005)(6116002)(6486002)(81156014)(5024004)(8676002)(68736007)(256004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0342;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dOEnhf3r8/XghtDNePfhTrmX7HVPA9IjYEDY919rFhjrbskfUJdfq2TN3jHsqVtTrwnASbkfgPBtE1JeLbQpXAKoPBNNLnU1qVxCmLbkpVKnd1zIhLuUYZBHXNd3Kux9DjGJRWrqvuEduv4daJCbw9iAfrdgmwO8jBRefM4QiUYghLzpEosy3+qoeM+OmoVSCA4kD7cQBixLKu2cXzoVJSLtbmFk3y74zqnBpGrPweUxjkKFStjJgCm6ShGRW8HtS1YckjfftHptTLxYfS4cXzu6dFnQ2nfPYjdC7AWsOchZDNNXdaidAllyNTtTk/MC7G8VmxRtQKZQufDgLjgz+RoynrjnsB+7CoYmZdJkwEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47B8F01C10FB374D95B1D9CA48FCE328@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29893533-3995-4801-43b1-08d63b5b5a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 15:54:46.4928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0342
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 09:33:03AM +0200, Michal Hocko wrote:
> On Thu 25-10-18 20:32:47, Roman Gushchin wrote:
> > On Thu, Oct 25, 2018 at 04:20:14PM -0400, Sasha Levin wrote:
> > > On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
> > > > On Thu, 25 Oct 2018 11:23:52 +0200 Michal Hocko <mhocko@kernel.org>=
 wrote:
> > > >=20
> > > > > On Wed 24-10-18 15:19:50, Andrew Morton wrote:
> > > > > > On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com>=
 wrote:
> > > > > >
> > > > > > > Spock reported that the commit 172b06c32b94 ("mm: slowly shri=
nk slabs
> > > > > > > with a relatively small number of objects") leads to a regres=
sion on
> > > > > > > his setup: periodically the majority of the pagecache is evic=
ted
> > > > > > > without an obvious reason, while before the change the amount=
 of free
> > > > > > > memory was balancing around the watermark.
> > > > > > >
> > > > > > > The reason behind is that the mentioned above change created =
some
> > > > > > > minimal background pressure on the inode cache. The problem i=
s that
> > > > > > > if an inode is considered to be reclaimed, all belonging page=
cache
> > > > > > > page are stripped, no matter how many of them are there. So, =
if a huge
> > > > > > > multi-gigabyte file is cached in the memory, and the goal is =
to
> > > > > > > reclaim only few slab objects (unused inodes), we still can e=
ventually
> > > > > > > evict all gigabytes of the pagecache at once.
> > > > > > >
> > > > > > > The workload described by Spock has few large non-mapped file=
s in the
> > > > > > > pagecache, so it's especially noticeable.
> > > > > > >
> > > > > > > To solve the problem let's postpone the reclaim of inodes, wh=
ich have
> > > > > > > more than 1 attached page. Let's wait until the pagecache pag=
es will
> > > > > > > be evicted naturally by scanning the corresponding LRU lists,=
 and only
> > > > > > > then reclaim the inode structure.
> > > > > >
> > > > > > Is this regression serious enough to warrant fixing 4.19.1?
> > > > >=20
> > > > > Let's not forget about stable tree(s) which backported 172b06c32b=
94. I
> > > > > would suggest reverting there.
> > > >=20
> > > > Yup.  Sasha, can you please take care of this?
> > >=20
> > > Sure, I'll revert it from current stable trees.
> > >=20
> > > Should 172b06c32b94 and this commit be backported once Roman confirms
> > > the issue is fixed? As far as I understand 172b06c32b94 addressed an
> > > issue FB were seeing in their fleet and needed to be fixed.
> >=20
> > The memcg leak was also independently reported by several companies,
> > so it's not only about our fleet.
>=20
> By memcg leak you mean a lot of dead memcgs with small amount of memory
> which are staying behind and the global memory pressure removes them
> only very slowly or almost not at all, right?

Right.

>=20
> I have avague recollection that systemd can trigger a pattern which
> makes this "leak" noticeable. Is that right? If yes what would be a
> minimal and safe fix for the stable tree? "mm: don't miss the last page
> because of round-off error" would sound like the candidate but I never
> got around to review it properly.

Yes, systemd can create and destroy a ton of cgroups under some circumstanc=
es,
but there is nothing systemd-specific here. It's quite typical to run servi=
ces
in new cgroups, so with time the number of dying cgroups tends to grow.

I've listed all necessary patches, it's the required set (except the last p=
atch,
but it has to be squashed). f2e821fc8c63 can be probably skipped, but I hav=
en't
tested without it, and it's the most straightforward patch from the set.

Daniel McGinnes has reported the same issue in the cgroups@ mailing list,
and he confirmed that this patchset solved the problem for him.

> > The memcg css leak is fixed by a series of commits (as in the mm tree):
> >   37e521912118 math64: prevent double calculation of DIV64_U64_ROUND_UP=
() arguments
> >   c6be4e82b1b3 mm: don't miss the last page because of round-off error
> >   f2e821fc8c63 mm: drain memcg stocks on css offlining
> >   03a971b56f18 mm: rework memcg kernel stack accounting
>=20
> btw. none of these sha are refering to anything in my git tree. They all
> seem to be in the next tree though.

Yeah, they all are in the mm tree, and hashes are from Johannes's git.

>=20
> >   172b06c32b94 mm: slowly shrink slabs with a relatively small number o=
f objects
> >=20
> > The last one by itself isn't enough, and it makes no sense to backport =
it
> > without all other patches. So, I'd either backport them all (including
> > 47036ad4032e ("mm: don't reclaim inodes with many attached pages"),
> > either just revert 172b06c32b94.
> >=20
> > Also 172b06c32b94 ("mm: slowly shrink slabs with a relatively small num=
ber of objects")
> > by itself is fine, but it reveals an independent issue in inode reclaim=
 code,
> > which 47036ad4032e ("mm: don't reclaim inodes with many attached pages"=
) aims to fix.
>=20
> To me it sounds it needs much more time to settle before it can be
> considered safe for the stable tree. Even if the patch itself is correct
> it seems too subtle and reveal a behavior which was not anticipated and
> that just proves it is far from straightforward.

Absolutely. I'm not pushing this to stable at all, that single patch
was an accident.

Thanks!
