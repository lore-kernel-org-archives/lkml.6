Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52D4222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ogWR0BCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbfBOWUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:20:41 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15220 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBOWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:20:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c673b3b0000>; Fri, 15 Feb 2019 14:20:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 15 Feb 2019 14:20:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 15 Feb 2019 14:20:38 -0800
Received: from [10.2.160.210] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 22:20:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     <lsf-pc@lists.linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: [LSF/MM TOPIC] Generating physically contiguous memory
Date:   Fri, 15 Feb 2019 14:20:37 -0800
X-Mailer: MailMate (1.12.4r5594)
Message-ID: <CEDBC792-DE5A-42CB-AA31-40C039470BD0@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550269243; bh=PVlYGjyWaFVWJioBZgBkG+3PLaDi4XJfqvkkL2DVWxY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding;
        b=ogWR0BCuJXewZzQEbJpYlL6oQOPHs3TDFPbVoaDaQfS985aojrx16wa56IBizh27Q
         W650rtKEZTBrMGR3NmV59/2JI9QFULJ8lNlkvmq/GvvhmDe5oMNGjiEsk/Gs0B4xcB
         0tvVG0B1FBs/z0ynvpN1lT1F8jz2MPYNDa4qM+hFaGG0ZiQuCkq+aiJz8i3WerXaJM
         91rderrFOSmUTTdB9kXVGlKcGeqsseaHFRhyP49yPEzT4LNVH2Jm1v1KuAFrna9S/4
         7bepyHG4HtcPv0/PbMEYRmU3+He3k/+6BVAM/2SOB+KTg9g0NTwahvWZUi0Dz/gvVg
         C3Fr5BaFr5tgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Problem

----

Large pages and physically contiguous memory are important to devices, =

such as GPUs, FPGAs, NICs and RDMA controllers, because they can often =

reduce address translation overheads and hence achieve better =

performance when operating on large pages (2MB and beyond). The same can =

be said of CPU performance, of course, but there is an important =

difference: GPUs and high-throughput devices often take a more severe =

performance hit, in the event of a TLB miss, as compared to a CPU, =

because larger volume of in-flight work is stalled due to the TLB miss =

and the induced page table walks. The effect is sufficiently large that =

such devices *really* want highly reliable ways to allocate large pages =

to minimize TLB misses and reduce the duration of page table walks.



Due to the lack of flexibility, Approaches using memory reservation at =

boot time (such as hugetlbfs) are a compromise that would be nice to =

avoid. THPs, in general, seems to be a proper way to go because it is =

transparent to userspace and provides large pages, but it is not perfect =

yet. The community is still working on it since 1) THP size is limited =

by the page allocation system and 2) THP creation requires a lot of =

effort (e.g., memory compaction and page reclamation on the critical =

path of page allocations).




Possible solutions

----

1. I recently posted an RFC [1] about actively generating physically =

contiguous memory from in-use pages after page allocation. This RFC =

moves pages around and make them physically contiguous when possible. It =

is different from existing approaches, since it does not rely on page =

allocation. On the other hand, this approach is still affected by =

non-moveable pages scattered across the memory, which is highly related =

but orthogonal and one of whose possible solutions is proposed by Mel =

Gorman recently [2].




2. THPs could be a solution as it provide large pages. THP avoids memory =

reservation at boot time, but to meet the needs, i.e., a lot of large =

pages, of some of these high-throughput accelerators, we need to make it =

easier to produce large pages, namely increasing the successful rate of =

allocating THPs and decreasing the overheads of allocating them. Mel =

Gorman has posted a related patchset [3].


It is also possible to generate THPs in the background, either like what =

khugepaged does right now, or periodically perform memory compaction to =

lower whole memory fragmentation level, or having certain amount of THP =

pools for future use. But these solutions still face the same problem.




3. A more restricted but more reliable way might be using libhugetlbfs. =

It reserves memory, which is dedicated to large page allocations and =

hence requires less effort to obtain large pages. It also supports page =

sizes larger than 2MB, which further reduces address translation =

overheads. But AFAIK device drivers are not able to directly grab large =

pages from libhugetlbfs, which is something devices want.




4. Recently Matthew Wilcox mentioned his XArray is going to support =

arbitrary sized pages [4], which would help maintain physically =

contiguous ranges once created (aka my RFC). Once my RFC generates =

physically contiguous memory, XArrays would maintain the page size and =

prevent reclaim/compaction from breaking them. Getting arbitrary sized =

pages can still be beneficial to devices when larger than 2MB pages =

becomes very difficult to get.



Feel free to provide your comments.

Thanks.


[1] https://lore.kernel.org/lkml/20190215220856.29749-1-zi.yan@sent.com/

[2] =

https://lore.kernel.org/lkml/20181123114528.28802-1-mgorman@techsingulari=
ty.net/

[3] =

https://lore.kernel.org/lkml/20190118175136.31341-1-mgorman@techsingulari=
ty.net/

[4] =

https://lore.kernel.org/lkml/20190208042448.GB21860@bombadil.infradead.or=
g/



--
Best Regards,
Yan Zi
