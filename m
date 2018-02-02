Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBBQ6n convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:58:43 -0500
Received: from smtp-out6.electric.net ([192.162.217.187]:65376 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBBQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:58:34 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Arnd Bergmann'" <arnd@arndb.de>,
        Ganesh Goudar <ganeshgr@chelsio.com>
CC: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Kumar Sanghvi <kumaras@chelsio.com>, Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: cxgb4: avoid memcpy beyond end of source buffer
Thread-Topic: [PATCH] net: cxgb4: avoid memcpy beyond end of source buffer
Thread-Index: AQHTnDlUuixEk1IOFUOERgf3dyfAtKORVaLw
Date: Fri, 2 Feb 2018 16:59:18 +0000
Message-ID: <54678fa6afa247a98922409d5473053c@AcuMS.aculab.com>
References: <20180202151849.808610-1-arnd@arndb.de>
In-Reply-To: <20180202151849.808610-1-arnd@arndb.de>
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

From: Arnd Bergmann
> Sent: 02 February 2018 15:19
> 
> Building with link-time-optimizations revealed that the cxgb4 driver does
> a fixed-size memcpy() from a variable-length constant string into the
> network interface name:
...
> I can see two equally workable solutions: either we use a strncpy() instead
> of the memcpy() to stop at the end of the input, or we make the source buffer
> fixed length as well. This implements the latter.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
> b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
> index 1d37672902da..a14e8db51cdc 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
> @@ -355,7 +355,7 @@ struct cxgb4_lld_info {
>  };
> 
>  struct cxgb4_uld_info {
> -	const char *name;
> +	char name[IFNAMSIZ];
>  	void *handle;
>  	unsigned int nrxq;
>  	unsigned int rxq_size;
> --
> 2.9.0

Surely there is another part to this patch?

	David
