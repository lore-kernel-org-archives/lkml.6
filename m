Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCVSrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:47:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeCVSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:47:11 -0400
Date: Thu, 22 Mar 2018 14:47:09 -0400 (EDT)
Message-Id: <20180322.144709.550558706036978967.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for
 local variables
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
References: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 21 Mar 2018 16:14:00 +0100

> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 9bd35f2291d6..28e33e139178 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -1913,16 +1913,11 @@ static void mvpp2_prs_sram_offset_set(struct mvpp2_prs_entry *pe,
>  }
>  
>  /* Find parser flow entry */
> -static struct mvpp2_prs_entry *mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
> +static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
>  {
> -	struct mvpp2_prs_entry *pe;
> +	struct mvpp2_prs_entry pe;
>  	int tid;
>  
> -	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
> -	if (!pe)
> -		return NULL;
> -	mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_FLOWS);
> -

In order to be an equivalent change you must bzero out this 'pe' object
on the stack.  You are only initializing the index member before passing
it into other functions.

Thank you.
