Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B52C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42120645
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeJLAyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:54:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJLAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:54:15 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44AB912DE580E;
        Thu, 11 Oct 2018 10:26:04 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:26:03 -0700 (PDT)
Message-Id: <20181011.102603.2088827315896221671.davem@davemloft.net>
To:     ying.xue@windriver.com
Cc:     jon.maloy@ericsson.com, dvyukov@google.com,
        parthasarathy.bhuvaragan@ericsson.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net] tipc: eliminate possible recursive locking
 detected by LOCKDEP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539259076-8562-1-git-send-email-ying.xue@windriver.com>
References: <1539259076-8562-1-git-send-email-ying.xue@windriver.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 10:26:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Xue <ying.xue@windriver.com>
Date: Thu, 11 Oct 2018 19:57:56 +0800

> When booting kernel with LOCKDEP option, below warning info was found:
> 
> WARNING: possible recursive locking detected
> 4.19.0-rc7+ #14 Not tainted
 ...
> The reason why the noise above was complained by LOCKDEP is because we
> nested to hold l->wakeupq.lock and l->inputq->lock in tipc_link_reset
> function. In fact it's unnecessary to move skb buffer from l->wakeupq
> queue to l->inputq queue while holding the two locks at the same time.
> Instead, we can move skb buffers in l->wakeupq queue to a temporary
> list first and then move the buffers of the temporary list to l->inputq
> queue, which is also safe for us.
> 
> Fixes: 3f32d0be6c16 ("tipc: lock wakeup & inputq at tipc_link_reset()")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Ying Xue <ying.xue@windriver.com>

Applied.
