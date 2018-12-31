Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB1121871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546286756;
	bh=7XPlEJ4VDxG41nQCvgYniEk6LoyTFXNejn5dK5ux5NY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q5EVwiu068VicMp6znPNmUpeXoW4HBtsZFPqbN5Vi9cb7JJsXqOCxx5aKB6r4Td53
	 8+aSJA1C1Xg/IMq5IfFl/jvkNTr2lvbkIvwGFXTyezAhMtXnhD6vd6O7hKQPf4OUHc
	 LZhzaHIVYTW1YfZpxrdPYFROM6d1/ZdX7yRo8f7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeLaUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeLaUFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 15:05:55 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD85218AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546286754;
        bh=7XPlEJ4VDxG41nQCvgYniEk6LoyTFXNejn5dK5ux5NY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wlxvolJu8vFWoeXffcXIjOmQWmLd+W0u/t0xVWhbIQTzcl7jr60RH3ewe7/m2UQYE
         Jec8pmdAbdjTOtGaWbj8TTamNVu8ShVSFCSXE8g06xJBfcHAEwC1YSBCOeEFhKqjOx
         irAHhxx3BcltynO2K+9GAOSaq32gk2KY/TFhPNO0=
Received: by mail-wr1-f53.google.com with SMTP id l9so27120817wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 12:05:54 -0800 (PST)
X-Gm-Message-State: AJcUukcpydWox68ztzkg9RiLF6n4A9g5QTAuVW/BhJaGN13qqhkPbFJP
        GX6pMyy+o49sb2zH073zIBNlaqxm2RyY/4Y1VLjnog==
X-Google-Smtp-Source: ALg8bN7FnKib1gSJnjV688pFz6J52w2djXbpu8ps9tKniS9fEw7KJhmbZjjVdZZNft5bfjjSaGf3ondKNv+IcVnYgHk=
X-Received: by 2002:adf:8323:: with SMTP id 32mr32564815wrd.176.1546286752698;
 Mon, 31 Dec 2018 12:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20181231072112.21051-1-namit@vmware.com> <20181231072112.21051-6-namit@vmware.com>
In-Reply-To: <20181231072112.21051-6-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 31 Dec 2018 12:05:41 -0800
X-Gmail-Original-Message-ID: <CALCETrVyJ9gBaJG6poOiWLro3z2jrSXtL087EOEssQ=gOhOBpA@mail.gmail.com>
Message-ID: <CALCETrVyJ9gBaJG6poOiWLro3z2jrSXtL087EOEssQ=gOhOBpA@mail.gmail.com>
Subject: Re: [RFC v2 5/6] x86: learning and patching indirect branch targets
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
>
> During runtime, we collect the targets of indirect branch targets and
> patch them in. Patching is done asynchronously, by modifying each of the
> relpoline code-paths separately while diverting code execution to the
> other path during patching. Preemption is disabled while the code runs,
> and we wait for preemption to occur on each core to ensure no core is
> executing the patched code.
>
> To make use of relpolines, a worker goes over the experienced indirect
> calls targets and sorts them according to frequency. The target that
> was encountered most times is patched in.
>
> Periodically, the indirect branches are set back into learning mode to
> see whether the targets have changed. The current policy might be too
> aggressive.
>

Can you put, in a comment somewhere, a clear description of the actual
optpoline assembly sequence?  I'm finding this code very hard to
follow as is.  Something like:

/*
 * An optpoline is:
 *
* cmp something, something else
* je somewhere
* [repeats of the above]
* RETPOLINE (i.e. call some thunk)
*/

And please make it correct.

Your comment says that preemption is disabled, but it's not obvious to
me where this happens.

Also, you define REX_B and don't use it.  Are there other cases of that?
