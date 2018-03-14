Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeCNRWz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:22:55 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:46860 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCNRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:22:52 -0400
X-Google-Smtp-Source: AG47ELsHulDNg14yutHJMTSjwhLmIJYakXkBpK1BcAFMgJa3Pgyo2ncdikpQSTpfifi7sFHr1fPNeFQ7mBbijl9CCmo=
MIME-Version: 1.0
In-Reply-To: <f439051c3964c6bb5342e25fb5327e0cdeba001e.1521045132.git.jtoppins@redhat.com>
References: <f439051c3964c6bb5342e25fb5327e0cdeba001e.1521045132.git.jtoppins@redhat.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 14 Mar 2018 10:22:51 -0700
Message-ID: <CACKFLi=R2q71JH2Jbqbpy8HrzNpg1UmnoNWKhEs7ooWLWoQOqQ@mail.gmail.com>
Subject: Re: [PATCH net] tg3: prevent scheduling while atomic splat
To: Jonathan Toppins <jtoppins@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Andy Gospodarek <andy@greyhouse.net>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:36 AM, Jonathan Toppins <jtoppins@redhat.com> wrote:
> The problem was introduced in commit
> 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes"). The bug occurs
> because tp->lock spinlock is held which is obtained in tg3_start
> by way of tg3_full_lock(), line 11571. The documentation for usleep_range()
> specifically states it cannot be used inside a spinlock.
>
> Fixes: 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes")
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>
> Notes:
>     The thing I need reviewed from Broadcom is if the udelay should be 20
>     instead of 10, due to any timing changes introduced by the offending
>     patch.

Thanks.  10 us is correct.

As a future improvement, we might want to see if we can release the
spinlock and go back to usleep_range().  The wait time is potentially
up to 20 msec which is quite long.

Acked-by: Michael Chan <michael.chan@broadcom.com>
