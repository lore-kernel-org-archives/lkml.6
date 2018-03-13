Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCMBUO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:20:14 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39278 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbeCMBUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:20:12 -0400
Date: Mon, 12 Mar 2018 21:20:10 -0400 (EDT)
Message-Id: <20180312.212010.215262612578386966.davem@davemloft.net>
To: niklas.cassel@axis.com
Cc: Jose.Abreu@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, pavel@ucw.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180312085541.GA406@axis.com>
References: <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
        <20180309.101520.1551234308448290917.davem@davemloft.net>
        <20180312085541.GA406@axis.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>
Date: Mon, 12 Mar 2018 09:55:42 +0100

> Jose is simply responding to the commit message description of this patch.
> 
> You explained that there is an implicit memory barrier between physical memory
> writes and those to MMIO register space, as long as you used writel().
> 
> I assumed that you meant writel() vs writel_relaxed(), where there latter
> does not do an implicit barrier.
> 
> I also found this from you:
> https://lwn.net/Articles/198995/
> 
> If my assumption was incorrect, please correct me.
> 
> As you seem to possess knowledge regarding this, you are probably the most
> suited person to know if this patch simply needs a commit message rewrite,
> or if it should be dropped completely.

Yes, I have always argued that the non-relaxed {read,write}{b,w,l}()
interfaces should imply barriers wrt. physical memory accesses.

Without that, drivers are harder to write.  Specifically, drivers that
work properly on all architectures will be very hard to write.

But looking at some drivers, probably this isn't fully the case right
now.  Which is unfortunate, but we must code to reality.

For example, looking at drivers/net/ethernet/broadcom/tg3.c, we have
tg3_start_xmit() going:

	write descriptors
	...
	/* Sync BD data before updating mailbox */
	wmb();
	...
		/* Packets are ready, update Tx producer idx on card. */
		tw32_tx_mbox(tnapi->prodmbox, entry);

so it really seems to be necessary.

So this stmmac revert is not valid.

Sorry for all the confusion.  I guess it's a lot of wishful thinking on
my part :-)
