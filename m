Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC07120658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqsQCPiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC07120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJSXyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:54:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46385 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:54:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id p143-v6so14554063lfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6rf62TxAXASgOhg9e3zSdT2Ym1eFmFjJWE7Rtl4Q7w=;
        b=IqsQCPiqMcgRL5+JkRoTvKL3KamYU38jn0J7e9mFDM1U4FPS7W/LfVsEY7LLDDU6K9
         lSaL5fvN6IdRSRqEAHKjJxQDiaPFVsXzlw3UvPE6WNTGe5L3NJY3vQFexCCjSE/fr5c9
         oAVDdzYGsG6T+3rNN3SEkgQnhlRx6A3nOqDvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6rf62TxAXASgOhg9e3zSdT2Ym1eFmFjJWE7Rtl4Q7w=;
        b=YK2PX5YVf/4x5/+HInViSETdDwF2hd5hKLH/amoYlv5xe6y0vt16635YmXSaIdf6Kg
         uioE5bPQavJNsJUt8/6G0aqWGX0wGeuRo/GiYUbjS1KAKqArRpdaz6rRSZDpFGFxMy+B
         i/244IDvAzddixNoAh6uxzNMR6mYY3GRmvyByZGVvI3GT6O4MVuKZ+w0EHSaZmBHiY17
         jv9ww7eAKQQNkLxWcYzg7dN7YNcjMuHC34yjHVAqUkvMUnA4fu0OaY5mioa4q4LSmtNd
         3dafcKVtYzU5WnzCp6bv392WRRWkEABPznLt4GOJ6DHYPHDEBwVvqnLG68wzCRp85Kkw
         7w/w==
X-Gm-Message-State: ABuFfogPcZ3LEsodYaquCjQoKxxBSRIKAbuujDgJ8mp+XhBuTLql+3xd
        4j7fZCo5Pv2CATyJkaxNrMFJ5cga6F1mHLUJ0GMQQg==
X-Google-Smtp-Source: ACcGV602y46MzMKst9UFa5/kq8pdY7GtYIj6Qt+St6HjDtoe4SyaVRB7JrTHemafReUIbpO1NMTnu0czbiyJHzwhc2g=
X-Received: by 2002:a19:5a05:: with SMTP id o5mr3509983lfb.140.1539964060754;
 Fri, 19 Oct 2018 08:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 19 Oct 2018 09:47:29 -0600
Message-ID: <CANLsYkzb_40ODVF5Mh7i3urEaq769drifjC+KWH+cgKR9L9a5g@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc: Fix bad register address for CLAIM
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 22:56, Leo Yan <leo.yan@linaro.org> wrote:
>
> Commit 4d3ebd3658d8 ("coreisght: tmc: Claim device before use") uses
> CLAIM tag to validate if the device is available, it needs to pass
> the device base address to access related registers.
>
> In the function tmc_etb_disable_hw() it wrongly passes the driver data
> pointer as register base address, thus it's easily to produce the kernel
> warning info like below:
>
> [   83.579898] WARNING: CPU: 4 PID: 2970 at drivers/hwtracing/coresight/coresight.c:207 coresight_disclaim_device_unlocked+0x44/0x80
> [   83.591448] Modules linked in:
> [   83.594485] CPU: 4 PID: 2970 Comm: uname Not tainted 4.19.0-rc6-00417-g721b509 #110
> [   83.602067] Hardware name: ARM Juno development board (r2) (DT)
> [   83.607932] pstate: 80000085 (Nzcv daIf -PAN -UAO)
> [   83.612681] pc : coresight_disclaim_device_unlocked+0x44/0x80
> [   83.618375] lr : coresight_disclaim_device_unlocked+0x44/0x80
> [   83.624064] sp : ffff00000fe3ba20
> [   83.627347] x29: ffff00000fe3ba20 x28: ffff80002d430dc0
> [   83.632618] x27: ffff800033177c00 x26: ffff80002eb44480
> [   83.637889] x25: 0000000000000001 x24: ffff800033c72600
> [   83.643160] x23: ffff0000099b11f8 x22: ffff0000099b11c8
> [   83.648430] x21: 0000000000000002 x20: ffff800033a90418
> [   83.653701] x19: ffff0000099b11c8 x18: 0000000000000000
> [   83.658971] x17: 0000000000000000 x16: 0000000000000000
> [   83.664241] x15: 0000000000000000 x14: 0000000000000000
> [   83.669511] x13: 0000000000000000 x12: 0000000000000000
> [   83.674782] x11: 0000000000000000 x10: 0000000000000000
> [   83.680052] x9 : 0000000000000000 x8 : 0000000000000001
> [   83.685322] x7 : 0000000000010000 x6 : ffff800033ebab18
> [   83.690593] x5 : ffff800033ebab18 x4 : ffff800033e6c698
> [   83.695862] x3 : 0000000000000001 x2 : 0000000000000000
> [   83.701133] x1 : 0000000000000000 x0 : 0000000000000001
> [   83.706404] Call trace:
> [   83.708830]  coresight_disclaim_device_unlocked+0x44/0x80
> [   83.714180]  coresight_disclaim_device+0x34/0x48
> [   83.718756]  tmc_disable_etf_sink+0xc4/0xf0
> [   83.722902]  coresight_disable_path_from+0xc8/0x240
> [   83.727735]  coresight_disable_path+0x24/0x30
> [   83.732053]  etm_event_stop+0x130/0x170
> [   83.735854]  etm_event_del+0x24/0x30
> [   83.739399]  event_sched_out.isra.51+0xcc/0x1e8
> [   83.743887]  group_sched_out.part.53+0x44/0xb0
> [   83.748291]  ctx_sched_out+0x298/0x2b8
> [   83.752005]  task_ctx_sched_out+0x74/0xa8
> [   83.755980]  perf_event_exit_task+0x140/0x418
> [   83.760298]  do_exit+0x3f4/0xcf0
> [   83.763497]  do_group_exit+0x5c/0xc0
> [   83.767041]  __arm64_sys_exit_group+0x24/0x28
> [   83.771359]  el0_svc_common+0x110/0x178
> [   83.775160]  el0_svc_handler+0x94/0xe8
> [   83.778875]  el0_svc+0x8/0xc
> [   83.781728] ---[ end trace 02d8d8eac46db9e5 ]---
>
> This patch is to fix this bug by using 'drvdata->base' as the
> register base address for CLAIM related operation.
>
> Fixes: 4d3ebd3658d8 ("coreisght: tmc: Claim device before use")
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 53fc83b..5864ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -86,7 +86,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>
>  static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  {
> -       coresight_disclaim_device(drvdata);
> +       coresight_disclaim_device(drvdata->base);
>         __tmc_etb_disable_hw(drvdata);
>  }
>

Applied - thanks.
Mathieu

> --
> 2.7.4
>
