Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C91C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1532075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fB5PUEIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1532075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeIGBGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:06:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeIGBGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K8gtEAHh5JTc+EdfKeS8DS2HcXM7g9F3c3rEJHgljZ0=; b=fB5PUEIk3lHLe9XXTcGLPMi0i
        6NCfiqSdQsj71ArEhMPMhcIPv1K/9FvaZS9q/o0QV4Ka97Nwvcs6U64hSQ/XGrV8Wua4wDkMdVp6+
        u9W4pAKWkeG3ZEkiWUxUsVBUnf5SLyx5BndFsZHFtWZhcTscMjVE0mWMK8Xvjfv9W01UpZYt5VR0o
        +PjnBYTs6PjnhbG5guOHakylKriX4DqYAJmu3kwfWMO4LojuvIVLRWa5GpzR4JW9re9T7MIOiYvjb
        /9bHRo48LtljDyNj98z96n9f/r1x2rcikH3h5AS1GDZk13HB6KSrYZ26DJq6bxrWg8REnhlpTXZiM
        AXOmmSyRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy0uO-0002tI-2D; Thu, 06 Sep 2018 20:29:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id 2949D6E0AA9; Thu,  6 Sep 2018 22:29:43 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:29:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180906202943.GE9358@worktop.programming.kicks-ass.net>
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
 <20180906141524.GF24106@hirez.programming.kicks-ass.net>
 <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
 <20180906194441.GA9358@worktop.programming.kicks-ass.net>
 <2465aa4d-fa84-cb0c-082a-15240472b349@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2465aa4d-fa84-cb0c-082a-15240472b349@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:05:05PM -0700, Reinette Chatre wrote:
> When I separate the above into the two functions it just becomes either:
>                    rdpmcl(l2_hit_pmcnum, l2_hits_after);
>                    rdpmcl(l2_miss_pmcnum, l2_miss_after);
> or:
>                    rdpmcl(l3_hit_pmcnum, l3_hits_after);
>                    rdpmcl(l3_miss_pmcnum, l3_miss_after);
> 

Right, which is the exact _same_ code, so you only need a single
function.
