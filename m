Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C33C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1ED218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392958AbeLVXDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:03:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40438 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392911AbeLVXDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:03:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4637514A8F325;
        Sat, 22 Dec 2018 15:03:36 -0800 (PST)
Date:   Sat, 22 Dec 2018 15:03:33 -0800 (PST)
Message-Id: <20181222.150333.1964216452010509730.davem@davemloft.net>
To:     deepa.kernel@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, arnd@arndb.de, y2038@lists.linaro.org
Subject: Re: [PATCH] sock: Make sock->sk_tstamp thread-safe
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181221202733.19627-1-deepa.kernel@gmail.com>
References: <20181221202733.19627-1-deepa.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Dec 2018 15:03:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 21 Dec 2018 12:27:33 -0800

> Al Viro mentioned that there is probably a race condition
> lurking in accesses of sk_tstamp on 32-bit machines.
> 
> sock->sk_tstamp is of type ktime_t which is always an s64.
> On a 32 bit architecture, we might run into situations of
> unsafe access as the access to the field becomes non atomic.
> 
> Use seqlocks for synchronization.
> This allows us to avoid using spinlocks for readers as
> readers do not need mutual exclusion.
> 
> Another approach to solve this is to require sk_lock for all
> modifications of the timestamps. The current approach allows
> for timestamps to have their own lock: sk_tstamp_lock.
> This allows for the patch to not compete with already
> existing critical sections, and side effects are limited
> to the paths in the patch.
> 
> The addition of the new field maintains the data locality
> optimizations from
> commit 9115e8cd2a0c ("net: reorganize struct sock for better data
> locality")
> 
> Note that all the instances of the sk_tstamp accesses
> are either through the ioctl or the syscall recvmsg.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Since, regardless of whether this is the final approach we will
take, it seems that sunrpc needs to be added to this patch.

So I'm definitely waiting for a new version.

Thanks.
