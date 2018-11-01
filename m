Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CA2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BF52081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jAcw4DsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BF52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeKASCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:02:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sIZdAemLUiHYB44Xta+IGVhqMgW1vg1JHGzNMj+p4Wc=; b=jAcw4DsIGmyr3TiyUErfY7apl
        f1iQpcwyJYboY7xULLTjUAnaVSZbx+NTkTXGgVbItWTweJ6Von9a7zjDFPcIwagOiZdMYNSXQqGr4
        OlCCDxX2fBjqv8t2kPLCFaDwFh8c8cY+66j0fXBnpSdEYHZxk4B6GbP3vVdy36yOA3fC847v4lzO/
        NDW3dHJxJYOdFiJ8LPSlCA5Jmw9SIyOtRi0RtvtOH0bobRj+11jVMmnnEteerkW8fk8cx/6pfndu4
        wBHIpaPDRQuh5//5+khjgVh6Y65hmrZZcVa0A+E2EhpSUtfAHqA9uCMAy7I3qSDZqi2WAyDoVkuVH
        468Gg1Uzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI8pV-0006CD-J4; Thu, 01 Nov 2018 08:59:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8182120296F15; Thu,  1 Nov 2018 09:59:51 +0100 (CET)
Date:   Thu, 1 Nov 2018 09:59:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     Waiman Long <longman@redhat.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181101085951.GD3159@hirez.programming.kicks-ass.net>
References: <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
 <20181023093328.GA15378@yi.y.sun>
 <20181031015417.GC15378@yi.y.sun>
 <20181031141030.GB13219@hirez.programming.kicks-ass.net>
 <fc0bf563-b1ae-4d4b-1341-11c44b759b8a@redhat.com>
 <20181031171538.GC13219@hirez.programming.kicks-ass.net>
 <20181101032020.GE15378@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101032020.GE15378@yi.y.sun>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:20:21AM +0800, Yi Sun wrote:
> On 18-10-31 18:15:39, Peter Zijlstra wrote:

> > So Yi, are you actually seeing a problem? If so, can you give details?
> 
> Where does the patch come from? I cannot find it through google.

What patch!? The one I posted:

  https://lkml.kernel.org/r/20181031141030.GB13219@hirez.programming.kicks-ass.net

I made that up real quick.

> Per Waiman's comment, it seems not suitable to call vcpu_is_preempted()
> in pv_wait_head_or_lock(). So, we cannot make HvSpinWaitInfo notification
> through vcpu_is_preempted() for such case. Based on that, I suggest to
> add one more callback function in pv_lock_ops.

We're not doing anything until you can show a problem. If it ain't
broken, don't fix it etc..

> BTW, which performance test do you suggest? I am trying to test it by
> AIM7.

Waiman?

