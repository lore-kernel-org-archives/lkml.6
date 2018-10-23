Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C629C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47D2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC47D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeJXCcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:32:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJXCcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:32:31 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 49F421472358E;
        Tue, 23 Oct 2018 11:08:03 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:08:02 -0700 (PDT)
Message-Id: <20181023.110802.2298971732908535065.davem@davemloft.net>
To:     mk.singh@oracle.com
Cc:     netdev@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding:avoid repeated display of same link status
 change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181023152924.24033-1-mk.singh@oracle.com>
References: <20181023152924.24033-1-mk.singh@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Oct 2018 11:08:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mk.singh@oracle.com
Date: Tue, 23 Oct 2018 20:59:24 +0530

> @@ -229,6 +229,7 @@ struct bonding {
>  	struct	 dentry *debug_dir;
>  #endif /* CONFIG_DEBUG_FS */
>  	struct rtnl_link_stats64 bond_stats;
> +	atomic_t rtnl_needed;

As mentioned by others, if the only operations you perform on a value
are set and read, using atomic_t is utterly and totally pointless.

I really have no idea what is achieved by using atomic_t in this set
of circumstances.

It is not guaranteeing that the value stays stable after you read it,
and it is not guaranteeing that another thread won't overwrite the
value you just set it to.

All of those things, if important, need proper synchronization.  An
atomic_t by itself will not do that for you.
