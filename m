Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090DC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090DC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbeKFBCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:02:14 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34734 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:02:14 -0500
Received: by mail-ot1-f42.google.com with SMTP id t5so4738102otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ab6Vk+yzfKDjSfnydzp4gBlhKr240tzvkIDBQusVGs=;
        b=j6Uv0R8VrXf7V6WtBSQgQjrzHTTMk0Nfss+UL3eOsrTL5U7Rm2JzTBeQYO+UrHckO+
         KbR8FmVmT4MNTUkIhEeac68fuMgo5KPvCepLQAk2o2bvx/lIqE7670qp7lJbsz0jNzfv
         WZHDYqi5kiEQNIoroLL4x72THLv6bN9KZaFBIMwuDqxCNteXDJn+3PZiKs2bCDPklRzI
         SX5et6D9VAXgfoIRY6nn5Gk4qGcg7Ua6z5EFMumegsFEfQWxJs72ZSvrUfjpIHQFOcfo
         ZvdiL47+bE32PtbSQtxA1wbvEppM+UXW9rLSxYEAhDYzkej62TUYkoWVyVeGy5FTJt9P
         X9zA==
X-Gm-Message-State: AGRZ1gKGHCh0fx443PHk54ihgIpxk6RaM+CrIKngr3EAnKQiQ6Hu7gGv
        i6nkrUyW0Rlh/+K7fbrjrrkf6bf2Vha9XPzwSnFsYQ==
X-Google-Smtp-Source: AJdET5e8E+jo8eZz1ZiJl91pG/x8rC+nUUEfetc2nyTEV5UOBoYJdRdpsF/pENlFFfKxwMCVbveai9tkULNqDSzjIjk=
X-Received: by 2002:a9d:55af:: with SMTP id m44mr14082790oth.277.1541432517364;
 Mon, 05 Nov 2018 07:41:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:faf:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 07:41:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1811020922240.1642@nanos.tec.linutronix.de>
References: <1541085133-32534-1-git-send-email-neelx@redhat.com>
 <alpine.DEB.2.21.1811011630310.1642@nanos.tec.linutronix.de>
 <CACjP9X-aZ4-6h7KkgZO6TtPCY4teiBTzVn-c11ULPwbPid8qWQ@mail.gmail.com> <alpine.DEB.2.21.1811020922240.1642@nanos.tec.linutronix.de>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 5 Nov 2018 16:41:56 +0100
Message-ID: <CACjP9X-1ZJhGuNLNXBvvzcffWqpxFRUDmc4jsRuvTE2s4hxtJw@mail.gmail.com>
Subject: Re: [PATCH] tsc: make calibration refinement more robust
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 11:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Daniel,
>
> On Fri, 2 Nov 2018, Daniel Vacek wrote:
>> On Thu, Nov 1, 2018 at 4:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> -#define MAX_RETRIES     5
>> >> -#define SMI_TRESHOLD    50000
>> >> +#define MAX_RETRIES  5
>> >> +#define TSC_THRESHOLD        (tsc_khz >> 5)
>> >
>> > This breaks pit_hpet_ptimer_calibrate_cpu() because at that point tsc_hkz is 0.
>>
>> That did not show up with my testing, sorry. I guess
>> pit_calibrate_tsc() never failed for me. Hmm, actually it looks like
>> quick_pit_calibrate() does the job for me so
>> pit_hpet_ptimer_calibrate_cpu() is likely not even called.
>
> Right. It's only called when quick calibration fails. Testing does not
> replace code inspection :)

Agreed. I was not 100% sure about this early init and order of
execution as it's dynamically changed with x86_platform.calibrate_cpu
and x86_platform.calibrate_tsc. Thanks again for the review, Thomas.

> Can you please avoid hiding the logic in a macro? Just use a local
> variable:
>
>         u64 thresh = tsc_khz ? tsc_khz >> 5 : TSC_DEFAULT_THRESHOLD;
>
> and use that in the comparison.

Sweet, I'll do that :)

--nX

> Thanks,
>
>         tglx
