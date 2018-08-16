Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A196C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B352147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B352147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391624AbeHPSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:09:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391394AbeHPSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:09:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AEE9E25A;
        Thu, 16 Aug 2018 15:09:55 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:09:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] console: Add console=auto option
Message-ID: <20180816150948.GA10648@kroah.com>
References: <20180816141055.451-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816141055.451-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:10:55AM -0400, Prarit Bhargava wrote:
> ACPI may contain an SPCR table that defines a default system console.
> On ARM if the table is present then the SPCR console is enabled by default.
> On x86 the SPCR console is used if 'earlycon' (no parameters) is
> specified as a kernel parameter and is used only as the early console.
> To use the SPCR data as a console a user must boot with 'earlycon',
> grep logs & specify a console= kernel parameter, and then reboot again.
> 
> Add 'console=auto' that enables a firmware or hardware console, and on
> x86 enable the SPCR console if 'console=auto' is specified.
> 
> Tested on systems with and without an ACPI SPCR.  The following kernel
> parameters were also tested:
> 
> console=ttyS0,115200    		works
> earlycon                		works (early console only)
> console=auto            		works (full console as expected)
> no console or earlycon arguments	works (no output as expected)
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Al Stone <ahs3@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: x86@kernel.org
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  1 +
>  arch/x86/kernel/acpi/boot.c                     |  5 +++++
>  include/linux/console.h                         |  1 +
>  kernel/printk/printk.c                          | 10 ++++++++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a32f2a126791..dd057224f33b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -635,6 +635,7 @@
>  
>  		hvc<n>	Use the hypervisor console device <n>. This is for
>  			both Xen and PowerPC hypervisors.
> +		auto	[X86] Enable ACPI SPCR console
>  
>  		If the device connected to the port is not a TTY but a braille
>  		device, prepend "brl," before the device type, for instance
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3b20607d581b..fb2616ba3b21 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>  	e820__update_table_print();
>  }
> +
> +void __init arch_console_setup(void)
> +{
> +	acpi_parse_spcr(false, true);
> +}

<snip>

> +int arch_console_setup(void);

Function does not match its prototype :(

How did you build this successfully?

