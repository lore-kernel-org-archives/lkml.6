Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDSRQK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:16:10 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:47042 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeDSRQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:16:08 -0400
X-Google-Smtp-Source: AIpwx4/AbihCv17IPhKmz62T+o4S2WKudcK8wH4gdM/+6ZLozKeubxOV+2WtDwrJDA9d9tbW4DGAvq2zuvj11XxLg2Q=
MIME-Version: 1.0
In-Reply-To: <20180416171106.rlm2nrvrxfoodcvf@redbean>
References: <20180411190509.24995-1-malat@debian.org> <20180416171106.rlm2nrvrxfoodcvf@redbean>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 19 Apr 2018 19:15:47 +0200
X-Google-Sender-Auth: xTG_DKqMNuL-NomsmzG7-6DZV2Y
Message-ID: <CA+7wUszXLPQy=tv87mH78F1ngoY44wSc8DcptsZnwJhC1cH+bQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/module: silence a gcc warning
To: Jessica Yu <jeyu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JHGGx2016392

Hi Jessica,

On Mon, Apr 16, 2018 at 7:11 PM, Jessica Yu <jeyu@kernel.org> wrote:
> +++ Mathieu Malaterre [11/04/18 21:05 +0200]:
>>
>> In commit 8c8ef42aee8f ("module: include other structures in module
>> version
>> check"), the function `struct_module` was renamed to `module_layout` but
>> no
>> prototype was added to `include/linux/module.h`. Remove warning triggered
>> at W=1:
>>
>>  kernel/module.c:4378:6: warning: no previous prototype for
>> ‘module_layout’ [-Wmissing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> include/linux/module.h | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index d44df9b2c131..28046e8b7e9d 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -786,6 +786,14 @@ extern int module_sysfs_initialized;
>>
>> #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:"
>> #x)
>>
>> +#ifdef CONFIG_MODVERSIONS
>> +void module_layout(struct module *mod,
>> +                  struct modversion_info *ver,
>> +                  struct kernel_param *kp,
>> +                  struct kernel_symbol *ks,
>> +                  struct tracepoint * const *tp);
>> +#endif /* CONFIG_MODVERSIONS */
>> +
>
>
> Hi Mathieu,
>
> We're going to need a forward declaration in module.h for struct tracepoint
> to address the kbuild warnings.

Well that what I also thought at first. But since line 433 already does:

struct tracepoint * const *tracepoints_ptrs;

I suspect I should instead add sentinels: #ifdef CONFIG_TRACEPOINTS/#endif

Will try out shortly.

> Thanks,
>
> Jessica
>
>
>> /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
>>
>> #define __MODULE_STRING(x) __stringify(x)
>> --
>> 2.11.0
>>
>
