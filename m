Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90769C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5560B20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOb/fWf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5560B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeLFOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:32:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39691 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeLFOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:32:01 -0500
Received: by mail-yb1-f194.google.com with SMTP id s15so509609ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI3le/AIaBijHw5uZ2k9t8fgzRfmVnmWoFR1dUmPcUk=;
        b=dOb/fWf8y2Uy9Urs1EeiKNYHSgOo/cOmGNQRiH/6+sSrbRXwjTr/+xiQFBD2tuDf/6
         xFnjVL5TJ6rSmaQuNxrrbi721vpKpbb4ubNl/BBPmNaff3DG+YYhqnN8tvvdxBRVhaNQ
         IQVFmIWX1N7YZTP3ukCzi6ksb/MHPPPri0dM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI3le/AIaBijHw5uZ2k9t8fgzRfmVnmWoFR1dUmPcUk=;
        b=B3MZj/s+yFEfkico7oONWifhpt/a//kRHkDMeDoEDiON6OnXTAk8AYlmugTZ8l5iyF
         w03SUvR2CPpn5SoEb9mrK47nJfcTaXPdU1IFjHzGcnfSqFxKIY7Y/xCjdlYdCpSnb8k4
         Ty1uftL9FfrPNg2SCLw9ErBEZ5XFE3ae7c+aZsOkDerr8dxbB2Zf9dS7V19/sC9kMR5c
         CSOrjZH54OSWTjF4U3bVsw0M6B2fIsPF/BYdxY2UtaBSWNciP9nmoPY9fG2M+AcR3ccU
         5rUNvfdoujknoQQO4lHThcsXrpGYac3nPnp9Rf18ZMIWkRjyK+EJnyOKioOC2eomlcHh
         6unw==
X-Gm-Message-State: AA+aEWYkWdToD8GGYS2mApLJEWrivHjhYaAi7ghkAtcWSdEm4eM9Urk1
        HjnufFwEAoYyVszlsz5BNVtQjyTdNfJ75TNTidNSPw==
X-Google-Smtp-Source: AFSGD/VVtoqYQoxxGjb6oM9lBVGFt4zwqsE16/q067B+3dPwrg4Sgakw3PYJsNSEyuNsXpG4wpcdU649ORSdkQT1uwM=
X-Received: by 2002:a81:2e0d:: with SMTP id u13mr28814164ywu.45.1544106720591;
 Thu, 06 Dec 2018 06:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org> <20181205183304.000714627@goodmis.org>
 <20181206132007.GB27744@arm.com>
In-Reply-To: <20181206132007.GB27744@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 6 Dec 2018 15:31:49 +0100
Message-ID: <CADYN=9KpSP3n=g=M3+217MVs-OXMBJzcUqAPrh7Jm-b8_aH3TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before ftrace_modify_all_code()
To:     Will Deacon <will.deacon@arm.com>
Cc:     rostedt@goodmis.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 14:19, Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > It has been reported that ftrace_replace_code() which is called by
> > ftrace_modify_all_code() can cause a soft lockup warning for an
> > allmodconfig kernel. This is because all the debug options enabled
> > causes the loop in ftrace_replace_code() (which loops over all the
> > functions being enabled where there can be 10s of thousands), is too
> > slow, and never schedules out.
> >
> > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > ftrace_replace_code() will make it call cond_resched() in the loop,
> > which prevents the soft lockup warning from triggering.
> >
> > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> >
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 57e962290df3..9a8de0a79f97 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >
> >  void arch_ftrace_update_code(int command)
> >  {
> > +     command |= FTRACE_SCHEDULABLE;
> >       ftrace_modify_all_code(command);
> >  }
>
> Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> on that hill so...
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> Thanks, Steve!
>
> Will
