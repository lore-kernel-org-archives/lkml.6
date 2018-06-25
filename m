Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459EB25658
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459EB25658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbeFYJEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55117 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754245AbeFYJEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:04:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7453AD26;
        Mon, 25 Jun 2018 09:04:35 +0000 (UTC)
Date:   Mon, 25 Jun 2018 11:04:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional processes
Message-ID: <20180625090434.GE28965@dhcp22.suse.cz>
References: <20180615065541.GA24039@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz>
 <20180620130311.GM13685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
 <20180621074537.GC10465@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806211347050.213939@chino.kir.corp.google.com>
 <20180622074257.GQ10465@dhcp22.suse.cz>
 <20180622142917.GB10465@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806221147090.110785@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806221147090.110785@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 11:49:14, David Rientjes wrote:
> On Fri, 22 Jun 2018, Michal Hocko wrote:
> 
> > > > preempt_disable() is required because it calls kvm_kick_many_cpus() with 
> > > > wait == true because KVM_REQ_APIC_PAGE_RELOAD sets KVM_REQUEST_WAIT and 
> > > > thus the smp_call_function_many() is going to block until all cpus can run 
> > > > ack_flush().
> > > 
> > > I will make sure to talk to the maintainer of the respective code to
> > > do the nonblock case correctly.
> > 
> > I've just double checked this particular code and the wait path and this
> > one is not a sleep. It is a busy wait for IPI to get handled. So this
> > one should be OK AFAICS. Anyway I will send an RFC and involve
> > respective maintainers to make sure I am not making any incorrect
> > assumptions.
> 
> Do you believe that having the only potential source of memory freeing 
> busy waiting for all other cpus on the system to run ack_flush() is 
> particularly dangerous given the fact that they may be allocating 
> themselves?

These are IPIs. How could they depend on a memory allocation? In other
words we do rely on the very same mechanism for TLB flushing so this is
any different.

Maybe I am missing something here though.

-- 
Michal Hocko
SUSE Labs
