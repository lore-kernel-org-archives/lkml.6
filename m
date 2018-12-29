Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7EC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31802145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaWkSNJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeL2KC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 05:02:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48319 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbeL2KC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 05:02:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F1CA21CCA;
        Sat, 29 Dec 2018 05:02:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 29 Dec 2018 05:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=G6Xp2/+N8BFhpfIvek7LJpWLo8ioC8eE7s6mAK/Uk
        To=; b=KaWkSNJMRSs3YiXBdZxUNH69HZC+jvcQ60vrZz9MDjM1Wc1x5HhPrvhxO
        V3pUbcpw8mLvf3iruUr08kwnPLsTg8OKOLVHxxdt3xoNk2YndhegZmMffc/pULIK
        njvkWv41M0FL2XS03pBX2SCMyKnYk2PAHMz6S3iBcz2sjF2MvBjizk6UvHN7bk/O
        FXHrHUaUBU8zK7SCKAs22c0ZCJmYAOFEVornxLrICeEKZL8QMYLrCiNkp8l1QA2l
        DIVIrpAa9O7DZSn+jzbg6ng+0DaYgoYl017yoRXCngrIDx8DDfN7ebeOIS523WTE
        n6LUduQftvAC7V0nhs6CTDGIXP+dw==
X-ME-Sender: <xms:LkYnXEkqpYk_Dx59m-kCbqcRNxaGtXauigQqZTdEpiUB_GHrM5VJew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrtdekgdduudculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpefrvghkkhgrucfgnhgsvghrghcuoehpvghnsggvrhhgsehi
    khhirdhfiheqnecukfhppeekledrvdejrdeffedrudejfeenucfrrghrrghmpehmrghilh
    hfrhhomhepphgvnhgsvghrghesihhkihdrfhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:LkYnXDYXcCHnGHH7d_l6r-ua9SP-9XffrxplVt8SAqSVFrAQDiO-jQ>
    <xmx:LkYnXNcMUZHD5pMO4HdWLZbk9CY9Y82n5iBvP6mc1_4CyLeRP3aIAg>
    <xmx:LkYnXOAwxNIJ6T7T13-ddvPrbOAbp2ij9127p8Bm5RnTlMs1ux-0OA>
    <xmx:MEYnXGGbJvXKSK_gI1B29EIbEaon6yReOQvMvnO9Y043szEO5AnZGg>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21578E459A;
        Sat, 29 Dec 2018 05:02:19 -0500 (EST)
Subject: Re: [PATCH] mm/slub.c: freelist is ensured to be NULL when new_slab()
 fails
To:     Peng Wang <rocking@whu.edu.cn>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20181229062512.30469-1-rocking@whu.edu.cn>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <56ee5ac0-0785-cf2a-c1b4-95d4df2d11f1@iki.fi>
Date:   Sat, 29 Dec 2018 12:02:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181229062512.30469-1-rocking@whu.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2018 8.25, Peng Wang wrote:
> new_slab_objects() will return immediately if freelist is not NULL.
> 
>           if (freelist)
>                   return freelist;
> 
> One more assignment operation could be avoided.
> 
> Signed-off-by: Peng Wang <rocking@whu.edu.cn>

Reviewed-by: Pekka Enberg <penberg@kernel.org>

> ---
>   mm/slub.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 36c0befeebd8..cf2ef4ababff 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2463,8 +2463,7 @@ static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
>   		stat(s, ALLOC_SLAB);
>   		c->page = page;
>   		*pc = c;
> -	} else
> -		freelist = NULL;
> +	}
>   
>   	return freelist;
>   }
> 
