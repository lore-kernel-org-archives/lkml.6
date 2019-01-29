Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8F0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FED20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVcqUjmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfA2TJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:09:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2TJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cua5YyY3UCe/2GZUwqOSzY6Efy7wQkjzkYSxkI+PGIc=; b=gVcqUjmOXq5LVw8P80svC9HYP
        AV8bRa1e6rYmZwXtE6cNeG0FGcm8XcguwKoNEFRTx7ABc+Nx/PtM4QjuVMLk/RfooU0lRdnkWxOqT
        QRzoVNadl1qrmH2b/smBvJ9lU7mKAOS0dIfiwUBYj+kivO4cslH6ojOFJH/BPXeYDEcZWq2+4VDuH
        KymK/JiSENNQxnkaa9PJ5pz11okYs9d5b4ZeGmCvOtzi8CKSuHWlJUnZhwhOn4KQ4rEiylU4FISEn
        iLyexJFSEeziwNmFVxQ7FBZ122QdaCxlvNN0P6++7mqVuXcvrpnc6QI7RMXH5dLVQs1bJW0S+fMlb
        WpgokPBRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goYkf-0003Mo-DW; Tue, 29 Jan 2019 19:08:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84A3F201EC171; Tue, 29 Jan 2019 20:08:51 +0100 (CET)
Date:   Tue, 29 Jan 2019 20:08:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
Message-ID: <20190129190851.GA2961@hirez.programming.kicks-ass.net>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-6-surenb@google.com>
 <20190129123843.GK28467@hirez.programming.kicks-ass.net>
 <CAJuCfpGxtGHsow002nd8Ao8mo9MaZQqZau_NLTMrZ8=aypTkig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGxtGHsow002nd8Ao8mo9MaZQqZau_NLTMrZ8=aypTkig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:18:20AM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 29, 2019 at 4:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> > > +                     atomic_set(&group->polling, polling);
> > > +                     /*
> > > +                      * Memory barrier is needed to order group->polling
> > > +                      * write before times[] read in collect_percpu_times()
> > > +                      */
> > > +                     smp_mb__after_atomic();
> >
> > That's broken, smp_mb__{before,after}_atomic() can only be used on
> > atomic RmW operations, something atomic_set() is _not_.
> 
> Oh, I didn't realize that. After reading the following example from
> atomic_ops.txt 

That document it woefully out of date (and I should double check, but I
think we can actually delete it now). Please see
Documentation/atomic_t.txt

> I was under impression that smp_mb__after_atomic()
> would make changes done by atomic_set() visible:
> 
> /* All memory operations before this call will
> * be globally visible before the clear_bit().
> */
> smp_mb__before_atomic();
> clear_bit( ... );
> /* The clear_bit() will be visible before all
> * subsequent memory operations.
> */
> smp_mb__after_atomic();
> 
> but I'm probably missing something. Is there a more detailed
> description of these rules anywhere else?

See atomic_t.txt; but the difference is that clear_bit() is a RmW, while
atomic_set() is just a plain store.

> Meanwhile I'll change smp_mb__after_atomic() into smp_mb(). Would that
> fix the ordering?

It would work here; but I'm still trying to actually understand all
this. So while the detail would be fine, I'm not ready to judge the
over-all thing.
