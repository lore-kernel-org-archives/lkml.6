Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEBNkf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:40:35 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36701 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:40:33 -0400
X-Google-Smtp-Source: AB8JxZoToWWGgxP9ZX4AJUTd6l/2hCpulki4HE7Q9EsjksoioX0iKkyKRQPZ31g7GUK+qvR/sZNpGzT76I8SgaeFBsU=
MIME-Version: 1.0
In-Reply-To: <20180426103133.GA6953@linaro.org>
References: <20180412091822.GG12256@bigcity.dyn.berto.se> <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se> <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se> <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
 <20180420160013.GA13769@linaro.org> <20180422221827.GB27674@bigcity.dyn.berto.se>
 <20180423095420.GA23995@linaro.org> <20180425225603.GA26177@bigcity.dyn.berto.se>
 <20180426103133.GA6953@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 15:40:31 +0200
X-Google-Sender-Auth: TjGrEOftXi4he1oBMEmiDGs0370
Message-ID: <CAMuHMdXhfA6XEhY_C6bsSurMQVEMen484f8ZTs9X=q4cZSJcWQ@mail.gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42Degeo017972

Hi Vincent,

On Thu, Apr 26, 2018 at 12:31 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> Le Thursday 26 Apr 2018 à 00:56:03 (+0200), Niklas Söderlund a écrit :
>> Here are the result, sorry for the delay.
>>
>> On 2018-04-23 11:54:20 +0200, Vincent Guittot wrote:
>>
>> [snip]
>>
>> >
>> > Thanks for the report. Can you re run with the following trace-cmd sequence ? My previous sequence disables ftrace events
>> >
>> > trace-cmd reset > /dev/null
>> > trace-cmd start -b 40000 -p function -l dump_backtrace:traceoff -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
>> > trace-cmd start -b 40000 -p function -l dump_backtrace -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
>> >
>> > I have updated the patch and added traces to check that scheduler returns from idle_balance function and doesn't stay stuck
>>
>> Once more I applied the change bellow on-top of c18bb396d3d261eb ("Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>>
>> This time the result of 'trace-cmd report' is so large I do not include
>> it here, but I attach the trace.dat file. Not sure why but the timing of
>> sending the NMI to the backtrace print is different (but content the
>> same AFIK) so in the odd change it can help figure this out:
>>
>
> Thanks for the trace, I have been able to catch a problem with it.
> Could you test the patch below to confirm that the problem is solved ?
> The patch apply on-top of
> c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")
>
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Date: Thu, 26 Apr 2018 12:19:32 +0200
> Subject: [PATCH] sched/fair: fix the update of blocked load when newly idle
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> With commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle"),
> we release the rq->lock when updating blocked load of idle CPUs. This open
> a time window during which another CPU can add a task to this CPU's cfs_rq.
> The check for newly added task of idle_balance() is not in the common path.
> Move the out label to include this check.
>
> Fixes: 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
