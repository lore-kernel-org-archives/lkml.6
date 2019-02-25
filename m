Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA0E213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBYOTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:19:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45089 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:19:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id v139so5317929qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 06:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNuIMyokVLzF2EOJQlmwGNQywdCsWYJSYSTHWv8S7o8=;
        b=uIjTghtwwTwm9P4oIqXjgRgEjEYA/MpBJgh7Bng2t0gRhs1NS/hnh1iDECKJ5Trp4u
         3g7b3PoSWWF5nX9vGDK4cFmoKB182mGCs0npU6IRKj0GczDiPdUANlMfB2OmzXoLqdN/
         qPpl8PS4RwsUrz6sxU3/b+dnP931IPnXqAdnYGYvsHKWP+r+m9NF2MWJp5rGQdu+4Zz7
         Q0KTlsoL6xF5oBLtDe5YcAJwlRQV56KbxxpV/JidTLI4zu7EZMAn4NRSV0nV86/g1Sgp
         Savh98vKg6v2ZWm80azAmHv+nwG6pcs3dSr35xyUdsysjq7SAxGe9s4jMmv/Nqqu1UNk
         ya2A==
X-Gm-Message-State: AHQUAuaUjPfFyyKv3oFHY2kjsw5Em7H79+zQOEDTlHfC9Rj0CrbNj3m9
        4oZalgGHQL83AQDMhqjhfPveqAQqK5rshtSl1Y4=
X-Google-Smtp-Source: AHgI3Iavej6ScRuKK/MT4XK7GLxlBdcjiyUPI7eCWWN7/Atl1ckHlqDLx70MJWJyhR9yBBvHmaGSLWLCNMmLCJ67WWs=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr13164975qki.291.1551104367400;
 Mon, 25 Feb 2019 06:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20190225032619.17070-1-yaohongbo@huawei.com> <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
 <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com> <CAK8P3a1mpRP6SLrJPS1z5aPZc0O4GE8wuTUkjkGL31_GVYrmDQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mpRP6SLrJPS1z5aPZc0O4GE8wuTUkjkGL31_GVYrmDQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 15:19:10 +0100
Message-ID: <CAK8P3a02a=rqQdxrWPhKsNkdj8r0p-nR8Cf+fgwFTEY5WHGr9g@mail.gmail.com>
Subject: Re: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Hongbo Yao <yaohongbo@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Feb 25, 2019 at 10:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Feb 25, 2019 at 5:53 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:

>
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index a6dc47edc4cf..0d5ebde29c0d 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -160,7 +160,7 @@ static int gem_ptp_adjfine(struct ptp_clock_info
> *ptp, long scaled_ppm)
>  static int gem_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  {
>         struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
> -       struct timespec64 now, then = ns_to_timespec64(delta);
> +       struct timespec64 now;
>         u32 adj, sign = 0;
>
>         if (delta < 0) {
> @@ -170,7 +170,7 @@ static int gem_ptp_adjtime(struct ptp_clock_info
> *ptp, s64 delta)
>
>         if (delta > TSU_NSEC_MAX_VAL) {
>                 gem_tsu_get_time(&bp->ptp_clock_info, &now);
> -               now = timespec64_add(now, then);
> +               now = timespec64_add(now, ns_to_timespec64(delta));
>
>                 gem_tsu_set_time(&bp->ptp_clock_info,
>                                  (const struct timespec64 *)&now);

This part of of course completely bogus, I had first changed it
to timespec64_add_ns() for testing, and then back. Please ignore.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 5fb4353c742b..4efcba0252a4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -151,7 +151,7 @@ static int i40e_ptp_adjtime(struct ptp_clock_info
> *ptp, s64 delta)
>         mutex_lock(&pf->tmreg_lock);
>
>         i40e_ptp_read(pf, &now, NULL);
> -       timespec64_add_ns(&now, delta);
> +       timespec64_add_ns(&now, ns_to_timespec64(delta));
>         i40e_ptp_write(pf, (const struct timespec64 *)&now);
>
>         mutex_unlock(&pf->tmreg_lock);
>

I think this is still needed, I've added this to my y2038 backlog
and will send a patch for it eventually.

       Arnd
