Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE1921523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1921523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeHXSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:47:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbeHXSrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6570A804B4DB;
        Fri, 24 Aug 2018 15:12:43 +0000 (UTC)
Received: from redhat.com (ovpn-125-224.rdu2.redhat.com [10.10.125.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8566535446;
        Fri, 24 Aug 2018 15:12:41 +0000 (UTC)
Date:   Fri, 24 Aug 2018 11:12:40 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180824151239.GC4244@redhat.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113629.GI29735@dhcp22.suse.cz>
 <103b1b33-1a1d-27a1-dcf8-5c8ad60056a6@i-love.sakura.ne.jp>
 <20180824133207.GR29735@dhcp22.suse.cz>
 <72844762-7398-c770-1702-f945573f4059@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72844762-7398-c770-1702-f945573f4059@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 15:12:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 15:12:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:52:25PM +0900, Tetsuo Handa wrote:
> On 2018/08/24 22:32, Michal Hocko wrote:
> > On Fri 24-08-18 22:02:23, Tetsuo Handa wrote:
> >> I worry that (currently
> >> out-of-tree) users of this API are involving work / recursion.
> > 
> > I do not give a slightest about out-of-tree modules. They will have to
> > accomodate to the new API. I have no problems to extend the
> > documentation and be explicit about this expectation.
> 
> You don't need to care about out-of-tree modules. But you need to hear from
> mm/hmm.c authors/maintainers when making changes for mmu-notifiers.
> 
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index 133ba78820ee..698e371aafe3 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -153,7 +153,9 @@ struct mmu_notifier_ops {
> >  	 *
> >  	 * If blockable argument is set to false then the callback cannot
> >  	 * sleep and has to return with -EAGAIN. 0 should be returned
> > -	 * otherwise.
> > +	 * otherwise. Please note that if invalidate_range_start approves
> > +	 * a non-blocking behavior then the same applies to
> > +	 * invalidate_range_end.
> 
> Prior to 93065ac753e44438 ("mm, oom: distinguish blockable mode for mmu
> notifiers"), whether to utilize MMU_INVALIDATE_DOES_NOT_BLOCK was up to
> mmu-notifiers users.
> 
> 	-	 * If both of these callbacks cannot block, and invalidate_range
> 	-	 * cannot block, mmu_notifier_ops.flags should have
> 	-	 * MMU_INVALIDATE_DOES_NOT_BLOCK set.
> 	+	 * If blockable argument is set to false then the callback cannot
> 	+	 * sleep and has to return with -EAGAIN. 0 should be returned
> 	+	 * otherwise.
> 
> Even out-of-tree mmu-notifiers users had rights not to accommodate (i.e.
> make changes) immediately by not setting MMU_INVALIDATE_DOES_NOT_BLOCK.
> 
> Now we are in a merge window. And we noticed a possibility that out-of-tree
> mmu-notifiers users might have trouble with making changes immediately in order
> to follow 93065ac753e44438 if expectation for mm/hmm.c changes immediately.
> And you are trying to ignore such possibility by just updating expected behavior
> description instead of giving out-of-tree users a grace period to check and update
> their code.

Intention is that 99% of HMM users will be upstream as long as they are
not people shouldn't worry. We have been working on nouveau to use it
for the last year or so. Many bits were added in 4.16, 4.17, 4.18 and i
hope it will all be there in 4.20/4.21 timeframe.

See my other mail for list of other users.

> 
> >> and keeps "all operations protected by hmm->mirrors_sem held for write are
> >> atomic". This suggests that "some operations protected by hmm->mirrors_sem held
> >> for read will sleep (and in the worst case involves memory allocation
> >> dependency)".
> > 
> > Yes and so what? The clear expectation is that neither of the range
> > notifiers do not sleep in !blocking mode. I really fail to see what you
> > are trying to say.
> 
> I'm saying "Get ACK from Jérôme about mm/hmm.c changes".

I am fine with Michal patch, i already said so couple month ago first time
this discussion did pop up, Michal you can add:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
