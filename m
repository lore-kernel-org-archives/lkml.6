Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E11261E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E11261E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeFYW3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:29:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753155AbeFYW3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C7C87A7E8;
        Mon, 25 Jun 2018 22:29:11 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-121-147.rdu2.redhat.com [10.10.121.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7EB7C24;
        Mon, 25 Jun 2018 22:29:10 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
To:     Laura Abbott <labbott@redhat.com>, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
 <d110c9af-cb68-5a3c-bc70-0c7650edb0d4@redhat.com>
 <cfd52ae6-6fea-1a5a-b2dd-4dfdd65acd15@redhat.com>
From:   Christoph von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <2e4d9686-835c-f4be-2647-2344899e3cd4@redhat.com>
Date:   Mon, 25 Jun 2018 18:29:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cfd52ae6-6fea-1a5a-b2dd-4dfdd65acd15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 25 Jun 2018 22:29:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 25 Jun 2018 22:29:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'crecklin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 03:44 PM, Laura Abbott wrote:
> On 06/25/2018 08:22 AM, Christoph von Recklinghausen wrote:
>> Add correct address for linux-mm
>>
>> On 06/25/2018 11:08 AM, Chris von Recklinghausen wrote:
>>> Enabling HARDENED_USER_COPY causes measurable regressions in the
>>> networking performances, up to 8% under UDP flood.
>>>
>>> A generic distro may want to enable HARDENED_USER_COPY in their default
>>> kernel config, but at the same time, such distro may want to be able to
>>> avoid the performance penalties in with the default configuration and
>>> enable the stricter check on a per-boot basis.
>>>
>>> This change adds a config variable and a boot parameter to
>>> conditionally
>>> enable HARDENED_USER_COPY at boot time, and switch HUC to off if
>>> HUC_DEFAULT_OFF is set.
>>>
>>> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
>>> ---
>>>   .../admin-guide/kernel-parameters.rst         |  2 ++
>>>   .../admin-guide/kernel-parameters.txt         |  3 ++
>>>   include/linux/thread_info.h                   |  7 +++++
>>>   mm/usercopy.c                                 | 28
>>> +++++++++++++++++++
>>>   security/Kconfig                              | 10 +++++++
>>>   5 files changed, 50 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.rst
>>> b/Documentation/admin-guide/kernel-parameters.rst
>>> index b8d0bc07ed0a..c3035038e3ae 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.rst
>>> +++ b/Documentation/admin-guide/kernel-parameters.rst
>>> @@ -100,6 +100,8 @@ parameter is applicable::
>>>       FB    The frame buffer device is enabled.
>>>       FTRACE    Function tracing enabled.
>>>       GCOV    GCOV profiling is enabled.
>>> +    HUC    Hardened usercopy is enabled
>>> +    HUCF    Hardened usercopy disabled at boot
>>>       HW    Appropriate hardware is enabled.
>>>       IA-64    IA-64 architecture is enabled.
>>>       IMA     Integrity measurement architecture is enabled.
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>> b/Documentation/admin-guide/kernel-parameters.txt
>>> index efc7aa7a0670..cd3354bc14d3 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -816,6 +816,9 @@
>>>       disable=    [IPV6]
>>>               See Documentation/networking/ipv6.txt.
>>>   +    enable_hardened_usercopy [HUC,HUCF]
>>> +            Enable hardened usercopy checks
>>> +
>>>       disable_radix    [PPC]
>>>               Disable RADIX MMU mode on POWER9
>>>   diff --git a/include/linux/thread_info.h
>>> b/include/linux/thread_info.h
>>> index 8d8821b3689a..140a36cc1c2c 100644
>>> --- a/include/linux/thread_info.h
>>> +++ b/include/linux/thread_info.h
>>> @@ -109,12 +109,19 @@ static inline int
>>> arch_within_stack_frames(const void * const stack,
>>>   #endif
>>>     #ifdef CONFIG_HARDENED_USERCOPY
>>> +#include <linux/jump_label.h>
>>> +
>>> +DECLARE_STATIC_KEY_FALSE(bypass_usercopy_checks);
>>> +
>>>   extern void __check_object_size(const void *ptr, unsigned long n,
>>>                       bool to_user);
>>>     static __always_inline void check_object_size(const void *ptr,
>>> unsigned long n,
>>>                             bool to_user)
>>>   {
>>> +    if (static_branch_likely(&bypass_usercopy_checks))
>>> +        return;
>>> +
>>>       if (!__builtin_constant_p(n))
>>>           __check_object_size(ptr, n, to_user);
>>>   }
>>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>>> index e9e9325f7638..ce3996da1b2e 100644
>>> --- a/mm/usercopy.c
>>> +++ b/mm/usercopy.c
>>> @@ -279,3 +279,31 @@ void __check_object_size(const void *ptr,
>>> unsigned long n, bool to_user)
>>>       check_kernel_text_object((const unsigned long)ptr, n, to_user);
>>>   }
>>>   EXPORT_SYMBOL(__check_object_size);
>>> +
>>> +DEFINE_STATIC_KEY_FALSE(bypass_usercopy_checks);
>>> +EXPORT_SYMBOL(bypass_usercopy_checks);
>>> +
>>> +#ifdef CONFIG_HUC_DEFAULT_OFF
>>> +#define HUC_DEFAULT false
>>> +#else
>>> +#define HUC_DEFAULT true
>>> +#endif
>>> +
>>> +static bool enable_huc_atboot = HUC_DEFAULT;
>>> +
>>> +static int __init parse_enable_usercopy(char *str)
>>> +{
>>> +    enable_huc_atboot = true;
>>> +    return 1;
>>> +}
>>> +
>>> +static int __init set_enable_usercopy(void)
>>> +{
>>> +    if (enable_huc_atboot == false)
>>> +        static_branch_enable(&bypass_usercopy_checks);
>>> +    return 1;
>>> +}
>>> +
>>> +__setup("enable_hardened_usercopy", parse_enable_usercopy);
>>> +
>>> +late_initcall(set_enable_usercopy);
>>> diff --git a/security/Kconfig b/security/Kconfig
>>> index c4302067a3ad..a6173897b85c 100644
>>> --- a/security/Kconfig
>>> +++ b/security/Kconfig
>>> @@ -189,6 +189,16 @@ config HARDENED_USERCOPY_PAGESPAN
>>>         been removed. This config is intended to be used only while
>>>         trying to find such users.
>>>   +config HUC_DEFAULT_OFF
>>> +    bool "allow CONFIG_HARDENED_USERCOPY to be configured but
>>> disabled"
>>> +    depends on HARDENED_USERCOPY
>>> +    help
>>> +      When CONFIG_HARDENED_USERCOPY is enabled, disable its
>>> +      functionality unless it is enabled via at boot time
>>> +      via the "enable_hardened_usercopy" boot parameter. This allows
>>> +      the functionality of hardened usercopy to be present but not
>>> +      impact performance unless it is needed.
>>> +
>>>   config FORTIFY_SOURCE
>>>       bool "Harden common str/mem functions against buffer overflows"
>>>       depends on ARCH_HAS_FORTIFY_SOURCE
>>
>>
>
> This seems a bit backwards, I'd much rather see hardened user copy
> default to on with the basic config option and then just have a command
> line option to turn it off.
>
> Thanks,
> Laura

I have a small set of customers that want CONFIG_HARDENED_USERCOPY
enabled, and a large number of customers who would be impacted by its
default behavior (before my change).  The desire was to have the smaller
number of users need to change their boot lines to get the behavior they
wanted. Adding CONFIG_HUC_DEFAULT_OFF was an attempt to preserve the
default behavior of existing users of CONFIG_HARDENED_USERCOPY (default
enabled) and allowing that to coexist with the desires of the greater
number of my customers (default disabled).

If folks think that it's better to have it enabled by default and the
command line option to turn it off I can do that (it is simpler). Does
anyone else have opinions one way or the other?

Thanks,

Chris

