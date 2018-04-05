Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDENNQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:13:16 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45682 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeDENNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:13:15 -0400
X-Google-Smtp-Source: AIpwx4+sApsG4G4jp0IfFUZBON09PmyDzBaUCJCwOszotYNuApSRXpzlXFuZNVWVNb1/VOFDxYmg5+dE8DwrtR4ztbU=
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Apr 2018 15:13:13 +0200
X-Google-Sender-Auth: fX86iWjTJ-mAbgt24Nj5kmdpJtw
Message-ID: <CAMuHMdWovmqqgrOvtA=cyineJigwOtv-tGwz_PBVRFrgtryumw@mail.gmail.com>
Subject: net_dim() may use uninitialized data
To: Tal Gilboa <talgi@mellanox.com>
Cc: netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35DDKNx023320

Hi Tal,

With gcc-4.1.2:

    drivers/net/ethernet/broadcom/bcmsysport.c: In function ‘bcm_sysport_poll’:
    include/linux/net_dim.h:354: warning: ‘curr_stats.ppms’ may be
used uninitialized in this function
    include/linux/net_dim.h:354: warning: ‘curr_stats.bpms’ may be
used uninitialized in this function
    include/linux/net_dim.h:354: warning: ‘curr_stats.epms’ may be
used uninitialized in this function

Indeed, ...

| static inline void net_dim_calc_stats(struct net_dim_sample *start,
|                                       struct net_dim_sample *end,
|                                       struct net_dim_stats *curr_stats)
| {
|         /* u32 holds up to 71 minutes, should be enough */
|         u32 delta_us = ktime_us_delta(end->time, start->time);
|         u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
|         u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
|                              start->byte_ctr);
|
|         if (!delta_us)
|                 return;

... if delta_us is zero, none of the below will be initialized ...

|         curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
|         curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
|         curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
|                                         delta_us);
| }
|
| static inline void net_dim(struct net_dim *dim,
|                            struct net_dim_sample end_sample)
| {
|         struct net_dim_stats curr_stats;
|         u16 nevents;
|
|         switch (dim->state) {
|         case NET_DIM_MEASURE_IN_PROGRESS:
|                 nevents = BIT_GAP(BITS_PER_TYPE(u16),
|                                   end_sample.event_ctr,
|                                   dim->start_sample.event_ctr);
|                 if (nevents < NET_DIM_NEVENTS)
|                         break;
|                 net_dim_calc_stats(&dim->start_sample, &end_sample,
|                                    &curr_stats);

... in the output parameter curr_stats ...

|                 if (net_dim_decision(&curr_stats, dim)) {

... and net_dim_decision will make some funky decisions based on
uninitialized data.

What are the proper values to initialize curr_stats with?
Alternatively, perhaps the call to net_dim_decision() should be made
dependent on delta_us being non-zero?

|                         dim->state = NET_DIM_APPLY_NEW_PROFILE;
|                         schedule_work(&dim->work);
|                         break;
|                 }
|                 /* fall through */
|         case NET_DIM_START_MEASURE:
|                 dim->state = NET_DIM_MEASURE_IN_PROGRESS;
|                 break;
|         case NET_DIM_APPLY_NEW_PROFILE:
|                 break;
|         }
| }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
