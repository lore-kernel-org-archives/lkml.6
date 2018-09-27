Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E6EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD15216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJISzdin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD15216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeI1FhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:37:03 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44476 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:37:02 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5-v6so1857308ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j/CEtSattSH0H6OiJgLkWVvtxI5AY4coi92JfRRXbeg=;
        b=MJISzdinGnvftLHxIYlhxTY0612kfA1/o5vj79Knf8YObHmjjOz4SUbmyKa5FXqm0h
         DwV2xdMOubV9678PHPPs5fXJBmZizIXdhFJBJU5kxkivLZ4fW5xxgMEEXZH7a+Bv+b6O
         8Vgjq7DfagBSmN064F+/xImSfmjuBbjPT+ShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j/CEtSattSH0H6OiJgLkWVvtxI5AY4coi92JfRRXbeg=;
        b=lZ+w6Ouzydn/gNJhstTpPU9y7XCTQgf9CFhBz9aFnMz57K0rS7nt+CNoRcEaJg8dv6
         rgCrPutHPrBx0w/YdR8z0jKBrNFnl0s+uZCT9HP8ss0WYzIUcEbqSDVE7ZDEH3EH5ROv
         OOi9ME3MymdYMSmdai/c8Rcf92qSFW5bZ8pSFjM8Vq74bmgI6Q8FcMGw1CKtZ7yYsXrB
         eF3QZQALIsmy+Ydcu+Yfzu2vWF55eoMq9jtkIIDyAqrcOwBcPY8mCRFxxXHSRPzZSHXl
         +1Jr/Qlhx+dr103IEWEhzJZq7abkO5gx+vz+j3e6dj9uOn9TarMj1lSSietcpZSaoOUD
         QcJQ==
X-Gm-Message-State: ABuFfoh8DdXft20YM9xb00CNtT44c719RfGupQtWW8ovCABZpUFgbaZ1
        ZTtdPm7q5H7Lu75a88HtRt8VUTZ6rv0=
X-Google-Smtp-Source: ACcGV61m4jdcgZIM0LRBHMwSzT+xuehj2HooPrvjqb9/d5ywoEQB5kb/HaES3wOt9pVagbz9kYPt9A==
X-Received: by 2002:a25:ca51:: with SMTP id a78-v6mr7092043ybg.385.1538090177908;
        Thu, 27 Sep 2018 16:16:17 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id s14-v6sm1431491ywa.65.2018.09.27.16.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 16:16:17 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id e201-v6so1851163ywa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:16:17 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr6621053ywf.237.1538089830274;
 Thu, 27 Sep 2018 16:10:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 16:10:29
 -0700 (PDT)
In-Reply-To: <20180927224839.GF15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com> <20180927224839.GF15491@cisco.cisco.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 16:10:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ8VSJ6BqqxAL+B12bv2xTNU3CzpBOMf-zEChO9opaFMA@mail.gmail.com>
Message-ID: <CAGXu5jJ8VSJ6BqqxAL+B12bv2xTNU3CzpBOMf-zEChO9opaFMA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>,
        Stephane Graber <stgraber@ubuntu.com>
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

On Thu, Sep 27, 2018 at 3:48 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
>> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
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
> I'm not sure what you mean by "len won't be sufficient for versioning
> here"? Anyway, I can do some packing on these; I didn't bother before
> since I figured it's a userspace interface, so saving a few bytes
> isn't a huge deal.

I was thinking the "len" portion was for determining if the API ever
changes in the future. My point was that given the padding holes, e.g.
adding a u8 after signaled, "len" wouldn't change, so the kernel might
expect to starting reading something after signaled that it wasn't
checking before, but the len would be the same.

>> I have to say, I'm vaguely nervous about changing the semantics here
>> for passing back the fd as the return code from the seccomp() syscall.
>> Alternatives seem less appealing, though: changing the meaning of the
>> uargs parameter when SECCOMP_FILTER_FLAG_NEW_LISTENER is set, for
>> example. Hmm.
>
> From my perspective we can drop this whole thing. The only thing I'll
> ever use is the ptrace version. Someone at some point (I don't
> remember who, maybe stgraber) suggested this version would be useful
> as well.

Well that would certainly change the exposure of the interface pretty
drastically. :)

So, let's talk more about this, as it raises another thought I had
too: for the PTRACE interface to work, you have to know specifically
which filter you want to get notifications for. Won't that be slightly
tricky?

> Anyway, let me know if your nervousness outweighs this, I'm happy to
> drop it.

I'm not opposed to keeping it, but if you don't think anyone will use
it ... we should probably drop it just to avoid the complexity. It's a
cool API, though, so I'd like to hear from others first before you go
tearing it out. ;) (stgraber added to CC)

>> It is possible (though unlikely given the type widths involved here)
>> for unotif = {} to not initialize padding, so I would recommend an
>> explicit memset(&unotif, 0, sizeof(unotif)) here.
>
> Orly? I didn't know that, thanks.

Yeah, it's a pretty annoying C-ism. The spec says that struct
_members_ will get zero-initialized, but it doesn't say anything about
padding. >_< In most cases, the padding gets initialized too, just
because of bit widths being small enough that they're caught in the
member initialization that the compiler does. But for REALLY big
holes, they may get missed. In this case, while the padding is small,
it's directly exposed to userspace, so I want to make it robust.

>> > +       if (copy_from_user(&size, buf, sizeof(size)))
>> > +               return -EFAULT;
>> > +       size = min_t(size_t, size, sizeof(resp));
>> > +       if (copy_from_user(&resp, buf, size))
>> > +               return -EFAULT;
>>
>> For sanity checking on a double-read from userspace, please add:
>>
>>     if (resp.len != size)
>>         return -EINVAL;
>
> Won't that fail if sizeof(resp) < resp.len, because of the min_t()?

Ah, true. In that case, probably do resp.len = size to avoid any logic
failures due to the double-read? I just want to avoid any chance of
confusing the size and actually using it somewhere.

-Kees

-- 
Kees Cook
Pixel Security
