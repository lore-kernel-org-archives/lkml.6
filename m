Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CEC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747B42089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RryKO4nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747B42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJPAOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:14:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35243 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:14:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so20377336wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jzks89GG/HNqn+253ROvUQ3oYQXN2Pef9gPwJyk99ok=;
        b=RryKO4nXIVXfhPPF10goQNEmROlBsJuvqHZP32V2Flc8qSwLZje5qa57DxcDfCcUMg
         gGBtkaedSv733zde7Z5mDmb+c5FpTbfE8UOvNSd5Ma/1WtPWt17VQGEsjz/5qHGyN2Cm
         LMUitxEX8HkNEP9dYr0N3uLg2v9Ybsz53J66ubPciTqCXrGatEipPwb47DpN8xrCcajf
         mwAJB0za4V1cr1Aia7MIgTN68tvpDBas7PyJlefwigvuNBeBiOfwPPEMi8GaTUf3l1LC
         lrYXXvMLF+jxfDOhfZfTUJltlAG/L2bEae7LDjetY6oFoI1nvEAJyA+yhgpLkY1buK7P
         2XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jzks89GG/HNqn+253ROvUQ3oYQXN2Pef9gPwJyk99ok=;
        b=U0TVvhuj+9NYzbzmKN98N2A/ZoEIe+P0wr3uqYqszU92HybgYQP62LHuha8S5jYK10
         7XRd9BPgkBjzbsKehcUKDrcShgjzO6mT2ayjodQhuWmze3Nmo2hkZ/fRKEW/TIPAjMqB
         9zygjtz0QlYRrL0g2l3S86mpjc0lzfQRFCSmWuamPshkJvLkmGDYrponSa23lbDxJ9Yj
         dFkJzsGV8j3EX0lwPCGoldOeZCpKhytwuW1YLAX1IR1GsLk02OVIB4UMaAnlWZNj/ur1
         GRyRgOlpFkoMam1EeSqtyeefFgcUbYpFEaYXnngy9ABRRD47HPtJlVgRNlP6l4aTGPOQ
         kh4Q==
X-Gm-Message-State: ABuFfohCI8XYnL//ewkFudaHm0Cs5McjuJwPJccOWY4pgWyLPTVQhAFK
        kFF7yAQbkgyhus1tgUiwB/9gyQ==
X-Google-Smtp-Source: ACcGV60hol1CwtfAyti3qEUQBdUzlR+LtMZAtlcVtHZeUe1CT6ZV4jdo40sIciqhjdvOAuHpPGLxeA==
X-Received: by 2002:a1c:607:: with SMTP id 7-v6mr13402838wmg.103.1539620905207;
        Mon, 15 Oct 2018 09:28:25 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id 130-v6sm10213527wmn.7.2018.10.15.09.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:28:24 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:28:18 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
Message-ID: <20181015162817.a7egfo4hutzi3cah@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:11:51AM -0700, Kees Cook wrote:
> On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> > Currently, when writing
> >
> > echo 18446744073709551616 > /proc/sys/fs/file-max
> >
> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > crashes the system.
> > This commit explicitly caps the value for file-max to ULONG_MAX.
> >
> > Note, this isn't technically necessary since proc_get_long() will already
> > return ULONG_MAX. However, two reason why we still should do this:
> > 1. it makes it explicit what the upper bound of file-max is instead of
> >    making readers of the code infer it from proc_get_long() themselves
> > 2. other tunebles than file-max may want to set a lower max value than
> >    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> >    such cases too
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v0->v1:
> > - if max value is < than ULONG_MAX use max as upper bound
> > - (Dominik) remove double "the" from commit message
> > ---
> >  kernel/sysctl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 97551eb42946..226d4eaf4b0e 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> >  static int __maybe_unused two = 2;
> >  static int __maybe_unused four = 4;
> >  static unsigned long one_ul = 1;
> > +static unsigned long ulong_max = ULONG_MAX;
> >  static int one_hundred = 100;
> >  static int one_thousand = 1000;
> >  #ifdef CONFIG_PRINTK
> > @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> >                 .maxlen         = sizeof(files_stat.max_files),
> >                 .mode           = 0644,
> >                 .proc_handler   = proc_doulongvec_minmax,
> > +               .extra2         = &ulong_max,
> 
> Don't we want this capped lower? The percpu comparisons, for example,
> are all signed long. And there is at least this test, which could
> overflow:
> 
>         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
>                 goto out;

Does that check even make sense? 
Commit 518de9b39e854542de59bfb8b9f61c8f7ecf808b made get_max_files()
return a long to bump the number of allowed files to more than 2^31.

But assuming a platform where an unsigned long is 64bit which is what
get_max_files() returns and atomic_long_read() is 64bit too this is
guaranteed to overflow, no?  So I'm not clear what this is trying to do.
Seems this should simply be:

if (atomic_long_read(&unix_nr_socks) > get_max_files())
        goto out;

or am I missing a crucial point?

> 
> Seems like max-files should be  SLONG_MAX / 2 or something instead?

Hm. Isn't that a bit low? Iiuc, this would mean cutting the maximum
number of open files in half? If at all shouldn't it be LONG_MAX?

> 
> >         },
> >         {
> >                 .procname       = "nr_open",
> > @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >                                 break;
> >                         if (neg)
> >                                 continue;
> > +                       if (max && val > *max)
> > +                               val = *max;
> >                         val = convmul * val / convdiv;
> >                         if ((min && val < *min) || (max && val > *max))
> >                                 continue;
> > --
> > 2.17.1
> >
> 
> -Kees
> 
> -- 
> Kees Cook
> Pixel Security
