Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92EC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3815120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3815120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeLJUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:04:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLJUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:04:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D760A1473AE8E;
        Mon, 10 Dec 2018 12:04:02 -0800 (PST)
Date:   Mon, 10 Dec 2018 12:04:02 -0800 (PST)
Message-Id: <20181210.120402.2087888281534527051.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     h.morris@cascoda.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: ca8210: remove a dead branch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210113443.22796-1-yuehaibing@huawei.com>
References: <20181210113443.22796-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 12:04:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 10 Dec 2018 19:34:43 +0800

> Fix follwing gcc warning:
> 
> drivers/net/ieee802154/ca8210.c:730:10: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> the variable 'len' is of type u8 and cannot greater than
> CA8210_SPI_BUF_SIZE , which is 256.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Then bug is the variable type here.

We are reading a u8 from buf[], then adding 2, which can overflow.

'len' should be an unsigned int or similar.
