Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCNRna (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:43:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeCNRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:43:29 -0400
Date: Wed, 14 Mar 2018 13:43:24 -0400 (EDT)
Message-Id: <20180314.134324.74418674311685220.davem@davemloft.net>
To: michael.chan@broadcom.com
Cc: jtoppins@redhat.com, netdev@vger.kernel.org, andy@greyhouse.net,
        siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tg3: prevent scheduling while atomic splat
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACKFLi=R2q71JH2Jbqbpy8HrzNpg1UmnoNWKhEs7ooWLWoQOqQ@mail.gmail.com>
References: <f439051c3964c6bb5342e25fb5327e0cdeba001e.1521045132.git.jtoppins@redhat.com>
        <CACKFLi=R2q71JH2Jbqbpy8HrzNpg1UmnoNWKhEs7ooWLWoQOqQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 14 Mar 2018 10:22:51 -0700

> On Wed, Mar 14, 2018 at 9:36 AM, Jonathan Toppins <jtoppins@redhat.com> wrote:
>> The problem was introduced in commit
>> 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes"). The bug occurs
>> because tp->lock spinlock is held which is obtained in tg3_start
>> by way of tg3_full_lock(), line 11571. The documentation for usleep_range()
>> specifically states it cannot be used inside a spinlock.
>>
>> Fixes: 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes")
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>> ---
>>
>> Notes:
>>     The thing I need reviewed from Broadcom is if the udelay should be 20
>>     instead of 10, due to any timing changes introduced by the offending
>>     patch.
> 
> Thanks.  10 us is correct.
> 
> As a future improvement, we might want to see if we can release the
> spinlock and go back to usleep_range().  The wait time is potentially
> up to 20 msec which is quite long.
> 
> Acked-by: Michael Chan <michael.chan@broadcom.com>

Applied, thanks everyone.
