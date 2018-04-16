Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeDPPFE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:05:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeDPPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:05:02 -0400
Date: Mon, 16 Apr 2018 11:05:01 -0400 (EDT)
Message-Id: <20180416.110501.92472500114183248.davem@davemloft.net>
To: liu.xiang6@zte.com.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
Subject: Re: [PATCH v3] net: davicom: dm9000: Avoid spinlock recursion
 during dm9000_timeout routine
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523695834-6261-1-git-send-email-liu.xiang6@zte.com.cn>
References: <1523695834-6261-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Xiang <liu.xiang6@zte.com.cn>
Date: Sat, 14 Apr 2018 16:50:34 +0800

> +static bool dm9000_current_in_timeout(struct board_info *db)
> +{
> +	bool ret = false;
> +
> +	preempt_disable();
> +	ret = (db->timeout_cpu == smp_processor_id());
> +	preempt_enable();

This doesn't work.

As soon as you do preempt_enable(), smp_processor_id() can change.
