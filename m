Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E38C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2420855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF2420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeKZFRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:17:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKZFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:17:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DCE5814CFA111;
        Sun, 25 Nov 2018 10:26:07 -0800 (PST)
Date:   Sun, 25 Nov 2018 10:26:07 -0800 (PST)
Message-Id: <20181125.102607.771941500171801961.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] net: bridge: remove redundant checks for null
 p->dev and p->br
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181125160851.6919-1-colin.king@canonical.com>
References: <20181125160851.6919-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 25 Nov 2018 10:26:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 25 Nov 2018 16:08:51 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a null check on p->dev after p->dev was being
> dereferenced by the ns_capable check on p->dev. It turns out that
> neither the p->dev and p->br null checks are necessary, and can be
> removed, which cleans up a static analyis warning.
> 
> As Nikolay Aleksandrov noted, these checks can be removed because:
> 
> "My reasoning of why it shouldn't be possible:
> - On port add new_nbp() sets both p->dev and p->br before creating
>   kobj/sysfs
> 
> - On port del (trickier) del_nbp() calls kobject_del() before call_rcu()
>   to destroy the port which in turn calls sysfs_remove_dir() which uses
>   kernfs_remove() which deactivates (shouldn't be able to open new
>   files) and calls kernfs_drain() to drain current open/mmaped files in
>   the respective dir before continuing, thus making it impossible to
>   open a bridge port sysfs file with p->dev and p->br equal to NULL.
> 
> So I think it's safe to remove those checks altogether. It'd be nice to
> get a second look over my reasoning as I might be missing something in
> sysfs/kernfs call path."
> 
> Thanks to Nikolay Aleksandrov's suggestion to remove the check and
> David Miller for sanity checking this.
> 
> Detected by CoverityScan, CID#751490 ("Dereference before null check")
> 
> Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
