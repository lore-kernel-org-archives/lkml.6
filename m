Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A097C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B92145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUb14pqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23B92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeLAE16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:27:58 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46294 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLAE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:27:58 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so2552895ywe.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QkzUvpQuJ8ST4pylyvDHIiPnZIKJ3MooKGdce0pdQ0w=;
        b=HUb14pqW3xOlVjm+6lWQd/ZwKcC5V76i+K/+bOfHw4eVCu2Jpb0IFgvszRTm7CTbO6
         +jshAgHfYrgcnINhwn5zze8ZNQsaDzhQxOvztPCcr+ii5zat0KpjqiUpJ0nO+qf4zQkA
         qmBVX+3acnqilv6kGmLezK35ANQNfYT5pQOjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QkzUvpQuJ8ST4pylyvDHIiPnZIKJ3MooKGdce0pdQ0w=;
        b=AFHC8Oc8Ca8qz9FSGXQC+IAfwbZ/WHtiDpKl6liVeBSl/uqGxsrPtp6RX4ktLA5WKM
         D4sqJkZ9XYErqMIQR1vIdAXyIzb5zR9PwLBebI3/ucxWpOymZVNBWj7Der5DSVprdIi1
         1ICxDuoA55HtDV2Y7MbCMAT1cTlvpJ4FzTScsSdk8PpVlqTA9Xh1HLCc3U12BBdc+aqX
         BV4XepJwS3TlFUyB5/NkfCWSh1TiOM2a/KB99I/GfHj9MEP6cHmQhq8FO50wSTus/zVI
         L2bniiE6PQOauJyW6UGBwvWm8t6KUvtg2R8PGXid9yxxOmXUXwSOtrdBdOeDLCHZIvoH
         UVLw==
X-Gm-Message-State: AA+aEWaxZYeYUk72QDlItsm1oegcXH2A1fyms1jr8CGFRpyLTGfhSpMX
        kOeyUdWFqIX0NS69Ynv5FxdSKOfYpT8=
X-Google-Smtp-Source: AFSGD/UsH1fDSxg6+3MH/NWOpVFGKmlRWHdJV+Xr8nvaE+karerCP2EAWnvUxtrH5EM84x19khtF8w==
X-Received: by 2002:a81:b2c8:: with SMTP id q191-v6mr6338806ywh.313.1543598278565;
        Fri, 30 Nov 2018 09:17:58 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j6sm1713188ywi.110.2018.11.30.09.17.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:17:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id a67-v6so2514021ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:17:58 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr6336927ybc.421.1543597957550;
 Fri, 30 Nov 2018 09:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1543583987-27948-1-git-send-email-alex.popov@linux.com> <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 30 Nov 2018 09:12:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
Message-ID: <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the 'mach' pass
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        amonakov@ispras.ru, Tycho Andersen <tycho@tycho.ws>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        gcc@gcc.gnu.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 30, 2018 at 5:20 AM Alexander Popov <alex.popov@linux.com> wr=
ote:
> >
> > Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
> > after the 'reload' pass. That allows gcc to do some weird optimization =
in
> > function prologues and epilogues, which are generated later [1].
> >
> > Let's avoid that by registering the 'stackleak_cleanup' pass before
> > the 'mach' pass, which performs the machine dependent code transformati=
ons.
> > It's the moment when the stack frame size is final and function prologu=
es
> > and epilogues are already generated.
> >
> > [1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
>
> Thanks, applied!

Eek, no, this is breaking my build badly:

*** WARNING *** there are active plugins, do not report this as a bug
unless you can reproduce it without enabling any plugins.
Event                            | Plugins
PLUGIN_START_UNIT                | stackleak_plugin
kernel/exit.c: In function =E2=80=98release_task=E2=80=99:
kernel/exit.c:228:1: internal compiler error: Segmentation fault
 }

Failing with:

gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

-Kees

>
> -Kees
>
> > ---
> >  scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugi=
ns/stackleak_plugin.c
> > index 2f48da9..6f41b32 100644
> > --- a/scripts/gcc-plugins/stackleak_plugin.c
> > +++ b/scripts/gcc-plugins/stackleak_plugin.c
> > @@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args=
 *plugin_info,
> >                                                 PASS_POS_INSERT_BEFORE)=
;
> >
> >         /*
> > -        * The stackleak_cleanup pass should be executed after the
> > -        * "reload" pass, when the stack frame size is final.
> > +        * The stackleak_cleanup pass should be executed before the "ma=
ch"
> > +        * pass, which performs the machine dependent code transformati=
ons.
> > +        * It's the moment when the stack frame size is already final a=
nd
> > +        * function prologues and epilogues are generated.
> >          */
> > -       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER=
);
> > +       PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE)=
;
> >
> >         if (!plugin_default_version_check(version, &gcc_version)) {
> >                 error(G_("incompatible gcc/plugin versions"));
> > --
> > 2.7.4
> >
>
>
> --
> Kees Cook



--=20
Kees Cook
