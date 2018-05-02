Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeEBOya convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:54:30 -0400
Received: from smtp-out4.electric.net ([192.162.216.182]:63961 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeEBOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:54:27 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Antoine Tenart'" <antoine.tenart@bootlin.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "oferh@marvell.com" <oferh@marvell.com>,
        "igall@marvell.com" <igall@marvell.com>
Subject: RE: [PATCH 01/10] crypto: aead - allow to allocate AEAD requests on
 the stack
Thread-Topic: [PATCH 01/10] crypto: aead - allow to allocate AEAD requests on
 the stack
Thread-Index: AQHT4fyKUNgtSEFab0iAsqaTkmQI1KQchwzA
Date: Wed, 2 May 2018 14:55:19 +0000
Message-ID: <02ad9eb93c494314a85db69886cf787a@AcuMS.aculab.com>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
 <20180502095725.31935-2-antoine.tenart@bootlin.com>
In-Reply-To: <20180502095725.31935-2-antoine.tenart@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart
> Sent: 02 May 2018 10:57
> Adds the AEAD_REQUEST_ON_STACK primitive to allow allocating AEAD
> requests on the stack, as it can already be done with various other
> crypto algorithms within the kernel.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  include/crypto/aead.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/crypto/aead.h b/include/crypto/aead.h
> index 1e26f790b03f..b67064786546 100644
> --- a/include/crypto/aead.h
> +++ b/include/crypto/aead.h
> @@ -151,6 +151,11 @@ struct aead_alg {
>  	struct crypto_alg base;
>  };
> 
> +#define AEAD_REQUEST_ON_STACK(name, tfm) \
> +	char __##name##_desc[sizeof(struct aead_request) + \
> +		crypto_aead_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> +	struct aead_request *name = (void *)__##name##_desc
> +

This looks stunningly like a VLA.

	David
