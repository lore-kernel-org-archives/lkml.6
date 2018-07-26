Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F031620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1oGVTL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F031620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeGZPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:16:10 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46296 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:16:10 -0400
Received: by mail-ua0-f195.google.com with SMTP id r18-v6so1121405ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipSMxe/AxtwPcVsrNdRWkFZR246cM5NwayOubDETSiw=;
        b=Y1oGVTL5CS1ewiljOsz7i4birEiEO395iyAClbG14LFUP4xaCIjYSGzt9gERK8bB/a
         CTgoLYFFQ4cz2h13xGf69Plq3uqqMQ/eK8w39u1WRfsKeQPlx6knSGiyQg3cWtn6gWND
         a7vlDNkKAxiDpDSIxoZRP0/XiG0D2FI/ogeuwOQk1eehNgQB8FvEroqWMP6mUloVtunp
         FDvGACMgeAf5ehugGyUus0PmzeW1vUnz9tLjc7ZvjXbrUvGT0YVoBjjx0kO3vOfzjwd0
         vVpcvf3dS2MI2ZYSyWiD4WN4r5361w05gDF4SCpsOMXsMDx1KcHJVOnpeF0POfHi+1j5
         uUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipSMxe/AxtwPcVsrNdRWkFZR246cM5NwayOubDETSiw=;
        b=efN+fByIqMac4yXOyoRfoKukjHqa12r6oKJCAIHYXFElLKOtZBhdnQOwX7XE66R+q3
         MDKzrlkyOlyazSmzIOJwtM+AZmNa3h5JDxFrMBb49f/zmdIFEUgM8ZI83L+TFmO0YUp/
         ugZs+PT9hT8RlwvUd5ETlAezEuEzV0frQZnVtvlCLFIdBbaeQgX8Lea5oYrncBE0XwXO
         wQcxZ1d+KzXecVsL7rcWzDJNof85WUTi/4ZKmk5E7i2rXyJgm1Ap5B/yUf9OffElqcN4
         fC+GyZBEuK1G9Rqk9V6wgnIwU0kQzXId+7cbl0Tx6XWEExIpF5hk3STuCxFigCdEb80r
         0yeQ==
X-Gm-Message-State: AOUpUlFqLsBsDodhuMNKiXz308Iw4dZ+obPtV+kFe+3GLqkdzb/elsrm
        m9jiAkRxteuUqojIU/+O0nY1Otki5+KQMQ9Y8PDyMw==
X-Google-Smtp-Source: AAOMgpcdbmC6W/25JZd6erbR6A++5R4PpFM+cwCKJuiWO5zkYhaKVaejLmIy60UDu5r9dBTc8PxWwAeFflcZNW3/NwU=
X-Received: by 2002:ab0:32c1:: with SMTP id f1-v6mr1399493uao.87.1532613549527;
 Thu, 26 Jul 2018 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180711124112.893478-1-arnd@arndb.de>
In-Reply-To: <20180711124112.893478-1-arnd@arndb.de>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 26 Jul 2018 16:59:06 +0300
Message-ID: <CAFCwf114SALuHsHmhbNxG+OMh+Zg+wnfJ6mirMuu2zmXiq6fqQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] amdgpu: kfd: use modern ktime accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Yong Zhao <yong.zhao@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Andres Rodriguez <andres.rodriguez@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 3:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> getrawmonotonic64() and get_monotonic_boottime64() are deprecated
> because of the nonstandard naming.
>
> The replacement functions ktime_get_raw_ns() and ktime_get_boot_ns()
> also simplify the callers.
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>.
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Patch was originall sent on Jun 18 but not applied yet, resending
> With Felix' Reviewed-by tag
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f64c5551cdba..7e717716b90e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -754,7 +754,6 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
>  {
>         struct kfd_ioctl_get_clock_counters_args *args = data;
>         struct kfd_dev *dev;
> -       struct timespec64 time;
>
>         dev = kfd_device_by_id(args->gpu_id);
>         if (dev)
> @@ -766,11 +765,8 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
>                 args->gpu_clock_counter = 0;
>
>         /* No access to rdtsc. Using raw monotonic time */
> -       getrawmonotonic64(&time);
> -       args->cpu_clock_counter = (uint64_t)timespec64_to_ns(&time);
> -
> -       get_monotonic_boottime64(&time);
> -       args->system_clock_counter = (uint64_t)timespec64_to_ns(&time);
> +       args->cpu_clock_counter = ktime_get_raw_ns();
> +       args->system_clock_counter = ktime_get_boot_ns();
>
>         /* Since the counter is in nano-seconds we use 1GHz frequency */
>         args->system_clock_freq = 1000000000;
> --
> 2.9.0
>
Applied to -next
Thanks,
Oded
