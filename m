Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089CDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED420833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT5RkNZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfA3O1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:27:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33693 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3O1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:27:24 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so16788634itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmMoE6fwKKEK5lfkDTrTiR8mVowCoseMK5e+Aa4eAHk=;
        b=DT5RkNZvROuYPfECyE8jP+VqbXH3dCau43BYWW0wZ2oHmbnGxoc3JitbwiQpegGqn5
         iro7tOegw0lnHs8AV8v6sDi7muDoWvJ7KZz5bg5025MM7ldpKHyS9zm95N0/GpCnULce
         QUSPM9UhaHDFu8RtlKJAIeFIQWNQIjVh1b/mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmMoE6fwKKEK5lfkDTrTiR8mVowCoseMK5e+Aa4eAHk=;
        b=j0A6RbBCq4JNEtqWqASgklSTDBczS34/TTydj+CLMJSePYSI5cEFezWtoPd511dRoi
         EfVYH3T6Fl7CAjNXI62F5eKmHs9OOYVG9Nr/Dg2ffzhTZba4dmAgTTkwxO4C4HQmIVEo
         h422ddrfkfNzboTbj1RAX2g8I6wtXNXcY888Coc0iznHMp1okqnJdY4ubNgiK6iRGcYW
         TjDgNHY9V4Jbh6Fc6rbyNhqbURlojHNIrWsQ1+aJtZHPMh2LVRH3gF16wlX4T+nnLnso
         1P2IivUjhem4JZgfiV72DvccS5r2MSN4JaCGT5Mz0xo4fjW7vc2Ss2YCOZJQWPBbfT4O
         7zww==
X-Gm-Message-State: AJcUukd99/mav6SHtJn+y6F4EWWKZMQtUVbSgwdFwnIXZ0O5cVyCHPPO
        rGniQ6JIM8pN+yH0Ip51QDR5oyK45ByiWcs4/d90aCLugBkSEA==
X-Google-Smtp-Source: ALg8bN63egVS24wIJzCak4gd65jcVIzt+Sa88X5z4QecoIvKR/4xF+Yuma/Tqqz4nGGf675Cl+8sPy8RmIF2uYFaGe0=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr16267055itf.14.1548858443691;
 Wed, 30 Jan 2019 06:27:23 -0800 (PST)
MIME-Version: 1.0
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130140104.GB2296@hirez.programming.kicks-ass.net> <20190130140144.GD3103@hirez.programming.kicks-ass.net>
In-Reply-To: <20190130140144.GD3103@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 15:27:12 +0100
Message-ID: <CAKfTPtAaHx9g7Gg54GYO+JS6Z18OQbX2P2k3O7K6LMXUv1Beew@mail.gmail.com>
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

On Wed, 30 Jan 2019 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 30, 2019 at 03:01:04PM +0100, Peter Zijlstra wrote:
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -282,13 +282,15 @@ static inline struct cfs_rq *group_cfs_r
> >       return grp->my_q;
> >  }
> >
> > -static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > +static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >       struct rq *rq = rq_of(cfs_rq);
> >       int cpu = cpu_of(rq);
> >
> >       if (cfs_rq->on_list)
> > -             return;
> > +             return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
>
> And I'm almost certain that can be: return true, but got my brain in a
> twist.

Yes this can return true

If cfs_rq->on_list) then a child not already on the list used the path :

if (cfs_rq->tg->parent &&
           cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {

which does rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;

>
> > +
> > +     cfs_rq->on_list = 1;
> >
> >       /*
> >        * Ensure we either appear before our parent (if already
