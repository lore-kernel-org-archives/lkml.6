Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B302C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149FC20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF25Zz6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149FC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438205AbeKWErl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbeKWErl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:47:41 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBC6213A2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542910032;
        bh=NLEjE+Lb8hSmXXek1PLb2TbjWwn8mr/hUyikcOoFyD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vF25Zz6EGi9X0EuE0YKJERyiegnzoDzQwkqEnB3PTd2naTr+PRk5f1HxFYYXqp2Ad
         7yoB13O2R/OervGwi1tDKIVCi19WSsz3W1GEzkDTpZfeuhULAyiiekcDIauGiqdFlC
         9YSMS0VJ0TL32HhQ1AQXB3zvQPuMx2uk/ESkt5RQ=
Received: by mail-wr1-f44.google.com with SMTP id v13so6610470wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:07:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZVoQ4kxTUlSn1TZ6ljd5OV1/jBGPcNk8crvg3DKGcvIPVM7ctO
        XV9GzF7HLCP5BW5dA0kTFtPyxL9WbhOP7Y9fKowlew==
X-Google-Smtp-Source: AFSGD/X7FqXK+MTnhG+lNPL191xc97f/2aY84IZUO9SJQZCiQ2rXyZejXTHnH4w4n1pLEacteK6AUrywE6xGf+59BTk=
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr10168899wri.77.1542910030740;
 Thu, 22 Nov 2018 10:07:10 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
In-Reply-To: <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 10:06:58 -0800
X-Gmail-Original-Message-ID: <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
Message-ID: <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 9:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 22, 2018 at 9:36 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > The other problem with the ERMS copy is that it gets used
> > for copy_to/from_io() - and the 'rep movsb' on uncached
> > locations has to do byte copies.
>
> Ugh. I thought we changed that *long* ago, because even our non-ERMS
> copy is broken for PCI (it does overlapping stores for the small tail
> cases).
>
> But looking at "memcpy_{from,to}io()", I don't see x86 overriding it
> with anything better.
>
> I suspect nobody uses those functions for anything critical any more.
> The fbcon people have their own copy functions, iirc.
>
> But we definitely should fix this. *NONE* of the regular memcpy
> functions actually work right for PCI space any more, and haven't for
> a long time.

I'm not personally volunteering, but I suspect we can do much better
than we do now:

 - The new MOVDIRI and MOVDIR64B instructions can do big writes to WC
and UC memory.  I assume those would be safe to use in ...toio()
functions, unless there are quirky devices out there that blow up if
their MMIO space is written in 64-byte chunks.

 - MOVNTDQA can, I think, do 64-byte loads, but only from WC memory.
For sufficiently large copies, it could plausibly be faster to create
a WC alias and use MOVNTDQA than it is to copy in 8- for 16-byte
chunks.  The i915 driver has a copy implementation using MOVNTDQA --
maybe this should get promoted to something in arch/x86 called
memcpy_from_wc().

--Andy
