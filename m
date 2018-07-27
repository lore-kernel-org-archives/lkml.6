Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC15C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F232088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F232088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeG0BYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:24:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:53525 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbeG0BYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:24:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 17:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,407,1526367600"; 
   d="scan'208";a="60168243"
Received: from megha-z97x-ud7-th.sc.intel.com (HELO [143.183.85.162]) ([143.183.85.162])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2018 17:05:39 -0700
Message-ID: <1532651107.19157.24.camel@megha-Z97X-UD7-TH>
Subject: Re: [RFC] crypto: Remove mcryptd
From:   Megha Dey <megha.dey@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Date:   Thu, 26 Jul 2018 17:25:07 -0700
In-Reply-To: <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
References: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
         <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 11:53 +0800, Herbert Xu wrote:
> On Fri, May 11, 2018 at 06:44:13PM -0700, Megha Dey wrote:
> >
> > +static struct ahash_alg *simd_ahash_create_compat(const char *algname,
> > +						       const char *drvname,
> > +						       const char *basename)
> > +{
> > +	struct ahash_alg *alg;
> > +	struct ahash_alg *ialg;
> > +	int err;
> 
> I think there has been a misunderstsanding.  You're not actually
> using the simd wrapper here.  All you're doing is creating a function
> with the word simd in its name.  In all other respects this is just
> exposing the underlying algorithm to users directly, which cannot
> work because the underlying algorithm requires SIMD.

Hi Herbert,

Thanks for the feedback.

I still have some questions though:

1. On the existing algorithms covered in aesni_intel-glue.c (eg:
__cbc-aes-aesni), 3 algorithms are registered in /proc/crypto:

     __cbc(aes)
     cryptd(__cbc-aes-aesni)--> registered via cryptd_create_skcipher

     cbc(aes)
     cbc-aes-aesni	--> registered via simd_skcipher_create_compat

     __cbc(aes)
     __cbc-aes-aesni    --> registered as the internal algorithm

I would want to know why do we need the cryptd(__cbc-aes-aesni)
algorithm at all. I do not see any of the associated setkey, encrypt or
decrypt functions getting called during the selftest or while running
tcrypt. I just see the simd_(setkey, encrypt, decrypt) functions
directly called the inner algorithms. However, if I remove the cryptd
algorithm, none of the algorithms are registered.

> 
> What you need to do is create an actual simd wrapper with cryptd
 
This simd wrapper is already present for skcipher right(in simd.c)?
Assuming we only have ciphers and no hash algorithms, are any changes
required in these wrappers?

Pseudo code:
1. Register inner algorithm (cbc-aes-aesni-mb) in aes_cbc_mb_mod_init()
2. Register outer algorithm with the mcryptd- prefix for the driver name
using the simd_skcipher_create_compat(mcryptd-cbc-aes-aesni-mb)
3. tcrypt/testmanager calls the
crypto_skcipher_encrypt->simd_skcipher_encrypt->mb_cbc_aes_encrypt 
4. Shift helper functions which help flush outstanding jobs to glue
layer.
5. Delete mcryptd.c
6. All similar simd wrapper for hash algorithms. 

> and all the functions that may do SIMD work needs to invoke cryptd
> if may_use_simd() (and other conditions) is false.
> 
> This wrapper should live in crypto/simd.c.
> 
> Cheers,


