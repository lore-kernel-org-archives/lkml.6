Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F88CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BD127C84
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD127C84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936100AbeF2UXD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:23:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38934 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbeF2UXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:23:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so835971oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp4j+1mT3nEK8eXHf7wO0e4Y9DH/Z1srsg1RBBuXTQo=;
        b=RXOkJsK0o8SRJNKj7eAHxDplfZOa92F8tbQ/Bf09fM8l5Y+6EJzsITehx5hsZWXiF3
         66flkUQGU+3uWDGpzlBfnXg4NtjG/JvQrZCI+4OR5Off837kL4HWFS/SQVtA6USJakKp
         QS5yHKY9fbL43ZNxAWmi/Aps3kbvmh+XvDhRxQkCP8j9Mqc8UeIgxmMk8VZGaBGhI0mO
         s5f5m/dwzvxjiD8gmnhrd0EJNwHVp2HmYABgC2nGB35Kl7vMCO3ocEPjDUH9M9T/C6+e
         drNRVzAfkhvF+Dv0nwjB6zdD+GXHsrHEokYak2AVLUq1uaYzoI40vFr9uTNi9+L+aBuZ
         BvYQ==
X-Gm-Message-State: APt69E2XaDmVXDKMk9qI79JNweenf03sirLzoC3bVnXOP3W/ZiHZPAuq
        +QxPvdCwKxgjYT/S6kD3tDCB8iVVjEM=
X-Google-Smtp-Source: AAOMgpceeQAxbwHQgCZAyCHN6zqqdQz0duZpvZSiaUT2dIRDgsvuw0as5cN4HzFMlfLcV77SnXuUnA==
X-Received: by 2002:aca:ce85:: with SMTP id e127-v6mr7540701oig.169.1530303780884;
        Fri, 29 Jun 2018 13:23:00 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b21-v6sm9745610oih.5.2018.06.29.13.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 13:22:59 -0700 (PDT)
Subject: Re: [PATCH] arm64: Clear the stack
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180629190553.7282-1-labbott@redhat.com>
 <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com>
Date:   Fri, 29 Jun 2018 13:22:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 01:19 PM, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
>> Implementation of stackleak based heavily on the x86 version
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> [...]
>> +#define current_top_of_stack() (task_stack_page(current) + THREAD_SIZE)
>> +#define on_thread_stack()      (on_task_stack(current, current_stack_pointer))
> 
> nit on types here. I get some warnings:
> 
> kernel/stackleak.c:55:12: warning: assignment makes integer from
> pointer without a cast [-Wint-conversion]
>     boundary = current_top_of_stack();
>              ^
> kernel/stackleak.c:65:24: warning: assignment makes integer from
> pointer without a cast [-Wint-conversion]
>    current->lowest_stack = current_top_of_stack() - THREAD_SIZE / 64;
>                          ^
> 
> So I think this needs to be:
> 
> +#define current_top_of_stack() ((unsigned long)task_stack_page(current) + \
> +                                THREAD_SIZE)
> 

Argh, missed that in an amend, can fix for next version if there
are no other objections to this approach.

>> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
>> index a535742a1c06..972ce4ca7f6a 100644
>> --- a/scripts/Makefile.gcc-plugins
>> +++ b/scripts/Makefile.gcc-plugins
>> @@ -37,11 +37,14 @@ ifdef CONFIG_GCC_PLUGINS
>>
>>     gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)    += stackleak_plugin.so
>>     gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)     += -DSTACKLEAK_PLUGIN -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
>> +  ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +    DISABLE_STACKLEAK_PLUGIN           += -fplugin-arg-stackleak_plugin-disable
>> +  endif
>>
>>     GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
>>
>>     export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
>> -  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
>> +  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN DISABLE_STACKLEAK_PLUGIN
>>
>>     ifneq ($(PLUGINCC),)
>>       # SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
> 
> If there is a v14, I think this hunk should be taken there, since it's
> part of the common code.
> 
> Otherwise, this works for me and passes the lkdtm tests.
> 
> -Kees
> 

Thanks,
Laura
