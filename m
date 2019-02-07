Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44DD21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549536881;
	bh=E3lSeFjpZUF6MJ2RhSuWQTiY9wElTj8VdCv6drTuuVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VL/6Xn9SRH7UAsfzCgnv+H8/ZoqllzJfQTD9Ixz+B8Rl3zaHGUPBCWadRec0ive/u
	 NkfdR715xMn47o4ePA4tHPTC9Gdy7kbuvuk0qtcYGH/WdgMHMbfLZnZ9xvJgVcFiOB
	 t1B5QWaPQI+LkV6xkNIZ4WvFR6xb+tWEVODK7izE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfBGKyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGKyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:54:38 -0500
Received: from linux-8ccs (ip5f5adbc2.dynamic.kabel-deutschland.de [95.90.219.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E3D21872;
        Thu,  7 Feb 2019 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549536877;
        bh=E3lSeFjpZUF6MJ2RhSuWQTiY9wElTj8VdCv6drTuuVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZP7FEC054fd9blizq9OocQp3UA9UG60LBGiVJdn6u8VFmNS67xUm5Et14j+ixJ4z
         4ZpZWO4RP7Qg1PWbJ1n7twtodU9AoRRK+EbMWiH9dVd0GhLWEciMcY+dmXvzoy+Enc
         lAJ75CdzFQS6ByS6UNULVEAHGosHIsit6a1CASKg=
Date:   Thu, 7 Feb 2019 11:54:31 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] include/linux/module.h: mark init/cleanup_module
 aliases as __init/exit
Message-ID: <20190207105431.GA26041@linux-8ccs>
References: <20190206175627.GA20399@gmail.com>
 <CANiq72=gS7=G6WbZ4jqybMBh44FeF7UeVEfeb1hN8uMAMt_2bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72=gS7=G6WbZ4jqybMBh44FeF7UeVEfeb1hN8uMAMt_2bw@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miguel Ojeda [06/02/19 22:19 +0100]:
>On Wed, Feb 6, 2019 at 6:56 PM Miguel Ojeda
><miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 8fa38d3e7538..1b5e370f1bc0 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -129,13 +129,13 @@ extern void cleanup_module(void);
>>  #define module_init(initfn)                                    \
>>         static inline initcall_t __maybe_unused __inittest(void)                \
>>         { return initfn; }                                      \
>> -       int init_module(void) __attribute__((alias(#initfn)));
>> +       int init_module(void) __init __attribute__((alias(#initfn)));
>>
>>  /* This is only required if you want to be unloadable. */
>>  #define module_exit(exitfn)                                    \
>>         static inline exitcall_t __maybe_unused __exittest(void)                \
>>         { return exitfn; }                                      \
>> -       void cleanup_module(void) __attribute__((alias(#exitfn)));
>> +       void cleanup_module(void) __exit __attribute__((alias(#exitfn)));
>
>It turns out that there are some modules without __init/__exit marked
>functions, which GCC complains about, since now the alias is in a
>different section than the target:
>
>  * In some cases, this is due to a missing __init/__exit marking
>(e.g. drivers/connector/connector.c). These should be fixed in any
>case.
>  * In other cases, the cleanup function is not marked as such because
>it is called from another place in the TU, like the init function
>(e.g. arch/x86/kvm/vmx.c). We would need to create an actual cleanup
>function (marked as __exit) that simply calls the current exit static
>function.

Grr, I guess it was not so simple after all. :)

>So we have a few alternatives:
>
>  1) Going only with __cold.
>  2) Using the new __copy attribute (because then they are copied only
>in the cases they are actually used).
>  3) Fix and go for __init/__exit. While this requires some tweaking
>as explained above, it would be good if we can achieve it since then
>we are enforcing proper __init/__exit markings for all modules
>(whereas __copy wouldn't spot).
>
>I think it is worth achieving 3), but that will take a bit more of
>time. In that case, I suggest we push 1) or 2) for the moment (so that
>the warning is fixed) and then work on fixing all instances. As soon
>as that is done, we can push 3).

My order of preference would be 2, 1, striving for 3 eventually. 

Thanks Miguel!

Jessica

