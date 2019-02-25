Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB21C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FB420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551110644;
	bh=hHZ383Pb+0ysEbmsR/9vzGlS0qI031AYvniJXYFLWwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0IKDvUEm15X2I72OUIySzxLOpt7rxEN9C39xPDH+y0Uqm0YGD3kP0sOKexSQo/fnw
	 7vQcMeK0asxOMi+FotqK6310hGFmxPPbv7CITRVDH5CVnBSNIk5Bu+jdkwBhprfdZx
	 3DJvw/W6rPYoyiEluCHt+qhP732Torxt+yjUd09k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfBYQEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:04:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbfBYQEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:04:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99F59AFCB;
        Mon, 25 Feb 2019 16:04:00 +0000 (UTC)
Date:   Mon, 25 Feb 2019 17:03:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] make memblock allocator utilize the node's fallback
 info
Message-ID: <20190225160358.GW10588@dhcp22.suse.cz>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24-02-19 20:34:03, Pingfan Liu wrote:
> There are NUMA machines with memory-less node. At present page allocator builds the
> full fallback info by build_zonelists(). But memblock allocator does not utilize
> this info. And for memory-less node, memblock allocator just falls back "node 0",
> without utilizing the nearest node. Unfortunately, the percpu section is allocated 
> by memblock, which is accessed frequently after bootup.
> 
> This series aims to improve the performance of per cpu section on memory-less node
> by feeding node's fallback info to memblock allocator on x86, like we do for page
> allocator. On other archs, it requires independent effort to setup node to cpumask
> map ahead.

Do you have any numbers to tell us how much does this improve the
situation?
-- 
Michal Hocko
SUSE Labs
