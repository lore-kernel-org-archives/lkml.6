Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1FC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620CF218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfA3IVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:21:54 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42932 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfA3IVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:21:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so13711779vsd.9;
        Wed, 30 Jan 2019 00:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXRoeRbZly/zcIscio6rfCE5e28iEH5JSota4EpbSNQ=;
        b=drxDBs4t4mjF9Kp6kQMr+mbR/SPGRGKr5YyrhVuxP5Hn5Vb653hSOgCUcdSS8QRPW8
         aDhmHXlZ7WfAT8TNA/66XWn83BEpdGlM6kuHZ7WiMqFdr++hftkboMlckzi5muW9XOGG
         2ihzYS2TBtWQoizzqt8eeRs/bVpbho7EClsIY4q+cgPSf17/3s6/pgC2gQjkuB3UedQ0
         RCVKVaX3xItQi61ten0sM/UA1qABXgFofjctlT4wtsmfteyCATO2gR+UfPZnmxyheRQN
         lzZO0kJek7FMcecA9wSUP7RqrFuokorkutyEs6XjGrDWOCs7t68EvTOQpa8NEALItgwy
         QcXQ==
X-Gm-Message-State: AJcUukeej7obpU94ptyVS7PWoNAYQXchUUm+aPqYDYZ/ukd88CiN+i1H
        urgNbltpKaZlXUuhzS3Tk80zpBB9rPKpg8kWrwk=
X-Google-Smtp-Source: ALg8bN4Tcw9HDIoapB7MuAWG2VV78bc4r7NqYlnepWvt9ph8hOZQ5WJoqrEpETHahfxCo6RFRg4xwGkLyr/USHRgwaw=
X-Received: by 2002:a67:f43:: with SMTP id 64mr12335445vsp.166.1548836512519;
 Wed, 30 Jan 2019 00:21:52 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jan 2019 09:21:41 +0100
Message-ID: <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns instead which is lock safe for such case
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks for your patch!

/**
 * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
 *
 * This timestamp is not guaranteed to be monotonic across an update.
 * The timestamp is calculated by:
 *
 *      now = base_mono + clock_delta * slope
 *
 * So if the update lowers the slope, readers who are forced to the
 * not yet updated second array are still using the old steeper slope.
 *
 * tmono
 * ^
 * |    o  n
 * |   o n
 * |  u
 * | o
 * |o
 * |12345678---> reader order
 *
 * o = old slope
 * u = update
 * n = new slope
 *
 * So reader 6 will observe time going backwards versus reader 5.
 *
 * While other CPUs are likely to be able observe that, the only way
 * for a CPU local observation is when an NMI hits in the middle of
 * the update. Timestamps taken from that NMI context might be ahead
 * of the following timestamps. Callers need to be aware of that and
 * deal with it.
 */

As this function is not guaranteed to be monotonic, have you checked how
the Runtime PM code behaves if time goes backwards? Does it just make
a suboptimal decision or does it crash?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
