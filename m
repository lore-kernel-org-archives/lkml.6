Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeDPPI7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:08:59 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42380 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:08:57 -0400
Date: Mon, 16 Apr 2018 11:08:55 -0400 (EDT)
Message-Id: <20180416.110855.61732218036810337.davem@davemloft.net>
To: rafalo@cadence.com
Cc: nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Receive Side Coalescing for macb driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafal Ozieblo <rafalo@cadence.com>
Date: Sat, 14 Apr 2018 21:53:07 +0100

> This patch series adds support for receive side coalescing
> for Cadence GEM driver. Receive segmentation coalescing
> is a mechanism to reduce CPU overhead. This is done by
> coalescing received TCP message segments together into
> a single large message. This means that when the message
> is complete the CPU only has to process the single header
> and act upon the one data payload.

You're going to have to think more deeply about enabling this
feature.

If you can't adjust the receive buffer offset, then the various
packet header fields will be unaligned.

On certain architectures this will result in unaligned traps
all over the networking stack as the packet is being processed.

So enabling this by default will hurt performance on such
systems a lot.

The whole "skb_reserve(skb, NET_IP_ALIGN)" is not just for fun,
it is absolutely essential.
