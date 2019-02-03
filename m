Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2938FC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A5A2183E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfBFBRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:17:42 -0500
Received: from ozlabs.org ([203.11.71.1]:60073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfBFBRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:17:42 -0500
Received: by ozlabs.org (Postfix, from userid 1011)
        id 43vNpr2SQQz9s3x; Wed,  6 Feb 2019 12:17:40 +1100 (AEDT)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Metcalf <chris.d.metcalf@gmail.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
In-Reply-To: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
References: <18a30387-6aa5-6123-e67c-57579ecc3f38@roeck-us.net> <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
Date:   Mon, 04 Feb 2019 10:16:12 +1030
Message-ID: <87munc306z.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> (Adding Chris Metcalf and Rusty Russell.)
>
> If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
> evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
> previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
> commits listed below.
>
>   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
>   expects that has_work is evaluated by for_each_cpu().
>
>   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
>   assumes that for_each_cpu() does not need to evaluate has_work.
>
>   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
>   expects that has_work is evaluated by for_each_cpu().
>
> What should we do? Do we explicitly evaluate has_mask if NR_CPUS == 1 ?

No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.

Doing anything else would be horrible, IMHO.

Cheers,
Rusty.
