Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85797C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BD720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BD720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeIKE5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:57:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeIKE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9442040216EA;
        Tue, 11 Sep 2018 00:01:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7125310CD62C;
        Tue, 11 Sep 2018 00:00:55 +0000 (UTC)
Date:   Tue, 11 Sep 2018 08:00:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911000049.GB30977@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 00:01:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 00:01:00 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, Sep 10, 2018 at 09:49:20AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Sun, Sep 09, 2018 at 08:58:24PM +0800, Ming Lei wrote:
> > @@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
> >  
> >  	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
> >  
> > -	/*
> > -	 * Restore per-cpu operation.  smp_store_release() is paired
> > -	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> > -	 * zeroing is visible to all percpu accesses which can see the
> > -	 * following __PERCPU_REF_ATOMIC clearing.
> > -	 */
> 
> So, while the location of percpu counter resetting moved, the pairing
> of store_release and READ_ONCE is still required to ensure that the
> clearing is visible before the switching to percpu mode becomes
> effective.  Can you please rephrase and keep the above comment?

OK, will do it in V2.

> 
> > -	for_each_possible_cpu(cpu)
> > -		*per_cpu_ptr(percpu_count, cpu) = 0;
> > -
> >  	smp_store_release(&ref->percpu_count_ptr,
> >  			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
> >  }
> ...
> > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> >  void percpu_ref_reinit(struct percpu_ref *ref)
> >  {
> >  	unsigned long flags;
> > +	unsigned long __percpu *percpu_count;
> >  
> >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> >  
> > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> 
> Can you elaborate this part?  This doesn't seem required for the
> described change.  Why is it part of the patch?

The motivation of this patch is to avoid the above warning and allow
the ref to switch back to percpu mode without dropping to zero.

That is why the check has to be changed to the above way.


Thanks,
Ming
