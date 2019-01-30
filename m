Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D46C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DD220989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlmTjeKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfA3N3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:29:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34510 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:29:54 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so16653247itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uwFeQHIVQy35WsZ5wssVHAlzcrQzug78g9MjzOiFAk=;
        b=dlmTjeKHZq5CmjoyYS3f9cUIYm90I5KTGsmcOcSxfiYpfSd5J+8tIL872GlC/qBPyk
         BX1JAM2H+PQLsPpg8zrcxJyyf79xAT5dxs89j8q7keaQYDugwPOT141UdElQN8fkzQm1
         zOTNw77d15Lsm7F1noSnbDclNKDscuk6vra78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uwFeQHIVQy35WsZ5wssVHAlzcrQzug78g9MjzOiFAk=;
        b=dGyWnVjLHOsgrucNMW9ZQLuNr4thTGO9WH/2PFKEMoO0TIuwgtN3q2hzYhdcJJyAit
         hhirZlP/6pOjIphbiQQNtLNP8DODKKbkeGC3TRjShzBg7e8cU+bdH/OGAcfge1dtIajl
         hzgSS7o0ettnvXOwDAjSf8D+5IfhsBxW6wa1MpJRSqtp7npNNCyqQ3abI0opub0uaXwc
         OA74vIzom+q2R3PvfCeeomn9Adu/tUCoEFt+4vJ+DnkeMKHU1XrCx/1WkwfOVReSFcV5
         7BcCVSfpVoGsDHm94fDIuCUeb9Db6kd3RMLsMOLCyxqhzhCGv1oAVSgAB4mVtl/xgP3u
         NyzQ==
X-Gm-Message-State: AJcUukeBoS/HvDPMY9+lO6arxgGi73MgCkpn3xifMm1MMDKfyfiFUYTh
        TqlwMkSg4XNdkZ7+QEeBEwUmM4TK4XKQcnoc+qBq6BHC5jSxaQ==
X-Google-Smtp-Source: ALg8bN7BYHhnoWStKV9VSeK1CaYJ5bHejTQyie6c7jDCTyluCHIKd4E25ligvK4oLFrSjay1kG12mMIYEEmFKPS/0Qw=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr17410947jak.11.1548854993436;
 Wed, 30 Jan 2019 05:29:53 -0800 (PST)
MIME-Version: 1.0
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net> <20190130130620.GB3103@hirez.programming.kicks-ass.net>
 <20190130132717.GC3103@hirez.programming.kicks-ass.net>
In-Reply-To: <20190130132717.GC3103@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 14:29:42 +0100
Message-ID: <CAKfTPtBhOomgYONsdfaaVgZCENM+QhfPie2qpu0KyOsvMiog_g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 30, 2019 at 02:06:20PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 30, 2019 at 02:04:10PM +0100, Peter Zijlstra wrote:
>
> > > So I don't much like this; at all. But maybe I misunderstand, this is
> > > somewhat tricky stuff and I've not looked at it in a while.
> > >
> > > So per normal we do:
> > >
> > >     enqueue_task_fair()
> > >       for_each_sched_entity() {
> > >         if (se->on_rq)
> > >           break;
> > >         enqueue_entity()
> > >           list_add_leaf_cfs_rq();
> > >       }
> > >
> > > This ensures that all parents are already enqueued, right? because this
> > > is what enqueues those parents.
> > >
> > > And in this case you add an unconditional second
> > > for_each_sched_entity(); even though it is completely redundant, afaict.
> >
> > Ah, it doesn't do a second iteration; it continues where the previous
> > two left off.
> >
> > Still, why isn't this in unthrottle?
>
> Aah, I see, because we need:
>
>   rq->tmp_alone_branch == &rq->lead_cfs_rq_list
>
> at the end of enqueue_task_fair(); having had that assertion would've

Yes exactly.
You have been quicker than me to reply

> saved some pain I suppose.
