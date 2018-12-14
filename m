Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6372EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B002080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbeLNVZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:25:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:25:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1A9C14E085CD;
        Fri, 14 Dec 2018 13:25:51 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:25:51 -0800 (PST)
Message-Id: <20181214.132551.1587998892072248943.davem@davemloft.net>
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
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 13:25:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 22:17:20 +0100

> @@ -635,8 +636,9 @@ static int threadfunc(void *data)
>  	int i, step, err = 0, insert_retries = 0;
>  	struct thread_data *tdata = data;
>  
> -	up(&prestart_sem);
> -	if (down_interruptible(&startup_sem))
> +	if (atomic_dec_and_test(&startup_count))
> +		wake_up(&startup_wait);
> +	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1))
>  		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);

Arnd, please adjust this pr_err() text to match the new code as pointed out by
Phil Sutter.

Thank you.
