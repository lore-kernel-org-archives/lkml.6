Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241DFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A7C2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOs44IFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfBFQYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:24:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32889 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBFQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:24:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so3305094pfb.0;
        Wed, 06 Feb 2019 08:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3kxfnmBJF9JEeLTh2Qv9UfiGWUm5fMi+IhLoPJOxnc=;
        b=TOs44IFxpDo8l3wywTdA3/xWWnWhN6UatDpaS2Q6+Ctt6VczwdlhJvcDxfNfoU4Qe+
         fPN7h4BtM3N/nwFPwhtz7RX+vJjiarfjv3srCVD1ioPk54nTxrIviR2d0WYwZ2UbZzns
         8RHkSe3jVDJuf5jKDl5EVK/cSt+c2onn65qGVwYnHUVWjTOVeIh/gmzSRw/8asjhx+qh
         Wtm9DcqopbqECAQKKjz2FMkQQcabxRugpgJvZsQuSjyoQ5RchXF+0XjrNqLB54qFu5TW
         FQAoQHT3WngGSERXsY5Xl2xUGuhnQPXOS/bs7r7dZzI382rEoCwlE/cpHOcINQKxSVXS
         frlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3kxfnmBJF9JEeLTh2Qv9UfiGWUm5fMi+IhLoPJOxnc=;
        b=sI8/j1AeedOhMKy2eUGexAGu110UVNjek4tb0jyxaFIdiwnalb+grcd6NHxLTTBB3s
         UuWAAI2IxlZlSSZ02D6ygzse6vkxF/SiAqGFxRcTyfOFGUnAi+8F2eVB7kDCpNk2X/4j
         PCafYSVVoma07vVdpSySewWs9XDCEUP/BF7szyuk44z/lYp9kxHr97+1XZgeTqI8Qqd2
         wTtOpWIZoEao1cbmBmM3JQcxGVUurWUThlZ5u6dWHy+cGo8UqpLSEqGyYg+Y4+17buo4
         a8w5XgQMM6Mf8onBQufWRvZcqPxNk+e4jDJqug0JXlQtGs751bXhYiklxSLft0fqsp2r
         j+jw==
X-Gm-Message-State: AHQUAuY95Dd9MqUEeQKmuJGJqXIv5qVRu91xmucJz2YQ25rv3uQH4u1C
        aVMQNNdS4tUDbFxidDW3DCNw3Biz
X-Google-Smtp-Source: AHgI3IYhw9WZpm+mywwAL0qVkE0TRXuKGYMLgGTiDU4KbP9bWqvXaHtCSLxeFym4VOZ2w2twoVYlCg==
X-Received: by 2002:a63:1766:: with SMTP id 38mr5413529pgx.299.1549470242559;
        Wed, 06 Feb 2019 08:24:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9sm9374626pfi.74.2019.02.06.08.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:24:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 08:23:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Chris Metcalf <chris.d.metcalf@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
Message-ID: <20190206162359.GA30699@roeck-us.net>
References: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
 <87munc306z.fsf@rustcorp.com.au>
 <201902060631.x166V9J8014750@www262.sakura.ne.jp>
 <20190206143625.GA25998@roeck-us.net>
 <e4dd7464-a787-c54f-24f9-9caaeb759cfc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4dd7464-a787-c54f-24f9-9caaeb759cfc@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:57:45PM +0900, Tetsuo Handa wrote:
> On 2019/02/06 23:36, Guenter Roeck wrote:
> > On Wed, Feb 06, 2019 at 03:31:09PM +0900, Tetsuo Handa wrote:
> >> (Adding linux-arch ML.)
> >>
> >> Rusty Russell wrote:
> >>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> >>>> (Adding Chris Metcalf and Rusty Russell.)
> >>>>
> >>>> If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
> >>>> evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
> >>>> previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
> >>>> commits listed below.
> >>>>
> >>>>   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
> >>>>   expects that has_work is evaluated by for_each_cpu().
> >>>>
> >>>>   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
> >>>>   assumes that for_each_cpu() does not need to evaluate has_work.
> >>>>
> >>>>   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
> >>>>   expects that has_work is evaluated by for_each_cpu().
> >>>>
> >>>> What should we do? Do we explicitly evaluate has_work if NR_CPUS == 1 ?
> >>>
> >>> No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.
> >>>
> >>> Doing anything else would be horrible, IMHO.
> >>>
> >>
> >> Fixing 2d3854a37e8b767a might involve subtle changes. If we do
> >>
> > 
> > Why not fix the macros ?
> > 
> > #define for_each_cpu(cpu, mask)                 \
> >         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> > 
> > does not really make sense since it does not evaluate mask.
> > 
> > #define for_each_cpu(cpu, mask)                 \
> >         for ((cpu) = 0; (cpu) < 1 && cpumask_test_cpu((cpu), (mask)); (cpu)++)
> > 
> > or something similar might do it.
> 
> Fixing macros is fine, The problem is that "mask" becomes evaluated
> which might be currently undefined or unassigned if CONFIG_SMP=n.
> Evaluating "mask" generates expected behavior for lru_add_drain_all()
> case. But there might be cases where evaluating "mask" generate
> unexpected behavior/results.

Interesting notion. I would have assumed that passing a parameter
to a function or macro implies that this parameter may be used.

This makes me wonder - what is the point of ", (mask)" in the current
macros ? It doesn't make sense to me.

Anyway, I agree that fixing the macro might result in some failures.
However, I would argue that those failures would actually be bugs,
hidden by the buggy macros. But of course that it just my opinion.

Guenter
