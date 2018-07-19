Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URG_BIZ,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35B02084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHVkcz+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35B02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeGSN5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbeGSN5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:57:34 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C2C20673;
        Thu, 19 Jul 2018 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532006067;
        bh=JegcJGV5tvo1vBOLzri1VvP8JMF5ewddHE5zCd11uIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHVkcz+UbkZp0kc29KmNf4EbZdl5jWcxXfXyv7e66NhzwSC9ko5aT2H+KfxK8F6tK
         CBFgeoNpNjS51XSOX7v67loUSHM0+AbNWrhWoML+RvrcKcZ1rr53LwlDsD+od6PQVc
         Yx9wueoET/190OvTyy3/cwkYU4g1VIBQ6/9qLb2E=
Date:   Thu, 19 Jul 2018 15:14:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        mhillenb@amazon.de, linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180719131422.GC5595@lerouge>
References: <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
 <20180718153628.GA24359@linux.vnet.ibm.com>
 <1531929711.3414.29.camel@infradead.org>
 <20180718163712.GB12945@linux.vnet.ibm.com>
 <1531942865.3414.35.camel@infradead.org>
 <20180718201700.GN12945@linux.vnet.ibm.com>
 <86d12d1a-46dd-d82a-96c2-e842ac5a2a6c@de.ibm.com>
 <1531984833.12620.16.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531984833.12620.16.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 09:20:33AM +0200, David Woodhouse wrote:
> On Thu, 2018-07-19 at 08:45 +0200, Christian Borntraeger wrote:
> > 
> > > My thought would be something like this:
> > > 
> > >       if (context_tracking_cpu_is_enabled())
> > >               rcu_kvm_enter();
> > >       else
> > >               rcu_virt_note_context_switch(smp_processor_id());
> > 
> > In the past we needed that (when we introduced that). At least with every
> > host interrupt we called this making an rcu event at least every HZ.
> > Will the changes in need_resched make this part unnecessary?
> 
> Yes, the change in need_resched() should make this part unnecessary.
> Unless your architecture's version of the vcpu_run() loop just loops
> forever even when TIF_NEED_RESCHED is set? :)
> 
> I'm not sure about the context tracking condition in the code snippet
> cited above, though. I think that's what caused my problem in the first
> place — I have CONTEXT_TRACKING_FORCE && !NO_HZ_FULL. So in 4.15, that
> means rcu_user_enter() did nothing and rcu_virt_note_context_switch()
> wasn't called. Hence the observed stalls.
> 
> Should rcu_user_enter() itself be conditional on CONTEXT_TRACKING not
> NO_HZ_FULL? 

Ah, CONTEXT_TRACKING_FORCE is only for testing purpose, you should not select
it, it's going to introduce overhead. Actually I should remove that. Although
since we have removed CONFIG_NOHZ_FULL_ALL it's the last way we have to test
NOHZ_FULL from config alone.
