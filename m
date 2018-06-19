Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00047C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76A620874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76A620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756021AbeFSFr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:47:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40158 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeFSFrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:47:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so17065752oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwREOWVRwksXPOSy9kCtD0deob5AunG4tI8IamtZGRo=;
        b=NNmM7OmAKg3/4A057RDd1OY0DO6bRDGVkVkcl3VY+cWAQ7KNa6UysKPkLU3YC2+Pqf
         CYqGx9lEGTfPbu3E9TiOKIZBgQmbOWllNI8JlvXf3JlI9QSDDrzMUthLzOy80BdSgA/i
         CaUeEh1Zc/bhn1chXrYyf5B6ivc+rvf5Leq2vR6KhqQjLSfcbOweX9vwNQBvCqcDlh2f
         ny72PQv0WNPkX6r3ExJRRGLkgPvSLrYnsEr7xAYcjahR17rEYgroUrrM3R9xvT31Jj8e
         rWeINj4CPz75A9UY1gqmfkq36sJSyKju0M9tLgLsl1vOH7HeaC6JXeOiOgdea+Y+3z4x
         Ajpw==
X-Gm-Message-State: APt69E24NFpIGefBvvMBaQJacCqDzsJhYBgugQCdfErdp1ZBDpXUuFaf
        4QYxRLAoCG+H9cC+NI2O53401IgwgPz8/DvYsTI=
X-Google-Smtp-Source: ADUXVKIG6O1VWXRO0cjVJYrd8MLVWXJ5dWZLWTDZmyiF5SeTQt69Mq0owrpDKVdBxbevLtLo7ES2X4KX23NU3wJmdwg=
X-Received: by 2002:aca:a686:: with SMTP id t6-v6mr8931628oij.48.1529387274582;
 Mon, 18 Jun 2018 22:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180618140518.2920804-1-arnd@arndb.de> <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
 <87efh3hndq.fsf@igel.home>
In-Reply-To: <87efh3hndq.fsf@igel.home>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 19 Jun 2018 07:47:41 +0200
Message-ID: <CA+7wUsx+M1PE_ZcyT0JokY3r8hFLZfufUyFGX7kYX-fAZ524Fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
To:     schwab@linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        gerg@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
        Meelis Roos <mroos@linux.ee>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:04 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 18 2018, Mathieu Malaterre <malat@debian.org> wrote:
>
> > Sadly, trying again today does not work anymore. Adding some printk
> > just before WARN_ON:
> >
> > +printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
> > RTC_OFFSET, now - RTC_OFFSET );
> > +printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
> > req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
> > req.reply_len);
> >
> > leads to:
> >
> > [    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
> > [    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4
>
> A good value would have 0xd7 in the first byte.  The problem is that
> pmu_set_rtc_time is also broken, and leads to an invalid time value
> stored in the RTC.  Since pmu_request is a varargs function passing
> values of type time64_t without casting won't work.
>
> You need to reset your RTC before you can continue.

Indeed that was silly, I was not paying attention. I'll try again tonight.

> I think the right fix is to change nowtime in pmu_set_rtc_time and
> cuda_set_rtc_time back to unsigned int (or to u32).
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
