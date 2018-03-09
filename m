Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeCIRbt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:31:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39628 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbeCIRbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:31:48 -0500
X-Google-Smtp-Source: AG47ELu8YjdSjvKZWTQlaeGxd1Aome7iU9CwobS/P6XyHoJPQ/NaJz9KIpmkZtMzSxZk/P9Q3j/MLpUmUdBCINW6tlU=
MIME-Version: 1.0
In-Reply-To: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
References: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 9 Mar 2018 10:31:45 -0700
Message-ID: <CANLsYky8tQp8owOq2YdkR6GC=gUdJDLa5G42y7xHbPdNXi7Sfw@mail.gmail.com>
Subject: Re: [PATCH v2] perf machine: Fix load kernel symbol with '-k' option
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 March 2018 at 23:05, Leo Yan <leo.yan@linaro.org> wrote:
> On Hikey arm64 octa A53 platform, when use command './perf report -v
> -k vmlinux --stdio' it outputs below error info, and it skips to load
> kernel symbol and doesn't print symbol for event:
> Failed to open [kernel.kallsyms]_text, continuing without symbols.
>
> The regression is introduced by commit ("8c7f1bb37b29 perf machine: Move
> kernel mmap name into struct machine"), which changes the logic for
> machine mmap_name by removing function machine__mmap_name() and always
> use 'machine->mmap_name'.  Comparing difference between
> machine__mmap_name() and 'machine->mmap_name', the later one includes
> the string for specified kernel vmlinux string with option '-k' in
> command, but the old function machine__mmap_name() ignores vmlinux
> path string.  As result, event's mmap file name doesn't match with
> machine mmap file name anymore and it skips to load kernel symbol from
> vmlinux file.
>
> To resolve this issue, this patch adds extra checking for
> 'symbol_conf.vmlinux_name', when it has been set string so we can know
> it includes vmlinux path string specified for option '-k'. For this
> case it sets 'is_kernel_mmap' to true and run into flow to load kernel
> symbol from vmlinux.
>
> This patch has been verified with two commands: './perf report -v
> -k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
> -k vmlinux'.
>
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/machine.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 12b7427..3125871 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>         else
>                 kernel_type = DSO_TYPE_GUEST_KERNEL;
>
> -       is_kernel_mmap = memcmp(event->mmap.filename,
> -                               machine->mmap_name,
> -                               strlen(machine->mmap_name) - 1) == 0;
> +       /*
> +        * When symbol_conf.vmlinux_name is not NULL, it includes the specified
> +        * kernel vmlinux path with option '-k'.  So set 'is_kernel_mmap' to
> +        * true for creating machine symbol map.
> +        */
> +       if (symbol_conf.vmlinux_name)
> +               is_kernel_mmap = true;
> +       else
> +               is_kernel_mmap = memcmp(event->mmap.filename,
> +                                       machine->mmap_name,
> +                                       strlen(machine->mmap_name) - 1) == 0;
> +

I have tested this on my side and things work properly.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>


>         if (event->mmap.filename[0] == '/' ||
>             (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
>                 map = machine__findnew_module_map(machine, event->mmap.start,
> --
> 2.7.4
>
