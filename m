Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4862C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBFD2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBFD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbeFMGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:30:40 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53574 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeFMGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:30:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fSzIg-0001V3-Ve; Wed, 13 Jun 2018 14:30:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fSzId-0007Ll-2G; Wed, 13 Jun 2018 14:30:31 +0800
Date:   Wed, 13 Jun 2018 14:30:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>, hadar.gat@arm.com,
        Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccree: fix iv copying for small buffers
Message-ID: <20180613063030.bsrq3xmufcw4zi52@gondor.apana.org.au>
References: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
 <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:02:04PM +0300, Gilad Ben-Yossef wrote:
>
> I'd be really happy to get a review on this patch - not so much what
> it is doing but
> rather the rational behind it - how is a tfm provider supposed to
> handle copying the
> last block of ciphertext into the request structure if the ciphertext
> size is less than a
> block?

Which algorithm is this? In general we disallow requests which
are not a multiple of a block for block ciphers.  Obviously this
doesn't apply to stream ciphers such as ctr(aes), but in that case
it doesn't really matter as you cannot chain such a request.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
