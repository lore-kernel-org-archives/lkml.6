Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB61AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61D5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIlWHx60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfBFOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:36:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38389 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:36:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so2965219pgc.5;
        Wed, 06 Feb 2019 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQHBL4H4E6t1GSVT+e5d2e8jbqm9+4cul5BGqspsN2I=;
        b=tIlWHx60gPrDUm/8WuRcYjBTZtZaZ3gI8BSG6RAbleszT4dI53TmC5ig59sVBeJwVe
         ildDd5nrv1sQJnZjmSwlubTOCobIj0SIs4JbrlY21ixeBIlgatL0jBB9ijg9EWPXmhm1
         5s5pdp0RKzQSfQ1KID5JEUB8NG7kK9dSGtvRleYjZ27wzNDecjBZXmImM6wbzRfR50Px
         +yUqmLiiHGZ0zWfgNibVQBbGYYE/J5lQ4hO2qTPfPS1NkzcOeYwKIbVa2XQS/sM6INuA
         WuXpfy+dhdnFrDhE6Y0+owBA0W08jfIpo0YJyUwGknSd0qMT3cZ8+wQzkblyOvVM64Z9
         pKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQHBL4H4E6t1GSVT+e5d2e8jbqm9+4cul5BGqspsN2I=;
        b=FOSi1Ua/CEUSqvt0a8z6zPiThESb9k768rQRJWxnEoWCjgk0XSdCHh0bJ3WsMcjkK9
         dCTVffh3epOgogWIaxkfU7SqJxr9fhmXg14Wuvv5aJiKaYeFC3AkOEZ1PwhwWUKJs19y
         6Zp+fYpQnqVhybHWAMaXJYUmL8AhW2vy2fbq3r7ELUh23dIqdSJZ4GelA84F0MhVI3p2
         kZa7QLLM8Kg4V8SsXsC1ADn6IByGA+Qdt1F/r8sFfGurCs8oBFc7UmSOwCZpa6gX1gZJ
         zQFR5v/vOzujkB30u2pvWUCIQplFoMVXWO/jzBStIp6DIhN7OlSDUqWQXVdNlkYc/dhF
         mKWg==
X-Gm-Message-State: AHQUAuYc2oyYlfS57WHHibuox7BpBjNzaxh8+4GxFPy5mJbMh2lmi1RW
        mr5OGo3etNOrYKJsB9nGIO5BkbQu
X-Google-Smtp-Source: AHgI3IY2mYr+reflHTmYh/rjy9Lup9mpYSVj1qMKfyhuqdXZ3N4QKb0xnCQ/eaqzIaVE3Vq9WBu60w==
X-Received: by 2002:a62:c505:: with SMTP id j5mr10781039pfg.149.1549463787859;
        Wed, 06 Feb 2019 06:36:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n73sm9278491pfj.148.2019.02.06.06.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:36:26 -0800 (PST)
Date:   Wed, 6 Feb 2019 06:36:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Chris Metcalf <chris.d.metcalf@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
Message-ID: <20190206143625.GA25998@roeck-us.net>
References: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
 <87munc306z.fsf@rustcorp.com.au>
 <201902060631.x166V9J8014750@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902060631.x166V9J8014750@www262.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:31:09PM +0900, Tetsuo Handa wrote:
> (Adding linux-arch ML.)
> 
> Rusty Russell wrote:
> > Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> > > (Adding Chris Metcalf and Rusty Russell.)
> > >
> > > If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
> > > evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
> > > previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
> > > commits listed below.
> > >
> > >   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
> > >   expects that has_work is evaluated by for_each_cpu().
> > >
> > >   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
> > >   assumes that for_each_cpu() does not need to evaluate has_work.
> > >
> > >   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
> > >   expects that has_work is evaluated by for_each_cpu().
> > >
> > > What should we do? Do we explicitly evaluate has_work if NR_CPUS == 1 ?
> > 
> > No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.
> > 
> > Doing anything else would be horrible, IMHO.
> > 
> 
> Fixing 2d3854a37e8b767a might involve subtle changes. If we do
> 

Why not fix the macros ?

#define for_each_cpu(cpu, mask)                 \
        for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)

does not really make sense since it does not evaluate mask.

#define for_each_cpu(cpu, mask)                 \
        for ((cpu) = 0; (cpu) < 1 && cpumask_test_cpu((cpu), (mask)); (cpu)++)

or something similar might do it.

Guenter
