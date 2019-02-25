Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8022084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfBYJH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:07:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35009 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:07:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so9634530qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhFpiNlQhnII497yog+JM6Qj/4JkhP2SptxjacnGbjk=;
        b=Cl6fziEw7H/Tn375FXzumApSoOchO/9AUwnrMUzREgrjoGBw/BBP9Me1xOSaNrOkLx
         W9YsXz3ExG9K8tUi8Gd1AuVVYQIg6LGXJDar8nNhElusB1n8kjEynn14+ioTyC7tNZ9c
         TvIyT2zVfJFL2R1UJfFx/1jNvPkctX3iOjXxCCC6ShlTRVJy2irgX2NiuHzPGGGqTCUE
         jrwxiFt4JEurMuB+Kctw3jqPkrBYqvql9RpH06zXwjGP4GKj+Zz+bMDiWaEPNsbvNiCL
         RvMMU0BX6CTpUCtOdCiGuR1eJVaVXGctStqPzoBKFsHdLFHHeVLbL/mccBT4MYQ1PXsr
         9j0w==
X-Gm-Message-State: AHQUAuY2VO9/DKMc0C/YbnNCNY+qjWzMcdz4klTgEVpSGOgl4GnTzLVC
        8/Cx6Z7J7iPSXpFEPefshsMV3u4OGO+wv2T9ac4=
X-Google-Smtp-Source: AHgI3IbsEbE0bTXt9qHOo0kIzDN0HjVcpjazckJXiFUGECoxRlLgXsP64ZmZERRY45GlrKUhAvVvNJyP4fUCtVxrRdM=
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr12651201qvc.40.1551085677062;
 Mon, 25 Feb 2019 01:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190225032619.17070-1-yaohongbo@huawei.com> <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
 <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com>
In-Reply-To: <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 10:07:40 +0100
Message-ID: <CAK8P3a1mpRP6SLrJPS1z5aPZc0O4GE8wuTUkjkGL31_GVYrmDQ@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 10:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Feb 25, 2019 at 5:53 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:

> arch/arm/xen/enlighten.c:       *ts = timespec64_add(now, ts_monotonic);
> arch/arm/xen/enlighten.c:       system_time = timespec64_add(now,
> tk->wall_to_monotonic);
> drivers/net/ethernet/cadence/macb_ptp.c:                now =
> timespec64_add(now, then);
> drivers/net/ethernet/intel/igb/igb_main.c:              ts =
> timespec64_add(adapter->perout[0].start,
> drivers/net/ethernet/intel/igb/igb_main.c:              ts =
> timespec64_add(adapter->perout[1].start,
> drivers/net/ethernet/intel/igb/igb_ptp.c:       now = timespec64_add(now, then);
> fs/cifs/dfs_cache.c:    return timespec64_add(now, ts);
> include/linux/rtc.h:    *to_set = timespec64_add(*now, delay);
> include/linux/time64.h:static inline struct timespec64
> timespec64_add(struct timespec64 lhs,
> kernel/time/timekeeping.c:      tmp = timespec64_add(tk_xtime(tk), *ts);
> kernel/time/timekeeping.c:
> timespec64_add(timekeeping_suspend_time, delta_delta);
> net/ceph/messenger.c:           ts =
> timespec64_add(con->last_keepalive_ack, ts);
>
> It looks like an actual overflow would be really bad in most of these,
> regardless of the undefined behavior.

Side note: I was wondering whether some of those should use
timespec64_add_ns() instead of converting a 64-bit nanosecond
value to timespec64 first. My conclusion was "no, since
timespec64_add_ns() avoids a 64-bit division by assuming that
the nanoseconds are small", and in fact we probably need the oppose
and change two drivers the other way:

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c
b/drivers/net/ethernet/cadence/macb_ptp.c
index a6dc47edc4cf..0d5ebde29c0d 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -160,7 +160,7 @@ static int gem_ptp_adjfine(struct ptp_clock_info
*ptp, long scaled_ppm)
 static int gem_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
        struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
-       struct timespec64 now, then = ns_to_timespec64(delta);
+       struct timespec64 now;
        u32 adj, sign = 0;

        if (delta < 0) {
@@ -170,7 +170,7 @@ static int gem_ptp_adjtime(struct ptp_clock_info
*ptp, s64 delta)

        if (delta > TSU_NSEC_MAX_VAL) {
                gem_tsu_get_time(&bp->ptp_clock_info, &now);
-               now = timespec64_add(now, then);
+               now = timespec64_add(now, ns_to_timespec64(delta));

                gem_tsu_set_time(&bp->ptp_clock_info,
                                 (const struct timespec64 *)&now);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 5fb4353c742b..4efcba0252a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -151,7 +151,7 @@ static int i40e_ptp_adjtime(struct ptp_clock_info
*ptp, s64 delta)
        mutex_lock(&pf->tmreg_lock);

        i40e_ptp_read(pf, &now, NULL);
-       timespec64_add_ns(&now, delta);
+       timespec64_add_ns(&now, ns_to_timespec64(delta));
        i40e_ptp_write(pf, (const struct timespec64 *)&now);

        mutex_unlock(&pf->tmreg_lock);


        Arnd
