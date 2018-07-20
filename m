Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708D3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70320833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeGTEjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:39:48 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38884 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeGTEjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:39:48 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fgMU1-0004uo-SV; Fri, 20 Jul 2018 11:53:33 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fgMTt-0007Sd-7x; Fri, 20 Jul 2018 11:53:25 +0800
Date:   Fri, 20 Jul 2018 11:53:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        megha.dey@intel.com
Subject: Re: [RFC] crypto: Remove mcryptd
Message-ID: <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
References: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 06:44:13PM -0700, Megha Dey wrote:
>
> +static struct ahash_alg *simd_ahash_create_compat(const char *algname,
> +						       const char *drvname,
> +						       const char *basename)
> +{
> +	struct ahash_alg *alg;
> +	struct ahash_alg *ialg;
> +	int err;

I think there has been a misunderstsanding.  You're not actually
using the simd wrapper here.  All you're doing is creating a function
with the word simd in its name.  In all other respects this is just
exposing the underlying algorithm to users directly, which cannot
work because the underlying algorithm requires SIMD.

What you need to do is create an actual simd wrapper with cryptd
and all the functions that may do SIMD work needs to invoke cryptd
if may_use_simd() (and other conditions) is false.

This wrapper should live in crypto/simd.c.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
