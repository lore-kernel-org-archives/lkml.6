Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC62C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7190120672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lyap9fIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7190120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeLEKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:43:26 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33569 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:43:25 -0500
Received: by mail-yb1-f193.google.com with SMTP id f125so3452227ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRI4PDsEEwb31m3DRLBEFs4W8LJyus7kckexdrC0sas=;
        b=Lyap9fIFpvmPqItvXQ5xgdadbnM7zJTCd8BWpLSob4VHaBroFebRDaUUR8UoP2OsCk
         BX4SvFENr1cwLKkCUVfqVFoUKq8D+yDLDTt3KjYSzE5t2rkcMlW1WIJZr9Kjxyy2/zXw
         6YUeQuDQ7myfwD8dyQxhUu1amM6guzeog98VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRI4PDsEEwb31m3DRLBEFs4W8LJyus7kckexdrC0sas=;
        b=MEtXJOu/2N2Xx/G1w6UXBrl5j10MKjk0A14rNDW5bQGrRmjI4ajT5EB8U+9tSi+0zg
         qT8WQuFi9PCSqbI1iPHzoNmmt/s2Sge6AOumApHi9idYYlD8WiMpUBwt3vaLScw1WVc2
         y/Rul0vKvtjd5IT5VWJ+qwXpeXmxxZA26AdRzAg0kRxZDEcTQAI9K//BDE8DCe9Ql4rB
         8nOHx/x84CzTs9dWaJYgkLHn6pXvAnRWPF/iX0QbDBMquQ1BvR63Mi/cWWSexFHU6rdD
         76cvfMSvecnb1Yzj5cMroz8V0k8ZN3By0m+uawjTDH5OzMq1IlwbPxx8xEh+x0JekcQH
         b03g==
X-Gm-Message-State: AA+aEWZw8YAvgRQfxKrpyt+shci6g77FwiTBuf6bsn0EVb25yJuGG2xG
        1EKHb8tjAPNmu2UsX2vDUV/Abe2zsa704XoGARN/ZQ==
X-Google-Smtp-Source: AFSGD/WmnNMS0aydzCgeSYOnj7WtAkX3gAryrLEhit4OhAwUj//KWlDosPgtaKLQEpgolkNZ00JzY8nJwFGNmqdsbl4=
X-Received: by 2002:a25:1143:: with SMTP id 64-v6mr22413321ybr.195.1544006604364;
 Wed, 05 Dec 2018 02:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20181204192903.8193-1-anders.roxell@linaro.org> <20181205095445.GA14317@arm.com>
In-Reply-To: <20181205095445.GA14317@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 5 Dec 2018 11:43:12 +0100
Message-ID: <CADYN=9+-z=_5Gn9hJcGi8UwbNxS2jK+OXe5DE0pGxscuZA_8tg@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
To:     Will Deacon <will.deacon@arm.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 10:54, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Anders, Steve,
>
> On Tue, Dec 04, 2018 at 08:29:03PM +0100, Anders Roxell wrote:
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
> >
> > Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  kernel/trace/ftrace.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index c375e33239f7..7080eb464983 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2419,11 +2419,19 @@ void __weak ftrace_replace_code(int enable)
> >  {
> >       struct dyn_ftrace *rec;
> >       struct ftrace_page *pg;
> > +     bool schedulable;
> >       int failed;
> >
> >       if (unlikely(ftrace_disabled))
> >               return;
> >
> > +     /*
> > +      * Some archs calls this function with interrupts or preemption
> > +      * disabled. However, for other archs that can preempt, this can cause
> > +      * an tremendous unneeded latency.
> > +      */
> > +     schedulable = !irqs_disabled() && !preempt_count();
>
> Is there a reason not to use preemptible() here?

As I understand it preemptible() is defined to 0 if
CONFIG_PREEMPT_COUNT is disabled.
Thats no good right ?

Cheers,
Anders
