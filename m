Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC629C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6890E2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6890E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeKCPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:41:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46106 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeKCPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:41:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EEB3A14525CCC;
        Fri,  2 Nov 2018 23:31:38 -0700 (PDT)
Date:   Fri, 02 Nov 2018 23:31:38 -0700 (PDT)
Message-Id: <20181102.233138.738200505012734856.davem@davemloft.net>
To:     mk.singh@oracle.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, mkubecek@suse.cz,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding:avoid repeated display of same link status
 change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031105729.7442-1-mk.singh@oracle.com>
References: <20181031105729.7442-1-mk.singh@oracle.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Nov 2018 23:31:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mk.singh@oracle.com
Date: Wed, 31 Oct 2018 16:27:28 +0530

> -			if (slave->delay) {
> +			if (slave->delay &&
> +			    !atomic64_read(&bond->rtnl_needed)) {
 ...
> +			    !atomic64_read(&bond->rtnl_needed)) {
 ...
> +			atomic64_set(&bond->rtnl_needed, 1);
 ...
> +		atomic64_set(&bond->rtnl_needed, 0);
 ...
> @@ -229,6 +229,7 @@ struct bonding {
>  	struct	 dentry *debug_dir;
>  #endif /* CONFIG_DEBUG_FS */
>  	struct rtnl_link_stats64 bond_stats;
> +	atomic64_t rtnl_needed;

There is nothing "atomic" about a value that is only set and read.

And using a full 64-bit value for something taking on only '0' and
'1' is unnecessary as well.
