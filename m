Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72E6C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B5520868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B5520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeJLQyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:54:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39592 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeJLQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:54:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id d15-v6so10858634edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDKYe35FsxogIgamBcnKreRGYTvQQkgpabxWLy0uoo4=;
        b=dAxqJgoS3sG/2BgZcDy/WMDdB7MhBL/mdp7p1evOgI6R1xb6qavNmVWAGWPuGSvbAj
         Icvgyl83HPhYXlxMp6X2Aj3hKtbH2dfQwQm2o1YzIVcWc/0+iyoDeBerOH4TfWsZZozq
         EeYWz16wRctqVkd/7gmgyWwUReG3PmkDt35kImk1zzjtW9HetIGHNeeyuATfm0fjeFzc
         7Umjdnvbktl4Pvw3tbhD7Ww4MsEqKIqNa2B91Wg62SD4a19AawtvL/gy74d6NPH3DRaP
         LVQAjIGRumt+/2dsP4OKkn2FK8pqBOnPwAEK5ksn00NYqRY6wXVNlOx8ZOtEG+9v3rsA
         zm3Q==
X-Gm-Message-State: ABuFfoiYwzJ699KmgOMuYvGOF3Zt3KmEWSzy9XQ/HTdmWMjEa7KwZ2Ue
        pW9fcQE4ux9vsQF6wUOUYilFCTlLXPY=
X-Google-Smtp-Source: ACcGV62m3CVgLo9JxHwwJxKo7GXvQdgBiBWF6VBjtuuXRWcVBRNVgcPgWnXknlGew8x4pZ2Ji8hKzw==
X-Received: by 2002:a17:906:6983:: with SMTP id i3-v6mr6388503ejr.141.1539336188432;
        Fri, 12 Oct 2018 02:23:08 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a17-v6sm501346edd.61.2018.10.12.02.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 02:23:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-2-hdegoede@redhat.com>
 <20181011213508.40b8ce0e@alans-desktop>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
Date:   Fri, 12 Oct 2018 11:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181011213508.40b8ce0e@alans-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-10-18 22:35, Alan Cox wrote:
>> 1) PMIC accesses often come in the form of a read-modify-write on one of
>> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
>> between the read and the write. If the P-Unit modifies the register during
>> this window?, then we end up overwriting the P-Unit's changes.
>> I believe that this is mostly an academic problem, but I'm not sure.
> 
> It should be.

You mean that the problem should be purely academic, IOW that registers touched
by the P-Unit are never touched through ACPI Opregions / power-resources?

>> 2) To safely access the shared I2C bus, we need to do 3 things:
>> a) Notify the GPU driver that we are starting a window in which it may not
>> access the P-Unit, since the P-Unit seems to ignore the semaphore for
>> explicit power-level requests made by the GPU driver
> 
> That's not what happens. It's more a problem of
> 
> We take the SEM
> The GPU driver pokes the GPU
> The GPU decides it wants to change the power situation
> The GPU asks
> It blocks on the SEM
> 
> and the system deadlocks.

That may be, but why does it deadlock? It should just wait for the I2C transfer
to finish, the GPU driver does wait for the P-Unit to report back that
it has done its job, IIRC it even has a timeout on the wait, yet we
get a consistent freeze. While nothing should stop the I2C transfer to
simply complete at this point, release the semaphore and everything then
can continue normally.

>> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
>> C6/C7 while we hold the semaphore hangs the SoC
> 
> Not just C6/C7 necessarily. We need to stop assorted transitions.

Could be, it may be that the pm_qos request results in the CPU never
leaving C0. The code for this originally comes from the Android-x86 kernel patchset:

https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches

and IIRC the commit there talks about avoiding C6 and C7.

> Given how horrible this lot was to debug originally do you have any
> meaningful test data and performance numbers to justify it ?

No, my mean reason for re-visiting this (I wrote most of the original code
to deal with this) was that I thought I was seeing a case where the
AML was modifying a PMIC register which was also being touched by the
P-Unit.

Eventually I figured out I was not actually seeing this, but then the
patch was already written.

> As an ahem
> 'feature' it's gone away in modern chips so is it worth the attention ?

I know and good riddance. But Cherry Trail SoCs with AXP288 PMICs are
still very common and are being sold 10000 at a time by Endless with
Linux pre-installed.

This change mostly just moves a bunch of code around, the only new
feature is the ability to nest calls to the iosf_mbi_block_punit_i2c_access()
function and not deadlock then.

This does result in a nice cleanup in the form of putting all the code
dealing with this together in arch/x86/platform/intel/iosf_mbi.c instead
of having it split over iosf_mbi.c and i2c-designware code.

And this will allow making the AXP288 fuel-gauge driver do all the steps
to claim the i2c-bus once before reading multiple registers to get the
battery status, something which has been on my TODO list for a while,
since as mentioned taking all these steps together is not cheap, esp.
if you also take into account all the work the GPU driver does when
notified that it will be unable to access the P-Unit for a while and
currently we do all the setup and teardown like 5 times or so just to
get the battery status once.

But sorry no numbers, it is sort of hard to measure this and I do think
that the impact will not be that big since the battery status is not
checked that often. Which is also why I've not spend time on this so
far.

I can understand that you are reluctant to change this code, but this
commit is not changing the logic, it mostly just moves the code around
and I do believe that overall doing this is worthwhile.

Regards,

Hans

p.s.

There also is this infamous bug which we really really need to fix:
https://bugzilla.kernel.org/show_bug.cgi?id=109051

But mostly (only?) seems to happen on systems with a Crystal Cove
PMIC where the I2C bus is not shared.

I know that some work was being done on this recently what is the
status of this?
