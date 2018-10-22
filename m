Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BBC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A674320672
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4Y7DLHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A674320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeJWFbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:31:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43465 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbeJWFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:31:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so19623554plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=znTYvf1OdVnkHfETcdKAJ1/9hxvTH0agKlVs4jcYVOg=;
        b=v4Y7DLHpB48e0Vs3eThPeTv1Z3JWGfJ2AVKhEJwCzx8aE0ytkkahLc01CGnlw83WcJ
         OKk0gabDYLIUswebcxxWvqvoHyKhsvbxqC0dQzDMcKccrdS1/kBvApwmE0H+eUB4yS0A
         wGSevvCayzcazt3+02tP3MM50HnXLnZ9G4B+lRYXamQvxXO1EpWkh+Rf+z/mcUpJtksi
         1QS/uqpWP7IP7Ry7HY8PRQ6ZSqtwAUpcrhoifuxw/KR6FAkJgubTTxSbwx8QGyPPk+SG
         /XXb7TWZLI298eSwYkWc8zi11UuvY/nOjSV2JxyGbAbvi2p+jSaTPAj4X48OTOJWGTJY
         km9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=znTYvf1OdVnkHfETcdKAJ1/9hxvTH0agKlVs4jcYVOg=;
        b=KtYn8HYHkruE+J4IubUC73NI85V8g702iGMFnzye7LljopiUezKaUwYnvUqPhGp63Y
         rJA44ODHrXlbp4bKXyZsDQUstMStdgR543iEPKlGCoo8EhMPA/PxsIImtKdY0Fce9GLZ
         m/UC2GDnQ/UDxlRL5SW6wxNszWYwnY9mZ3NLJBPUm18eOTb7jXhrWYjHB3lJhfXtJAY4
         uoW4P0JiTI4YsodcAFvV8NmmMPrMaso0DYRFBOPt//0SQYBX2CpBA95QWmBGzLQZ90za
         pH2te2LslyC+Z5+wssFfI/qO6HBKmh9BUD7PaTlclIbXGFlE4u6WfdoUzN+TaXvrPaDM
         42Kw==
X-Gm-Message-State: ABuFfoidQNxwjxcmJ3FC/FEd+RqGV2nUiCU2UFehLYx1H2rg/SUvvKSr
        8/DTCh4C6Y7w4ntw4e8ulD53Gg==
X-Google-Smtp-Source: ACcGV61eDYhRyehboulMzIXek5qRLQZN0yut/f6a1vMimt0cm2Sy4vNdqLkZP3Qmuq0tIu3SsQhZfQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr45999033pls.217.1540242672587;
        Mon, 22 Oct 2018 14:11:12 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v19-v6sm5519437pgl.80.2018.10.22.14.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:11:11 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:11:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        yang.s@alibaba-inc.com, Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm,oom: Use timeout based back off.
In-Reply-To: <1540033021-3258-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.1810221406400.120157@chino.kir.corp.google.com>
References: <1540033021-3258-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018, Tetsuo Handa wrote:

> This patch changes the OOM killer to wait for either
> 
>   (A) __mmput() of the OOM victim's mm completes
> 
> or
> 
>   (B) the OOM reaper gives up waiting for (A) because memory pages
>       used by the OOM victim's mm did not decrease for one second
> 
> in order to mitigate at least three problems
> 
>   (1) an OOM victim needlessly selects next OOM victim if the OOM-killed
>       processes are using clone(CLONE_VM) without CLONE_THREAD because
>       task_will_free_mem(current) in out_of_memory() returns false when
>       MMF_OOM_SKIP was set before remaining OOM-killed processes reach
>       out_of_memory().
> 
>   (2) an memcg OOM event needlessly selects next OOM victim because we
>       are assuming that the OOM reaper can reclaim majority of the OOM
>       victim's mm, but sometimes we need to wait for completion of
>       free_pgtables() in exit_mmap() in order to reclaim enough memory.
> 
>   (3) an memcg OOM event from a multithreaded process by an unprivileged
>       user can needlessly trigger flooding of "Out of memory and no
>       killable processes..." and dump_header() messages because
>       task_will_free_mem(current) in out_of_memory() returns false when
>       MMF_OOM_SKIP was set before remaining OOM-killed threads reach
>       out_of_memory().
> 
> all caused by setting MMF_OOM_SKIP too early.
> 
> Michal has proposed an attempt to handover setting of MMF_OOM_SKIP to
> the OOM victim's exit path [1] in order to handle (2), but there was no
> feedback (except me) and nobody knows whether it is really safe and is
> worth constrain future changes. Not only that attempt can mitigate only
> portion of exit_mmap() (rather than until the OOM victim thread becomes
> invisible from the OOM killer), that attempt does not help at all for (1)
> and (3) because __mmput() cannot be called.
> 
> I have proposed many patches which mitigate (1) and (3) without using
> timeout based approach, but Michal is rejecting them and wants to address
> the root cause that MMF_OOM_SKIP is set too early. And nobody (including
> Michal) has time to make the OOM reaper reclaim more memory (including
> mlock()ed and shared memory, and mmap_sem contention) before setting
> MMF_OOM_SKIP. We are deadlocked there.
> 
> Michal has been refusing timeout based approach, but I don't think this
> is something we have to be frayed around the edge about possibility of
> overlooking races/bugs just because Michal does not want to use timeout.
> I believe that timeout based back off is the only approach we can use
> for now.
> 

I've proposed patches that have been running for months in a production 
environment that make the oom killer useful without serially killing many 
processes unnecessarily.  At this point, it is *much* easier to just fork 
the oom killer logic rather than continue to invest time into fixing it in 
Linux.  That's unfortunate because I'm sure you realize how problematic 
the current implementation is, how abusive it is, and have seen its 
effects yourself.  I admire your persistance in trying to fix the issues 
surrounding the oom killer, but have come to the conclusion that forking 
it is a much better use of time.
