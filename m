Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A5C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E6E20857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E6E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeIJBNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:13:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37966 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeIJBNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:13:38 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so36400022oix.5;
        Sun, 09 Sep 2018 13:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+dMeOka9TY4dCNV3KChU1LDPCS+8dqySNYiXAZLRwc=;
        b=VX1yre2ReG2TvdL59GaFhjxL6BsevMmAQSA6SYKkIs1HgJRz+BFAaSqJh82BC4TKjX
         Fk73zsTwoNOd1RNAPwlm58Uz1vyZa0b5TFADqxY5pkgFmey5PJjx8t1TkapXzGwrsujm
         h9W/G5WyyYh/+ZsS10NuTp0V266Mhdpa0PlTFdju0gwqlX8l76VB9akIAy6ef4jAzcqR
         tWj00H2dLc0/hOf+9LzHUQlHPkQ9bZQQMUBOokWHpipUKZH1uMcdGP8kAovSSN4kf757
         fzXeic3b/AJ0fR+eIxsvdfGkB1fCZduQbBl66MofNnIGF3GBArT782o7x3cuYEUDRu3C
         qDng==
X-Gm-Message-State: APzg51BGJfrRmac+tIXO0FtlVOTBgMjgUHlQbLBhXcY330MkGOSpOolP
        oZ/6IRVMKxmP8zuQ0NcFo8sSqfbiyPaSy2CKJOQ=
X-Google-Smtp-Source: ANB0VdbB2eZqYz8luHER+wdzfu4k50zLWBHL9dxl7NPS8zx0Uak7FUZRD9fGXV+/NHrnVNeYH2CvqRqQCjEL75e5DlE=
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr19425898oie.152.1536524566498;
 Sun, 09 Sep 2018 13:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
In-Reply-To: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Sep 2018 22:22:35 +0200
Message-ID: <CAJZ5v0hEFGCu8xv6MvwmVvspOwLveD4sPzU-=ewKfbrV9omzBw@mail.gmail.com>
Subject: Re: [PATCH v1] dd: Invoke one probe retry cycle after some initcall levels
To:     rishabhb@quicinc.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Vikram Mulukutla <markivx@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 7:40 PM Rishabh Bhatnagar <rishabhb@quicinc.com> wrote:
>
> From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>
> Drivers that are registered at an initcall level may have to
> wait until late_init before the probe deferral mechanism can
> retry their probe functions. It is possible that their
> dependencies were resolved much earlier, in some cases even
> before the next initcall level. Invoke one probe retry cycle
> at every _sync initcall level after subsys initcall, allowing
> these drivers to be probed earlier.
> To give an example many Qualcomm drivers are dependent on the
> regulator and bus driver. Both the regulator and bus driver
> are probed in the subsys_initcall level. Now the probe of bus
> driver requires regulator to be working. If the probe of bus
> driver happens before regulator, then bus driver's probe will
> be deferred and all other device's probes which depend on bus
> driver will also be deferred.
> The impact of this problem is reduced if we have this patch.
>
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>
> Changes since v0:
>  * Remove arch_initcall_sync(deferred_probe_initcall) from patch. This is not
>    really needed as none of the devices are re-probed in arch_initcall_sync
>    level.
>
>  drivers/base/dd.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d72..9aa41aa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -224,23 +224,43 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +static void enable_trigger_defer_cycle(void)
> +{
> +       driver_deferred_probe_enable = true;

Isn't it sufficient to enable it once?

> +       driver_deferred_probe_trigger();
> +       /*
> +        * Sort as many dependencies as possible before the next initcall
> +        * level
> +        */
> +       flush_work(&deferred_probe_work);
> +}

I would call this function driver_deferred_probe_sync() or similar to
indicate that it is a synchronization point.

Thanks,
Rafael
