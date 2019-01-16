Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B183820651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405881AbfAPRM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:12:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfAPRM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F40755C9;
        Wed, 16 Jan 2019 17:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B63405C228;
        Wed, 16 Jan 2019 17:12:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190116164703.9267-1-vt@altlinux.org>
References: <20190116164703.9267-1-vt@altlinux.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, qat-linux@intel.com
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public key algorithms
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24886.1547658740.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jan 2019 17:12:20 +0000
Message-ID: <24887.1547658740@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 17:12:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Umm...  What do I apply this patch to?

In your modified public_key_verify_signature():

> -	sg_init_one(&digest_sg, output, outlen);
> -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> +	sg_init_one(&output_sg, output, outlen);
> +	akcipher_request_set_crypt(req, &sig_sg, &output_sg, sig->s_size,
>  				   outlen);

Why is the output necessary?  It was there for the decoded hash to be placed
in prior to comparison - but now that's not necessary.

> -	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> +	ret = crypto_wait_req(crypto_akcipher_verify(req, sig->digest,
> +						     sig->digest_size), &cwait);

I see sig->digest is passed in here.  Should it be passed in in place of
output_sg above?

> -	inst->alg.verify = pkcs1pad_verify;
> +	inst->alg.verify_rsa = pkcs1pad_verify;

Is there a reason that pkcs1pad_verify() can't do the comparison?

> -	.verify = rsa_verify,
> +	.verify_rsa = rsa_verify,

Likewise verify_rsa()?

Granted, this might involve pkcs1pad_verify() dressing up the signature in the
appropriate wrappings and passing it along to verify_rsa() to do the actual
comparison there (ie. what pkcs1pad_verify_complete() does).

> -	.verify = caam_rsa_enc,
> +	.verify_rsa = caam_rsa_enc,

I presume this is the reason - because this reuses its encrypt operation
directly.  But could this instead perform the comparison upon completion, say
in rsa_pub_done()?

> -	.verify = qat_rsa_enc,
> +	.verify_rsa = qat_rsa_enc,

Again, this could do the comparison, say, in qat_rsa_cb().

David
