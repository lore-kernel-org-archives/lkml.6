Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3805204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqc4xXqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3805204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeJKXgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:36:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45037 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJKXgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:36:37 -0400
Received: by mail-io1-f68.google.com with SMTP id x26-v6so7010046iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ev4VPBFyvZ3Tz6tF3DC+XmKcsvKCZdDG8ySpCDtHpg=;
        b=dqc4xXqwYgiqmCwihQqFYRWefh9mVkYpR8cHc8fC915voFZyHFTvAFrcZ9sRPuXRyT
         sS3Jn2MblaWasR+FHKoh2x5WfK2aaJjESblhXCLwIC5ao3fGis31g5KH+vvB7dHMjalj
         SJRcl65zEDy+oWZcbBB3ArIhy5KxA8bQpVh7e4KfTOrI3EMtAoeYlL7V6WInfg0JLU+M
         GikHrFV6PGu1CgkiF44/KP7wcUErgoZHgqsD+wrabahCjAF9ULqqIyQ7ixWARZIvYSlg
         /nb3YAevTBDkj+UBLoviEy1oSR7bJn0Bazk57F0JTnTSixSzwW6p1Gsp6iS7HjsHtv6k
         nJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ev4VPBFyvZ3Tz6tF3DC+XmKcsvKCZdDG8ySpCDtHpg=;
        b=Sijv8sZvETkRA8kci4NBHSeavKbqmXJxtDma66zYMkzaiSmHUFgc/eIoBEjTvDoz/L
         xATBT+Y6clrHWyTGs2aowvne/ZJ7jHC3lohI4kb+heeLIGx2sPHm26XNbVSd3NYd6JcF
         RlZzo0aD8cM5XlRnf3xzACFcgBIT9igiez2NBgME9DbSPFWsyvul8VV9pjh6YzocBS20
         of2ULYrJWG84OSSXKHre0kikcR2xeuEFLiqmlNg2ev2kHPaQ6i9VSOL4t540kWtCts6E
         I2txxb2TbnzPemFLxEdQJ7n96q3SJxVCtc150H6mMFxcWh7byG7NBU4xtj76RMo/wj+y
         nRKw==
X-Gm-Message-State: ABuFfoiZOumKlwGdSb8InfV5aypV2wDlQyWfGxCzP3l2YcE+lnsHaa6S
        dV25Eu8D8Zt9euXVGGAHxzcCswImWA0SpJMPiQEdTA==
X-Google-Smtp-Source: ACcGV63dPtUCdupLmip0C4pOKUVavGli3vKavsprL20wRQMKItdRPHBGFxKUN4mJtq2OAfdFLXtSJeLd96QkOrXtzds=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr1446187iog.271.1539274123913;
 Thu, 11 Oct 2018 09:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181011103825.023036082@infradead.org> <20181011104019.748208519@infradead.org>
 <CANn89iKxTMRr_XSC4xHD-etoU9kF6nN7yzQP4AEfYeNKjQLTPQ@mail.gmail.com>
 <CANn89iJsD=rKTjiGF_EEoSh9WmiifOjxu2mcqSv8Sx-NT7zixQ@mail.gmail.com> <20181011155034.GC9867@hirez.programming.kicks-ass.net>
In-Reply-To: <20181011155034.GC9867@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Oct 2018 09:08:19 -0700
Message-ID: <CANn89i+xbyatCY3Qs=rH9Aaoa2-kbF0nE9u-Tg=NNgbg28OGjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/percpu: Fix this_cpu_read()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 8:50 AM Peter Zijlstra <peterz@infradead.org> wrote:

> Right; it goes back a long long way... is:
>
>   7c3576d261ce ("[PATCH] i386: Convert PDA into the percpu section")
>
> early enough? That introduces percpu_from_op(), but arguably the
> pda_from_op() it replaces was buggy already.

Yeah I guess all stable versions would need a fix anyway, so this tag
would suffice,
even if bug was older.
