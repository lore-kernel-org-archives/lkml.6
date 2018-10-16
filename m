Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BXlCMplr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BC12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJPXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:43:29 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18199 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:43:29 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9GFqHmG016345;
        Wed, 17 Oct 2018 00:52:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9GFqHmG016345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539705138;
        bh=XefGj7/n/aOxKKMyVxV/oEy4zF+cdmEGiZE4AQEAsao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BXlCMplrlPVdIYIwLRBftVXZD0oGgPId4NZ05PsukI8tKmaa2Z3LTefkD/bD5aybW
         BHIa48/ss+A0rkwXCcOjqC8tn5/idmkJBdEE6GcUKLLo05b2pXJSBYnYgF9MjiN4YH
         banG0tSgZTk318ozVJyLII8OQAxeY5rFdWaV0jMfCpgVC1SP6EuaM4COXNrIyJmJy4
         Gne/W/u0gXsMl33PzwavnplfpHvtPtgnQeKjynxHzktThPH2ip9k5Rl4jb4+EcDT6P
         jwcEu2c/59zxHT+Wm7bbF2WUIsr0MjPy8Pz6k6ZoRiQ1aVRvg0wSmtnmufnguum1dP
         TohQzpVbp+w5Q==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id y195so3008405vsc.7;
        Tue, 16 Oct 2018 08:52:17 -0700 (PDT)
X-Gm-Message-State: ABuFfohienZ9IX0sf3f24HaE4Q0YCTw7UkEgcEYf95gv5BtcaDvIesbZ
        kPR2+Yve/Jep20onk2Q7WdR+/+rIb6usmKd99JU=
X-Google-Smtp-Source: ACcGV60zNDVeV6aYvCVfIZ92VTG0K1OTGmO2w+IkFitHAa42MsVL2hsGtJ6xICGRw8X2hAV/2iovKWvhj1nu3pztGhc=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr9159390vsb.54.1539705136853;
 Tue, 16 Oct 2018 08:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com> <20181016142540.pxlwu3ft6n2b4pgj@treble>
In-Reply-To: <20181016142540.pxlwu3ft6n2b4pgj@treble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 00:51:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARLW4NmeY0Rq19Bj_5kOFbp6YDtsUDhNaAfVXjL85cAMg@mail.gmail.com>
Message-ID: <CAK7LNARLW4NmeY0Rq19Bj_5kOFbp6YDtsUDhNaAfVXjL85cAMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] objtool: move libelf check out of top Makefile
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:25 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Oct 16, 2018 at 06:10:52PM +0900, Masahiro Yamada wrote:
> > Another behavioral change is, missing libelf for CONFIG_STACK_VALIDATION
> > was previously a warning, but now a error.
>
> This behavioral change should be fine.  It was already an error for
> UNWINDER_ORC, so this would only upgrade a warning to an error for
> people using STACK_VALIDATION without ORC, which should be a small
> number of people by this point.
>
> > diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
> > index f3c165d..bc26fc0 100644
> > --- a/scripts/Makefile.toolcheck
> > +++ b/scripts/Makefile.toolcheck
> > @@ -12,6 +12,11 @@ include include/config/auto.conf
> >  __toolcheck:
> >       @:
> >
> > +chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> > +msg_stack_validation = "libelf is necessary for building the objtool." \
> > +                    "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> > +toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
> > +
> >  PHONY += $(toolcheck-y)
> >  __toolcheck: $(toolcheck-y)
>
> This is a nice improvement.
>
> It would probably be a good idea to clarify to the user which config
> option(s) are the cause for the error, by putting
> "CONFIG_STACK_VALIDATION" in the error string, for example.
>
> Though, for this particular case, it would be clearer to have a
> different error, based on which option is enabled, like we had before.
>
> Like:
>
>
> ifdef CONFIG_UNWINDER_ORC
>
> chk_unwinder_orc = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> msg_unwinder_orc = "Cannot build objtool to generate ORC metadata for CONFIG_UNWINDER_ORC=y.  " \
>                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> toolcheck-$(CONFIG_UNWINDER_ORC) += unwinder_orc
>
> else
>
> chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> msg_stack_validation = "Cannot build objtool for CONFIG_STACK_VALIDATION=y.  " \
>                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
>
> endif
>
>
> What do you think?


It is ugly.

Do you need such detailed information like ORC metadata stuff here?

This Makefile aims to error out, showing why the build failed.
That's it.



-- 
Best Regards
Masahiro Yamada
