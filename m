Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22742C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE820C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfB0SPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:15:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46366 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfB0SPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:15:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D682F1411B41C;
        Wed, 27 Feb 2019 10:14:59 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:14:59 -0800 (PST)
Message-Id: <20190227.101459.1829634170038511470.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] appletalk: Fix use-after-free in atalk_proc_exit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190227145900.28808-1-yuehaibing@huawei.com>
References: <20190227145900.28808-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Feb 2019 10:15:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 27 Feb 2019 22:59:00 +0800

> @@ -1925,7 +1925,10 @@ static int __init atalk_init(void)
>  
>  	register_netdevice_notifier(&ddp_notifier);
>  	aarp_proto_init();
> -	atalk_proc_init();
> +	rc = atalk_proc_init();
> +	if (rc)
> +		goto out;
> +
>  	atalk_register_sysctl();
>  out:

This leaves the netdevice notifier registered etc.  You need to add a proper
error cleanup code path.
