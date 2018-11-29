Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B392081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HBHiuNdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B392081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeK2Sma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:42:30 -0500
Received: from m12-15.163.com ([220.181.12.15]:42019 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeK2Sma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Fva0u
        psThI9/5B/dKzbVzKIt0VO+FAZlovF3pRRZcnM=; b=HBHiuNdyJUPoiUhA3OTdO
        O0XntqpN5KEpBMRnggtSDIqKFfqNKpF1zI5J5TeAywt5XV3ouaQzh5xqYkgPYs28
        g0+yEbmErE1DE+WXrcwJZ8cLRaBzJdgx8T+Z1ejTROSJ0PpU4CfXTdd20iZaIQ4q
        FbxTI30vfkOV6g3/gwPIxk=
Received: from bp (unknown [106.120.213.96])
        by smtp11 (Coremail) with SMTP id D8CowABniS1Rl_9b5izuAQ--.18628S2;
        Thu, 29 Nov 2018 15:37:53 +0800 (CST)
Date:   Thu, 29 Nov 2018 15:37:56 +0800
From:   PanBian <bianpan2016@163.com>
To:     David Miller <davem@davemloft.net>
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd-xgbe: set skb to NULL after freeing it
Message-ID: <20181129073756.GA73287@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543392585-17962-1-git-send-email-bianpan2016@163.com>
 <20181128.104931.1898736297454841540.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128.104931.1898736297454841540.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: D8CowABniS1Rl_9b5izuAQ--.18628S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4xGryxKrWxKr4fXFWDurg_yoWfXFb_Wr
        ykX3WkCw1DCasrGF4ftrWfXwn3Ga1UGry0qw48XrsFvr9xJrZ3C3ykWrnYgryxu392kF1U
        GFn5Za97uw13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUntku7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUREOclaD0WuU1QAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:49:31AM -0800, David Miller wrote:
> From: Pan Bian <bianpan2016@163.com>
> Date: Wed, 28 Nov 2018 16:09:45 +0800
> 
> If either of these two cases are executed, it means that it must be
> the case that:
> 
> 	!last || context_next
> 
> is FALSE, therefore the conditional in the tail code of this function:
> 
> 	/* Check if we need to save state before leaving */
> 	if (received && (!last || context_next)) {
> 		rdata = XGBE_GET_DESC_DATA(ring, ring->cur);
> 		rdata->state_saved = 1;
> 		rdata->state.skb = skb;
> 		rdata->state.len = len;
> 		rdata->state.error = error;
> 	}
> 
> will not trigger, and therefore we will not record the free'd SKB.
> 
> And if we iterate the loop again, it is guaranteed that 'skb' will
> be set to a new packet or NULL.
> 
> So there is no problem here.

Got it. Sorry for my misunderstanding. Thank you and Tom for the 
detailed explanations.

Pan

