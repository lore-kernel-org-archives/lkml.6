Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeBCAdd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:33:33 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeBCAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:33:27 -0500
Date: Fri, 02 Feb 2018 19:33:24 -0500 (EST)
Message-Id: <20180202.193324.255250279487626556.davem@davemloft.net>
To: arnd@arndb.de
Cc: ganeshgr@chelsio.com, nico@linaro.org, ak@linux.intel.com,
        herbert@gondor.apana.org.au, rahul.lakkireddy@chelsio.com,
        kumaras@chelsio.com, harsh@chelsio.com, atul.gupta@chelsio.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb4: avoid memcpy beyond end of source buffer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180202151849.808610-1-arnd@arndb.de>
References: <20180202151849.808610-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  2 Feb 2018 16:18:37 +0100

> Building with link-time-optimizations revealed that the cxgb4 driver does
> a fixed-size memcpy() from a variable-length constant string into the
> network interface name:
> 
> In function 'memcpy',
>     inlined from 'cfg_queues_uld.constprop' at drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:335:2,
>     inlined from 'cxgb4_register_uld.constprop' at drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:719:9:
> include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>    __read_overflow2();
>    ^
> 
> I can see two equally workable solutions: either we use a strncpy() instead
> of the memcpy() to stop at the end of the input, or we make the source buffer
> fixed length as well. This implements the latter.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Not the most pleasant thing in the world, but I can't think of a better
solution.

> @@ -355,7 +355,7 @@ struct cxgb4_lld_info {
>  };
>  
>  struct cxgb4_uld_info {
> -	const char *name;
> +	char name[IFNAMSIZ];
>  	void *handle;
>  	unsigned int nrxq;
>  	unsigned int rxq_size;

David Laight asked how this can be the sole part of the patch.

All of these structures are initialized like:

static struct cxgb4_uld_info {
	.name	= "foo",
	...
};

So changing from "const char *" to "char []" just works.
