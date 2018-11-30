Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB71C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156E620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWxq6XEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156E620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLAG4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:56:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33952 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:56:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so4962480lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtlTgtUilYOBKnXnQRdlG+93Y6itvwnqZXTEFM9dxfA=;
        b=FWxq6XEN1FdQQd65gUuJGXvqkihiZELIBtl9VG3CH2Vdx+YXWfw8mDm1rzQPI7sDTF
         sPbYlZxQEl/b/SEHlk/t68laoPCBkr9+ah1ig1xBbAWsAHBJc6ffVLNmNMh4ONPBpnkE
         7rKSs1LUjQB2H3A1y9NNopUuOxUTzN216LZcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtlTgtUilYOBKnXnQRdlG+93Y6itvwnqZXTEFM9dxfA=;
        b=YNN42rd5Sl+pmvdcdp9XPMe9J+BHEzIMPCfFXxMxLB+xsYkUQe/oZIaNy22yDoTu5O
         SXApBVjUUeudhdGthiNS/gZdCjLYUJi0rqfsTbW4xRL8QgYoLaIkAw7R9lZEZpC/j4ha
         0Yz0psQUQi5xeFGqd7O5gxFQ935mQG62CX8gxUeocWxe8bP0/O4pfkYyxIaSkRbzDoFt
         Ee48EBfwuA9bGKUxFJXYRZVIv7vZUYcBntS0uVHuB3dVlhqn4KmWWDyDM7JlUP30KhdD
         kLQXHHSFGiUFQHiXQ7q/8QRK2odKYbVI6QsYweMtfzlqZuI0vZbtM2rpyVlZggcGRldQ
         I86Q==
X-Gm-Message-State: AA+aEWaGSpEEbfsmJD3FwMRk94mCa2nvlEhVESijRIQR0kvnWy+nEN/N
        25Kppaok2uayKcAWhOjCe7tdm+2c0sY=
X-Google-Smtp-Source: AFSGD/XoOY+l5hFdw+RteprBMm33XvR4BLWmB+uwEBd2YEMfE94v6he7U/Ygnk7JMGqlhE2B6hxZfw==
X-Received: by 2002:a19:c995:: with SMTP id z143mr3871710lff.79.1543607172585;
        Fri, 30 Nov 2018 11:46:12 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k3-v6sm939197lja.8.2018.11.30.11.46.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 11:46:11 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p6so4962399lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:46:11 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr4282052lfj.138.1543607170629;
 Fri, 30 Nov 2018 11:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble> <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
 <20181130183917.hxmti5josgq4clti@treble>
In-Reply-To: <20181130183917.hxmti5josgq4clti@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 11:45:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
Message-ID: <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:39 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> AFAICT, all the other proposed options seem to have major issues.

I still absolutely detest this patch, and in fact it got worse from
the test of the config variable.

Honestly, the entry code being legible and simple is more important
than the extra cycle from branching to a trampoline for static calls.

Just don't do the inline case if it causes this much confusion.

             Linus
