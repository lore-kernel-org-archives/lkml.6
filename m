Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F83C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D34206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BjLtSuFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D34206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeIKJYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:24:42 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:44816 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeIKJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:24:42 -0400
Received: by mail-yb1-f171.google.com with SMTP id l16-v6so8830627ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6pNdeO9GV1SjSyj4AhoSk2EQLN6wIUjBE4eyYkHJthU=;
        b=BjLtSuFS5C7Gfo8E17Kfhc7LNALygkZKyenlQckxwRZgOiprCRSLF69fAFeWWgIEPO
         oDGm3qom/CHpmBFeWjJrTBHftbnyF/g6h2Ji33wROmLoAlaoPKFii8n6Kn8mwEz7GEvz
         02TeM+96HB0Rb53N24Gksuj0g9UAXc1FLmbk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6pNdeO9GV1SjSyj4AhoSk2EQLN6wIUjBE4eyYkHJthU=;
        b=DVUP9xrr+oW66nGPtGpoWdV6olVW0ObQ3dFxw4DeIYXl+ZY2q+M264zigwaU5NyuPR
         ZxlIbEnJ5dvNPBCmRVwCOFx86JYOjzxFZZR7eytVjhgSwBd83Q1hj0X6Gnpx27E0hJFl
         8SsjgsL3fQmDPANqK1ccdzb8u33VcwXHwcdERG+h8+fzR8GaYrXe9OfhTAKPe9fsP2Ly
         rtNzg+4Cwb6lKqaD11cgyCaCdaOV1SijqyQR8ljzcVkSliHOh8txbN4Mx6uvteAjZVuN
         4WyL3+vSFjxOv2nQfJ5HyJ0qp3imze0yO70hbKXYvoKJ+sn6CxZQilzfWFpq3TlvsIyo
         EbTw==
X-Gm-Message-State: APzg51BfocgOsvH7cZ+RjTer5EuEhzIvoiuNfiAkotDvP3UZnk3vDXov
        kuun8EAYwiA4bClCfaRTlZfhV+Ynqw4=
X-Google-Smtp-Source: ANB0VdasTNZPFxJWgCY+vtPic1geZdf2ZjuEMmKD/TCcxKsYRXWnYus4qxJz5cg3nQSWfkjaebU+FQ==
X-Received: by 2002:a25:becf:: with SMTP id k15-v6mr5124056ybm.219.1536640040039;
        Mon, 10 Sep 2018 21:27:20 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 129-v6sm6882388ywq.26.2018.09.10.21.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 21:27:19 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id k5-v6so8831836ybo.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:27:18 -0700 (PDT)
X-Received: by 2002:a25:23c3:: with SMTP id j186-v6mr10578257ybj.137.1536640038348;
 Mon, 10 Sep 2018 21:27:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 21:27:17
 -0700 (PDT)
In-Reply-To: <20180910172109.GB27005@redhat.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com> <20180910172109.GB27005@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 21:27:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL_a5B6w39Vb3S07-Epu4JGPTB5N6A75ERVOryvNeA7ZA@mail.gmail.com>
Message-ID: <CAGXu5jL_a5B6w39Vb3S07-Epu4JGPTB5N6A75ERVOryvNeA7ZA@mail.gmail.com>
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

On Mon, Sep 10, 2018 at 10:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 09/10, Kees Cook wrote:
>>
>> On Mon, Sep 10, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>> > On Mon, Sep 10, 2018 at 5:29 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >> Hi Kees,
>> >>
>> >> I was thinking about backporting the commit 98da7d08850fb8bde
>> >> ("fs/exec.c: account for argv/envp pointers"), but I am not sure
>> >> I understand it...
>>
>> BTW, if you backport that, please get the rest associated with the
>> various Stack Clash related weaknesses:
>
> may be...
>
>> da029c11e6b1 exec: Limit arg stack to at most 75% of _STK_LIM
>
> and I have to admit that I do not understand this patch at all, the
> changelog explains nothing.

The issue here is with keeping some stack space available for a
program to reasonably start execution without doing insane things. The
sizes were picked after discussion with Linus while examining the
various Stack Clash weaknesses.

> Could you explain what this patch actually prevents from? Especially
> now that we have stack_guard_gap?

One of the many Stack Clash abuses was that it was possible to jump
over the stack gap with outrageous environment variables that got
expanded in stupid ways by, IIRC, glibc or the dynamic linker. The
point here was to be defensive in the face of future weaknesses, and
try to be robust in the face of crazy execs but workable under normal
(but large) execs.

-Kees

-- 
Kees Cook
Pixel Security
