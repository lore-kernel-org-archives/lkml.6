Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6C7222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437225AbfBNRBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:01:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437188AbfBNRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:01:09 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B53714D5ECCD;
        Thu, 14 Feb 2019 09:01:08 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:01:07 -0800 (PST)
Message-Id: <20190214.090107.1088098621242009425.davem@davemloft.net>
To:     jose.abreu@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH net] net: stmmac: Fix NAPI poll in TX path when in
 multi-queue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a264c48823687434e4d18aeb5830707e00c64250.1550077162.git.joabreu@synopsys.com>
References: <a264c48823687434e4d18aeb5830707e00c64250.1550077162.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 09:01:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>
Date: Wed, 13 Feb 2019 18:00:43 +0100

> Commit 8fce33317023 introduced the concept of NAPI per-channel and
> independent cleaning of TX path.
> 
> This is currently breaking performance in some cases. The scenario
> happens when all packets are being received in Queue 0 but the TX is
> performed in Queue != 0.
> 
> I didn't look very deep but it seems that NAPI for Queue 0 will clean
> the RX path but as TX is in different NAPI, this last one is called at a
> slower rate which kills performance in TX. I suspect this is due to TX
> cleaning takes much longer than RX and because NAPI will get canceled
> once we return with 0 budget consumed (e.g. when TX is still not done it
> will return 0 budget).
> 
> Fix this by looking at all TX channels in NAPI poll function.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")

No this isn't right.

The TX interrupt events for Queue != 0 should clean up the TX packets
on those queues.

Furthermore you are breaking the locality of the TX processing.

I'm not applying this, sorry.
