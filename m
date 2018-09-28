Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17FCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A886F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A886F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeI1LcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:32:14 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42604 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1LcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:32:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l2Z-0000A6-0r; Fri, 28 Sep 2018 13:10:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l2W-000623-0S; Fri, 28 Sep 2018 13:10:08 +0800
Date:   Fri, 28 Sep 2018 13:10:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        "David S . Miller " <davem@davemloft.net>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-crypto@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mxs-dcp - Fix wait logic on chan threads
Message-ID: <20180928051007.53pokj4jmazcdikz@gondor.apana.org.au>
References: <163d1af7d51bfa330f4cc685c5c493cd38aa584b.1537541211.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163d1af7d51bfa330f4cc685c5c493cd38aa584b.1537541211.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:03:18PM +0300, Leonard Crestez wrote:
> When compiling with CONFIG_DEBUG_ATOMIC_SLEEP=y the mxs-dcp driver
> prints warnings such as:
> 
> WARNING: CPU: 0 PID: 120 at kernel/sched/core.c:7736 __might_sleep+0x98/0x9c
> do not call blocking ops when !TASK_RUNNING; state=1 set at [<8081978c>] dcp_chan_thread_sha+0x3c/0x2ec
> 
> The problem is that blocking ops will manipulate current->state
> themselves so it is not allowed to call them between
> set_current_state(TASK_INTERRUPTIBLE) and schedule().
> 
> Fix this by converting the per-chan mutex to a spinlock (it only
> protects tiny list ops anyway) and rearranging the wait logic so that
> callbacks are called current->state as TASK_RUNNING. Those callbacks
> will indeed call blocking ops themselves so this is required.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
