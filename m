Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeCSXdl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:33:41 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51162 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeCSXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:33:39 -0400
Date: Tue, 20 Mar 2018 07:33:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: doc - clarify hash callbacks state machine
Message-ID: <20180319233323.GA15897@gondor.apana.org.au>
References: <20180305103945.3517-1-horia.geanta@nxp.com>
 <20180316151642.GA6606@gondor.apana.org.au>
 <AM3PR04MB45284A83B66E00785872DE698D40@AM3PR04MB452.eurprd04.prod.outlook.com>
 <20180319092458.GB12302@gondor.apana.org.au>
 <AM3PR04MB4520497CC3D9B2B98B8E63798D40@AM3PR04MB452.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM3PR04MB4520497CC3D9B2B98B8E63798D40@AM3PR04MB452.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 11:04:24AM +0000, Horia Geantă wrote:
>
> The only solution to avoid leaks in this case is to repeatedly DMA map & unmap
> the buffer.
> IOW, if one wants to load/save HW state in a buffer after an .update() and to
> instruct the crypto engine to do this operation, the following steps are involved:
> -gpp: DMA map the buffer, get its IOVA
> -gpp: program the crypto engine with IOVA, wait for crypto engine's signal
> -crypto engine: load HW state from buffer, perform the partial hash, save HW
> state in buffer, signal gpp
> -gpp: DMA unmap the buffer

What buffer are you talking about here? Is it the hash state?

If it's the hash state and assuming DMA mapping was slow enough
on your platform, you could solve it by maintaining a fixed set
of hash states that are rotated through the actual hash requests.

Let's say you allocate n such hash states which are always mapped,
then if there are less than n hash requests outstanding, you could
directly use the mapped hash states in the requests.

If there are more than n, then you simply copy in/copy out for each
hash operation.

The number n limits how many operations can be pending to be
processed by the hardware.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
