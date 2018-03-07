Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeCGRmy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:42:54 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54704 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeCGRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:42:52 -0500
Date: Wed, 07 Mar 2018 12:42:49 -0500 (EST)
Message-Id: <20180307.124249.619165601144161535.davem@davemloft.net>
To: niklas.cassel@axis.com
Cc: pavel@ucw.cz, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180307172157.GA22658@axis.com>
References: <20180302232853.GA11108@axis.com>
        <20180307.103226.1538176953286317879.davem@davemloft.net>
        <20180307172157.GA22658@axis.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>
Date: Wed, 7 Mar 2018 18:21:57 +0100

> Considering this, you can drop/revert:
> 95eb930a40a0 ("net: stmmac: use correct barrier between coherent memory and MMIO")
> or perhaps you want me to send a revert?

You must submit explicit patches to do a revert or any other change.

> After reverting 95eb930a40a0, we will still have a dma_wmb() _after_ the
> last descriptor word write. You just explained that nothing else is needed
> after the last descriptor word write, so I actually think that this last
> barrier is superfluous.

You don't need one after the last descriptor write.

Look, you're only concerned with ordering within the descriptor writes.

So it's only about:

	desc->a = x;

	/* Write to 'a' must be visible to the hardware before 'b'. */
	dma_wmb();
	desc->b = y;

	writel();

That's all that you need.
