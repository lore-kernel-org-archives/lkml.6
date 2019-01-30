Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A83C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B73218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548888936;
	bh=oMrJKF17pErY8vdizP0pGkB+pQKVNwzV5MKv/m9vv2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1gi1svlO7Ze/5lpKZWXvhGVxXXX9E/T+q98uJGAYc/IGt97Gjs3Gk/gpwqgI2PYQT
	 Mv79QSIqwjl2waHC9edQOcUglA1kvN9A6/yAs7rZ6irvDGzTM3t8pO0brnk6AOzR6q
	 Hvd7If1eR0FhhcdOy5r/6G96aQAuk2rmCVWDtSDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfA3Wze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:55:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46589 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfA3Wze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 17:55:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so1108701otm.13;
        Wed, 30 Jan 2019 14:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuA330KElE94ag75CUZF0JfLlQgGpCicSadKqqJDO2M=;
        b=TF3ZPtgmjYDUfIWCEAvj6lkOSKq9FTzRdP6LVjXzV4UbfN7MsJWW3x2YVVY1r5hEmH
         c5Q6TnymvxyYumGuZ907+vAMTOAFB0XscJtpopGaW+/PXSmizj4GiWQzPK1p99ECVnvN
         pE+yAzhBEJ2nM9m4zyn6izTRbMtU75JpEPEBVNgkX+/622DgoxUi8uuwxaJhyNoNe74t
         y2IjopX8/YRk/zwe9IyYqMsbmJsaQQmRuM6Wwq/Qn0Qmo1M7+ZMm0OpWY8kt3tBo43dc
         sPTqdvBeVAOAwjZbUr8fjJIuJlpFy1niB6ImNUu24Cq7BKfMSupcluy9pKVzxZ49KgGc
         MbgA==
X-Gm-Message-State: AJcUuke7mDe7qxt3X4gWWMCbcE/eVVooiwr6PTd9+qmwN2EiXvHZ8B1b
        QOGN8R+kPLIT3RMoXF5qQYrcWBUqI3TlrUaUv1ufxA==
X-Google-Smtp-Source: ALg8bN5WmlZghK92UzFWWO/bpgaQE+0vzBzrN5Lq8REMLjdrp+ANVFp49w+PVDNz/myAVI16mzVYyEsNcw/EoGNppFM=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr24659825otg.139.1548885192162;
 Wed, 30 Jan 2019 13:53:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jan 2019 22:53:00 +0100
Message-ID: <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
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
> Use ktime_get_mono_fast_ns() instead which is lock safe for such case
>
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update and as a result can goes backward. According to
> update_fast_timekeeper() description: "In the worst case, this can
> result is a slightly wrong timestamp (a few nanoseconds)". For
> PM runtime autosuspend, this means only that the suspend decision can
> be slightly sub optimal.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Hi Rafael,
>
> Sorry, I sent the version with the typo mistake that generated the compilation error
> reported by kbuild-test-robot
>
> This version doesn't have the typo.

OK, I've applied this one, thanks!
