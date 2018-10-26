Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B5EECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9722085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2+/RaWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9722085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJ0ArA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:47:00 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44205 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeJ0ArA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:47:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id p144-v6so671332yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cdhQ6ngFhxzmZ8WAlxjhY2jTtZMa1dnFvjGSGrdfdro=;
        b=g2+/RaWUJSUqhXylhtNNHzvWiH/+nOhptU/HzjFNVsqR3lPawTpMRQlJxIn+jcCJoS
         IewMS/xC9f4TN4MtDjXd5E4VVGxQ8igkM7A1qeqHnMgf5c9O7GaFl6CcDQNfe+dCdgSP
         VZLYzCJ1Ts9YqQea6uzLMKH7MjolB59dKYgVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cdhQ6ngFhxzmZ8WAlxjhY2jTtZMa1dnFvjGSGrdfdro=;
        b=Ww0PL/h9I696kIP0caLblsugdOf6X+KFijZJEnAEnRKYzN+sOtmD/LSeFyhFz65bF9
         SInTIdgwWjqGKgrLAfZRhdAzfyNbfR5kfVcAKcsYiMI3pkgBi87lzrPe/bvIS2n+83h0
         EKYL0ir/hR0gRG8XJC1oufSJ965aGxFyjYMTdl3TlYwBIs+zVR7+Xdm++eFyJisTu8Ue
         DfAaNjYdUSBhYGUYwiKR9R3noih7WuN26mvdbkW1ISAhUNWWvapASyEZHtDJZv3b/IMF
         5wQdHwVRKr7m8dhgqWjLHfPqwEfLRAa2Oh1y1LUmkvvg6yrLRgf8pN81J6JCuiVqn2ml
         NZ1w==
X-Gm-Message-State: AGRZ1gKVjyeB9y4J/GuBJXnW3vSjw37z9kfI/S9u2lK3+xyeIYzMWvPx
        uFRYg5CyNuBpzEYkTwXLhQBhnCQ2w+Wg3Q==
X-Google-Smtp-Source: AJdET5djvw9KmgorRgZ8e9v3eEjhiHWDTRSrwbwm6S4VCbqtrqMJzu810p+8DdUUfGBjgbLZICPFgg==
X-Received: by 2002:a25:acc2:: with SMTP id x2-v6mr4067263ybd.37.1540570161340;
        Fri, 26 Oct 2018 09:09:21 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id k185-v6sm1071223ywc.98.2018.10.26.09.09.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 09:09:19 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id j9-v6so682922ybj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:09:19 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr4169181yba.410.1540570158570;
 Fri, 26 Oct 2018 09:09:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 09:09:17
 -0700 (PDT)
In-Reply-To: <20181025130129.GE3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com> <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com> <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com> <20181025130129.GE3725@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 17:09:17 +0100
X-Gmail-Original-Message-ID: <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
Message-ID: <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:01 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 10/25, Oleg Nesterov wrote:
>> perhaps it needs some changes too. I even have a vague feeling that I have already
>> blamed this function some time ago...
>
> Heh, yes, 3 years ago ;)
>
> https://lore.kernel.org/lkml/20150106184427.GA18153@redhat.com/
>
> I can't understand my email today, but note that I tried to point out that
> task_is_descendant() can dereference the freed mem.

Instead of:

        while (walker->pid > 0) {

should it simply be "while (pid_liave(walker)) {"? And add a
pid_alive(parent) after rcu_read_lock()?

> And yes, task_is_descendant() is overcompicated for no reason, afaics.

Yeah, agreed. I'll fix this up. Just to make sure I'm not crazy: the
real_parent of all tasks in a thread group are the same, yes? The
trouble I was trying to deal with for the complication was where a
non-leader thread would add an exception to the checking, and the
tasks wouldn't match. (As far as I can see, though, using
same_thread_group() should fix it.)

-Kees

-- 
Kees Cook
