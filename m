Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeDRRfm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:35:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeDRRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:35:40 -0400
Date: Wed, 18 Apr 2018 13:35:39 -0400 (EDT)
Message-Id: <20180418.133539.1514284482902646647.davem@davemloft.net>
To: liuxiang_1999@126.com
Cc: liu.xiang6@zte.com.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: davicom: dm9000: Avoid spinlock recursion
 during dm9000_timeout routine
From: David Miller <davem@davemloft.net>
In-Reply-To: <72770aae.bb31.162d9036874.Coremail.liuxiang_1999@126.com>
References: <1523695834-6261-1-git-send-email-liu.xiang6@zte.com.cn>
        <20180416.110501.92472500114183248.davem@davemloft.net>
        <72770aae.bb31.162d9036874.Coremail.liuxiang_1999@126.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuxiang  <liuxiang_1999@126.com>
Date: Wed, 18 Apr 2018 21:48:22 +0800 (CST)

> Because the timeout task gets the main spinlock and disable the
> current cpu's irq, there is no other task on the same cpu can run,
> and tasks on the other cpus can not enter the dm9000_timeout()
> again. So in the whole dm9000_timeout() routine, db->timeout_cpu can
> not be changed by other tasks. Although smp_processor_id() may
> change after preempt_enable(), these tasks always get the false
> result when call dm9000_current_in_timeout.  Only the timeout task
> get the true result. And if there is no timeout, all the tasks that
> want to do asynchronous phy operation get the false result. So I
> think this can avoid racy.

This is a very shaky foundation upon which to base the correctness
of your driver's synchronization in my opinion.
