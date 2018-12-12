Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ED8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629A20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544608256;
	bh=t8QBY8bY5rYMhCuL0wTDPbGMgTa0gPBTaq+SURvFwT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YU+h/MRXT2ZeCATSWOIKcMfo44Ts6PjnUcUKC1fLbmMft3TeeV9IYUgdqe0gX6uJ2
	 qa+FhQQrseDFTFDXD6rC7jU656It5eggVEFUfcOKj5Hbi2gNxQOYwMi3AAErQzINQI
	 P2Q6uWfOh0TakOU1UdR6F9Ry0rpaG7Um+CENsfIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLLJuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:50:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:33638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbeLLJuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:50:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35863B002;
        Wed, 12 Dec 2018 09:50:53 +0000 (UTC)
Date:   Wed, 12 Dec 2018 10:50:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181212095051.GO1286@dhcp22.suse.cz>
References: <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
 <20181210044916.GC24097@redhat.com>
 <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 16:37:22, David Rientjes wrote:
[...]
> Since it depends on the workload, specifically workloads that fit within a 
> single node, I think the reasonable approach would be to have a sane 
> default regardless of the use of MADV_HUGEPAGE or thp defrag settings and 
> then optimzie for the minority of cases where the workload does not fit in 
> a single node.  I'm assuming there is no debate about these larger 
> workloads being in the minority, although we have single machines where 
> this encompasses the totality of their workloads.

Your assumption is wrong I believe. This is the fundamental disagreement
we are discussing here. You are essentially arguing for node_reclaim
(formerly zone_reclaim) behavior for THP pages. All that without any
actual data on wider variety of workloads. As the matter of _fact_ we
know that node_reclaim behavior is not a suitable default. We did
that mistake in the past and we had to revert that default _exactly_
because a wider variety of workloads suffered from over reclaim and
performance issues as a result of constant reclaim

You have also haven't explained why you do care so much about remote THP
while you do not care about remote base bages (the page allocator
falls back to those as soon as the kswapd doesn't keep pace with the
allocation rate; THP or high order pages in general is analoguous with
kcompactd doing a pro-active compaction). Like the base pages we do not
want larger pages to fallback to a remote node too easily. There is no
question about that I believe.

I can be convinced that larger pages really require a different behavior
than base pages but you should better show _real_ numbers on a wider
variety workloads to back your claims. I have only heard hand waving and
a very vague and quite doubtful numbers for a non-disclosed benchmark
without a clear indication on how it relates to real world workloads. So
color me unconvinced.
-- 
Michal Hocko
SUSE Labs
