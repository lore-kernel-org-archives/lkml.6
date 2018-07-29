Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC723C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EEB20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EEB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeG2VGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:06:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2VGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:06:43 -0400
Received: from localhost (unknown [IPv6:2603:3004:61b:dd00::7bb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D659713E0422C;
        Sun, 29 Jul 2018 12:35:11 -0700 (PDT)
Date:   Sun, 29 Jul 2018 12:35:10 -0700 (PDT)
Message-Id: <20180729.123510.1847228041867717113.davem@davemloft.net>
To:     Eugeniy.Paltsev@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Jose.Abreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com
Subject: Re: [PATCH] NET: stmmac: align DMA stuff to largest cache line
 length
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726120537.4664-1-Eugeniy.Paltsev@synopsys.com>
References: <20180726120537.4664-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 12:35:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date: Thu, 26 Jul 2018 15:05:37 +0300

> As for today STMMAC_ALIGN macro (which is used to align DMA stuff)
> relies on L1 line length (L1_CACHE_BYTES).
> This isn't correct in case of system with several cache levels
> which might have L1 cache line length smaller than L2 line. This
> can lead to sharing one cache line between DMA buffer and other
> data, so we can lose this data while invalidate DMA buffer before
> DMA transaction.
> 
> Fix that by using SMP_CACHE_BYTES instead of L1_CACHE_BYTES for
> aligning.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

This is definitely an improvement, so applied and queued up for
-stable.

There is also dma_get_cache_alignment(), so maybe we can eventually
use that here instead.
