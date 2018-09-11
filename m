Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429E1206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rc/m6pTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429E1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeIKJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:28:15 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:38296 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeIKJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:28:15 -0400
Received: by mail-yw1-f51.google.com with SMTP id n21-v6so8720636ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q8FU+9bVL81svFCXr9TaqXSMHt6I9+JgGyYzUNGGyAk=;
        b=Rc/m6pTCvoVBSN1m1VwUzUb2MgOmgNaGIZJ+BGiIls/UtzfyLk+e35beSP/9oPI8+9
         /zv+VnFNeVFAnLy1+rYdWW8dyE5GvPX33oJOF9D50atiw+RvDUvq3vEOFeCf0qjL6GSi
         EZX4emm6Pu6uR8uhB09AwKPAiaDAvh14iXeL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q8FU+9bVL81svFCXr9TaqXSMHt6I9+JgGyYzUNGGyAk=;
        b=AjcUz0YJNejRpEdlvhDJ0oH20i7vV7iPWvIgHptnmx332o5px346/Dd+NMZ8bPJPn4
         dMr45382YarXKc5crBjeMBzmacvvmhp6upblhPujxrQmx5YVT74+p5XDb2kdPpF+5Sa/
         EIfXmc/12erljTX4D12YFkLuWGK/x6ZJpVR+ShGW6Nw/eOYJrpRslo2OxR/acoF3UMeo
         /rO9xqhNgoWUzqxMpbuN9vtjdcsRz8mnIroSAUyacEoVgK97D23h7+b1amwCksHbu2ZH
         me4hS6cLbRnX+J/maVCxo4MgvXgWRkid5H4Vp2ZzJSetRCafDYshxPcYRbFt5s1whZa1
         lrzg==
X-Gm-Message-State: APzg51AsfaH0v15uvYOFrqYL6ZODZ777pniU8PzMV6uiO/VfKG/SXVUh
        9Fm1//NJD3v3GunoInj617alyflgRG8=
X-Google-Smtp-Source: ANB0VdZLMRhR81TgYOoZO9oaoSynJYG8nr+7C8m2OKjp7liEEn5hVLONInyqM+DtIHcMdIqv7zOgog==
X-Received: by 2002:a81:3b4c:: with SMTP id i73-v6mr12000258ywa.121.1536640252378;
        Mon, 10 Sep 2018 21:30:52 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id y188-v6sm6147641ywe.2.2018.09.10.21.30.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 21:30:51 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y20-v6so8832891ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:30:50 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr11534244ybh.209.1536640250362;
 Mon, 10 Sep 2018 21:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 21:30:49
 -0700 (PDT)
In-Reply-To: <20180910174355.GA27312@redhat.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
 <20180910172109.GB27005@redhat.com> <20180910174355.GA27312@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 21:30:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKwJx6mLV8=Z313kkZzqhikyoKwnRTQsd5X+U_gMkuS_w@mail.gmail.com>
Message-ID: <CAGXu5jKwJx6mLV8=Z313kkZzqhikyoKwnRTQsd5X+U_gMkuS_w@mail.gmail.com>
Subject: Re: get_arg_page() && ptr_size accounting
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:43 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 09/10, Oleg Nesterov wrote:
>>
>> On 09/10, Kees Cook wrote:
>> >
>> > On Mon, Sep 10, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>> > > On Mon, Sep 10, 2018 at 5:29 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > >> Hi Kees,
>> > >>
>> > >> I was thinking about backporting the commit 98da7d08850fb8bde
>> > >> ("fs/exec.c: account for argv/envp pointers"), but I am not sure
>> > >> I understand it...
>> >
>> > BTW, if you backport that, please get the rest associated with the
>> > various Stack Clash related weaknesses:
>>
>> may be...
>>
>> > da029c11e6b1 exec: Limit arg stack to at most 75% of _STK_LIM
>>
>> and I have to admit that I do not understand this patch at all, the
>> changelog explains nothing.
>>
>> Could you explain what this patch actually prevents from? Especially
>> now that we have stack_guard_gap?
>
> forgot to mention...
>
> with this patch
>
>         #define MAX_ARG_STRINGS 0x7FFFFFFF
>
> doesn't match the reality. perhaps something like below makes sense just
> to make it clear, but this is cosmetic.

Part of the discussion from back then was basically "we don't have
hard-coded limits so programs need to check dynamically themselves".

I'd prefer to leave it all well enough alone since I don't want to
introduce regressions here in the face of the many many Stack Clash
style weaknesses.

-Kees

-- 
Kees Cook
Pixel Security
