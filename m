Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB91C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097D520869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfBBKu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:50:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41627 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfBBKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:50:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so7536065edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 02:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhGtStlXLM8RSv4JU084cQSWOl31CLMw0QWLTmg4ONQ=;
        b=LLBjVQ5Zb7d2mzY93r43oc0izET5ln5FC7veEM5aDdu47MPSotOp3bS6RTA4WuJVjT
         GYsSxlfuuNrjU+d+UgVQ0DGxqIvaJ8F2iWzSBKPHoYvZDNXNDyI7irz3+GcvRndEIYyF
         jZRB0iMEJI2w7IuvH0K6xXUPI3nPYjM8f1t+tXZr1x/Vc3f9Wvt69dEqaH47XJXS+Aov
         fA3hL0XB+44w5e7yF5rhfBDkRO4pZWf05rSnOchh7VXFSSHEkOfYvkEDodb5o+/1u1ZJ
         aWIItv+W85oJ/cyKGEn8rBOj5M4IwZv8IltG23fz25vAgF3tWb94gpUChXdkbqRAs8cM
         CNUQ==
X-Gm-Message-State: AJcUukc2AiQeoFaDEbO5aQf0SNBD/R7OVTeOjWhylc+ecWFBtpFcPhNh
        N34ROfBU/SzcrDBZh0P1dqg+39dIbB0=
X-Google-Smtp-Source: ALg8bN5bvAKodrAh+EjbcFr81YPvuJr6xvgVnx8fLJHO0bv0i0dnYKPW8a9wq0WPhQEbI8QDLaaASg==
X-Received: by 2002:aa7:da57:: with SMTP id w23mr42977367eds.7.1549104625217;
        Sat, 02 Feb 2019 02:50:25 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1810:f055:509d:1c96:c07c:69f9])
        by smtp.gmail.com with ESMTPSA id z40sm2691062edz.86.2019.02.02.02.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 02:50:24 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180924143719.22191-1-hdegoede@redhat.com>
 <CAKErNvoeMs9cDDAvMfxaGLsKY3-q_JmrjCUB8VK4ZUXUVytwsQ@mail.gmail.com>
 <35cfd1f2-43eb-fc49-4777-a21413bb2d41@redhat.com>
 <CAHp75VfxuQ5SA7X_zwOiAZ41HvE-Oi32aBhCCZ_T7S9rDT48vg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a56d2e8-c309-77f4-6ea6-a4e9d2bb0f1b@redhat.com>
Date:   Sat, 2 Feb 2019 11:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfxuQ5SA7X_zwOiAZ41HvE-Oi32aBhCCZ_T7S9rDT48vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/19 12:25 AM, Andy Shevchenko wrote:
> On Sat, Feb 2, 2019 at 12:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 1/31/19 8:47 PM, Maxim Mikityanskiy wrote:
>>> On Mon, Sep 24, 2018 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> We were relying on the interrupt being shared with the ACPI SCI and the
>>>> ACPI core calling irq_set_wake. But that does not always happen on
>>>> Bay Trail devices, so we should do it ourselves.
>>>>
>>>> This fixes wake from USB not working on various Bay Trail devices.
>>>
>>> This patch breaks suspend on ASUS E202SA (bisecting pointed me to this
>>> patch, and if I revert it and build 4.20.5 without this patch,
>>> everything works flawlessly).
>>
>> Thank you for the bug report, can you please test 4.20.5 with the attached
>> patch on top? That should fix it. Once I've confirmation that this fixes
>> things I will submit the patch upstream.
> 
> Thanks for fast reply, Hans!
> 
> I looked at the patch and would propose one modification, i.e. use
> INTEL_CPU_FAM6() macro instead of ICPU().

I just tried and I like the idea, but this does not work.

The problem is that macro assumes that the driver_data being passed is
always a struct and the & to take the address of the struct is part of
the macro instead of passed with the argument, making it impossible to
pass a simple integer value or a bunch of flags (in a bitmask).

IMHO this is a shortcoming of the macro and should be fixed, moving
the & to the callers of the macro.

Given that this patch needs to go to stable to fix the regression I
think it is best to just keep the patch as is. And then for -next, once
the macro is fixed we can convert the int0002_vgpio driver to use it.

Regards,

Hans
