Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9421FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607E921476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LelkQvFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607E921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeJRC2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:28:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46391 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRC2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:28:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id j202-v6so10755698ywa.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BvS6s5e3Ccz2AZdsJrSkBdOPFXjXmL4OCyqgTGSCQiI=;
        b=LelkQvFmubbB5ts6bfTwC09I1W6k4atqyEhZjcDZMfyukkKw8Z5kNQwn//IMXLTB3C
         N/KucNrL9JvioClfnU0UJX+q4NuQeGcn5BgpcajgZqcm6EB3SeY/uZQIF+f1HuHzfHV8
         09aK9XV5FIyEYNUJaOPHVxau4BtgI/xGCiKyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BvS6s5e3Ccz2AZdsJrSkBdOPFXjXmL4OCyqgTGSCQiI=;
        b=V2dZstWxLx34gezy/1FaCqTIJf2c5gEnikwzi8xhDZjnBkc580X26b2yqsHsrzNJ5o
         sPfzu5kn5bPQKzfYtfSGxzXhyTifMRcOeqdnBYmWL0sSVxUwpZO7eI7A7EFc7Va1etKJ
         sKoosaDbUvvCt0BWBt4VusGmQPGAzVMcd2gUnFbdjpvBXbQT5Ow99oYf3xN/CtIf6WLh
         dfVX++OTbRsVIPL11E3bRulOmr9ua5lmKvxYrGs1X/IL7EVw1VpEgmP5JTMAgh+KAN/6
         W+y4IU/aZT76nKFvZMpU1A5DkalxjDsrGcAHXabLvR6xTAbambZyKQuYxWh9pWxUW+g5
         9Zhg==
X-Gm-Message-State: ABuFfohJ+kOU+lUa+88K5cvaNCvM5BIFVFakVFcvtecioB07JGbWSoWZ
        Gw4dnpAVEkVaLngEDI6gcaI71lqaM3U=
X-Google-Smtp-Source: ACcGV60QPxkGBhDLwCxYba6xIswgWlO3wBxBzaMF07oHd85al8yPz2AY5V4ZK4oWsKJk7JofqT9psQ==
X-Received: by 2002:a81:ae04:: with SMTP id m4-v6mr15676808ywh.474.1539801118292;
        Wed, 17 Oct 2018 11:31:58 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l138-v6sm5674683ywe.50.2018.10.17.11.31.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:31:57 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o8-v6so10778799ybk.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:31:56 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr16325360yba.141.1539801116376;
 Wed, 17 Oct 2018 11:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 11:31:55
 -0700 (PDT)
In-Reply-To: <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com> <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 11:31:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+LBzzZeqPAcfAjOmQ7db=2xNdcw2CMurc+PDWtS85fcA@mail.gmail.com>
Message-ID: <CAGXu5j+LBzzZeqPAcfAjOmQ7db=2xNdcw2CMurc+PDWtS85fcA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:25 AM, Michael Tirado <mtirado418@gmail.com> wrote:
> On Thu, Sep 13, 2018 at 12:02 AM Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> Or we could have a
>> seccomp() mode that adds a filter but only kicks in after execve().
>>
>> --Andy
>
> Hey that's a pretty good idea, then we could block execve in a seccomp
> launcher without post-exec cooperation, or that patch I wrote that used
> an execve counter which probably should have been through prctl instead.

This has come up a few times before, actually. I had a working
prototype, but it needed some more shaking-out. I do like the idea of
"activate later" filters, though I'd always felt like using execve as
the boundary was a bit limiting. I wonder if we could do some kind of
external trigger (i.e. the fd passed to the caller) for when to
activate... likely the synchronization is a horror show, though, so if
execve is "good enough", I'll probably be happy with that. :)

-Kees

-- 
Kees Cook
Pixel Security
