Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeCGPcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:32:31 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:53140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933665AbeCGPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:32:28 -0500
Date: Wed, 07 Mar 2018 10:32:26 -0500 (EST)
Message-Id: <20180307.103226.1538176953286317879.davem@davemloft.net>
To: niklas.cassel@axis.com
Cc: pavel@ucw.cz, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180302232853.GA11108@axis.com>
References: <20180302091959.GC15948@amd>
        <20180302.095411.1270630534912987342.davem@davemloft.net>
        <20180302232853.GA11108@axis.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>
Date: Sat, 3 Mar 2018 00:28:53 +0100

> However, the last write we do is "DMA start transmission",
> this is a register in the IP, i.e. it is a write to the cache
> incoherent MMIO region (rather than a write to cache coherent memory).
> To ensure that all writes to cache coherent memory have
> completed before we start the DMA, we have to use the barrier
> wmb() (which performs a more extensive flush compared to
> dma_wmb()).

The is an implicit memory barrier between physical memory writes
and those to MMIO register space.

So as long as you place the dma_wmb() to ensure the correct
ordering within the descriptor words, you need nothing else
after the last descriptor word write.
