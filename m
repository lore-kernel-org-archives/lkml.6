Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F7208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062F7208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbeHAJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:56:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:42637 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbeHAJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:56:43 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 93E91C009; Wed,  1 Aug 2018 10:12:12 +0200 (CEST)
Date:   Wed, 1 Aug 2018 10:11:57 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] net/9p/trans_virtio.c: add a terminal char for mount tag
Message-ID: <20180801081157.GA20127@nautica>
References: <5B6164F6.60004@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6164F6.60004@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Aug 01, 2018:
> chan->tag has no terminal char at last which will result in printing messy
> code when debugging code. So we should add '\0' for tag.

9p is full of non null-terminated string so I'm not sure how I feel
about it, is there anything wrong with how this is used or was this just
when you tried to printf it?

If it's just for debugging I'd suggest using the printf format "%.*s"
with "chan->tag_len, chan->tag" arguments,


That said it's not like this is costly, so I'll take it if someone else
thinks this is helpful

> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/trans_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index d422bfc..49d71d6 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -585,7 +585,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> -	tag = kmalloc(tag_len, GFP_KERNEL);
> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
>  		goto out_free_vq;
> -- 
-- 
Dominique 
