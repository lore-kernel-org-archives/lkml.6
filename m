Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B853C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE742085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfBUMaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:30:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35022 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:30:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so13989851edp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RcKGq+tQ20NREKzWCndQOiEvbCD3YRYXIDRNdbR95uk=;
        b=Xi/0lOwMI9/MdyI0CgpgFxf2Qt6Q+CNfoawgNwrUO5zSw7Lc31oYeVtqfEnRm/OTnu
         DSKrnlD0argKBGD3BYPczKwj7YB5hilXqUP6qPgRFKJBvXimZwk2JAfJ1uKThxK+LMXH
         NPtALCmzS8OiQoiByaIq7VldqFtMfBUE0qS3U42dPMCi7jq7yP4+mAe55ssEYm/ZLiTq
         IpirAL/DQWRTShfJniSk7MoghjsmIZnpXGkm1GOay3C9KXavru15t3mK4WcvRCNiMLm4
         /yaEX5D95u+OnUWyU7oWtXcJXPPPvZVG8HyJSAQLJ7+VrFLNN9YXAsqIvuTSdEJStxm7
         kHng==
X-Gm-Message-State: AHQUAuZjfayK/M6RXay96sntI4snnb5Trlkgb2oWZQzSEAScp5QyXo8I
        LQtfr6G/VNDIBTaTSQrMySIVKq1qS48=
X-Google-Smtp-Source: AHgI3Iae5yIKErrnbvs5FZEGEvZAP1eiw2nzVpd2SwMVAQEjF3rmVH/ES/TZOEOOD1AXCd6Am/XoDg==
X-Received: by 2002:a50:eb82:: with SMTP id y2mr19093884edr.38.1550752221038;
        Thu, 21 Feb 2019 04:30:21 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f16sm2583159ejc.27.2019.02.21.04.30.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:30:20 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
Date:   Thu, 21 Feb 2019 13:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-19 22:47, Lendacky, Thomas wrote:
> On 2/19/19 3:01 PM, Thomas Gleixner wrote:
>> Hans,
>>
>> On Tue, 19 Feb 2019, Hans de Goede wrote:
>>
>> Cc+: ACPI/AMD folks
>>
>>> Various people are reporting false positive "do_IRQ: #.55 No irq handler for
>>> vector"
>>> messages on AMD ryzen based laptops, see e.g.:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
>>>
>>> Which contains this dmesg snippet:
>>>
>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up secondary CPUs
>>> ...
>>> Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP configuration:
>>> Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0, CPUs:      #1
>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq handler for
>>> vector
>>> Feb 07 20:14:29 localhost.localdomain kernel:  #2
>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq handler for
>>> vector
>>> Feb 07 20:14:29 localhost.localdomain kernel:  #3
>>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq handler for
>>> vector
>>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node, 4 CPUs
>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical packages: 1
>>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4 processors
>>> activated (15968.49 BogoMIPS)
>>>
>>> It seems that we get an IRQ for each CPU as we bring it online,
>>> which feels to me like it is some sorta false-positive.
>>
>> Sigh, that looks like BIOS value add again.
>>
>> It's not a false positive. Something _IS_ sending a vector 55 to these CPUs
>> for whatever reason.
>>
> 
> I remember seeing something like this in the past and it turned out to be
> a BIOS issue.  BIOS was enabling the APs to interact with the legacy 8259
> interrupt controller when only the BSP should. During POST the APs were
> exposed to ExtINT/INTR events as a result of the mis-configuration
> (probably due to a UEFI timer-tick using the 8259) and this left a pending
> ExtINT/INTR interrupt latched on the APs.
> 
> When the APs were started by the OS, the latched ExtINT/INTR interrupt is
> processed shortly after the OS enables interrupts. The AP then queries the
> 8259 to identify the vector number (which is the value of the 8259's ICW2
> register + the IRQ level). The master 8259's ICW2 was set to 0x30 and,
> since no interrupts are actually pending, the 8259 will respond with IRQ7
> (spurious interrupt) yielding a vector of 0x37 or 55.
> 
> The OS was not expecting vector 55 and printed the message.
> 
>  From the Intel Developer's Manual: Vol 3a, Section 10.5.1:
> "Only one processor in the system should have an LVT entry configured to
> use the ExtINT delivery mode."
> 
> Not saying this is the problem, but very well could be.

That sounds like a likely candidate, esp. also since this only happens
once per CPU when we first only the CPU.

Can you provide me with a patch with some printk-s / pr_debugs to
test for this, then I can build a kernel with that patch added and
we can see if your hypothesis is right.

Regards,

Hans


> 
> Thanks,
> Tom
> 
>>> I temporarily have access to a loaner laptop for a couple of weeks which shows
>>> the same errors and I would like to fix this, but I don't really know how to
>>> fix this.
>>
>> Can you please enable CONFIG_GENERIC_IRQ_DEBUGFS and dig in the files there
>> whether vector 55 is used on CPU0 and which device is associated to that.
>>
>> I bet its a legacy IRQ and as that space starts at 48 (IRQ0) this should be
>> IRQ9 which is usually - DRUMROLL - the ACPI interrupt.
>>
>> The kernel clearly sets that up to be delivered to CPU 0 only, but I've
>> seen that before that the BIOS value add thinks that this setup is not
>> relevant.
>>
>> /me goes off and sings LALALA
>>
>>> Note if you want I can set up root ssh-access to the laptop.
>>
>> As a least resort. root ssh - SHUDDER - Ooops now I spilled my preferred
>> password for that :)
>>
>> Thanks,
>>
>> 	tglx
>>
