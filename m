Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeDWSmF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:42:05 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43365 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeDWSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:42:00 -0400
X-Google-Smtp-Source: AIpwx4/0aMorYPdAylBaVtw4dyH4n0EHxgAGP/vOVC8lRSa1/7BKhyYWOcrWiYiU2xT7Vv+25lRLch4OjCn6J4+psFM=
MIME-Version: 1.0
In-Reply-To: <CA+7wUszXLPQy=tv87mH78F1ngoY44wSc8DcptsZnwJhC1cH+bQ@mail.gmail.com>
References: <20180411190509.24995-1-malat@debian.org> <20180416171106.rlm2nrvrxfoodcvf@redbean>
 <CA+7wUszXLPQy=tv87mH78F1ngoY44wSc8DcptsZnwJhC1cH+bQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 23 Apr 2018 20:41:39 +0200
X-Google-Sender-Auth: 98--8mHYfVn1tkFL8OpvhAmXVCo
Message-ID: <CA+7wUsxuQUM_KaP=E-C4ebLL8MheuNZL-iznBKSBTGxCG8EpHA@mail.gmail.com>
Subject: Re: [PATCH] kernel/module: silence a gcc warning
To: Jessica Yu <jeyu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NIgDOP028893

On Thu, Apr 19, 2018 at 7:15 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi Jessica,
>
> On Mon, Apr 16, 2018 at 7:11 PM, Jessica Yu <jeyu@kernel.org> wrote:
>> +++ Mathieu Malaterre [11/04/18 21:05 +0200]:
>>>
>>> In commit 8c8ef42aee8f ("module: include other structures in module
>>> version
>>> check"), the function `struct_module` was renamed to `module_layout` but
>>> no
>>> prototype was added to `include/linux/module.h`. Remove warning triggered
>>> at W=1:
>>>
>>>  kernel/module.c:4378:6: warning: no previous prototype for
>>> ‘module_layout’ [-Wmissing-prototypes]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>> include/linux/module.h | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index d44df9b2c131..28046e8b7e9d 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -786,6 +786,14 @@ extern int module_sysfs_initialized;
>>>
>>> #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:"
>>> #x)
>>>
>>> +#ifdef CONFIG_MODVERSIONS
>>> +void module_layout(struct module *mod,
>>> +                  struct modversion_info *ver,
>>> +                  struct kernel_param *kp,
>>> +                  struct kernel_symbol *ks,
>>> +                  struct tracepoint * const *tp);
>>> +#endif /* CONFIG_MODVERSIONS */
>>> +
>>
>>
>> Hi Mathieu,
>>
>> We're going to need a forward declaration in module.h for struct tracepoint
>> to address the kbuild warnings.
>
> Well that what I also thought at first. But since line 433 already does:
>
> struct tracepoint * const *tracepoints_ptrs;
>
> I suspect I should instead add sentinels: #ifdef CONFIG_TRACEPOINTS/#endif

No that's missing totally the point.

> Will try out shortly.

Please drop the patch, fix is uglier than leaving the warning.

>> Thanks,
>>
>> Jessica
>>
>>
>>> /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
>>>
>>> #define __MODULE_STRING(x) __stringify(x)
>>> --
>>> 2.11.0
>>>
>>
