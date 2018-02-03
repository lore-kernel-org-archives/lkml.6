Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBCPMd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:12:33 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37462 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeBCPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:12:27 -0500
X-Google-Smtp-Source: AH8x227qshTIStxZg2VzfQdTQzSraTvivLCSdVLol/nX4dmjL0Bq/i0B/bh1PMTwQrWkLxD0OOp8DIlIV6wtb3I+X6w=
MIME-Version: 1.0
In-Reply-To: <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
References: <20180202153240.1190361-1-arnd@arndb.de> <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 3 Feb 2018 16:12:26 +0100
X-Google-Sender-Auth: U19QGXl6zMHn4IyZydIohMrxwzI
Message-ID: <CAK8P3a2AdziKXR=4LwMzUdoL2q2WXYZZz1uM9yh6VX2FbpqnnA@mail.gmail.com>
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 12:33 AM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> On 02/02/2018 10:32 AM, Arnd Bergmann wrote:
>> The legacy hypercall handlers were originally added with
>> a comment explaining that "copying the argument structures in
>> HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
>> variable is sufficiently safe" and only made sure to not write
>> past the end of the argument structure, the checks in linux/string.h
>> disagree with that, when link-time optimizations are used:
>>
>> In function 'memcpy',
>>     inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
>>     inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
>>     inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
>>     inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
>> include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>>    __read_overflow2();
>>    ^
>> make[3]: *** [ccLujFNx.ltrans15.ltrans.o] Error 1
>> make[3]: Target 'all' not remade because of errors.
>> lto-wrapper: fatal error: make returned 2 exit status
>> compilation terminated.
>> ld: error: lto-wrapper failed
>>
>> This changes the functions so that each argument is accessed with
>> exactly the correct length based on the command code.
>>
>> Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/xen/fallback.c | 94 ++++++++++++++++++++++++++++----------------------
>>  1 file changed, 53 insertions(+), 41 deletions(-)
>>

>>       default:
>> -             WARN_ON(rc != -ENOSYS);
>> -             break;
>> +             return -ENOSYS;
>>       }
>>
>> +     memcpy(&op.u, arg, len);
>> +     rc = _hypercall1(int, event_channel_op_compat, &op);
>> +     memcpy(arg, &op.u, len);
>
>
> We don't copy back for all commands, only those that are COPY_BACK.

Not sure what you mean. Is it harmful to copy back the data for the others
in any way? Otherwise I wouldn't micro-optimize this.

        Arnd
