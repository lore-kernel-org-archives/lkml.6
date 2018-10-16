Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6124F2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cDCZDWjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6124F2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJPW27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:28:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43484 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPW27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:28:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so25832608wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/b/VpRIMyt3d5syFDpQF8Qn4inxj6fdr/3ctOJsFyU=;
        b=cDCZDWjqQrGj5Dg1EulhXBvAAWJfiNkoVhtJt1xBn21hfBF+JyojZseELQ/f4jf0Lo
         JujlSmeErR+BG/XbrH0MX59wwFGtbimTITOOZPgqUfgiQErX0+U3JNBnyq7PG/IaNZZb
         9eLe4udG8aTcJfgx1NmvnDRcG4x6LDoC9rkTjR/+1cO0b+TBjKzVQWN1vygYtlGOHqEm
         OlqMGTgoXoMyWXyVs20JiLmArD6YK5Q184tbWamjxu2dAM/B18dbwT6HxEm/MF+J93Ap
         CqWVTzhrsrySB3idniCDAzaJnE8fnlYSjPODqsJlBOi5F2BhtSMM+tFKOpTSlmuXrIVz
         9f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/b/VpRIMyt3d5syFDpQF8Qn4inxj6fdr/3ctOJsFyU=;
        b=rsYZ8V2ezuNErP3JStCO0w2kKbRNIxzY+3MwaLzTighs7SSZhwoYU2+6ohH6Dehlhq
         8J6eJJLOBkRS6AyxhiizKTxP6jvxo/bp1X+fZSOfGVRAfQwXbZSLv6ecqfpy7w52R0jM
         zUzWGis4BJbde3NcInvAJDJ4nyG46CJCG6MKarN2nG9ky0UyvOuCNQnqdQU620N6cDVm
         XTVJmePOxuhA6ulS1sBo+xFUFfIYzWq3xuFeLxkpitXe3uten3e7iRqxw/CbkuJFZ2hF
         yJx9N9aT4ufEUbB5r1XZp0TsSvY4Wipo19c6evGIOgzdatKZGahtv83eu8vEFq1AXvEB
         035w==
X-Gm-Message-State: ABuFfojsMzZpW6wNuYNL23eOeKuXEvWAX1MiCkob0xC6ffrW31TuS1m2
        n7JTLBugr7vhS0QEiYo30jd+bQ==
X-Google-Smtp-Source: ACcGV60/DqPTXX1HjYcYOxQARxg/q0bpOu4fsdOowkvONwuNPBu4ybyI3yBvBlZE/DHvKFn66gi8+w==
X-Received: by 2002:a5d:5210:: with SMTP id j16-v6mr17918959wrv.290.1539700691979;
        Tue, 16 Oct 2018 07:38:11 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id 201-v6sm11614679wmf.30.2018.10.16.07.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 07:38:11 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:38:05 +0200
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
Message-ID: <20181016143803.ijubb3w7j4nn4oyw@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
 <20181015162817.a7egfo4hutzi3cah@brauner.io>
 <CAGXu5jKSnmcrmOCcuNKX39tx6_p0EY4GBtvpeK=g7PxUg1LJTA@mail.gmail.com>
 <20181016131621.ebtkabyzvfqkh3s6@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016131621.ebtkabyzvfqkh3s6@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:16:21PM +0200, Christian Brauner wrote:
> On Mon, Oct 15, 2018 at 02:20:15PM -0700, Kees Cook wrote:
> > On Mon, Oct 15, 2018 at 9:28 AM, Christian Brauner <christian@brauner.io> wrote:
> > > On Mon, Oct 15, 2018 at 09:11:51AM -0700, Kees Cook wrote:
> > >> On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> > >> > Currently, when writing
> > >> >
> > >> > echo 18446744073709551616 > /proc/sys/fs/file-max
> > >> >
> > >> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > >> > crashes the system.
> > >> > This commit explicitly caps the value for file-max to ULONG_MAX.
> > >> >
> > >> > Note, this isn't technically necessary since proc_get_long() will already
> > >> > return ULONG_MAX. However, two reason why we still should do this:
> > >> > 1. it makes it explicit what the upper bound of file-max is instead of
> > >> >    making readers of the code infer it from proc_get_long() themselves
> > >> > 2. other tunebles than file-max may want to set a lower max value than
> > >> >    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> > >> >    such cases too
> > >> >
> > >> > Cc: Kees Cook <keescook@chromium.org>
> > >> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > >> > ---
> > >> > v0->v1:
> > >> > - if max value is < than ULONG_MAX use max as upper bound
> > >> > - (Dominik) remove double "the" from commit message
> > >> > ---
> > >> >  kernel/sysctl.c | 4 ++++
> > >> >  1 file changed, 4 insertions(+)
> > >> >
> > >> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > >> > index 97551eb42946..226d4eaf4b0e 100644
> > >> > --- a/kernel/sysctl.c
> > >> > +++ b/kernel/sysctl.c
> > >> > @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> > >> >  static int __maybe_unused two = 2;
> > >> >  static int __maybe_unused four = 4;
> > >> >  static unsigned long one_ul = 1;
> > >> > +static unsigned long ulong_max = ULONG_MAX;
> > >> >  static int one_hundred = 100;
> > >> >  static int one_thousand = 1000;
> > >> >  #ifdef CONFIG_PRINTK
> > >> > @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> > >> >                 .maxlen         = sizeof(files_stat.max_files),
> > >> >                 .mode           = 0644,
> > >> >                 .proc_handler   = proc_doulongvec_minmax,
> > >> > +               .extra2         = &ulong_max,
> > >>
> > >> Don't we want this capped lower? The percpu comparisons, for example,
> > >> are all signed long. And there is at least this test, which could
> > >> overflow:
> > >>
> > >>         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
> > >>                 goto out;
> > >
> > > Does that check even make sense?
> > > Commit 518de9b39e854542de59bfb8b9f61c8f7ecf808b made get_max_files()
> > > return a long to bump the number of allowed files to more than 2^31.
> > >
> > > But assuming a platform where an unsigned long is 64bit which is what
> > > get_max_files() returns and atomic_long_read() is 64bit too this is
> > > guaranteed to overflow, no?  So I'm not clear what this is trying to do.
> > > Seems this should simply be:
> > >
> > > if (atomic_long_read(&unix_nr_socks) > get_max_files())
> > >         goto out;
> > >
> > > or am I missing a crucial point?
> > >
> > >>
> > >> Seems like max-files should be  SLONG_MAX / 2 or something instead?
> > >
> > > Hm. Isn't that a bit low? Iiuc, this would mean cutting the maximum
> > > number of open files in half? If at all shouldn't it be LONG_MAX?
> > 
> > LONG_MAX would align us with the values in the percpu stuff. I'm
> > really not sure what's happening in the sock check, but it's prone to
> > an unsigned multiplication overflow, if I'm reading it right. Probably
> > should just be a separate bug fix:
> > 
> > -         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
> > +         if (atomic_long_read(&unix_nr_socks) / 2 > get_max_files())
> 
> Yeah, as I said before this is just waiting for an overflow and it seems
> this bug has existed since the switch to git. The intention apparently
> was indeed to allow the number of sockets to be double the open file
> limit. However, as it is right now this just overflows. I'll send a
> separate patch for this but I'd sugest to do something like:
> 

Forget that. I'm obviously overcomplicating things that are supposed to
be simple.

> 
> > 
> > -Kees
> > 
> > >
> > >>
> > >> >         },
> > >> >         {
> > >> >                 .procname       = "nr_open",
> > >> > @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> > >> >                                 break;
> > >> >                         if (neg)
> > >> >                                 continue;
> > >> > +                       if (max && val > *max)
> > >> > +                               val = *max;
> > >> >                         val = convmul * val / convdiv;
> > >> >                         if ((min && val < *min) || (max && val > *max))
> > >> >                                 continue;
> > >> > --
> > >> > 2.17.1
> > >> >
> > >>
> > >> -Kees
> > >>
> > >> --
> > >> Kees Cook
> > >> Pixel Security
> > 
> > 
> > 
> > -- 
> > Kees Cook
> > Pixel Security
