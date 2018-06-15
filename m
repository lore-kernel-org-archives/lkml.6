Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 828DCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379DC2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379DC2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965908AbeFOPOj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:14:39 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57872 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFOPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:14:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fTqQT-0001GW-U7; Fri, 15 Jun 2018 23:14:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fTqQN-0003Eb-DO; Fri, 15 Jun 2018 23:14:03 +0800
Date:   Fri, 15 Jun 2018 23:14:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia He <hejianet@gmail.com>
Cc:     davem@davemloft.net, catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hejianet@gmail.com, jia.he@hxt-semitech.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm64/aes-blk - fix and move
 skcipher_walk_done out of kernel_neon_begin,_end
Message-ID: <20180615151403.cdvalbmdrt7gnodk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528443704-26850-1-git-send-email-hejianet@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia He <hejianet@gmail.com> wrote:
> In a arm64 server(QDF2400),I met a similar might-sleep warning as [1]:
> [    7.019116] BUG: sleeping function called from invalid context at
> ./include/crypto/algapi.h:416
> [    7.027863] in_atomic(): 1, irqs_disabled(): 0, pid: 410, name:
> cryptomgr_test
> [    7.035106] 1 lock held by cryptomgr_test/410:
> [    7.039549]  #0:         (ptrval) (&drbg->drbg_mutex){+.+.}, at:
> drbg_instantiate+0x34/0x398
> [    7.048038] CPU: 9 PID: 410 Comm: cryptomgr_test Not tainted
> 4.17.0-rc6+ #27
> [    7.068228]  dump_backtrace+0x0/0x1c0
> [    7.071890]  show_stack+0x24/0x30
> [    7.075208]  dump_stack+0xb0/0xec
> [    7.078523]  ___might_sleep+0x160/0x238
> [    7.082360]  skcipher_walk_done+0x118/0x2c8
> [    7.086545]  ctr_encrypt+0x98/0x130
> [    7.090035]  simd_skcipher_encrypt+0x68/0xc0
> [    7.094304]  drbg_kcapi_sym_ctr+0xd4/0x1f8
> [    7.098400]  drbg_ctr_update+0x98/0x330
> [    7.102236]  drbg_seed+0x1b8/0x2f0
> [    7.105637]  drbg_instantiate+0x2ac/0x398
> [    7.109646]  drbg_kcapi_seed+0xbc/0x188
> [    7.113482]  crypto_rng_reset+0x4c/0xb0
> [    7.117319]  alg_test_drbg+0xec/0x330
> [    7.120981]  alg_test.part.6+0x1c8/0x3c8
> [    7.124903]  alg_test+0x58/0xa0
> [    7.128044]  cryptomgr_test+0x50/0x58
> [    7.131708]  kthread+0x134/0x138
> [    7.134936]  ret_from_fork+0x10/0x1c
> 
> Seems there is a bug in Ard Biesheuvel's commit.
> Fixes: 683381747270 ("crypto: arm64/aes-blk - move kernel mode neon
> en/disable into loop")
> 
> [1] https://www.spinics.net/lists/linux-crypto/msg33103.html
> 
> Signed-off-by: jia.he@hxt-semitech.com
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: <stable@vger.kernel.org> # 4.17

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
