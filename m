Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0609C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C00920E20
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C00920E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeHPUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:23:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbeHPUXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:23:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33FA77A7EE;
        Thu, 16 Aug 2018 17:23:30 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C78E12027047;
        Thu, 16 Aug 2018 17:23:26 +0000 (UTC)
Subject: Re: [PATCH] console: Add console=auto option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
References: <20180816141055.451-1-prarit@redhat.com>
 <20180816150948.GA10648@kroah.com>
 <4335912e-dab7-c516-d71e-47ed479c638a@redhat.com>
 <20180816113311.676971d0@gandalf.local.home>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
Date:   Thu, 16 Aug 2018 13:23:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180816113311.676971d0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 16 Aug 2018 17:23:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 16 Aug 2018 17:23:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/16/2018 11:33 AM, Steven Rostedt wrote:
> On Thu, 16 Aug 2018 11:28:24 -0400
> Prarit Bhargava <prarit@redhat.com> wrote:
> 
>> On 08/16/2018 11:09 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Aug 16, 2018 at 10:10:55AM -0400, Prarit Bhargava wrote:  
>>>> ACPI may contain an SPCR table that defines a default system console.
>>>> On ARM if the table is present then the SPCR console is enabled by default.
>>>> On x86 the SPCR console is used if 'earlycon' (no parameters) is
>>>> specified as a kernel parameter and is used only as the early console.
>>>> To use the SPCR data as a console a user must boot with 'earlycon',
>>>> grep logs & specify a console= kernel parameter, and then reboot again.
>>>>
>>>> Add 'console=auto' that enables a firmware or hardware console, and on
>>>> x86 enable the SPCR console if 'console=auto' is specified.
>>>>
>>>> Tested on systems with and without an ACPI SPCR.  The following kernel
>>>> parameters were also tested:
>>>>
>>>> console=ttyS0,115200    		works
>>>> earlycon                		works (early console only)
>>>> console=auto            		works (full console as expected)
>>>> no console or earlycon arguments	works (no output as expected)
>>>>
>>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>>> Cc: Mark Salter <msalter@redhat.com>
>>>> Cc: Al Stone <ahs3@redhat.com>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: Len Brown <len.brown@intel.com>
>>>> Cc: Pavel Machek <pavel@ucw.cz>
>>>> Cc: x86@kernel.org
>>>> Cc: Petr Mladek <pmladek@suse.com>
>>>> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-pm@vger.kernel.org
>>>> ---
>>>>  Documentation/admin-guide/kernel-parameters.txt |  1 +
>>>>  arch/x86/kernel/acpi/boot.c                     |  5 +++++
>>>>  include/linux/console.h                         |  1 +
>>>>  kernel/printk/printk.c                          | 10 ++++++++++
>>>>  4 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index a32f2a126791..dd057224f33b 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -635,6 +635,7 @@
>>>>  
>>>>  		hvc<n>	Use the hypervisor console device <n>. This is for
>>>>  			both Xen and PowerPC hypervisors.
>>>> +		auto	[X86] Enable ACPI SPCR console
>>>>  
>>>>  		If the device connected to the port is not a TTY but a braille
>>>>  		device, prepend "brl," before the device type, for instance
>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>> index 3b20607d581b..fb2616ba3b21 100644
>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>> @@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>>>>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>>>>  	e820__update_table_print();
>>>>  }
>>>> +
>>>> +void __init arch_console_setup(void)
>>>> +{
>>>> +	acpi_parse_spcr(false, true);
>>>> +}  
>>>
>>> <snip>
>>>   
>>>> +int arch_console_setup(void);  
>>>
>>> Function does not match its prototype :(
>>>
>>> How did you build this successfully?  
>>
>> Weird, it compiles on my system?
> 
> Are you compiling with ACPI enabled?
> 

Yes, CONFIG_ACPI is enabled.

> It would still compile without it and use the properly prototyped
> "weak" function.

I did this:

1.  git co linux.git
2.  git am 0001-console-Add-console-auto-option.patch
3.  make -j224

and I have a clean compile with no warnings or errors.  My config is the
standard Fedora .config so it has CONFIG_ACPI enabled and CONFIG_ACPI_SPCR_TABLE
enabled.

IMO the compile should have warned or error'd out.  Is there a possibility that
some subtlety of weak functions that causes this to not be an error?

In any case, I've changed the prototype and other functions to void and am
finishing up retesting.

P.

> 
> -- Steve
> 
>>
>> I'll fix it though.
>>
