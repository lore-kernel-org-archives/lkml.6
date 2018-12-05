Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCA720672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbYn6OOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCA720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeLEKuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:50:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35821 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLEKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:50:52 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so8198032ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMF0bAzTBxyCkjK+bptI9nByQiftSOTnZNCdXVQwIUE=;
        b=VbYn6OOMANHGd9NLXCgfWGN8LiC6/Hc5e8pfcuOR7Tcv28w3jcd0ZsAHxU13ohXU9k
         6QmEi2cT7AG/YXWTDSLogpBHsh5cgsoChHAwYcPkchXpKGqnyqASrhYd/E+dCRm2eVpN
         jJrcP3LlQV900grS6OjawLv8jhEeTyXTpTtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMF0bAzTBxyCkjK+bptI9nByQiftSOTnZNCdXVQwIUE=;
        b=NDp82AZ6TSVU3bRDY6ytdYeA2Tz1O2JTbMnclA99bzPmLM3BYQIu2x8DPMvABkZmWj
         PCjQOlQGYHzs/LKEmaAIHkN8xcRyKwfOAtf8i1EXFzfFvz+X37bMu9lAZzQTI3omVG0D
         xdO0LL2LFCMyobEO/F774G+tqQOMtZjf9bfUUpjsI842wEVL6+BHjCWHhS9d5chL9JaS
         /hbZ+05sRFLZVw0liBn7QFuJQoJ/GjILUg9qwoINrMLtOC2azRoJ8/BvTZPYVfZTP460
         Ls6G8uz2rrPnvgyScITqDHO+ZeKEtszbbn0NNpE2w64PKBLLAFp3XJrBSCU7Lcx4QyBy
         MjNg==
X-Gm-Message-State: AA+aEWYhqXwxyhQ0pZbaSa88Nw61cBSlpH1B/QbytzCFRAHioT82pK25
        8XIyB2ko0vH4TBPHxEC3ijlif3h/74TrK9qsc3kROA==
X-Google-Smtp-Source: AFSGD/UEhroe4SxxFb753u7dU/rk+gMhi2coWefX1lqAmAmzT+wXfSDdIO7/7mBsQm0pFnjBp2HeCt+T3uL7qtaV4tg=
X-Received: by 2002:a25:2157:: with SMTP id h84-v6mr21892011ybh.198.1544007051334;
 Wed, 05 Dec 2018 02:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20181204194044.9506-1-anders.roxell@linaro.org> <20181204173258.6de70c66@vmware.local.home>
In-Reply-To: <20181204173258.6de70c66@vmware.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 5 Dec 2018 11:50:40 +0100
Message-ID: <CADYN=9JVZ0vRbon9DkxuUx4sYNMuCYyoYL1gydCLrdjRJGS4+g@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: add cond_resched to ftrace_replace_code()
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 23:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  4 Dec 2018 20:40:44 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > When running in qemu on an kernel built with allmodconfig and debug
> > options (in particular kcov and ubsan) enabled, ftrace_replace_code
> > function call take minutes. The ftrace selftest calls
> > ftrace_replace_code to look >40000 through
> > ftrace_make_call/ftrace_make_nop, and these end up calling
> > __aarch64_insn_write/aarch64_insn_patch_text_nosync.
> >
> > Microseconds add up because this is called in a loop for each dyn_ftrace
> > record, and this triggers the softlockup watchdog unless we let it sleep
> > occasionally.
> >
> > Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().
>
> This isn't urgent is it?

No, it is not urgent. I'm trying to get allmodconfig to boot on arm64.

> That is, it doesn't need a stable tag?

Also I don't think its a regression, since clearly nobody has ever been
able to boot an arm64 allmodconfig kernel or anything close to that.

Cheers,
Anders
