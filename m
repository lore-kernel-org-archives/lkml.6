Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241A72081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241A72081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeLKB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:29:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbeLKB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:29:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE897100AAA08;
        Mon, 10 Dec 2018 17:29:12 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:29:12 -0800 (PST)
Message-Id: <20181210.172912.1960183648027850219.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, neilb@suse.com,
        tom@quantonium.net, keescook@chromium.org, paulb@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_rhashtable: remove semaphore usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210211957.210189-1-arnd@arndb.de>
References: <20181210211957.210189-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 17:29:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 22:17:20 +0100

> This is one of only two files that initialize a semaphore to a negative
> value. We don't really need the two semaphores here at all, but can do
> the same thing in more conventional and more effient way, by using a
> single waitqueue and an atomic thread counter.
> 
> This gets us a little bit closer to eliminating classic semaphores from
> the kernel. It also fixes a corner case where we fail to continue after
> one of the threads fails to start up.
> 
> An alternative would be to use a split kthread_create()+wake_up_process()
> and completely eliminate the separate synchronization.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is part of a longer, untested, series to remove semaphores
> from the kernel, please review as such before applying.

This looks fine to me, although it seems kinda weird how the
synchronization works in that the N - 1 child threads will
be awoken two times, once when child N decrements the count
to zero and once when the parent decrements the count to -1
which lets us past the wait_event_interruptibel().

Nevertheless it should work just fine and I have no problems
with it.

Want me to apply this to net-next?

Thanks.

