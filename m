Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC5208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAC5208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeHQN3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:29:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQN3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:29:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1EB172645;
        Fri, 17 Aug 2018 10:26:41 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6E951745B;
        Fri, 17 Aug 2018 10:26:38 +0000 (UTC)
Subject: Re: [PATCH v2] console: Add console=auto option
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817081947.m425gok2ugt7tglp@pathway.suse.cz>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <00c60dca-60bc-8568-eaa3-d4b0c326cab4@redhat.com>
Date:   Fri, 17 Aug 2018 06:26:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180817081947.m425gok2ugt7tglp@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 10:26:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 10:26:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/17/2018 04:19 AM, Petr Mladek wrote:
> On Thu 2018-08-16 13:39:01, Prarit Bhargava wrote:
>> ACPI may contain an SPCR table that defines a default system console.
>> On ARM if the table is present then the SPCR console is enabled by default.
>> On x86 the SPCR console is used if 'earlycon' (no parameters) is
>> specified as a kernel parameter and is used only as the early console.
>> To use the SPCR data as a console a user must boot with 'earlycon',
>> grep logs & specify a console= kernel parameter, and then reboot again.
>>
>> Add 'console=auto' that enables a firmware or hardware console, and on
>> x86 enable the SPCR console if 'console=auto' is specified.
> 
> I basically like the idea. Just one or two nits below.
> 
> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a32f2a126791..dd057224f33b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -635,6 +635,7 @@
>>  
>>  		hvc<n>	Use the hypervisor console device <n>. This is for
>>  			both Xen and PowerPC hypervisors.
>> +		auto	[X86] Enable ACPI SPCR console
> 
> The "auto" option sounds reasonable. But earlycon does exactly this
> when used without no extra options. I prefer to stay consistent
> with the existing earlycon behavior.

Hi Petr, on x86 earlycon still only enables the early console but does not
enable the console.

> 
> 
>>  		If the device connected to the port is not a TTY but a braille
>>  		device, prepend "brl," before the device type, for instance
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 3b20607d581b..fb2616ba3b21 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>>  	e820__update_table_print();
>>  }
>> +
>> +void __init arch_console_setup(void)
>> +{
>> +	acpi_parse_spcr(false, true);
> 
> Just for record. I was curious that this might be called twice
> (also from acpi_boot_init(). But it looks safe after all.
> 

Yes, the console code prevents the same console from being registered twice.

> The trick is in the two bool parameters. One call allows to
> register/enable earlycon and ignores normal console. This other
> call does exactly the opposite. I do not see any unwanted side
> effects.

Thanks.  I'd like to know if you (or anyone else) has strong feelings about
changing the behaviour of earlycon on x86?  I could make it so that specifying
just earlycon would also initialize the console.

P.

> 
> Best Regards,
> Petr
> 
