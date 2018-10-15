Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66961C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084A92089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivoTqR4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084A92089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPFHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:07:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38144 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeJPFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:07:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so8100165ywa.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ME582DcDp099P/VepQ5EsfKF5/szu4h5ONCvAltxSQ=;
        b=ivoTqR4qtzlgg+pJ88QH6xdBJPbmz6MzFiauf/hjtN0d2s6i6H5v8vGSocW/16z+xu
         bFLVBMM6VM29BwmSaTprJHDE54NqZpkZp0N4sjvdzKKWDcvY/NzjoZHioG8bUojRNWPH
         ygyxKh858mbHtf8DdRl08lsQmh1QrD1ewuX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ME582DcDp099P/VepQ5EsfKF5/szu4h5ONCvAltxSQ=;
        b=Z4o4CTP5CgqBn2+9tI529eO93qtaPWQlpwera5PtVees3Tl34AUP9vKEWGW/bO6qor
         BJFtbsTw2tt1E3ltV7Rfv2v/Dm+fzCp6pKznRMNKQZQlpV9vIA5yC1IhEPcv9G1fKBtJ
         5docfXvc2ihR80N2Uk75GsayjuceiOR/2hBzuALt72JzJ3TxONh02rFkgt1lrvLWpjeF
         jcPxjQLl+0Ue7mdhJF752P9gfuZL++6H7rYpR/GjPukwJuFpIFHXCwRRTLJa8TlzVqJl
         ocUlTz1dG4SoD+yIMsmzvV0JMdHV5pU+cPou4uKtdDp3GycBCMBvayHErZOz+6Ftwujp
         +sQQ==
X-Gm-Message-State: ABuFfoiHDcHi6yFjlHVvYHZkRsHwh11QReRvf9UQPpN1Srh32zgUeQgr
        9Qomic5YqD4TGO857uwasjf97E7iD9I=
X-Google-Smtp-Source: ACcGV61qaqWEyi+TvslHQW5cTa3eF9YldCGgZg1b4hQEnQyMiAL9uj24wZ7Ysb8DMXNc3IeO5YGn6w==
X-Received: by 2002:a81:b3c2:: with SMTP id r185-v6mr10380388ywh.346.1539638418338;
        Mon, 15 Oct 2018 14:20:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id q6-v6sm2845581ywh.41.2018.10.15.14.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:20:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e190-v6so8070740ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:20:16 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr10251338ybk.209.1539638416456;
 Mon, 15 Oct 2018 14:20:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:20:15
 -0700 (PDT)
In-Reply-To: <20181015162817.a7egfo4hutzi3cah@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io> <20181015105544.4395-3-christian@brauner.io>
 <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com> <20181015162817.a7egfo4hutzi3cah@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:20:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKSnmcrmOCcuNKX39tx6_p0EY4GBtvpeK=g7PxUg1LJTA@mail.gmail.com>
Message-ID: <CAGXu5jKSnmcrmOCcuNKX39tx6_p0EY4GBtvpeK=g7PxUg1LJTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 9:28 AM, Christian Brauner <christian@brauner.io> wrote:
> On Mon, Oct 15, 2018 at 09:11:51AM -0700, Kees Cook wrote:
>> On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
>> > Currently, when writing
>> >
>> > echo 18446744073709551616 > /proc/sys/fs/file-max
>> >
>> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
>> > crashes the system.
>> > This commit explicitly caps the value for file-max to ULONG_MAX.
>> >
>> > Note, this isn't technically necessary since proc_get_long() will already
>> > return ULONG_MAX. However, two reason why we still should do this:
>> > 1. it makes it explicit what the upper bound of file-max is instead of
>> >    making readers of the code infer it from proc_get_long() themselves
>> > 2. other tunebles than file-max may want to set a lower max value than
>> >    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
>> >    such cases too
>> >
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Signed-off-by: Christian Brauner <christian@brauner.io>
>> > ---
>> > v0->v1:
>> > - if max value is < than ULONG_MAX use max as upper bound
>> > - (Dominik) remove double "the" from commit message
>> > ---
>> >  kernel/sysctl.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> > index 97551eb42946..226d4eaf4b0e 100644
>> > --- a/kernel/sysctl.c
>> > +++ b/kernel/sysctl.c
>> > @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
>> >  static int __maybe_unused two = 2;
>> >  static int __maybe_unused four = 4;
>> >  static unsigned long one_ul = 1;
>> > +static unsigned long ulong_max = ULONG_MAX;
>> >  static int one_hundred = 100;
>> >  static int one_thousand = 1000;
>> >  #ifdef CONFIG_PRINTK
>> > @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
>> >                 .maxlen         = sizeof(files_stat.max_files),
>> >                 .mode           = 0644,
>> >                 .proc_handler   = proc_doulongvec_minmax,
>> > +               .extra2         = &ulong_max,
>>
>> Don't we want this capped lower? The percpu comparisons, for example,
>> are all signed long. And there is at least this test, which could
>> overflow:
>>
>>         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
>>                 goto out;
>
> Does that check even make sense?
> Commit 518de9b39e854542de59bfb8b9f61c8f7ecf808b made get_max_files()
> return a long to bump the number of allowed files to more than 2^31.
>
> But assuming a platform where an unsigned long is 64bit which is what
> get_max_files() returns and atomic_long_read() is 64bit too this is
> guaranteed to overflow, no?  So I'm not clear what this is trying to do.
> Seems this should simply be:
>
> if (atomic_long_read(&unix_nr_socks) > get_max_files())
>         goto out;
>
> or am I missing a crucial point?
>
>>
>> Seems like max-files should be  SLONG_MAX / 2 or something instead?
>
> Hm. Isn't that a bit low? Iiuc, this would mean cutting the maximum
> number of open files in half? If at all shouldn't it be LONG_MAX?

LONG_MAX would align us with the values in the percpu stuff. I'm
really not sure what's happening in the sock check, but it's prone to
an unsigned multiplication overflow, if I'm reading it right. Probably
should just be a separate bug fix:

-         if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
+         if (atomic_long_read(&unix_nr_socks) / 2 > get_max_files())

-Kees

>
>>
>> >         },
>> >         {
>> >                 .procname       = "nr_open",
>> > @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>> >                                 break;
>> >                         if (neg)
>> >                                 continue;
>> > +                       if (max && val > *max)
>> > +                               val = *max;
>> >                         val = convmul * val / convdiv;
>> >                         if ((min && val < *min) || (max && val > *max))
>> >                                 continue;
>> > --
>> > 2.17.1
>> >
>>
>> -Kees
>>
>> --
>> Kees Cook
>> Pixel Security



-- 
Kees Cook
Pixel Security
