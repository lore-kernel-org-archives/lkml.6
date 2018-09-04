Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07C6206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07C6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDTus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:50:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34604 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:50:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id j25-v6so11660797wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojwXYoNsVYM3RbCDj1FHt/Dm0cBgaiFJCzY/Dhnkm+k=;
        b=uoPcVFWMWJ/i3ontKzowSb2Hg0j9Ql3q66iOsRRpBNBjfpWAgZAdM/9nCc5QRPBE/H
         78rTlEHqK2ziHfvySC+y9t4bkdxT01d5WRlR7PEOVG6qaEGJtXdbXTVv+4JIYNZweUex
         tjMC1CAd/H1xgFvftJ6q/W6+cBpmDuShX/ejDA4N7fd7vOe/hXU4JiVl5rJhBlkodmQH
         km6JVc6MIW/hQwESEb247qsnZvlW78fEe+uNlDJRSuxGJsUbtLzeu2CzxDAWCxr6P22F
         Ao++2LQURQaarvk6HXOxgQEa/mRtFcESGm4tfmqNI8TJHU6FuPnTyyqSaVLCfvUz87mr
         eK8A==
X-Gm-Message-State: APzg51CkQOuTdywDe/nDTpKyo3ulXA9IccU7R24SuZ1nkbtF5JjnHWDu
        MgFcQ0R4QSJh/KEsaoaYdDS/tQ==
X-Google-Smtp-Source: ANB0VdZwp+IguJFSiXsQkDjsh9MwsNqrsxCi+K3HyZd8P7F8x19QF0g66J6Gllm1290O/iAZH/1Niw==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr2773010wmc.24.1536074711089;
        Tue, 04 Sep 2018 08:25:11 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m68-v6sm23789312wmb.10.2018.09.04.08.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:25:10 -0700 (PDT)
Subject: Re: [PATCH] x86/setup: Deal with "quiet" commandline option earlier
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
References: <20180904144225.14831-1-hdegoede@redhat.com>
 <20180904144225.14831-2-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71db02a8-2732-85ee-bb66-14ac26f24eaf@redhat.com>
Date:   Tue, 4 Sep 2018 17:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180904144225.14831-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-09-18 16:42, Hans de Goede wrote:
> X86's setup_arch() calls parse_early_param() somewhat late, to make
> sure that everything is setup correcty to deal with earlyprintk over
> the EHCI debug port.
> 
> This means that a number of pr_info-s get done before
> "early_param("quiet", quiet_kernel)" from init/main.c gets processed.
> 
> Until commit 375899cddcbb ("printk: make sure to print log on console.")
> this was not a problem because the printk code would evaluate the
> console_loglevel vs the message-loglevel when flushing the buffer.
> 
> After this commit the check is done at the time that pr_info is actually
> called and the console_loglevel at calling time.
> 
> This causes the following messages to get printed with the "quiet" option:
> 
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> ...
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable
> 
> This commit fixes this by making x86's setup_arch() explicitly check for
> quiet early on.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Maninder Singh <maninder1.s@samsung.com>
> Fixes: 375899cddcbb ("printk: make sure to print log on console.")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self-nack, I accidentally still had the revert of commit
375899cddcbb ("printk: make sure to print log on console.") in
my tree while testing…

In order for my approach to work, we need to deal with the quiet
option even earlier, before the first pr_notice in init/main.c,
which requires access to the commandline before setup_arch()
which is the function which fills the boot_command_line on
several architectures.

So I think we need to look at a different approach.

I have one more idea, if that does not work out I think we
just need to revert 375899cddcbb ("printk: make sure to print log on console.")

Regards,

Hans




> ---
>   arch/x86/kernel/setup.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b4866badb235..38f66b14cf3d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -93,6 +93,7 @@
>   #include <asm/processor.h>
>   #include <asm/bugs.h>
>   #include <asm/kasan.h>
> +#include <asm/cmdline.h>
>   
>   #include <asm/vsyscall.h>
>   #include <asm/cpu.h>
> @@ -864,6 +865,16 @@ void __init setup_arch(char **cmdline_p)
>   	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
>   #endif
>   
> +#if !defined CONFIG_CMDLINE_BOOL || !defined CONFIG_CMDLINE_OVERRIDE
> +	/*
> +	 * We call parse_early_param() somewhat late, see x86_configure_nx()
> +	 * comment. Deal with "quiet" here to suppress printing of early
> +	 * boot messages when quiet has been requested.
> +	 */
> +	if (cmdline_find_option_bool(boot_command_line, "quiet"))
> +		console_loglevel = CONSOLE_LOGLEVEL_QUIET;
> +#endif
> +
>   	/*
>   	 * If we have OLPC OFW, we might end up relocating the fixmap due to
>   	 * reserve_top(), so do this before touching the ioremap area.
> 
