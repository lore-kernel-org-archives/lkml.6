Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017E92549A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017E92549A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeF3Una (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:43:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751503AbeF3Un3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A4CD87A83;
        Sat, 30 Jun 2018 20:43:28 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 915742026D69;
        Sat, 30 Jun 2018 20:43:27 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v3] add param that allows bootline control of hardened
 usercopy
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <1530101255-13988-1-git-send-email-crecklin@redhat.com>
 <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com>
From:   Christoph von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com>
Date:   Sat, 30 Jun 2018 16:43:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 30 Jun 2018 20:43:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 30 Jun 2018 20:43:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'crecklin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2018 04:11 PM, Kees Cook wrote:
> On Wed, Jun 27, 2018 at 5:07 AM, Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
>> Enabling HARDENED_USER_COPY causes measurable regressions in
> nit: HARDENED_USERCOPY
>
>>  networking performance, up to 8% under UDP flood.
>>
>> I'm running an a small packet UDP flood using pktgen vs. a host b2b
>> connected. On the receiver side the UDP packets are processed by a
>> simple user space process that just reads and drops them:
>>
>> https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.c
>>
>> Not very useful from a functional PoV, but it helps to pin-point
>> bottlenecks in the networking stack.
>>
>> When running a kernel with CONFIG_HARDENED_USERCOPY=y, I see a 5-8%
>> regression in the receive tput, compared to the same kernel without
>> this option enabled.
>>
>> With CONFIG_HARDENED_USERCOPY=y, perf shows ~6% of CPU time spent
>> cumulatively in __check_object_size (~4%) and __virt_addr_valid (~2%).
>>
>> The call-chain is:
>>
>> __GI___libc_recvfrom
>> entry_SYSCALL_64_after_hwframe
>> do_syscall_64
>> __x64_sys_recvfrom
>> __sys_recvfrom
>> inet_recvmsg
>> udp_recvmsg
>> __check_object_size
>>
>> udp_recvmsg() actually calls copy_to_iter() (inlined) and the latters
>> calls check_copy_size() (again, inlined).
> Thanks for including these details!
>
>> A generic distro may want to enable HARDENED_USER_COPY in their default
> same nit :)

Sorry, I'll fix those.

>
>> kernel config, but at the same time, such distro may want to be able to
>> avoid the performance penalties in with the default configuration and
>> disable the stricter check on a per-boot basis.
>>
>> This change adds a boot parameter that conditionally disables
>> HARDENED_USERCOPY at boot time.
>>
>> v2->v3:
>>         add benchmark details to commit comments
>>         Don't add new item to Documentation/admin-guide/kernel-parameters.rst
>>         rename boot param to "hardened_usercopy="
>>         update description in Documentation/admin-guide/kernel-parameters.txt
>>         static_branch_likely -> static_branch_unlikely
>>         add __ro_after_init versions of DEFINE_STATIC_KEY_FALSE,
>>                 DEFINE_STATIC_KEY_TRUE
>>         disable_huc_atboot -> enable_checks (strtobool "on" == true)
>>
>> v1->v2:
>>         remove CONFIG_HUC_DEFAULT_OFF
>>         default is now enabled, boot param disables
>>         move check to __check_object_size so as to not break optimization of
>>                 __builtin_constant_p()
>>         include linux/atomic.h before linux/jump_label.h
>>
>> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++
>>  include/linux/jump_label.h                    |  6 +++++
>>  include/linux/thread_info.h                   |  5 ++++
>>  mm/usercopy.c                                 | 26 +++++++++++++++++++
>>  4 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc7aa7a0670..560d4dc66f02 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -816,6 +816,17 @@
>>         disable=        [IPV6]
>>                         See Documentation/networking/ipv6.txt.
>>
>> +       hardened_usercopy=
>> +                        [KNL] Under CONFIG_HARDENED_USERCOPY, whether
>> +                        hardening is enabled for this boot. Hardened
>> +                        usercopy checking is used to protect the kernel
>> +                        from reading or writing beyond known memory
>> +                        allocation boundaries as a proactive defense
>> +                        against bounds-checking flaws in the kernel's
>> +                        copy_to_user()/copy_from_user() interface.
>> +                on      Perform hardened usercopy checks (default).
>> +                off     Disable hardened usercopy checks.
>> +
>>         disable_radix   [PPC]
>>                         Disable RADIX MMU mode on POWER9
>>
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index b46b541c67c4..1a0b6f17a5d6 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -299,12 +299,18 @@ struct static_key_false {
>>  #define DEFINE_STATIC_KEY_TRUE(name)   \
>>         struct static_key_true name = STATIC_KEY_TRUE_INIT
>>
>> +#define DEFINE_STATIC_KEY_TRUE_RO(name)        \
>> +       struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
>> +
>>  #define DECLARE_STATIC_KEY_TRUE(name)  \
>>         extern struct static_key_true name
>>
>>  #define DEFINE_STATIC_KEY_FALSE(name)  \
>>         struct static_key_false name = STATIC_KEY_FALSE_INIT
>>
>> +#define DEFINE_STATIC_KEY_FALSE_RO(name)       \
>> +       struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
>> +
>>  #define DECLARE_STATIC_KEY_FALSE(name) \
>>         extern struct static_key_false name
>>
>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 8d8821b3689a..ab24fe2d3f87 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -109,6 +109,11 @@ static inline int arch_within_stack_frames(const void * const stack,
>>  #endif
>>
>>  #ifdef CONFIG_HARDENED_USERCOPY
>> +#include <linux/atomic.h>
>> +#include <linux/jump_label.h>
>> +
>> +DECLARE_STATIC_KEY_FALSE(bypass_usercopy_checks);
>> +
> This isn't needed any more since bypass_usercopy_checks is internal to
> __check_object_size() now.

I'll remove that.

>
>>  extern void __check_object_size(const void *ptr, unsigned long n,
>>                                         bool to_user);
>>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index e9e9325f7638..39f8b1409618 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -20,6 +20,8 @@
>>  #include <linux/sched/task.h>
>>  #include <linux/sched/task_stack.h>
>>  #include <linux/thread_info.h>
>> +#include <linux/atomic.h>
>> +#include <linux/jump_label.h>
>>  #include <asm/sections.h>
>>
>>  /*
>> @@ -248,6 +250,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>>   */
>>  void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>>  {
>> +       if (static_branch_unlikely(&bypass_usercopy_checks))
>> +               return;
>> +
>>         /* Skip all tests if size is zero. */
>>         if (!n)
>>                 return;
>> @@ -279,3 +284,24 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>>         check_kernel_text_object((const unsigned long)ptr, n, to_user);
>>  }
>>  EXPORT_SYMBOL(__check_object_size);
>> +
>> +DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> This can be static.
>
>> +EXPORT_SYMBOL(bypass_usercopy_checks);
> No longer needs to be exported.
>
>> +
>> +static bool enable_checks __initdata = true;
>> +
>> +static int __init parse_hardened_usercopy(char *str)
>> +{
>> +       return strtobool(str, &enable_checks);
>> +}
>> +
>> +__setup("hardened_usercopy=", parse_hardened_usercopy);
>> +
>> +static int __init set_hardened_usercopy(void)
>> +{
>> +       if (enable_checks == false)
>> +               static_branch_enable(&bypass_usercopy_checks);
>> +       return 1;
>> +}
>> +
>> +late_initcall(set_hardened_usercopy);
> Otherwise, yeah, this looks good if the copy_from_iter() path can't be improved.

The last issue I'm chasing is build failures on ARCH=m68k. The error is
atomic_read and friends needed by the jump label code not being found.
The config has CONFIG_BROKEN_ON_SMP=y, so the jump label calls I added
will only be made #ifndef CONFIG_BROKEN_ON_SMP. Do you think that's
worth a mention in the blurb that's added to
Documentation/admin-guide/kernel-parameters.txt?

Thanks,

Chris

>
> -Kees
>

