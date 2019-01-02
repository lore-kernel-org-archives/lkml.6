Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D782C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B25521019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfABJ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:28:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728873AbfABJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:28:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x029NU72087467
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 04:28:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2prt58saxc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 04:28:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 2 Jan 2019 09:28:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 09:28:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x029SKc458654784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 09:28:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFAAEAE058;
        Wed,  2 Jan 2019 09:28:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B910AE051;
        Wed,  2 Jan 2019 09:28:19 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.244])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Jan 2019 09:28:19 +0000 (GMT)
Date:   Wed, 2 Jan 2019 11:28:17 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/2] x86/kdump: bugfix, make the behavior of
 crashkernel=X consistent with kaslr
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-3-git-send-email-kernelfans@gmail.com>
 <20181231084608.GB28478@rapoport-lnx>
 <CAFgQCTs2A-_ZzLAz=wZng=2e3+VURd97wJxLv5UesVUTMaw0hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTs2A-_ZzLAz=wZng=2e3+VURd97wJxLv5UesVUTMaw0hg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19010209-0020-0000-0000-000002FF732C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010209-0021-0000-0000-0000214F7718
Message-Id: <20190102092817.GB22664@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 02:47:54PM +0800, Pingfan Liu wrote:
> On Mon, Dec 31, 2018 at 4:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Fri, Dec 28, 2018 at 11:00:02AM +0800, Pingfan Liu wrote:
> > > Customer reported a bug on a high end server with many pcie devices, where
> > > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > > though we still see much memory under 896 MB, the finding still failed
> > > intermittently. Because currently we can only find region under 896 MB,
> > > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> > > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > > why failure is found. It raises confusion to the end user that sometimes
> > > crashkernel=X works while sometimes fails.
> > > If want to make it succeed, customer can change kernel option to
> > > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> > > limited space to behave even though its grammer looks more generic.
> > > And we can't answer questions raised from customer that confidently:
> > > 1) why it doesn't succeed to reserve 896 MB;
> > > 2) what's wrong with memory region under 4G;
> > > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> > >
> > > This patch simplifies the method suggested in the mail [1]. It just goes
> > > bottom-up to find a candidate region for crashkernel. The bottom-up may be
> > > better compatible with the old reservation style, i.e. still want to get
> > > memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> > >
> > > There is one trivial thing about the compatibility with old kexec-tools:
> > > if the reserved region is above 896M, then old tool will fail to load
> > > bzImage. But without this patch, the old tool also fail since there is no
> > > memory below 896M can be reserved for crashkernel.
> > >
> > > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Tang Chen <tangchen@cn.fujitsu.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > Cc: Daniel Vacek <neelx@redhat.com>
> > > Cc: Mathieu Malaterre <malat@debian.org>
> > > Cc: Stefan Agner <stefan@agner.ch>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: yinghai@kernel.org,
> > > Cc: vgoyal@redhat.com
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  arch/x86/kernel/setup.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > index d494b9b..165f9c3 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> > >
> > >       /* 0 means: find the address automatically */
> > >       if (crash_base <= 0) {
> > > +             bool bottom_up = memblock_bottom_up();
> > > +
> > > +             memblock_set_bottom_up(true);
> > >
> > >               /*
> > >                * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> > >                * as old kexec-tools loads bzImage below that, unless
> > >                * "crashkernel=size[KMG],high" is specified.
> > >                */
> > >               crash_base = memblock_find_in_range(CRASH_ALIGN,
> > > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > > -                                                      : CRASH_ADDR_LOW_MAX,
> > > -                                                 crash_size, CRASH_ALIGN);
> > > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> > > +             memblock_set_bottom_up(bottom_up);
> >
> > Using bottom-up does not guarantee that the allocation won't fall into a
> > removable memory, it only makes it highly probable.
> >
> > I think that the 'max_pfn * PAGE_SIZE' limit should be replaced with the
> > end of the non-removable memory node.
> >
> Since passing MEMBLOCK_NONE, memblock_find_in_range() ->...->
> __next_mem_range(), there is a logic to guarantee hotmovable memory
> will not be stamped over.
> if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
> continue;

Thanks for the clarification, I've missed that.
 
> Thanks,
> Pingfan
> 
> > > +
> > >               if (!crash_base) {
> > >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> > >                       return;
> > > --
> > > 2.7.4
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.

