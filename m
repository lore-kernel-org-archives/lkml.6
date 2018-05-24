Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971017AbeEXP6A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:58:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39431 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971002AbeEXP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:57:57 -0400
X-Google-Smtp-Source: AB8JxZrxyRe3KdxWRYCL0IU2WZEcwCBiXCukqPcbdvluxaSKeoh7plmb0wRZbzVMN5+sXFfESQEFrOwcAcNLKbyBvbY=
MIME-Version: 1.0
In-Reply-To: <20180524154505.d5r77w7xinpbc36n@linutronix.de>
References: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
 <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com> <20180524154505.d5r77w7xinpbc36n@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 May 2018 17:57:56 +0200
X-Google-Sender-Auth: fXjAWLpBE0WMww7xi9My7A17-XU
Message-ID: <CAJZ5v0hKfAuEyf7YQhb0Cs4p=RK6DADCrqvdSz0bcSihjiYBsw@mail.gmail.com>
Subject: Re: [PATCH RFC] suspend: Prevent might sleep splats
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 5:45 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-05-24 17:07:16 [+0200], Rafael J. Wysocki wrote:
>> On Thu, May 24, 2018 at 4:24 PM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > timekeeping suspend/resume calls read_persistent_clock() which takes
>> > rtc_lock. That results in might sleep warnings because at that point
>> > we run with interrupts disabled.
>> >
>> > We cannot convert rtc_lock to a raw spinlock as that would trigger
>> > other might sleep warnings.
>> >
>> > As a workaround we disable the might sleep warnings by setting
>> > system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
>> > restoring it to SYSTEM_RUNNING afer sysdev_resume().
>> >
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Hmm.  Don't we also need to cover suspend-to-idle?
>
> Well, if you agree with the approach then I would look into it.

As long as the SYSTEM_SUSPEND system state is defined unambiguously, I
don't have a problem with doing this.
