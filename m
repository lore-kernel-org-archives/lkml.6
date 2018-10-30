Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3792082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qf6j8Pgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3792082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeJaGzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:55:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44195 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJaGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:55:36 -0400
Received: by mail-yb1-f195.google.com with SMTP id p144-v6so5730427yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ie4VEMtorXQzSuqf1DMphjdt24z9SzsJCLFEUF8pqJk=;
        b=Qf6j8PgyPsdDibELN7LhE60q/nYfcoMtfME6YiCSuLGerkM6SonG2Votfi6A+HcLN3
         x+4qug/94+TwVg/E9y5v9YZ/UC0jfgl6eSyLZhnayGySnVwa8Fp4nkp32lXcZIrmvp0L
         wUcc+iBOUaQqqOd5e4bIpc0rDNP33bnVlxFu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ie4VEMtorXQzSuqf1DMphjdt24z9SzsJCLFEUF8pqJk=;
        b=Xkc/LFYOF79sYo49Ggk2/O9XxDxoE97gxFex3oKDoxEN6/o5WOvCH7pf7iKd4ludJF
         M4t2xwlVgrekd9RCy3elOSXbuzYmISxRBwtVqCQqeCheXWaMGcGDCWktoymVtRGedi0H
         23qwSgMSCJWyftEKHHrhwQIlH6fhhuBLYfS66+iIifmJwdRux53TZ7z33kWrwB7hkck0
         rnsbNLqtWbCQxtLOrMgResnn1pK9UvOm2CkD5x7r9iox9cpXfRc10JUHFW+AG5o5HtgI
         0NgsHf/jljO0PhQuzflIA3LjelS6z6/zRFsiJEefnWyXWEwxoAutevsjuVk5xbwcCfTC
         rZEg==
X-Gm-Message-State: AGRZ1gI4/OsgPvDWfL/e6IJ9dhReGYbvSbf4BsoIX4b7D2DX1BGNXiQJ
        2SD/qZA/hmIrjLPlmDFqHxmrwi14cDc=
X-Google-Smtp-Source: AJdET5dBnRMb5ZkR32k4cDZqZT9BFMM6BmutlhQIDtmRoS7/ypGnmROuyBM4JGDeON2S9EGAPYNACg==
X-Received: by 2002:a25:578b:: with SMTP id l133-v6mr560442ybb.3.1540936822021;
        Tue, 30 Oct 2018 15:00:22 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id v19-v6sm9885683ywv.19.2018.10.30.15.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:00:19 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id d126-v6so5604267ywa.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:00:19 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr574179ywd.288.1540936818774;
 Tue, 30 Oct 2018 15:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 15:00:17
 -0700 (PDT)
In-Reply-To: <20181030215404.GF7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws> <20181029224031.29809-2-tycho@tycho.ws>
 <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com> <20181030215404.GF7343@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 15:00:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com>
Message-ID: <CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 2:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Tue, Oct 30, 2018 at 02:49:21PM -0700, Kees Cook wrote:
>> On Mon, Oct 29, 2018 at 3:40 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> >     * switch to a flags based future-proofing mechanism for struct
>> >       seccomp_notif and seccomp_notif_resp, thus avoiding version issues
>> >       with structure length (Kees)
>> [...]
>> >
>> > +struct seccomp_notif {
>> > +       __u64 id;
>> > +       __u32 pid;
>> > +       __u32 flags;
>> > +       struct seccomp_data data;
>> > +};
>> > +
>> > +struct seccomp_notif_resp {
>> > +       __u64 id;
>> > +       __s64 val;
>> > +       __s32 error;
>> > +       __u32 flags;
>> > +};
>>
>> Hrm, so, what's the plan for when struct seccomp_data changes size?
>
> I guess my plan was don't ever change the size again, just use flags
> and have extra state available via ioctl().
>
>> I'm realizing that it might be "too late" for userspace to discover
>> it's running on a newer kernel. i.e. it gets a user notification, and
>> discovers flags it doesn't know how to handle. Do we actually need
>> both flags AND a length? Designing UAPI is frustrating! :)
>
> :). I don't see this as such a big problem -- in fact it's better than
> the length mode, where you don't know what you don't know, because it
> only copied as much info as you could handle. Older userspace would
> simply not use information it didn't know how to use.
>
>> Do we need another ioctl to discover the seccomp_data size maybe?
>
> That could be an option as well, assuming we agree that size would
> work, which I thought we didn't?

Size alone wasn't able to determine the layout of the seccomp_notif
structure since it had holes (in the prior version). seccomp_data
doesn't have holes and is likely to change in size (see the recent
thread on adding the MPK register to it...)

I'm trying to imagine the right API for this. A portable user of
seccomp_notif expects the id/pid/flags/data to always be in the same
place, but it's the size of seccomp_data that may change. So it wants
to allocate space for seccomp_notif header and "everything else", of
which is may only understand the start of seccomp_data (and ignore any
new trailing fields).

So... perhaps the "how big are things?" ioctl would report the header
size and the seccomp_data size. Then both are flexible. And flags
would be left as a way to "version" the header?

Any Linux API list members want to chime in here?

-- 
Kees Cook
