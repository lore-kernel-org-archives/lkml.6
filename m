Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeCWREV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:04:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43962 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeCWREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:04:20 -0400
Date: Fri, 23 Mar 2018 13:04:18 -0400 (EDT)
Message-Id: <20180323.130418.2223623186761161723.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
        <20180323.124326.2170503491903886041.davem@davemloft.net>
        <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 12:51:47 -0400

> It could if txdata->tx_db was not a union. There is a data dependency
> between txdata->tx_db.data.prod and txdata->tx_db.raw. 
> 
> So, no reordering.

I don't see it that way, the code requires that:

 	txdata->tx_db.data.prod += nbd;

is visible before the doorbell update.

barrier() doesn't provide that.

Neither does writel_relaxed().  However plain writel() does.

Therefore the code is only correct as-is, and your change potentially
adds a reordering problem.
