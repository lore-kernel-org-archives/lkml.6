Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755808AbeDQQUU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:20:20 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:47062 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755813AbeDQQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:10:21 -0400
X-Google-Smtp-Source: AIpwx49MhYNdBuRQplPSIvZjo+2qKMDxxR5+bVy1QTMSFH5FiGFjvc9S0uYr0ZSuPNcm5QYBmkNhJjrWDHQWffSh4xM=
MIME-Version: 1.0
In-Reply-To: <a967eb54-9c54-f9a7-f92a-0ae3d8eb60ba@de.ibm.com>
References: <20180417082054.26978-1-tmricht@linux.ibm.com> <a967eb54-9c54-f9a7-f92a-0ae3d8eb60ba@de.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Apr 2018 09:10:19 -0700
X-Google-Sender-Auth: KEKmz8j8si55kJ0WjB-gaZZVBfw
Message-ID: <CAGXu5j+oyYUiWF1PjnWyGQcaRWW8Tvwr7tQRQhCQj5+BWYjg2A@mail.gmail.com>
Subject: Re: [PATCH] modules: Fix display of wrong module .text address
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        brueckner@linux.vnet.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 1:24 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 04/17/2018 10:20 AM, Thomas Richter wrote:
>> In kernel v4.16.0 the module .text address is displayed
>> wrong when using /sys/module/*/sections/.text file.
>> Commit ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when
>> not restricting")
>> is the first bad commit.
>>
>> Here is the issue, using module qeth_l2 on s390 which is the
>> ethernet device driver:
>>
>> [root@s35lp76 ~]# lsmod
>> Module                  Size  Used by
>> qeth_l2                94208  1
>> ...
>>
>> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>> qeth_l2 94208 1 - Live 0x000003ff80401000
>>                        ^ This is the correct address in memory
>> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>> 0x0000000018ea8363      <---- This is a wrong address
>> [root@s35lp76 ~]#
>>
>> This breaks the perf tool which uses this address on s390
>> to calculate start of .text section in memory.
>>
>> Fix this by printing the correct (unhashed) address.
>>
>> Thanks to Jessica Yu for helping on this.
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>
> CC stable?
>
>> ---
>>  kernel/module.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index a6e43a5806a1..77ab7211ddef 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1472,7 +1472,7 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
>>  {
>>       struct module_sect_attr *sattr =
>>               container_of(mattr, struct module_sect_attr, mattr);
>> -     return sprintf(buf, "0x%pK\n", (void *)sattr->address);
>> +     return sprintf(buf, "%#lx\n", kptr_restrict < 2 ? sattr->address : 0);

Can we use %px instead, just to make the hash-bypass reports easier to grep for?

-Kees

>>  }
>>
>>  static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>>
>



-- 
Kees Cook
Pixel Security
