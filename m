Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA9C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352B120989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352B120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeLMKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:14:08 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50402 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeLMKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:14:07 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXO0I-0002vt-36; Thu, 13 Dec 2018 18:14:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXO0H-0004Xs-H3; Thu, 13 Dec 2018 18:14:01 +0800
Date:   Thu, 13 Dec 2018 18:14:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, davem@davemloft.net, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] X.509: Parse public key parameters from x509 for
 akcipher
Message-ID: <20181213101401.zsmpkz6okgkjmbw3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209135548.26232-1-vt@altlinux.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:
> Some public key algorithms (like ECDSA) keep in parameters field
> important data such as digest and curve OIDs (possibly more for
> different ECDSA variants). Thus, just setting a public key (as
> for RSA) is not enough.
> 
> Introduce set_params() callback for akcipher which will be used to
> pass BER encoded parameters array, with additional argument of
> algorithm OID.
> 
> This is done with the intent of adding support for EC-RDSA (ISO/IEC
> 14888-3:2018, RFC 7091, and basically ECDSA variant) public keys (which
> will be finally used in IMA subsystem). Thus, also oid_registry.h is
> updated.
> 
> Rationale:
> 
> - For such keys just setting public key without parameters is
>  meaningless, so it would be possible to add parameters in
>  crypto_akcipher_set_pub_key (and .set_pub_key) calls. But, this will
>  needlessly change API for RSA akcipher. Also, additional callback
>  making it possible to pass parameters after
>  crypto_akcipher_set_priv_key (and .set_priv_key) in the future.
> 
> - Algorithm OID is passed to be validated in .set_params callback,
>  otherwise, it could have the wrong value.
> 
> - Particular algorithm OIDs are checked in x509_note_params, (because
>  this is called from AlgorithmIdentifier (ASN.1) parser, which is
>  called multiple times, as it's used multiple times in X.509
>  certificate), to distinguish a public key call from a signature call.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Please post this with a patch that actually uses the set_params
callback.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
