Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6B12086D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfBSVBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:01:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfBSVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:01:52 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gwCWP-00009n-KW; Tue, 19 Feb 2019 22:01:45 +0100
Date:   Tue, 19 Feb 2019 22:01:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
In-Reply-To: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
Message-ID: <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

On Tue, 19 Feb 2019, Hans de Goede wrote:

Cc+: ACPI/AMD folks

> Various people are reporting false positive "do_IRQ: #.55 No irq handler for
> vector"
> messages on AMD ryzen based laptops, see e.g.:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
> 
> Which contains this dmesg snippet:
> 
> Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up secondary CPUs
> ...
> Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP configuration:
> Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0, CPUs:      #1
> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq handler for
> vector
> Feb 07 20:14:29 localhost.localdomain kernel:  #2
> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq handler for
> vector
> Feb 07 20:14:29 localhost.localdomain kernel:  #3
> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq handler for
> vector
> Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node, 4 CPUs
> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical packages: 1
> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4 processors
> activated (15968.49 BogoMIPS)
> 
> It seems that we get an IRQ for each CPU as we bring it online,
> which feels to me like it is some sorta false-positive.

Sigh, that looks like BIOS value add again.

It's not a false positive. Something _IS_ sending a vector 55 to these CPUs
for whatever reason.

> I temporarily have access to a loaner laptop for a couple of weeks which shows
> the same errors and I would like to fix this, but I don't really know how to
> fix this.

Can you please enable CONFIG_GENERIC_IRQ_DEBUGFS and dig in the files there
whether vector 55 is used on CPU0 and which device is associated to that.

I bet its a legacy IRQ and as that space starts at 48 (IRQ0) this should be
IRQ9 which is usually - DRUMROLL - the ACPI interrupt.

The kernel clearly sets that up to be delivered to CPU 0 only, but I've
seen that before that the BIOS value add thinks that this setup is not
relevant.

/me goes off and sings LALALA

> Note if you want I can set up root ssh-access to the laptop.

As a least resort. root ssh - SHUDDER - Ooops now I spilled my preferred
password for that :)

Thanks,

	tglx
