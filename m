Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814020837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIKhaDGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5814020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeFUH71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:59:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46824 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932481AbeFUH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:59:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so1225126pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6OQxJL7dRUGV1PZscFRO3BT3f6gtAk63i40gpsWBu1Y=;
        b=DIKhaDGALKJGM2StUpZHmy3S8rCFq8J14y5K5n/pMfI2G23qFihTnuvIx/yen1bpo9
         dRaH1PX4niQ1cRY8UvLjhUglJ90BLYqDd/d0ibB+pwidzvFHZyib2IQsv+nbjada5tP9
         9oiLKyJZzg555gkGSWz/GeRpONROym9JpcAxPPtmT8/8a6R8976Y8ItSqrwx0G4z8pj8
         VyYagUj+rre7UQXp1izQavKetZXtoTFY6oN1Tj3RB7M00GnoCrnhIHxv/HN2FFQfmnMo
         GnTqWjBRGPHQdHOTg307QAb25kSqJaqD7HY21282oxh0dCKdaZGB1ug1T6guilSrIIQN
         Smfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6OQxJL7dRUGV1PZscFRO3BT3f6gtAk63i40gpsWBu1Y=;
        b=ELHyoglQUqwj8YVV5ODU4+GcUBzMQtoeOlhsyjiJBxWxfOr8eGIqPaMpu/67dhP0p1
         eds3L8U3BwZjyaXKyvT3trikKO1jwTOW0Sg//XBFUOHSADpfIvdIlY5IUGvR4rPPhYtj
         6xxrPVjARCOYjShH0B+bXFlOy85rtae/Y8ZgRrvuOcHWTh2jHWjfG668vjbllJb62kDT
         uLmPWYgtAOZ7/WopUHGuMogF32Z0y53tdZ6L1X4eDDKD3eH5T0uJ1tLmj3VG63e+64T9
         CRxdgrEocww1vZBmsvK4+iSIFB5jggBqtx4hg0yv53gJjEtREyTHx7dwOcJoyzWcr3Ce
         /BrQ==
X-Gm-Message-State: APt69E0RlMO/+GWsdbCXMAUZjNp/tetn5wCAv5rTugirpNH58M9nNJPA
        T/hNrgJ96FrsnO6dcG9k7LYQ9MrGpVNvacIJm6ELvw==
X-Google-Smtp-Source: ADUXVKILWLsQ66Fc84EWbXImCin+5PxOUEed/DD801qMjVQ0vkfK/gHtVZV5XTByQppw38S1JUS7hcNjrqJ7KdOvgRw=
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr27037271plo.97.1529567965551;
 Thu, 21 Jun 2018 00:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 21 Jun 2018 00:59:05
 -0700 (PDT)
In-Reply-To: <CAHp75VdR_gDBk7v9WDN1fHc=1q=j2mx3CkTz83SZZWm=pbnczA@mail.gmail.com>
References: <20180620125540.228766-1-dvyukov@gmail.com> <CAHp75VdR_gDBk7v9WDN1fHc=1q=j2mx3CkTz83SZZWm=pbnczA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Jun 2018 09:59:05 +0200
Message-ID: <CACT4Y+bjdmgdeRLM5kBaf6-vunFwFRD0_zCZX=A-rY+XEEfnEA@mail.gmail.com>
Subject: Re: [PATCH] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 3:06 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 3:55 PM, Dmitry Vyukov <dvyukov@gmail.com> wrote:
>> From: Dmitry Vyukov <dvyukov@google.com>
>>
>> KERN_CONT leads to split lines in kernel output
>> and complicates useful changes to printk like
>> printing context before each line.
>>
>> Only acceptable use of continuations is basically
>> boot-time testing.
>>
>> Get rid of it.
>
>> +       printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
>> +               (address < PAGE_SIZE ? "NULL pointer dereference" :
>> +               "paging request"), (void *) address);
>
> Perhaps pr_alert() ?

It's the same, right? Make sense.

> Btw, parens are redundant for the first argument.
>
> P.S. And personally I would rather do
> if (address < PAGE_SIZE)
>  pr_alert(...NULL pointer dereference...);
> else
>  pr_alert(...paging request...);

It's kinda shorter this way. Any other opinions?

pr_alert("BUG: unable to handle kernel %s at %px\n",
        address < PAGE_SIZE ? "NULL pointer dereference" :
        "paging request", (void *) address);

vs:

if (address < PAGE_SIZE)
        pr_alert("BUG: unable to handle kernel NULL pointer
dereference at %px\n",
                (void *) address);
else
        pr_alert("BUG: unable to handle kernel paging request at %px\n",
                (void *) address);

Or, should we just do:

pr_alert("BUG: unable to handle kernel paging request at %px\n",
        (void *) address);

and not try to be too smart here? In the end, that can be a NULL deref
with 5K offset, right?
