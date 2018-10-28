Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB608ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6280020824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJ1N1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:27:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39754 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJ1N1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:27:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 58B38146F4249;
        Sat, 27 Oct 2018 21:44:27 -0700 (PDT)
Date:   Sat, 27 Oct 2018 21:44:26 -0700 (PDT)
Message-Id: <20181027.214426.537959459795607171.davem@davemloft.net>
To:     oleksandr@natalenko.name
Cc:     dave.taht@gmail.com, hkallweit1@gmail.com, toke@toke.dk,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
References: <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
        <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
        <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Oct 2018 21:44:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Fri, 26 Oct 2018 22:54:12 +0200

> Next, I've seen GRO bits in the call trace and decided to disable GRO
> on this NIC. So far, I cannot trigger a panic with GRO disabled even
> after 20 rounds of speedtest.
> 
> So, must be some generic thing indeed.

Yeah something is out-of-whack with GRO.

Does this fix it?

diff --git a/net/core/dev.c b/net/core/dev.c
index 022ad73d6253..77d43ae2a7bb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5457,7 +5457,7 @@ static void gro_flush_oldest(struct list_head *head)
 	/* Do not adjust napi->gro_hash[].count, caller is adding a new
 	 * SKB to the chain.
 	 */
-	list_del(&oldest->list);
+	skb_list_del_init(oldest);
 	napi_gro_complete(oldest);
 }
 
