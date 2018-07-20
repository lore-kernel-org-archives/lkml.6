Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F33F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wKbs4rll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F33F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeGTKg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:36:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54666 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeGTKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=npyWeYAvaDwlL6CBTqUqUL1bgVZHIQT8rxIdgq3D37U=; b=wKbs4rllj4iP8a5nPf2gecwSv
        lCbLHAOQdDbfdHHl2YzRzLBwZ1dZe/mHhe9KvxTSDQktsaHo4CPwmVggMBosaY4jUL9PUSsdVm0/j
        2SabX8VD9xJaEj++QI+OfboomP2aN4h6Jb5MBjyfhb3/hEzRklBnyA4UZ0P+YJD5m7m37SdDMKa3P
        eLtPevCAmkrTS94AjZZ5brsr5ZAjTkldYyJMl5FgSUsA8falbY9D8iDFLbXQe4JqqrqacndjWgQyZ
        ndgOjNe/t42XOBX2fImwRwpJOmGqqHyVsmQYgd2kESxSMdiiBUDjBvz8/xhPLM9LShi4om7vq3ni+
        zg9vVPuKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgS2A-0001aG-7V; Fri, 20 Jul 2018 09:49:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AD9E20277352; Fri, 20 Jul 2018 11:49:06 +0200 (CEST)
Date:   Fri, 20 Jul 2018 11:49:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720094906.GP2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <87muumtjwd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muumtjwd.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:02:10AM +0200, Vitaly Kuznetsov wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> 
> > [I added PeterZ and Vitaly -- can you see any way in which this would
> > break something obscure?  I don't.]
> 
> Thanks for CCing me,
> 
> I don't see how this can break things either. At first glance, however,
> I'm afraid we can add performance penalty to virtualized guests which
> don't use native_flush_tlb_others() (Hyper-V, KVM): we will be reloading
> CR3 without a need as we don't look at lazy mode in PV tlb flush
> functions.
> 
> We can either check to switch_mm_irqs_off() that
> native_flush_tlb_others() is in use or teach PV tlb flush functions to
> look at lazy mode too.

As Rik noted elsewhere in the thread, kvm_flush_tlb_others() ends up
calling native_tlb_flush_others() for all running vcpu threads.

The Hyper-V thing is magical, we can't really do anything about it
there. Let them worry about it.
