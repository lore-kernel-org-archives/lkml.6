Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeCUNsV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:48:21 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:36552 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeCUNsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:48:19 -0400
Message-ID: <1521640094.2645.29.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: aes-cmac: remove VLA usage
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 14:48:14 +0100
In-Reply-To: <20180321134247.GA1275@embeddedgus>
References: <20180321134247.GA1275@embeddedgus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 08:42 -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them
> with dynamic memory allocation instead.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  net/mac80211/aes_cmac.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
> index 2fb6558..c9444bf 100644
> --- a/net/mac80211/aes_cmac.c
> +++ b/net/mac80211/aes_cmac.c
> @@ -27,30 +27,42 @@ static const u8 zero[CMAC_TLEN_256];
>  void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>  			const u8 *data, size_t data_len, u8 *mic)
>  {
> -	SHASH_DESC_ON_STACK(desc, tfm);
> +	struct shash_desc *shash;
>  	u8 out[AES_BLOCK_SIZE];
>  
> -	desc->tfm = tfm;
> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
> +			GFP_KERNEL);
> +	if (!shash)
> +		return;

Honestly, this seems like a really bad idea - you're now hitting
kmalloc for every TX/RX frame here.

SHA_DESC_ON_STACK() should just be fixed to not need a VLA, but take
some sort of maximum, I guess?

johannes
