Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeCQN1y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 09:27:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45124 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeCQN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 09:27:53 -0400
Date: Sat, 17 Mar 2018 09:27:50 -0400 (EDT)
Message-Id: <20180317.092750.607418476271096975.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: swise@opengridcomputing.com, netdev@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        swise@chelsio.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        werner@chelsio.com, leedom@chelsio.com
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate
 barriers on weakly-ordered archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
References: <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org>
        <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
        <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Sat, 17 Mar 2018 00:25:14 -0400

> I think I finally got what you mean.
> 
> Code seems to have
> 
> wmb()
> writel()/writeq()
> wmb()
> 
> this can be safely replaced with
> 
> wmb()
> __raw_writel()/__raw_writeq()
> wmb()
> 
> This will work on all arches. Below is the new version. Let me know if this is OK.

Unfortunately, I think this won't work.

At least on sparc, the __raw_*() variants also change the endianness to
native endianness.

PowerPC does this as well, even documented in a comment :-)

/*
 * Non ordered and non-swapping "raw" accessors
 */

Only the non-__raw_ variants do the endianness swap to/from
little-endian.
