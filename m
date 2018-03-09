Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeCIJl6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:41:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:32889 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCIJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:41:53 -0500
X-Google-Smtp-Source: AG47ELtNX7qOekRgfH6lVwMa4o+Q8YCA8godbdBzcRGy9VqW+NHSbxr5EX4E1Dc352gAv6cJ2RnlYgyW55yTH1XNHxE=
MIME-Version: 1.0
In-Reply-To: <93864477-75bb-3f73-1d06-03d128b04f94@nokia.com>
References: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
 <20180309084151.2379-3-alexander.sverdlin@nokia.com> <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
 <93864477-75bb-3f73-1d06-03d128b04f94@nokia.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Mar 2018 09:41:52 +0000
Message-ID: <CAKv+Gu8BxDdF1V9g_c44p8Dj=WH5VVpyD5GyHs=N_jeP4Epc+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 March 2018 at 08:54, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> Hello Ard!
>
> On 09/03/18 09:50, Ard Biesheuvel wrote:
>>> +static u32 fixed_plts[] = {
>>> +       FTRACE_ADDR,
>>> +       MCOUNT_ADDR,
>>> +#ifdef CONFIG_OLD_MCOUNT
>>> +       (unsigned long)ftrace_caller_old,
>>> +       (unsigned long)mcount,
>>> +#endif
>>> +};
>>> +
>> Do we need this stuff in the PLT loader if ftrace is disabled?
>
> You are right, it probably would not even build w/o FTRACE.
> I'll fix it, thanks for looking into this!
>

Also, perhaps you can make the array const (after you put #ifdef's
around all entries)

>>>  static bool in_init(const struct module *mod, unsigned long loc)
>>>  {
>>>         return loc - (u32)mod->init_layout.base < mod->init_layout.size;
>>> @@ -31,26 +41,43 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>  {
>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>                                                           &mod->arch.init;
>>> +       int idx;
>>> +       struct plt_entries *plt;
>>> +
>>> +       /* Pre-allocate entries in the first plt */
>>> +       if (!pltsec->plt_count) {
>>> +               plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>> +               for (idx = 0; idx < ARRAY_SIZE(plt->ldr); ++idx)
>>> +                       plt->ldr[idx] = PLT_ENT_LDR;
>>> +               memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
>>> +               pltsec->plt_count = ARRAY_SIZE(fixed_plts);
>>> +               /*
>>> +                * cache the address,
>>> +                * ELF header is available only during module load
>>> +                */
>>> +               pltsec->plt_ent = plt;
>>> +       }
>>> +       plt = pltsec->plt_ent;
>>>
>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>> -       int idx = 0;
>>> +       idx = ARRAY_SIZE(fixed_plts);
>>> +       while (idx)
>>> +               if (plt->lit[--idx] == val)
>>> +                       return (u32)&plt->ldr[idx];
>>>

... and put all this handling in a helper function that only gets
called if ARRAY_SIZE() > 0

AFAICT, that should allow you to leave the rest unchanged.
