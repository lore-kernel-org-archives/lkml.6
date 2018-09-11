Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C206C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D7120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D7120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeIKUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:45:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKUpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:45:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 140CF401EF2E;
        Tue, 11 Sep 2018 15:45:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 639A82157F49;
        Tue, 11 Sep 2018 15:45:46 +0000 (UTC)
Date:   Tue, 11 Sep 2018 23:45:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911154540.GA10082@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 15:45:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 15:45:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 06:48:36AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Tue, Sep 11, 2018 at 08:00:50AM +0800, Ming Lei wrote:
> > > > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> > > >  void percpu_ref_reinit(struct percpu_ref *ref)
> > > >  {
> > > >  	unsigned long flags;
> > > > +	unsigned long __percpu *percpu_count;
> > > >  
> > > >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> > > >  
> > > > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > > > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > > 
> > > Can you elaborate this part?  This doesn't seem required for the
> > > described change.  Why is it part of the patch?
> > 
> > The motivation of this patch is to avoid the above warning and allow
> > the ref to switch back to percpu mode without dropping to zero.
> > 
> > That is why the check has to be changed to the above way.
> 
> So, this part seems wrong.  The function is called percpu_ref_reinit()
> - the refcnt is expected to be in its initial state with just the base
> ref once this function returns.  If you're removing the restriction on

But the comment says that 'Re-initialize @ref so that it's in the same
state as when it finished', and this invariant isn't changed with this
patch.

> when this can be called, you should also make sure that the function
> actually enforces the target state.  Also, this is a separate logical
> change, please put it in a separate patch.

OK, will do it in V2.

Thanks,
Ming
