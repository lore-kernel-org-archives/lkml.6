Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC03C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8321104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeLMKMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:12:41 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50394 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:12:41 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXNyu-0002uR-71; Thu, 13 Dec 2018 18:12:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXNyr-0004XO-Rh; Thu, 13 Dec 2018 18:12:33 +0800
Date:   Thu, 13 Dec 2018 18:12:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, davem@davemloft.net, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] akcipher: Introduce verify2 for public key algorithms
Message-ID: <20181213101233.6t7d5mxxkkavo46h@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211165938.1150-1-vt@altlinux.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:
> Current akcipher .verify() just decrypts signature to uncover message
> hash, which is then verified in upper level public_key_verify_signature
> by memcmp with the expected signature value, which is never passed into
> verify().
> 
> This approach is incompatible with ECDSA algorithms, because, to verify
> a signature ECDSA algorithm also needs a hash value as input; also, hash
> is used in ECDSA (together with a signature divided into halves `r||s`),
> not to produce hash, but to produce a number, which is then compared to
> `r` (first part of the signature) to determine if the signature is
> correct.  Thus, for ECDSA, nor requirements of .verify() itself, nor its
> output expectations in public_key_verify_signature aren't satisfied.
> 
> Make alternative .verify2() call which gets hash value and produce
> complete signature check (without any output, thus max_size() call will
> not be needed for verify2() operation).
> 
> If .verify2() call is present, it should be used in place of .verify().
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

We should convert all existing users to this interface and not
have both verify/verify2 forever.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
