Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1CC2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1CC2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIQSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:34:55 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:59266 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbeIQSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:34:54 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 7D5E3B8A0F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:07:37 +0100 (IST)
Received: (qmail 2790 invoked from network); 17 Sep 2018 13:07:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[193.179.3.151])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 17 Sep 2018 13:07:35 -0000
Date:   Mon, 17 Sep 2018 14:06:29 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jakub Ra??ek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
Message-ID: <20180917130629.nugwsgcsuoda6qf6@techsingularity.net>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com>
 <20180907131923.GB24106@hirez.programming.kicks-ass.net>
 <20180907134420.GD3995@linux.vnet.ibm.com>
 <20180907135235.GE24106@hirez.programming.kicks-ass.net>
 <CAE4VaGBeTy-du_tThkr3w-r2KbYW8m+sRcpDPn9sYeENUy_x4g@mail.gmail.com>
 <CAE4VaGDoxOQEhPYtVzEkNdrnFQ=Lnjj2is71ZYUBn_csUreoNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGDoxOQEhPYtVzEkNdrnFQ=Lnjj2is71ZYUBn_csUreoNA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:50:20PM +0200, Jirka Hladky wrote:
> Hi Peter and Srikar,
> 
> > I have bounced the 5 patches to you, (one of the 6 has not been applied by
> > Peter) so I have skipped that.
> > They can also be fetched from
> > http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com
> 
> I'm sorry for the delay, we have finally the results for the above
> kernel. The performance results look good compared to 4.19 vanilla and
> are about the same as Mel's sched-numa-fast-crossnode-v1r12 patch set
> for 4.18:
> 
> Compared to kernel-4.19.0-0.rc1.1
> 
>   * Improvement upto 20% for SPECjbb2005, SPECjvm2008 benchmarks
>   * Improvement upto 50% for stream benchmark
>   * Improvement upto 100% for the NAS benchmark (sp_C subtest, 8
> threads on 4 NUMA system with 4x E5-4610 v2 @ 2.30GHz, 64 cores in
> total)
> 
> When I compare it against Mel's patchset
> (git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
> sched-numa-fast-crossnode-v1r12)
> 
>   * Mel's kernel is about 15% faster for stream benchmarks
>   * The other benchmarks show very similar results with both kernels
> 
> Mel's patchset eliminates NUMA migration rate limits, this is
> presumbly the reason for the good stream results.
> 
> Do you have any update when the current patchset could be merged into
> the upstream kernel?
> 

I'm travelling at the moment but when I get back, I'll see what's in the
tip tree with respect to Srikar's patches and then rebase the fast-migration
patches on top and reconfirm they still behave as expected. Assuming
they do, I'll resend them.
