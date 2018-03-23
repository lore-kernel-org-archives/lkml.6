Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeCWQna (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:43:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43692 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:43:28 -0400
Date: Fri, 23 Mar 2018 12:43:26 -0400 (EDT)
Message-Id: <20180323.124326.2170503491903886041.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
References: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
        <20180323.122035.1380806748695640531.davem@davemloft.net>
        <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 12:31:12 -0400

> Sorry, you got me confused now.
> 
> If you look at the code closer, you'll see this.
> 
> 	wmb();
> 
> 	txdata->tx_db.data.prod += nbd;
> 	barrier();
> 
> 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> 
> and you also asked me to rename DOORBELL to DOORBELL_RELAXED() to make
> it obvious that we have a relaxed operator inside the macro.

This still doesn't match the stated pattern.

	wmb();
	/* no other memory or I/O or IOMEM operation */
	writel();

There is a write to a producer index there and then no non-compiler
barrier or any kind before the writel().

So, in fact, it might really need that implicit writel() barrier here!
