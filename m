Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C37C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F9421476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F9421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeIXBY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:24:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXBY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:24:56 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7BC59146B8DEA;
        Sun, 23 Sep 2018 12:26:23 -0700 (PDT)
Date:   Sun, 23 Sep 2018 12:26:22 -0700 (PDT)
Message-Id: <20180923.122622.2033570349162784418.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH] RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for
 rds_ib_stats
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180923.121927.436285462706036460.davem@davemloft.net>
References: <20180921180451.18711-1-natechancellor@gmail.com>
        <20180923064445.GC12338@flashbox>
        <20180923.121927.436285462706036460.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 23 Sep 2018 12:26:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 23 Sep 2018 12:19:27 -0700 (PDT)

> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Sat, 22 Sep 2018 23:44:45 -0700
> 
>> I have sent a v2 because this should be DECLARE_PER_CPU_SHARED_ALIGNED,
>> not DEFINE (thanks to 0day for catching it).
> 
> Your first version was already applied to the networking GIT tree, so
> you will need to submit a relative fixup with a proper "Fixes: " tag.

Nevermind, I took care of it myself.

====================
From 16fdf8ba98391650ce4bc4f3f71629d8a413bc21 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 23 Sep 2018 12:25:15 -0700
Subject: [PATCH] rds: Fix build regression.

Use DECLARE_* not DEFINE_*

Fixes: 8360ed6745df ("RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for rds_ib_stats")
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/rds/ib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index fd483760c910..71ff356ee702 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -443,7 +443,7 @@ int rds_ib_send_grab_credits(struct rds_ib_connection *ic, u32 wanted,
 int rds_ib_xmit_atomic(struct rds_connection *conn, struct rm_atomic_op *op);
 
 /* ib_stats.c */
-DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
 #define rds_ib_stats_inc(member) rds_stats_inc_which(rds_ib_stats, member)
 #define rds_ib_stats_add(member, count) \
 		rds_stats_add_which(rds_ib_stats, member, count)
-- 
2.13.6

