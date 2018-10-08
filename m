Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C058FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562C02077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562C02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJHM6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:58:03 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40516 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJHM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:58:02 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g9OOc-0001lz-W7; Mon, 08 Oct 2018 13:47:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g9OOY-000520-Ah; Mon, 08 Oct 2018 13:47:54 +0800
Date:   Mon, 8 Oct 2018 13:47:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/nitrox - Fix format strings
Message-ID: <20181008054754.zdt42w6whtpqkpif@gondor.apana.org.au>
References: <20181002210022.2369756-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002210022.2369756-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:00:03PM +0200, Arnd Bergmann wrote:
> The return type of atomic64_read() is unfortunately architecture
> specific, it can be 'long', 'long long', or 's64'. When it is 'long',
> we get a build warning:
> 
> drivers/crypto/cavium/nitrox/nitrox_debugfs.c: In function 'stats_show':
> drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]
>   seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
>                            ~~~^
>                            %ld
> drivers/crypto/cavium/nitrox/nitrox_debugfs.c:63:33: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]
>   seq_printf(s, "  Completed: %lld\n",
>                               ~~~^
>                               %ld
> drivers/crypto/cavium/nitrox/nitrox_debugfs.c:65:31: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]
> 
> Add an explicit cast to 's64' to get a consistent behavior on all
> architectures here during compile testing.
> 
> Fixes: 2a8780be9c26 ("crypto: cavium/nitrox - updated debugfs information.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This patch doesn't apply to cryptodev because the bug has already
been fixed by another patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
