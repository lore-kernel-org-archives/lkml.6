Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A7C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343CB223B5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343CB223B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeHJEsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:48:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:13309 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeHJEsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:48:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 19:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="253555370"
Received: from megha-z97x-ud7-th.sc.intel.com (HELO [143.183.85.162]) ([143.183.85.162])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2018 19:20:36 -0700
Message-ID: <1533868833.19050.19.camel@megha-Z97X-UD7-TH>
Subject: Re: [RFC] crypto: Remove mcryptd
From:   Megha Dey <megha.dey@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Date:   Thu, 09 Aug 2018 19:40:33 -0700
In-Reply-To: <20180808095621.h7ecacftx5ofe5ki@gondor.apana.org.au>
References: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
         <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
         <1532651107.19157.24.camel@megha-Z97X-UD7-TH>
         <20180808095621.h7ecacftx5ofe5ki@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 17:56 +0800, Herbert Xu wrote:
> On Thu, Jul 26, 2018 at 05:25:07PM -0700, Megha Dey wrote:
> > 
> > 1. On the existing algorithms covered in aesni_intel-glue.c (eg:
> > __cbc-aes-aesni), 3 algorithms are registered in /proc/crypto:
> > 
> >      __cbc(aes)
> >      cryptd(__cbc-aes-aesni)--> registered via cryptd_create_skcipher
> > 
> >      cbc(aes)
> >      cbc-aes-aesni	--> registered via simd_skcipher_create_compat
> > 
> >      __cbc(aes)
> >      __cbc-aes-aesni    --> registered as the internal algorithm
> > 
> > I would want to know why do we need the cryptd(__cbc-aes-aesni)
> > algorithm at all. I do not see any of the associated setkey, encrypt or
> > decrypt functions getting called during the selftest or while running
> > tcrypt. I just see the simd_(setkey, encrypt, decrypt) functions
> > directly called the inner algorithms. However, if I remove the cryptd
> > algorithm, none of the algorithms are registered.
> 
> The simd functions are the fast path where you are running in a
> context where SIMD can be used directly.  cryptd is the slow path
> where we defer the work to a work queue.

Hi Herbert,

Thank you for the clarification.

I seem to have gotten things to work (i.e remove mcryptd layer). I have
tried this with the skcipher on top of my previously posted patches for
the aes-cbc-mb multibuffer algorithm since the simd wrappers already
exist for it. I am working on extending to hashes, sorry for the
confusion.

I would like to get your approval first on the changes I have made in
the cryptd layer:

1. 
@@ -495,7 +534,10 @@ static void cryptd_skcipher_encrypt(struct
crypto_async_request *base,
        skcipher_request_set_crypt(subreq, req->src, req->dst,
req->cryptlen, req->iv);
 
-       err = crypto_skcipher_encrypt(subreq);
+       subreq->base.data = req->base.data;
+       subreq->base.complete = rctx->complete;
+       rctx->desc = *subreq;
+       err = crypto_skcipher_encrypt(&rctx->desc);
        skcipher_request_zero(subreq);

This change is necessary because for the multibuffer algorithms, the
inner algorithm needs a pointer to the original request. In the slow
path, since we allocate a skcipher_request on the stack, there is no
easy way to retrieve the request. In the mcryptd_layer, we had extra
logic to store this pointer. 

2. Currently, 
-struct cryptd_skcipher_request_ctx {
-       crypto_completion_t complete;
-};
-

For multibuffer algorithms, we need more structure members:
+struct cryptd_skcipher_request_ctx {
+        struct list_head waiter;
+        crypto_completion_t complete;
+        struct cryptd_tag tag;
+        struct skcipher_walk walk;
+        u8 flag;
+        int nbytes;
+        int error;
+        struct skcipher_request desc;
+        void *job;
+        u128 seq_iv;

I am not sure if adding the member to the original structure definition
is acceptable or I should introduce a new structure.

Lastly, for hashes, we have
struct cryptd_hash_request_ctx {
        crypto_completion_t complete;
        struct shash_desc desc;
};

If we were to use this(with the added fields for multibuffer), we should
update the shash_desc to ahash_request since we are an async algorithm
right?


> 
> > > What you need to do is create an actual simd wrapper with cryptd
> >  
> > This simd wrapper is already present for skcipher right(in simd.c)?
> > Assuming we only have ciphers and no hash algorithms, are any changes
> > required in these wrappers?
> 
> For skcipher yes they already exist.  But this thread was about
> hashes.
> 
> Cheers,


