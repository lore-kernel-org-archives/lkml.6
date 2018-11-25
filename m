Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C25C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441D320874
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441D320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeKYMx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:53:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:53:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD6A214EA793F;
        Sat, 24 Nov 2018 18:04:02 -0800 (PST)
Date:   Sat, 24 Nov 2018 18:04:02 -0800 (PST)
Message-Id: <20181124.180402.645583819668180736.davem@davemloft.net>
To:     nikolay@cumulusnetworks.com
Cc:     colin.king@canonical.com, roopa@cumulusnetworks.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: check for a null p->dev before
 dereferencing it
From:   David Miller <davem@davemloft.net>
In-Reply-To: <85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
References: <20181124121551.6942-1-colin.king@canonical.com>
        <85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Nov 2018 18:04:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 24 Nov 2018 14:21:07 +0200

> I was contacted recently about this privately and this was my reply:
> "Checking new_nbp() and del_nbp() it should not be possible to reach that code
> with p->dev or p->br as NULL. The cap check code has always been there, I just
> shuffled the rest of the function to obtain rtnl lock and kept it as close to
> the original as possible, thus the checks remained.
> In order to avoid future reports like this I'll send a cleanup once net-next
> opens up.
> 
> My reasoning of why it shouldn't be possible:
> - On port add new_nbp() sets both p->dev and p->br before creating kobj/sysfs
> 
> - On port del (trickier) del_nbp() calls kobject_del() before call_rcu() to destroy
>   the port which in turn calls sysfs_remove_dir() which uses kernfs_remove() which
>   deactivates (shouldn't be able to open new files) and calls kernfs_drain() to drain
>   current open/mmaped files in the respective dir before continuing, thus making it
>   impossible to open a bridge port sysfs file with p->dev and p->br equal to NULL.
> "
> 
> So I think it's safe to remove those checks altogether. It'd be nice to get a second
> look over my reasoning as I might be missing something in sysfs/kernfs call path.

I did a once over your analysis and I agree, the checks should be safe to remove.
