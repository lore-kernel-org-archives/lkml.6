Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41068C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190B2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeLOTb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:31:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53972 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOTbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:31:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C786214E8B324;
        Sat, 15 Dec 2018 11:31:24 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:31:24 -0800 (PST)
Message-Id: <20181215.113124.804119837626697932.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic:optmize rx refill buffer mechanism
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181209191419.16845-1-xuechaojing@huawei.com>
References: <20181209191419.16845-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:31:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Sun, 9 Dec 2018 19:14:19 +0000

> There is no need to schedule a different tasklet for refill,
> This patch remove it.
> 
> Suggested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

I completely agree with Neil's analysis.

You should never receive a packet if refilling the ring entry
resources fails.

It is so dangerous to allow the RX ring to reach an empty state,
not only does it mean that the device will stop receiving frames
but also this is probably one of the least tested conditions in
ring based networking designs and it proabably has bugs that hang
the chip and require a HW reset to recover from.

