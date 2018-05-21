Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeEUPrz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:47:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55946 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeEUPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:47:48 -0400
Date: Mon, 21 May 2018 11:47:42 -0400 (EDT)
Message-Id: <20180521.114742.427929977852677864.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        hannes@stressinduktion.org, edumazet@google.com
Subject: Re: [PATCH net] tuntap: raise EPOLLOUT on device up
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
References: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 May 2018 21:00:43 +0800

> We return -EIO on device down but can not raise EPOLLOUT after it was
> up. This may confuse user like vhost which expects tuntap to raise
> EPOLLOUT to re-enable its TX routine after tuntap is down. This could
> be easily reproduced by transmitting packets from VM while down and up
> the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.
> 
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I'm no so sure what to do with this patch.

Like Michael says, this flag bit is only checks upon transmit which
may or may not happen after this point.  It doesn't seem to be
guaranteed.
