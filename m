Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBDTAB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 14:00:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42200 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeBDS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 13:59:52 -0500
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180202153240.1190361-1-arnd@arndb.de>
 <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
 <CAK8P3a2AdziKXR=4LwMzUdoL2q2WXYZZz1uM9yh6VX2FbpqnnA@mail.gmail.com>
 <1e3424f4-771b-51ad-3630-0faf47e388e0@oracle.com>
 <CAK8P3a3v=SMcuOtG6xLt0rpAoPx-ox_TaQ=g+stNVWH4HBciHw@mail.gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <87946d71-5c94-1045-2e96-347423820d5c@oracle.com>
Date: Sun, 4 Feb 2018 13:55:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3v=SMcuOtG6xLt0rpAoPx-ox_TaQ=g+stNVWH4HBciHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802040253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2018 10:35 AM, Arnd Bergmann wrote:
> On Sat, Feb 3, 2018 at 6:08 PM, Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>>
>> On 02/03/2018 10:12 AM, Arnd Bergmann wrote:
>>> On Sat, Feb 3, 2018 at 12:33 AM, Boris Ostrovsky
>>> <boris.ostrovsky@oracle.com> wrote:
>>>> On 02/02/2018 10:32 AM, Arnd Bergmann wrote:
>>>>> The legacy hypercall handlers were originally added with
>>>>> a comment explaining that "copying the argument structures in
>>>>> HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
>>>>> variable is sufficiently safe" and only made sure to not write
>>>>> past the end of the argument structure, the checks in linux/string.h
>>>>> disagree with that, when link-time optimizations are used:
>>>>>
>>>>> In function 'memcpy',
>>>>>       inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
>>>>>       inlined from '__startup_pirq' at
>>>>> drivers/xen/events/events_base.c:529:2,
>>>>>       inlined from 'restore_pirqs' at
>>>>> drivers/xen/events/events_base.c:1439:3,
>>>>>       inlined from 'xen_irq_resume' at
>>>>> drivers/xen/events/events_base.c:1581:2:
>>>>> include/linux/string.h:350:3: error: call to '__read_overflow2' declared
>>>>> with attribute error: detected read beyond size of object passed as 2nd
>>>>> parameter
>>>>>      __read_overflow2();
>>>>>      ^
>>>>> make[3]: *** [ccLujFNx.ltrans15.ltrans.o] Error 1
>>>>> make[3]: Target 'all' not remade because of errors.
>>>>> lto-wrapper: fatal error: make returned 2 exit status
>>>>> compilation terminated.
>>>>> ld: error: lto-wrapper failed
>>>>>
>>>>> This changes the functions so that each argument is accessed with
>>>>> exactly the correct length based on the command code.
>>>>>
>>>>> Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for
>>>>> very old hypervisors")
>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>>> ---
>>>>>    drivers/xen/fallback.c | 94
>>>>> ++++++++++++++++++++++++++++----------------------
>>>>>    1 file changed, 53 insertions(+), 41 deletions(-)
>>>>>
>>>>>         default:
>>>>> -             WARN_ON(rc != -ENOSYS);
>>>>> -             break;
>>>>> +             return -ENOSYS;
>>>>>         }
>>>>>
>>>>> +     memcpy(&op.u, arg, len);
>>>>> +     rc = _hypercall1(int, event_channel_op_compat, &op);
>>>>> +     memcpy(arg, &op.u, len);
>>>>
>>>>
>>>> We don't copy back for all commands, only those that are COPY_BACK.
>>>
>>> Not sure what you mean. Is it harmful to copy back the data for the others
>>> in any way? Otherwise I wouldn't micro-optimize this.
>>
>>
>> I should have checked the original commit for fallback.c --- the code that
>> it replaced was doing copybacks for all hypercalls and selective copybacks
>> is an optimization introduced in that commit.
> It was not an optimization but a correctness fix to avoid overflowing
> the caller stack on the copy-back operation. What I tried to explain
> in my commit message is that the same fix is also needed on
> the copy-out before it. It's only a read access beyond the end
> of a local variable, but not both the static checks and kasan-stack
> get alarmed about it.
>

Yes, I understand that. I was referring to:

     Move the fallback code into out-of-line functions, and handle all of
     the operations known by this old a hypervisor individually: *Some don't
     require copying back anything at all*, and for the rest use the
     individual argument structures' sizes rather than the container's

in the original commit. I.e. prior to that commit we *were* copying back 
for all commands (although possibly with potentially incorrect size). So 
not copying back for some commands was an optimization.

In any case,

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
