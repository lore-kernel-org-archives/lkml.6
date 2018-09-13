Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806FFA3758
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7E22152E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7E22152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIMVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:17:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50490 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIMVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:17:22 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ED59C13FDD215;
        Thu, 13 Sep 2018 09:07:12 -0700 (PDT)
Date:   Thu, 13 Sep 2018 09:07:12 -0700 (PDT)
Message-Id: <20180913.090712.1849966692069488441.davem@davemloft.net>
To:     gomonovych@gmail.com
Cc:     w-kwok2@ti.com, m-karicheri2@ti.com, grygorii.strashko@ti.com,
        vasyl.gomonovych@nokia.com, ssantosh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] knav: qmss: Introduce queue descriptors monitor
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180911211549.12092-1-gomonovych@gmail.com>
References: <20180911211549.12092-1-gomonovych@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 09:07:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasyl Gomonovych <gomonovych@gmail.com>
Date: Tue, 11 Sep 2018 23:15:47 +0200

> Monitor and record available descriptors in knav_qmss queues
> Get amount of available descriptors in free-descriptor queue
> base on event-triggered RX traffic.
> Also monitor free-descriptor queue base on periodic time interval
> in kernel thread.
> To start monitoring available descriptors in queue earlyi,
> module parameters, enable start monitoring in boottime
> 
> This queue descriptor monitor helps debugging starvation issue.
> The monitor should help debug queue under traffic pressure
> and can describe the shape of this pressure when a queue
> faced descriptors starvation.
> Monitor helpful for IP blocks which do not have dedicated
> descriptor starvation interrupt like RapidIO IP.
> 
> Registration and enable file in debugfs hierarchy
> 
> |-/sys/kernel/debug
> |-- knav_qmssm_soc:hwqueue@2a40000
> |   |-- 8710
> |   |   |-- buffer_size
> |   |   |-- enable
> |   |   |-- monitor_stats
> |   |   -- unregister
> 
> ---
> 
> The current implementation is the first iteration
> and require additional work.
> By this patch I would like to know does this could be
> helpful for other components and continue my work in a right way.
> 
> Signed-off-by: Vasyl Gomonovych <vasyl.gomonovych@nokia.com>

This is way over engineered for just keeping some statistics around.

Just have a periodic timer or a workqueue that does the necessary
sampling.
