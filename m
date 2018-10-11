Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C60C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769382077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769382077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeJKUBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:01:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38039 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:01:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so9213925wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5BM3ARmHFFxcdDf3fM419QcwmtH/92iuXIQvAJHaXg=;
        b=FRXmYD0ZAzmfapkDhvfSeIlYnVA3zRRq23/La8eTolW6hXJ5nPhPslUtLUCCxgtbvp
         mKH/9K06dlZHG1sOLNmOftko+a0t0gYjxOH3lD1/i63JMRlTVQSVo7yCwX/N79uptuuS
         fejhNrbB/KkAu99zupi1vGzfRX96Xho4p2W40KrANVPXzL36mVzawK/OC0YdJngVv4HY
         g6cH0AUDX7wd8+1oOICjNETFTaaJdp4xr+ffDxnFvvby2jd0O6WnrFghMqzR2xwqT5oJ
         +B6hREWg/yNZ1vbCE13Cc4Z4r+gLRjq77SHZ9V4rik+1yBwoJH1U9gpfuEkOb/J1O4L/
         D2GQ==
X-Gm-Message-State: ABuFfojwIDpkDLaL4ue6WRTG2uhu08XuXulRnjpR8xYsm+ha4lVQze5A
        q4Po6Tge1cWG4XgrcNtOFTH6RQ==
X-Google-Smtp-Source: ACcGV60Xfkicc3M+NVrUIHSKPA0AS2xVITVBDz9CdZT55aYaoRHv/IQzNdUcN1NjkXe4S/m1c7gZxg==
X-Received: by 2002:a1c:a696:: with SMTP id p144-v6mr1587556wme.14.1539261292370;
        Thu, 11 Oct 2018 05:34:52 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o126-v6sm19293589wmo.3.2018.10.11.05.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 05:34:51 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:34:48 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181011123448.GS9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010131048.54afd1b6@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 10/10/18 13:10, luca abeni wrote:
> Hi,
> 
> On Tue,  9 Oct 2018 11:24:31 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> > +migrate_task:
> [...]
> > +	put_prev_task(rq, next);
> > +	if (rq->curr != rq->idle) {
> > +		rq->proxy = rq->idle;
> > +		set_tsk_need_resched(rq->idle);
> > +		/*
> > +		 * XXX [juril] don't we still need to migrate @next
> > to
> > +		 * @owner's CPU?
> > +		 */
> > +		return rq->idle;
> > +	}
> 
> If I understand well, this code ends up migrating the task only if the
> CPU was previously idle? (scheduling the idle task if the CPU was not
> previously idle)
> 
> Out of curiosity (I admit this is my ignorance), why is this needed?
> If I understand well, after scheduling the idle task the scheduler will
> be invoked again (because of the set_tsk_need_resched(rq->idle)) but I
> do not understand why it is not possible to migrate task "p" immediately
> (I would just check "rq->curr != p", to avoid migrating the currently
> scheduled task).

As the comment suggests, I was also puzzled by this bit.

I'd be inclined to agree with you, it seems that the only case in which
we want to "temporarily" schedule the idle task is if the proxy was
executing (so it just blocked on the mutex and being scheduled out).

If it wasn't we should be able to let the current "curr" continue
executing, in this case returning it as next will mean that schedule
takes the else branch and there isn't an actual context switch.

> > +	rq->proxy = &fake_task;

[...]

We can maybe also rq->proxy = rq->curr and return rq->curr in such a
case, instead of the below?

> > +	return NULL; /* Retry task selection on _this_ CPU. */

Peter, what are we missing? :-)
