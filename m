Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD93C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A8D2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A8D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJLPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:24:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46458 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJLPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:24:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id o21so11529992otb.13;
        Fri, 12 Oct 2018 00:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=um6mDg2IyyzdSCVWEY6gHlfduTP44M2OvXQyiVTqqRM=;
        b=QJC2GuFeQhAy1SWqYlpR+GEYAxUAVwLv+hLYVaL62pD01dqCgHMJWHpsPwpFLQRiDY
         GXUYv8W64b8PW0Lp/TrYX0xaCDRQDyoqoiGxevu8UPXuGms/XkLUDKKT8HPBg8zbNrUa
         UQqcIEE4XuLAvOrp8QsIsI29ypoghobBBFqol1rJzvHSoVgNuS0jD53c68me/2ypHDE9
         VJ8ohOy0ZkWNM7mY5bKIGw9XSibZEVKKuBduVSLXQEs1p5XTKF6yCkqWenmH94+MiYJm
         Qe1vi88qID9U7HQVi23b7YytIxc/0FpAjOmKbCHfWG2qMw6/U2/zM3nW1AgSwQDMeKc+
         rA4w==
X-Gm-Message-State: ABuFfohW6pYI1gYZn4uUvEClYjkmLKR9XY/susJNkAP6zdv15toudSiY
        arUFqlENZ3OaN5tnO5wsii73DF8lWpNMizy9JGbZ7g==
X-Google-Smtp-Source: ACcGV62MtCNSqgCKMMvnojDUbj6BVRhraQILs6nF8iyz4FLomt5N00Fjv3ywaH6OJCffn8Y47N6nf6Mc8lwJRECc4PM=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr3310565otg.139.1539330792613;
 Fri, 12 Oct 2018 00:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181011220134.1408.63391.stgit@localhost.localdomain> <20181011220944.1408.39823.stgit@localhost.localdomain>
In-Reply-To: <20181011220944.1408.39823.stgit@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Oct 2018 09:53:00 +0200
Message-ID: <CAJZ5v0ioPTXP6L6TXvRHvHdTQFu-v74izHUYSDoc3b9gYS7wog@mail.gmail.com>
Subject: Re: [driver-core PATCH v3 5/5] PM core: Use new async_schedule_dev command
To:     alexander.h.duyck@linux.intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:10 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we use the device specific version of the
> async_schedule commands to defer various tasks related to power management.
> By doing this we should see a slight improvement in performance as any
> device that is sensitive to latency/locality in the setup will now be
> initializing on the node closest to the device.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/power/main.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a690fd400260..ebb8b61b52e9 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -726,7 +726,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
>                 reinit_completion(&dev->power.completion);
>                 if (is_async(dev)) {
>                         get_device(dev);
> -                       async_schedule(async_resume_noirq, dev);
> +                       async_schedule_dev(async_resume_noirq, dev);
>                 }
>         }
>
> @@ -883,7 +883,7 @@ void dpm_resume_early(pm_message_t state)
>                 reinit_completion(&dev->power.completion);
>                 if (is_async(dev)) {
>                         get_device(dev);
> -                       async_schedule(async_resume_early, dev);
> +                       async_schedule_dev(async_resume_early, dev);
>                 }
>         }
>
> @@ -1047,7 +1047,7 @@ void dpm_resume(pm_message_t state)
>                 reinit_completion(&dev->power.completion);
>                 if (is_async(dev)) {
>                         get_device(dev);
> -                       async_schedule(async_resume, dev);
> +                       async_schedule_dev(async_resume, dev);
>                 }
>         }
>
> @@ -1366,7 +1366,7 @@ static int device_suspend_noirq(struct device *dev)
>
>         if (is_async(dev)) {
>                 get_device(dev);
> -               async_schedule(async_suspend_noirq, dev);
> +               async_schedule_dev(async_suspend_noirq, dev);
>                 return 0;
>         }
>         return __device_suspend_noirq(dev, pm_transition, false);
> @@ -1569,7 +1569,7 @@ static int device_suspend_late(struct device *dev)
>
>         if (is_async(dev)) {
>                 get_device(dev);
> -               async_schedule(async_suspend_late, dev);
> +               async_schedule_dev(async_suspend_late, dev);
>                 return 0;
>         }
>
> @@ -1833,7 +1833,7 @@ static int device_suspend(struct device *dev)
>
>         if (is_async(dev)) {
>                 get_device(dev);
> -               async_schedule(async_suspend, dev);
> +               async_schedule_dev(async_suspend, dev);
>                 return 0;
>         }
>
>
