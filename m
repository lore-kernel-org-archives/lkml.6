Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23092073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZojv/KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23092073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI2FA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:00:26 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41339 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeI2FA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:00:26 -0400
Received: by mail-yb1-f195.google.com with SMTP id d14-v6so3331847ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kc+xotBuieQLVo8qummA7HdgBUNE8UPl/HeS/sepKgw=;
        b=mZojv/KEZw6rscD0hNmSSUW3hAbAj4sPS6jGhaWRrPozf1phGUthK35UH17m/jvd6x
         UYFh4IaNVj4nCXQpiO7QVe039ih24wvbmwvfNKk8F4X5vD06lrDnOM4sNd5W8qKdaROT
         90G1N+tPDeOlbHTpLQR1zqpOd9fK/SF9Bsz88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kc+xotBuieQLVo8qummA7HdgBUNE8UPl/HeS/sepKgw=;
        b=TWEFelRdN22cQ++zYoJ+psrUhPaBU5IljLQrgJm+qT8DfneaWbNRSTa22OGUu9s71y
         0Y9tIwNrRec/TBYBT2nm6MzJb/z6aISqdE2i6aBcHK7tLCGHrFHX9jUKOqKuRg2OopIx
         kh1xM8wawCjDBMszV9vJJTnh0f2Yb1S1OiEctvKZLpsgGpm4C5evL6Ro/RuKxGm1vu+f
         Sr3747H2ylZEJIh8agC5jgZXGmBh7NobqOXtrd7tlseQR1zAVUh0xyhIdsYbiuUrJmO7
         rx+7gzoQoyrN9k6jLSsHeCg46JrCQps0Rgtqn79C9LaT2sZkuMW6+o1gWm68MZFFD6jO
         dCyQ==
X-Gm-Message-State: ABuFfohELDKIN4+Fbha+SHMicMlGcVTbolXRfCWjlFEfr0DkadXqs4uc
        noJlw8KT61U8fycAPZ7AdkIQDDPkHEs=
X-Google-Smtp-Source: ACcGV61rbvELCeH06S6k3aJ7Wu1b1msx2NMFcZwGapD49YAGgSvmghUYO8VEyAuEOKpLS1xZoJDxwA==
X-Received: by 2002:a25:5406:: with SMTP id i6-v6mr408036ybb.71.1538174073604;
        Fri, 28 Sep 2018 15:34:33 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 140-v6sm2450869ywt.71.2018.09.28.15.34.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:34:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o63-v6so3347964yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:34:32 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr394175ybg.171.1538174071972;
 Fri, 28 Sep 2018 15:34:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 15:34:31
 -0700 (PDT)
In-Reply-To: <CAKgNAkgcHENKrT=n4_YbmxJCOaY2Z+SXJcfuw9j7uOJwgym3Dg@mail.gmail.com>
References: <20180927151119.9989-1-tycho@tycho.ws> <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
 <20180928220359.GF18045@cisco.lan> <CAKgNAkgcHENKrT=n4_YbmxJCOaY2Z+SXJcfuw9j7uOJwgym3Dg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 15:34:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+GTwOZnNscfMmArxxJgNvPETgBns1Y6u11tapkoOwn+w@mail.gmail.com>
Message-ID: <CAGXu5j+GTwOZnNscfMmArxxJgNvPETgBns1Y6u11tapkoOwn+w@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        lkml <linux-kernel@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:16 PM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Hi Tycho,
>
> On Sat, 29 Sep 2018 at 00:04, Tycho Andersen <tycho@tycho.ws> wrote:
>>
>> On Fri, Sep 28, 2018 at 11:57:40PM +0200, Michael Kerrisk (man-opages) wrote:
>> > Hi Tycho,
>> >
>> > On 09/27/2018 05:11 PM, Tycho Andersen wrote:
>> > > Hi all,
>> > >
>> > > Here's v7 of the seccomp trap to userspace set. There are various minor
>> > > changes and bug fixes, but two major changes:
>> > >
>> > > * We now pass fds to the tracee via an ioctl, and do it immediately when
>> > >    the ioctl is called. For this we needed some help from the vfs, so
>> > >    I've put the one patch in this series and cc'd fsdevel. This does have
>> > >    the advantage that the feature is now totally decoupled from the rest
>> > >    of the set, which is itself useful (thanks Andy!)
>> > >
>> > > * Instead of putting all of the notification related stuff into the
>> > >    struct seccomp_filter, it now lives in its own struct notification,
>> > >    which is pointed to by struct seccomp_filter. This will save a lot of
>> > >    memory (thanks Tyler!)
>> >
>> > Is there a documentation (man page) patch for this API change?
>>
>> Not yet, but once we decide on a final API I'll prepare one.
>
> Honestly, the production of such documentation should be part of the
> evolution towards the final API...
>
> Documentation is not an afterthought. It's a tool for pushing you, the
> developer (and others, your reviewers) to more deeply consider your
> design.

In Tycho's defense, he did write up documentation in Documentation/
for the feature, so it won't be an afterthought. :) But yes, there's
no manpage delta yet.

-Kees

-- 
Kees Cook
Pixel Security
