Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF99FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ACA2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ACA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeKUSeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:34:20 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:48402 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKUSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:34:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gPNRJ-0004Vn-26; Wed, 21 Nov 2018 16:00:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gPNRF-0007Ym-GV; Wed, 21 Nov 2018 16:00:45 +0800
Date:   Wed, 21 Nov 2018 16:00:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2013@163.com>,
        Mathias Krause <minipli@googlemail.com>
Subject: Re: [net] xfrm_user: use xfrm_state_put to free xfrm_state_alloc
 return value
Message-ID: <20181121080045.4vtozqc6eyeyis2n@gondor.apana.org.au>
References: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:57:48PM +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2013@163.com>
> 
> The memory chunk allocated by xfrm_state_alloc() should be released with
> xfrm_state_put(), not kfree.
> 
> Signed-off-by: Pan Bian <bianpan2013@163.com>

This bug was introduced by

	commit 565f0fa902b64020d5d147ff1708567e9e0b6e49
	Author: Mathias Krause <minipli@googlemail.com>
	Date:   Thu May 3 10:55:07 2018 +0200

While using xfrm_state_put may work it's certainly not the designed
to do this.  We should instead export a function that calls
kmem_cache_free on xfrm_state directly and use that here.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
