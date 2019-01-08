Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178812087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W65T8RCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfAHSaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:30:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39159 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:30:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so4272136ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVChLnR3AiivkYUSmek/4Et4O/Csio/PUQK8m3BTvm8=;
        b=W65T8RCqaXrAaZbjZm4aCU0jUqpRNF+yKKEQEl4Hb2zpnnn8O38yETK6YITZ2JZNvs
         BR3LCvqlNHf71eAAzGESlQt8bg3vJA0F3HEvFG7afu39h7qP6Ows70AAS78aBlus2T3S
         lrdVY0iu1Yh1AP8qbS2xblc8jHM1sShOWsvU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVChLnR3AiivkYUSmek/4Et4O/Csio/PUQK8m3BTvm8=;
        b=tUoYrW/1yn1B4D+22ogENorTuXL7em1KWQxeV4ot0iMtFOXutXU7n3RO9CZ/L1KCMf
         0iPiWtjl3VSrVOlWMzw0YZDgB3Xj8NrAdExG1Wt8+dprRIldOZNmMfbCDAbTQ5BiT419
         IoHZQPasi9Vt9vp1G8q30jNn8irOm8eKVcAAYvEypYZ2UbM7dqitiCiUpnG6ogZu0FFJ
         y9ZzHGdqFyvQLvVIpDnmE6EqEjXQ2lzvQvwxwXwfy8UdzYTn5J2w6yVQ0hJwESe3WnFe
         SQf22n/KjAUYR74Wzag7spiF3HunN4fnDBWrgM5VTri25YG0vFEbvvtamSSU34KT8acl
         9dfA==
X-Gm-Message-State: AJcUukcLu+IUguBS+fxMK1NnH1vKTax9P7bCjvUbJsHQ/j00gm4yGReZ
        kR+1PAmWwmu6NjpqCi2m07JjrP5jqBc=
X-Google-Smtp-Source: ALg8bN6umf5t7sUHT38dxrSj0tNOR1QbLoew3PwIVGG7JuDTBadnDSB4W394MadFJHaz3zZnP1NSMQ==
X-Received: by 2002:a2e:681a:: with SMTP id c26-v6mr1632553lja.175.1546972242824;
        Tue, 08 Jan 2019 10:30:42 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z9sm13254140lfj.79.2019.01.08.10.30.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:30:42 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id q2-v6so4245166lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:30:41 -0800 (PST)
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr1475392lje.88.1546972241294;
 Tue, 08 Jan 2019 10:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20190103174657.251968-1-swboyd@chromium.org> <20190108174938.GA22547@codeaurora.org>
In-Reply-To: <20190108174938.GA22547@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 8 Jan 2019 10:30:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
Message-ID: <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch API
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:49 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Jan 03 2019 at 10:47 -0700, Stephen Boyd wrote:
> >Using the batch API from the interconnect driver sometimes leads to a
> >KASAN error due to an access to freed memory. This is easier to trigger
> >with threadirqs on the kernel commandline.
> >
> > BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
> > Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57
> >
> > CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
> > Call trace:
> >  dump_backtrace+0x0/0x2f8
> >  show_stack+0x20/0x2c
> >  __dump_stack+0x20/0x28
> >  dump_stack+0xcc/0x10c
> >  print_address_description+0x74/0x240
> >  kasan_report+0x250/0x26c
> >  __asan_report_load1_noabort+0x20/0x2c
> >  rpmh_tx_done+0x114/0x12c
> >  tcs_tx_done+0x450/0x768
> >  irq_forced_thread_fn+0x58/0x9c
> >  irq_thread+0x120/0x1dc
> >  kthread+0x248/0x260
> >  ret_from_fork+0x10/0x18
> >
> > Allocated by task 385:
> >  kasan_kmalloc+0xac/0x148
> >  __kmalloc+0x170/0x1e4
> >  rpmh_write_batch+0x174/0x540
> >  qcom_icc_set+0x8dc/0x9ac
> >  icc_set+0x288/0x2e8
> >  a6xx_gmu_stop+0x320/0x3c0
> >  a6xx_pm_suspend+0x108/0x124
> >  adreno_suspend+0x50/0x60
> >  pm_generic_runtime_suspend+0x60/0x78
> >  __rpm_callback+0x214/0x32c
> >  rpm_callback+0x54/0x184
> >  rpm_suspend+0x3f8/0xa90
> >  pm_runtime_work+0xb4/0x178
> >  process_one_work+0x544/0xbc0
> >  worker_thread+0x514/0x7d0
> >  kthread+0x248/0x260
> >  ret_from_fork+0x10/0x18
> >
> > Freed by task 385:
> >  __kasan_slab_free+0x12c/0x1e0
> >  kasan_slab_free+0x10/0x1c
> >  kfree+0x134/0x588
> >  rpmh_write_batch+0x49c/0x540
> >  qcom_icc_set+0x8dc/0x9ac
> >  icc_set+0x288/0x2e8
> >  a6xx_gmu_stop+0x320/0x3c0
> >  a6xx_pm_suspend+0x108/0x124
> >  adreno_suspend+0x50/0x60
> > cr50_spi spi5.0: SPI transfer timed out
> >  pm_generic_runtime_suspend+0x60/0x78
> >  __rpm_callback+0x214/0x32c
> >  rpm_callback+0x54/0x184
> >  rpm_suspend+0x3f8/0xa90
> >  pm_runtime_work+0xb4/0x178
> >  process_one_work+0x544/0xbc0
> >  worker_thread+0x514/0x7d0
> >  kthread+0x248/0x260
> >  ret_from_fork+0x10/0x18
> >
> > The buggy address belongs to the object at fffffff51414ac80
> >  which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 260 bytes inside of
> >  512-byte region [fffffff51414ac80, fffffff51414ae80)
> > The buggy address belongs to the page:
> > page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
> > flags: 0x4000000000008100(slab|head)
> > raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
> > raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                    ^
> >  fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >
> >The batch API sets the same completion for each rpmh message that's sent
> >and then loops through all the messages and waits for that single
> >completion declared on the stack to be completed before returning from
> >the function and freeing the message structures. Unfortunately, some
> >messages may still be in process and 'stuck' in the TCS. At some later
> >point, the tcs_tx_done() interrupt will run and try to process messages
> >that have already been freed at the end of rpmh_write_batch(). This will
> >in turn access the 'needs_free' member of the rpmh_request structure and
> >cause KASAN to complain.
> >
> Raju and I were discussing this solution and we think the issue may be
> because of a race condition between the thread calling the completion
> and the thread waiting for completion. Completion releases the waiting
> thread and then we try to read rpm_msg->needs_free after that. But, if
> we could read in the rpm_msg->needs_free before calling completion, we
> would not see the problem. How about this instead?
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c7beb6841289..0303a2971d4a 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>         struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
>                                                     msg);
>         struct completion *compl = rpm_msg->completion;
> +       bool free = rpm_msg->needs_free;
>
>         rpm_msg->err = r;
>
> @@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>         complete(compl);
>
>  exit:
> -       if (rpm_msg->needs_free)
> +       if (free)
>                 kfree(rpm_msg);
>  }
>

Hi Lina,
I think that's a worthy fix, too, and is needed to solve the issue you describe.

But I think Stephen's fix is still needed. In the rpmh_write_batch
scenario, we queue N things into rpmh, but set the same completion for
all of them. If only the first one completes but not the others, then
the loop in rpmh_write_batch will call wait_for_completion_timeout N
times on the same completion, and then goes on to free all N requests,
even though only the first one is actually done and out of the system
(well, almost out of the system, with the bug you noticed above).

We considered having just one completion on the last transfer, but
then if there's an error part way through you have no way of waiting
on the transfers that did get submitted. So I think N completions are
needed.
-Evan
