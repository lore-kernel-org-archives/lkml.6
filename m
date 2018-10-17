Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97332087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CiGm4d/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97332087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJRGSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:18:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44377 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:18:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id s73-v6so11018578ywg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0QvfOGpY4Lr0IaYv4IG8Gp33uCMmI3lehoP8d12qAvQ=;
        b=CiGm4d/J/HWm8NrvDOYqfVFXeFDCp/SBlPxBmCn2KDj8C0G1he0kf4O3YQ8ZBINMQW
         O4n1AB2vfbqk7Y2Hz98gKhHKOWRrWlvjbM8Ua0Sds35s0BN59tROgJC1p9WlsqOxEz+3
         gx3HLbVeW5+J5LQGdEVEKjWd6U4a+W3n0jwf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0QvfOGpY4Lr0IaYv4IG8Gp33uCMmI3lehoP8d12qAvQ=;
        b=Ip/RuPAkKWN5ymXqLE8PwW5D3JGMLMLxMDoa0Ej2zJgu2SE6vXWHKodSa+/avXGEFR
         EDQfuK3HAWjRSF5/ZCVZkUQL5uCMAgBjQPCNHjlGyZLmtYeBEkKThsGbxsCAqRLzCxPK
         aT526YM9aShAGqjGple1Ytqoe46ppRbt8ewk7HTCjywP7nE7joY/82CZub9kJmV0py2B
         Q1iS+3OcoCrccTv9QCvsk9wGk4LbsQa585u7+56aqqTdpYiqE8QBIRU8v8jhk7+5v/0O
         0gB3It0g8CBiDO4OmqH26VXdCdphow3RC6ebF3gLR7BG4z8HfJN/tlYURZR2R5WpqZB+
         afaA==
X-Gm-Message-State: ABuFfoj4qsV6sDF+t+0+RW467whEv/LtTlkQmbM9fwtKTcUPHvrLAVFb
        joKKXQFQO2K1ayBrRuAA0vOJL91WwxE=
X-Google-Smtp-Source: ACcGV62XxrWGsjY6SYeBz/Y56kTLu7k3+qfOkw2dR8X3drb2+fhrtqUPzBc6jtsmWa/gbCLZX2zZCA==
X-Received: by 2002:a81:3088:: with SMTP id w130-v6mr16447901yww.230.1539814866414;
        Wed, 17 Oct 2018 15:21:06 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c128-v6sm7372722ywb.68.2018.10.17.15.21.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:21:04 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 184-v6so11059888ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:21:04 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr17034903yba.141.1539814863826;
 Wed, 17 Oct 2018 15:21:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 15:21:02
 -0700 (PDT)
In-Reply-To: <20181017202933.GB14047@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com> <20181017202933.GB14047@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 15:21:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
Message-ID: <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
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

On Wed, Oct 17, 2018 at 1:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
>> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>> > @@ -60,4 +62,29 @@ struct seccomp_data {
>> >         __u64 args[6];
>> >  };
>> >
>> > +struct seccomp_notif {
>> > +       __u16 len;
>> > +       __u64 id;
>> > +       __u32 pid;
>> > +       __u8 signaled;
>> > +       struct seccomp_data data;
>> > +};
>> > +
>> > +struct seccomp_notif_resp {
>> > +       __u16 len;
>> > +       __u64 id;
>> > +       __s32 error;
>> > +       __s64 val;
>> > +};
>>
>> So, len has to come first, for versioning. However, since it's ahead
>> of a u64, this leaves a struct padding hole. pahole output:
>>
>> struct seccomp_notif {
>>         __u16                      len;                  /*     0     2 */
>>
>>         /* XXX 6 bytes hole, try to pack */
>>
>>         __u64                      id;                   /*     8     8 */
>>         __u32                      pid;                  /*    16     4 */
>>         __u8                       signaled;             /*    20     1 */
>>
>>         /* XXX 3 bytes hole, try to pack */
>>
>>         struct seccomp_data        data;                 /*    24    64 */
>>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
>>
>>         /* size: 88, cachelines: 2, members: 5 */
>>         /* sum members: 79, holes: 2, sum holes: 9 */
>>         /* last cacheline: 24 bytes */
>> };
>> struct seccomp_notif_resp {
>>         __u16                      len;                  /*     0     2 */
>>
>>         /* XXX 6 bytes hole, try to pack */
>>
>>         __u64                      id;                   /*     8     8 */
>>         __s32                      error;                /*    16     4 */
>>
>>         /* XXX 4 bytes hole, try to pack */
>>
>>         __s64                      val;                  /*    24     8 */
>>
>>         /* size: 32, cachelines: 1, members: 4 */
>>         /* sum members: 22, holes: 2, sum holes: 10 */
>>         /* last cacheline: 32 bytes */
>> };
>>
>> How about making len u32, and moving pid and error above "id"? This
>> leaves a hole after signaled, so changing "len" won't be sufficient
>> for versioning here. Perhaps move it after data?
>
> Just to confirm my understanding; I've got these as:
>
> struct seccomp_notif {
>         __u32                      len;                  /*     0     4 */
>         __u32                      pid;                  /*     4     4 */
>         __u64                      id;                   /*     8     8 */
>         __u8                       signaled;             /*    16     1 */
>
>         /* XXX 7 bytes hole, try to pack */
>
>         struct seccomp_data        data;                 /*    24    64 */
>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
>
>         /* size: 88, cachelines: 2, members: 5 */
>         /* sum members: 81, holes: 1, sum holes: 7 */
>         /* last cacheline: 24 bytes */
> };
> struct seccomp_notif_resp {
>         __u32                      len;                  /*     0     4 */
>         __s32                      error;                /*     4     4 */
>         __u64                      id;                   /*     8     8 */
>         __s64                      val;                  /*    16     8 */
>
>         /* size: 24, cachelines: 1, members: 4 */
>         /* last cacheline: 24 bytes */
> };
>
> in the next version. Since the structure has no padding at the end of
> it, I think the Right Thing will happen. Note that this is slightly
> different than what Kees suggested, if I add signaled after data, then
> I end up with:
>
> struct seccomp_notif {
>         __u32                      len;                  /*     0     4 */
>         __u32                      pid;                  /*     4     4 */
>         __u64                      id;                   /*     8     8 */
>         struct seccomp_data        data;                 /*    16    64 */
>         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>         __u8                       signaled;             /*    80     1 */
>
>         /* size: 88, cachelines: 2, members: 5 */
>         /* padding: 7 */
>         /* last cacheline: 24 bytes */
> };
>
> which I think will have the versioning problem if the next member
> introduces is < 7 bytes.

It'll be a problem in either place. What I was thinking was that
specific versioning is required instead of just length.

-Kees

-- 
Kees Cook
Pixel Security
