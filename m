Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDDPdd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:33:33 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44699 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeDDPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:33:27 -0400
X-Google-Smtp-Source: AIpwx4954JcaTwjY3hSvIwW8c+PQvD1RHo8LAEejb+ISytgyDPbUFMiIp1bBXZZV581lkqUtxIm9Eg==
Subject: Re: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES
 messages
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org,
        will.deacon@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org,
        gengdongjiu@huawei.com, linux-kernel@vger.kernel.org,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
 <20180403170830.29282-4-mr.nuke.me@gmail.com>
 <338e9bb4-a837-69f9-36e5-5ee2ddcaaa38@arm.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d6492b41-612a-b256-44c9-4ff3b3d5ae4b@gmail.com>
Date: Wed, 4 Apr 2018 10:33:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <338e9bb4-a837-69f9-36e5-5ee2ddcaaa38@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 04/04/2018 02:18 AM, James Morse wrote:
> Hi Alexandru,
> 
> On 03/04/18 18:08, Alexandru Gagniuc wrote:
>> BIOSes like to send NMIs for a number of silly reasons often deemed
>> to be "fatal". For example pin bounce during a PCIE hotplug/unplug
>> might cause the link to go down and retrain, with fatal PCI errors
>> being generated while the link is retraining.
> 
> Sounds fun!
> 
> 
>> Instead of panic()ing in NMI context, pass fatal errors down to IRQ
>> context to see if they can be resolved.
> 
> How do we know we will survive this trip?

We don't.


> On arm64 systems it may not be possible to return to the context we took the NMI
> notification from: we may bounce back into firmware with the same "world is on
> fire" error. Firmware can rightly assume the OS has made no attempt to handle
> the error. 

I'm not aware of the NMI path being used on arm64:
$ git grep 'select HAVE_ACPI_APEI_NMI'
arch/x86/Kconfig:       select HAVE_ACPI_APEI_NMI               if ACPI
$

A far as jumping back into firmware, the OS should clear the GHES block
status before exiting the NMI. THis tells the firmware that the OS got
the message [1]
I'm not seeing any mechanism to say "handled/not handled", so I'm not
sure how firmware can make such assumptions.


> Your 'not re-arming the error' example makes this worrying.

Those are one class of bugs you get when you let firmware run the show.
It's been an issue since day one of EFI. The best you can do in such
cases is accept you may later lose the link to a device.
Side-note: We have a BIOS defect filed with against this particular
issue, and it only seems to affect PCIe SMIs.


>> With these change, PCIe error are handled by AER. Other far less
>> common errors, such as machine check exceptions, still cause a panic()
>> in their respective handlers.
> 
> I agree AER is always going to be different. Could we take a look at the CPER
> records while still in_nmi() to decide whether linux knows better than firmware?
> 
> For non-standard or processor-errors I think we should always panic() if they're
> marked as fatal.
> For memory-errors we could split memory_failure() up to have
> {NMI,IRQ,process}-context helpers, all we need to know at NMI-time is whether
> the affected memory is kernel memory.

I'm trying to avoid splitting up the recovery logic based on _how_ we
were notified of the error. The only sure way to know if you've handled
an error is to try to handle it. Not handling _any_ fatal error still
results in a panic(), and I was very careful to ensure that.

The alternative is to keep ghes_do_proc() and ghes_notify_nmi() in sync,
duplicate code between the two. But we can also get ghes_proc_irq_work()
as an entry point, and this easily turns in a maintenance nightmare.

> For the PCI*/AER errors we should be able to try and handle it ... if we can get
> back to process/IRQ context:
> What happens if a PCIe driver has interrupts masked and is doing something to
> cause this error? We can take the NMI and setup the irq-work, but it may never
> run as we return to interrupts-masked context.

The way the recovery from NMI is set up is confusing. On NMIs,
ghes_proc_in_irq() is queued up to do further work. Despite the name, in
this case it runs as a task. That further queues up AER work,
Either way, PCIe endpoint interrupts are irrelevant here. AER recovery
runs independent of drivers or interrupts:
 - Drivers that implement AER recovery services are expected to do the
right thing and shut down IO. To not do so, is a bug in the driver.
 - Drivers that do not implement AER have their devices taken offline.

It is not uncommon for PCIe errors to amplify. Imagine losing the link
right after you've fired off several DMA queues. You'd get a stream of
Unsupported Request errors. AER handles this fairly well.

> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 2c998125b1d5..7243a99ea57e 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -955,7 +962,7 @@ static void __process_error(struct ghes *ghes)
>>  static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>  {
>>  	struct ghes *ghes;
>> -	int sev, ret = NMI_DONE;
>> +	int ret = NMI_DONE;
>>  
>>  	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>>  		return ret;
>> @@ -968,13 +975,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>  			ret = NMI_HANDLED;
>>  		}
>>  
>> -		sev = ghes_severity(ghes->estatus->error_severity);
>> -		if (sev >= GHES_SEV_PANIC) {
>> -			oops_begin();
>> -			ghes_print_queued_estatus();
>> -			__ghes_panic(ghes);
>> -		}
>> -
>>  		if (!(ghes->flags & GHES_TO_CLEAR))
>>  			continue;
> 
> For Processor-errors I think this is the wrong thing to do, but we should be
> able to poke around in the CPER records and find out what we are dealing with.

I don't think being trigger-happy with the panic button is ever a good
thing. The logic to stop the system exists downstream, and is being
called. I can see an issue if we somehow lose the ability to run queued
tasks, but in that case, we've already lost control of the machine.

Alex

[1] ACPI 6.2 spec.
18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10)

> Thanks,
> 
> James
> 
