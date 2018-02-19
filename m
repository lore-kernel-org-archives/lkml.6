Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeBSOFj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:05:39 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46276 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeBSOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:05:38 -0500
X-Google-Smtp-Source: AH8x225nsEtlYWQiiTIuO7aB9RVbFZGzdKYmMyVVmwRFSjFRuw8qgBPsRjULQsP8FQDdKn91O1t6ZF2VWmvOi8nM7n8=
MIME-Version: 1.0
In-Reply-To: <20180219122108.GD14978@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org> <20180215122635.24029-7-jolsa@kernel.org>
 <20180219022036.GB1583@sejong> <20180219122108.GD14978@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Feb 2018 23:05:16 +0900
X-Google-Sender-Auth: 8ExcE8krn-MjkD-VTFZUaLVHSp8
Message-ID: <CAM9d7cju4zUkQy+p6brsitnSMrc_aEm=NQvOHvwCrSh2xRoyjA@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf tools: Don't search for active kernel start in __machine__create_kernel_maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Feb 19, 2018 at 9:21 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Mon, Feb 19, 2018 at 11:20:36AM +0900, Namhyung Kim escreveu:
>> On Thu, Feb 15, 2018 at 01:26:32PM +0100, Jiri Olsa wrote:
>> >     if (!machine__get_running_kernel_start(machine, &name, &addr)) {
>> >             if (name &&
>> >                 maps__set_kallsyms_ref_reloc_sym(machine->vmlinux_maps, name, addr)) {
>> >                     machine__destroy_kernel_maps(machine);
>> >                     return -1;
>> >             }
>> > +           machine__set_kernel_mmap(machine, addr, 0);
>> >     }
>
>> > +   /*
>> > +    * Now that we have all the maps created, just set the ->end of them:
>> > +    */
>> > +   map_groups__fixup_end(&machine->kmaps);
>>
>> With above change, I think it work.  But the whole point of the above
>> is to set the end address of vmlinux and modules.  And now we don't
>> need it for modules thanks to modules__parse() for passing the size.
>>
>> So we only needs to update the end address of vmlinux using the start
>> address of the first module.  What about this then?
>
> Looks ok, Jiri? I noticed that Namhyung has the patch below in his git
> tree, but I couldn't find it in the mailing list, Jiri, can I have your
> acked-by?

This version has a bug that misses the call when there's no module.
I'll send a new version if Jiri agrees with the idea.

Thanks,
Namhyung


>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index fe27ef55cbb9..022f0539b750 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -1021,13 +1021,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
>>         return ret;
>>  }
>>
>> -static void map_groups__fixup_end(struct map_groups *mg)
>> -{
>> -       int i;
>> -       for (i = 0; i < MAP__NR_TYPES; ++i)
>> -               __map_groups__fixup_end(mg, i);
>> -}
>> -
>>  static char *get_kernel_version(const char *root_dir)
>>  {
>>         char version[PATH_MAX];
>> @@ -1235,6 +1228,7 @@ int machine__create_kernel_maps(struct machine *machine)
>>  {
>>         struct dso *kernel = machine__get_kernel(machine);
>>         const char *name = NULL;
>> +       struct map *map;
>>         u64 addr = 0;
>>         int ret;
>>
>> @@ -1261,13 +1255,13 @@ int machine__create_kernel_maps(struct machine *machine)
>>                         machine__destroy_kernel_maps(machine);
>>                         return -1;
>>                 }
>> -               machine__set_kernel_mmap(machine, addr, 0);
>>         }
>>
>> -       /*
>> -        * Now that we have all the maps created, just set the ->end of them:
>> -        */
>> -       map_groups__fixup_end(&machine->kmaps);
>> +       /* update end address of the kernel map using adjacent module address */
>> +       map = map__next(machine__kernel_map(machine));
>> +       if (map)
>> +               machine__set_kernel_mmap(machine, addr, map->start);
>> +
>>         return 0;
>>  }
