Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeEBF3w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:29:52 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32972 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:29:49 -0400
X-Google-Smtp-Source: AB8JxZo0nA1UBeSggm6Oa4z7BS5ylY3g8+lyjst7lOHovCB89GZkVO/ZkUW92zcBbK7lUioEvCRbVjS0Tm+vlun9Yxw=
MIME-Version: 1.0
In-Reply-To: <1525237251-32496-1-git-send-email-leo.yan@linaro.org>
References: <1525237251-32496-1-git-send-email-leo.yan@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 1 May 2018 22:29:46 -0700
X-Google-Sender-Auth: b6u9d_CVY9wa2wowmJyj4vDDg6Y
Message-ID: <CAGXu5jJjCJuDNOJPMHmu94naQvKke47LVv-Y=t9vji88FtkRDw@mail.gmail.com>
Subject: Re: [PATCH] coresight: Remove %px for printing pcsr value
To: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 10:00 PM, Leo Yan <leo.yan@linaro.org> wrote:
> The driver prints pcsr twice: the first time it uses specifier %px to
> print hexadecimal pcsr value and the second time uses specifier %pS for
> output kernel symbols.
>
> As suggested by Kees, using %pS should be sufficient and %px isn't
> necessary; the reason is if the pcsr is a kernel space address, we can
> easily get to know the code line from %pS format, on the other hand, if
> the pcsr value doesn't fall into kernel space range (e.g. if the CPU is
> stuck in firmware), %pS also gives out pcsr hexadecimal value.
>
> So this commit removes useless %px and update section "Output format"
> in the document for alignment between the code and document.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/trace/coresight-cpu-debug.txt       | 4 ++--
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
> index 2b9b51c..89ab09e 100644
> --- a/Documentation/trace/coresight-cpu-debug.txt
> +++ b/Documentation/trace/coresight-cpu-debug.txt
> @@ -177,11 +177,11 @@ Here is an example of the debugging output format:
>  ARM external debug module:
>  coresight-cpu-debug 850000.debug: CPU[0]:
>  coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
> -coresight-cpu-debug 850000.debug:  EDPCSR:  [<ffff00000808e9bc>] handle_IPI+0x174/0x1d8
> +coresight-cpu-debug 850000.debug:  EDPCSR:  handle_IPI+0x174/0x1d8
>  coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
>  coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
>  coresight-cpu-debug 852000.debug: CPU[1]:
>  coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
> -coresight-cpu-debug 852000.debug:  EDPCSR:  [<ffff0000087fab34>] debug_notifier_call+0x23c/0x358
> +coresight-cpu-debug 852000.debug:  EDPCSR:  debug_notifier_call+0x23c/0x358
>  coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
>  coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 9cdb3fb..78a054e 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
>         }
>
>         pc = debug_adjust_pc(drvdata);
> -       dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
> +       dev_emerg(dev, " EDPCSR:  %pS\n", (void *)pc);
>
>         if (drvdata->edcidsr_present)
>                 dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
