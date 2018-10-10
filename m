Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE736C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B932085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B932085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJJS14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:27:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54536 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:27:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so5001964wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbZuzvNF3bS7CN3muqddLMSV+8AjptbRC3Cc1DgHv8w=;
        b=ioHeQ8Qs4TZzKy351dHZ122iFCuXcMBw4gFVJUUDcZ6JN7k5DLVDhDnWgLhTqnYOvz
         XnMiIdHq1+lZIcBmsKT/5GuhsVUZDKvvls8O9zUmqbLY5JN6Q3N+3ZNU5KGzR9c9Q+Px
         667TZ9K3Cikjg5wy4EhoOx2b3LNah9TtkO5h2Puqm8BbCnBHvXa3CENHFvMwYTK2dMru
         MCpUZ3B+Q+pgAfmxjFVQEcOMQf++VWY+8NdATFzRMr3h7g91WS+iHwI6y6Os+QEPobWt
         VxiJXtVCtiIyrO2Mw6lZNZFoDjLi8Kkv/d6IBjimPn98u8yGC4iMkqVsA2BthMxeVZyD
         3H1A==
X-Gm-Message-State: ABuFfoitv4HNtcUL2GokdchJ+LJMXFcb7IsGn4tjhKsp+sZ51gNahWhg
        gPIidFu+5iAvIZDSU1/w6uF2jg==
X-Google-Smtp-Source: ACcGV61O5fRZII+9jOvksPnjoybkVHcYnvbV1926UMP3dktct6Tn29FcCRZ5PfZCwyXIfkK8IJF/Qw==
X-Received: by 2002:a1c:b20d:: with SMTP id b13-v6mr461603wmf.141.1539169575809;
        Wed, 10 Oct 2018 04:06:15 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id r131-v6sm13271878wmb.32.2018.10.10.04.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 04:06:14 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:06:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 3/8] locking/mutex: Rework task_struct::blocked_on
Message-ID: <20181010110611.GK9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-4-juri.lelli@redhat.com>
 <20181010124328.16052fd3@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010124328.16052fd3@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 12:43, luca abeni wrote:
> Hi,
> 
> On Tue,  9 Oct 2018 11:24:29 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Track the blocked-on relation for mutexes, this allows following this
> > relation at schedule time. Add blocked_task to track the inverse
> > relation.
> > 
> >                 ,-> task
> >                 |     | blocked-on
> >                 |     v
> >    blocked-task |   mutex
> >                 |     | owner
> >                 |     v
> >                 `-- task
> 
> I was a little bit confused by this description, because (if I
> understand the code well) blocked_task does not actually track the
> inverse of the "blocked_on" relationship, but just points to the task
> that is _currently_ acting as a proxy for a given task.
> 
> In theory, we could have multiple tasks blocked on "mutex" (which is
> owned by "task"), so if "blocked_task" tracked the inverse of
> "blocked_on" it should have been a list (or a data structure containing
> pointers to multiple task structures), no?
> 
> I would propose to change "blocked_task" into something like
> "current_proxy", or similar, which should be more clear (unless I
> completely misunderstood this stuff... In that case, sorry about the
> noise)

Makes sense to me. It looks also closer to what comment says.

> Also, I suspect that this "blocked_task" (or "current_proxy") field
> should be introcuced in patch 5 (same for the "task_is_blocked()"
> function from patch 4... Should it go in patch 5?)

Sure. I believe I might have wrongly split things while rebasing.
Will fix.

Thanks,

- Juri
