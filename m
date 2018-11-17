Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16161C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD2020815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD2020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKRGkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:40:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34678 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeKRGkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:40:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7CFE6146FE6EE;
        Sat, 17 Nov 2018 12:22:13 -0800 (PST)
Date:   Sat, 17 Nov 2018 12:22:12 -0800 (PST)
Message-Id: <20181117.122212.954465454738045729.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 2/3] net-next/hinic:performance improvement for HiNIC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115200548.5326-2-xuechaojing@huawei.com>
References: <20181115200548.5326-1-xuechaojing@huawei.com>
        <20181115200548.5326-2-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 12:22:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Thu, 15 Nov 2018 20:05:47 +0000

> In order to improve performance, this patch adds rx checksum offload
> for the HiNIC driver and optimizes the code. Performance test(Iperf) 
> shows more than 95% improvement in TCP streams.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

What kind of "optimizes the code" is being done here?  Be explicit.

And such unrelated changes to supporting checksum offload should be
split into another patch.

> +	csum_err = HINIC_RQ_CQE_STATUS_GET(status, CSUM_ERR);
> +
> +	if (!(netdev->features & NETIF_F_RXCSUM))
> +		return;
> +
> +	if (!csum_err)
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	else
> +		skb->ip_summed = CHECKSUM_NONE;

Does the CQE status word provide more information?  Like the checksum
computed over the packet?  That's more useful than a binary "csum correct"
state.

> +#define BIT(nr)			(1UL << (nr))

This is unnecessary, please include linux/bits.h and use the definition from
there.
