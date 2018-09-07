Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184F2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3D3Ztpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5184F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIGWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:09:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38223 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:09:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id e18-v6so5729664ybq.5;
        Fri, 07 Sep 2018 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iqig52G65T1oK5BZ8bJW4GpEe9IWDxjBJiK5Ly/PDlo=;
        b=W3D3ZtpiNJc27H1HB8ioZhJWEiXGPm9/5ONMzbWyxOaj21TqcWhqZpB84JWJsC+CgI
         gS/3Ht110XWa6B5moexvgg3Mp87rwMUaKfoeTcoIjyoHqTq4pyqg37k/6RsPLGi2geYF
         Op314hKbcmqwwAZtA0HQr8ym/TCLiYkVsncFTntIf5Go1ETM6sluyG92UfQZncXkmmPF
         p9F9aBqEUIVqrRK2Xr8SZSrb60XKVuvFwPBX9Zw6zs/R0I5FztandOqBJBpCGo9LMUqb
         6k5TFSynVNhm4UG6lAs5I5UeXjdR2ZWz9o366CNAnHvdkhp2y1PIhacEmP0xL4T2qVg2
         lw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqig52G65T1oK5BZ8bJW4GpEe9IWDxjBJiK5Ly/PDlo=;
        b=b+O8CIB0h/xcpZ6yYyGrQYTyKzxoWX7xN5+1AqRLewD3iSSb6RwFjGdaDEyeija+w0
         kR9oMMvRtkD9mtaeufXVKzHKW8Q3YG0B2fDQ89knXcoBJjvW3MOXWEX/g4kiXe4xRiot
         v59qp55e1nkWf2D1W2P4tNxpzhQRVk7CQ7Gdq4u79RksjRgsyMtUwRpLbg+cwylTJNHE
         VsyJJSAHk/6QRJ8pXacgo0vFbX4a3P80A81oiSQQM5YBbJbaxXpq5tUcnn6hUMP5a8Tn
         BkmObLM9R4zP5kXJmNC9Y1RgALT0vDm2CoxAlftfHdtCQvvne7XWr3FzigpvX60njeqH
         +VVw==
X-Gm-Message-State: APzg51DKTjYi14IxdZNWiRnnNA1WNUellLPTYa7qIG8O1BIJSK2UOlX0
        M4mGDbiMgf6cKgoGQymD3fk=
X-Google-Smtp-Source: ANB0VdZ1lSHAXnJqpm5awz8TtQ1gteaL20wRWrnpG6ZNJlejsCYUa44XveXHwVx5G74nRVQUWYgPeg==
X-Received: by 2002:a25:a2c9:: with SMTP id c9-v6mr4491657ybn.27.1536341253270;
        Fri, 07 Sep 2018 10:27:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:70a9])
        by smtp.gmail.com with ESMTPSA id t124-v6sm5539292ywt.105.2018.09.07.10.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:27:32 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:27:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-4-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906211045.29055-4-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 06, 2018 at 05:10:36PM -0400, Dennis Zhou wrote:
> @@ -2021,9 +2021,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
>  {
>  	if (unlikely(bio->bi_blkg))
>  		return -EBUSY;
> +	bio->bi_blkg = blkg_try_get_closest(blkg);
>  	return 0;

It prolly would be a good idea to point out that the associated blkg
might not be the same one passed in.  Maybe this gets cleared up later
in the series?

> @@ -298,14 +297,23 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
>  	while (true) {
>  		struct blkcg *pos = blkcg;
>  		struct blkcg *parent = blkcg_parent(blkcg);
> -
> -		while (parent && !__blkg_lookup(parent, q, false)) {
> +		struct blkcg_gq *ret_blkg = NULL;
> +
> +		while (parent) {
> +			blkg = __blkg_lookup(parent, q, false);
> +			if (blkg) {
> +				/* remember closest blkg */
> +				ret_blkg = blkg;
> +				break;
> +			}
>  			pos = parent;
>  			parent = blkcg_parent(parent);
>  		}
>  
>  		blkg = blkg_create(pos, q, NULL);
> -		if (pos == blkcg || IS_ERR(blkg))
> +		if (IS_ERR(blkg))
> +			return ret_blkg ?: q->root_blkg;

Why not ret_blkg here?

Thanks.

-- 
tejun
