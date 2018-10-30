Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21DAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709D32081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709D32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeJaDTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:19:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58074 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJaDTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:19:46 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E056814076BDE;
        Tue, 30 Oct 2018 11:25:11 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:25:11 -0700 (PDT)
Message-Id: <20181030.112511.957438343014682098.davem@davemloft.net>
To:     kurt@linutronix.de
Cc:     anirudh@xilinx.com, John.Linn@xilinx.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, andrew@lunn.ch,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181030093139.10226-2-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
        <20181030093139.10226-2-kurt@linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Oct 2018 11:25:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Tue, 30 Oct 2018 10:31:38 +0100

> The function could report a false positive if it gets preempted between reading
> the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
> the condition has to be rechecked to avoid false positives.
> 
> Therefore, check for expected condition even after the timeout occurred.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
 ...
>  		if (time_before_eq(end, jiffies)) {
> -			WARN_ON(1);
> -			return -ETIMEDOUT;
> +			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
> +			break;
>  		}
> +
>  		udelay(1);
>  	}
> -	return 0;
> +	if (val & XAE_MDIO_MCR_READY_MASK)
> +		return 0;
> +
> +	WARN_ON(1);
> +	return -ETIMEDOUT;

You are not fundamentally changing the situation at all.

The condtion could change right after your last read of
XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
modifications to this code.

It sounds more like the timeout is slightly too short, and that's the
real problem that causes whatever behavior you think you are fixing
here.

I'm not applying this.
