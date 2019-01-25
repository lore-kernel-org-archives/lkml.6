Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682D2218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAYKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:47:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:47:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so9805884wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ez7BVIK8CEDORi0eh6HkTa6FvfvmX8W90KQVvxq8NRQ=;
        b=cx0oUXUT18PWmu4izjae61qjX3CSFNaA5LKxyPNtEsJMyQwXXVZ8LWiYoS+wdlVr1k
         Z1pGlzX93yEaVei6Jxgojk7zZ4vaPb2vebNvlg7KELXnD6u7gsH/qy3DraMrUqWqYJjt
         jPifeRRg5Z65ZkIUBaPhJcgA2MSbFYsth9/lB5/PcXabKyqi4z3t5y/MKlvfLk4WDLie
         XW9dwYO1dcKdVdIIqmShzjC5DEFdK6sqqTZ8k6sthBEcjQqra0l+BQ2SAOrp1kDkT3va
         r210ItaEPeV9RWQElKaLSNcRZBYq8uZEy22pGG2X5TDJdGvaO1GtBR+P7K7yelgAs9sn
         gJBQ==
X-Gm-Message-State: AJcUukdlGoCuu6TgYncBIOzypVLeL0cBQreJXNNeLmJisnjYrhguV+Ha
        J6hzIP4ONj9THYWpHIaWGbdGUq9M1qk=
X-Google-Smtp-Source: ALg8bN5cgsGmKpb2uBPs3ME6XWWcHZBVJhytFb0rDRqHedS+2PaCdxWXxfhTgHaYEFP71AK+l5ojdQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr10925564wrp.61.1548413244356;
        Fri, 25 Jan 2019 02:47:24 -0800 (PST)
Received: from [10.200.153.26] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id y138sm73628707wmc.16.2019.01.25.02.47.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:47:23 -0800 (PST)
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Martin Sebor <msebor@gcc.gnu.org>, linux-kernel@vger.kernel.org
References: <20190123173707.GA16603@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <674267ed-6c9b-1307-3acf-019886605f91@redhat.com>
Date:   Fri, 25 Jan 2019 11:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123173707.GA16603@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 9:37 AM, Miguel Ojeda wrote:
> The upcoming GCC 9 release adds the -Wmissing-attributes warnings
> (enabled by -Wall), which trigger for all the init/cleanup_module
> aliases in the kernel (defined by the module_init/exit macros),
> ending up being very noisy.
> 
> These aliases point to the __init/__exit functions of a module,
> which are defined as __cold (among other attributes). However,
> the aliases themselves do not have the __cold attribute.
> 
> Since the compiler behaves differently when compiling a __cold
> function as well as when compiling paths leading to calls
> to __cold functions, the warning is trying to point out
> the possibly-forgotten attribute in the alias.
> 
> In order to keep the warning enabled, we choose to silence
> the warning by marking the aliases as __cold. This is possible
> marking either the extern declaration, the definition, or both.
> In order to avoid changing the behavior of callers, we do it
> only in the definition of the aliases (since those are not
> seen by any other TU).
> 
> Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> Note that an alternative is using the new copy attribute
> introduced by GCC 9 (Martin told me about it, as well as the
> new warning).
> 
> What I am concerned about using __copy is that I am not sure
> we should be copying all the attributes (even if some are
> blacklisted by the copy itself), since:
>    - We have unknown-to-GCC attributes (e.g. from plugins).
>    - We wouldn't enjoy the fix for older compilers
>      (e.g. if the fix had an actual impact).
> 
> So here I took the conservative approach for the moment,
> and we can discuss/apply whether another solution is best.
> 
> Jessica: please review what I explain in the commit message.
> Do we actually want the __cold attribute in the declaration
> as well? If yes, AFAIK, GCC would assume paths that end up
> calling the __init/__exit functions are not meant to be taken
> (but when we are asked to load modules, that is the expected
> path, no?).
> 
> I will put this in the compiler-attributes tree and get
> some time in linux-next, unless you want to pick it up!
> 
>   include/linux/module.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8fa38d3e7538..c4e805e87628 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -129,13 +129,13 @@ extern void cleanup_module(void);
>   #define module_init(initfn)					\
>   	static inline initcall_t __maybe_unused __inittest(void)		\
>   	{ return initfn; }					\
> -	int init_module(void) __attribute__((alias(#initfn)));
> +	int init_module(void) __cold __attribute__((alias(#initfn)));
>   
>   /* This is only required if you want to be unloadable. */
>   #define module_exit(exitfn)					\
>   	static inline exitcall_t __maybe_unused __exittest(void)		\
>   	{ return exitfn; }					\
> -	void cleanup_module(void) __attribute__((alias(#exitfn)));
> +	void cleanup_module(void) __cold __attribute__((alias(#exitfn)));
>   
>   #endif
>   
> 

Tested-by: Laura Abbott <labbott@redhat.com>
