Return-Path: <00moses.alexander00@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523481809; cv=none;
        d=google.com; s=arc-20160816;
        b=vmRtF0MgFLxyXnYRj/WVUhlPL2+5u+ySTqZoW1GVTdDgjQ1YWfYy3NEckVIBPJgTXt
         9CWEqaj+J/BLJBP4dn2AYYDfnJ6L0UaYhz61sRm8C6Q+/yHcu3C6+RFBVwX4v3UxgYmI
         DWcgnET2Pfko+1b1ub5upTbFsBmZcKUM6QWQjvWQxVkJUdrM4CksagCX8VXKyWE9I8zd
         YiSWJ13zL7VOgalmlgjRLn5Ov0yzzL0ospQJ23WPQ+9jDpc1A8d9VDKS4tbjly1376uE
         QjBAqExCYnKk9oqguK9wFcFkmYD4tCORm/yzPUFrkFLxQzgwAbAPbbyjaQpJa8UFkQsr
         T3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=JOQDX8WRv7v14SdosB/VhCb2duqMtTX3MX+PzKu77cE=;
        b=gI3kIh8w4REByfd7sNZxnCn9Zy+QM0knUvjFib0p7y8susrQKF11xLwrh2Jx+KgYVe
         bzVVY54sJgk12vzN6/IBt1E7dtYSACjrQErXI2/4m1Pt2hxSzay1fWmq8OdHs3zi5L22
         YGpIU7MFd/1p9UI5NLuY4zMarRBKDH5DAP11+36X4NVWxVFwsFb/yMxzgl2xpTbGlv7R
         LeZkuPBNRGyZID4InrQ0AyW+EuDGgxfNlMa7hN4xTv6Rt3zgGmEhW8JxBAs/qULGc7Z3
         d/poduz8x4o6fFSmVthO/SpjXC3yVVIdhW8p7NK+gofwyLh05nv/wN3+Nu88fRVUm5vE
         B/wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r3At8w4S;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r3At8w4S;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+eo8WH31OL3Hs57SsaLSm360xBALSwvJKTpEiztnZFOcTifc31h995B6SYajxqs4ahIueUew==
Date: Wed, 11 Apr 2018 23:23:20 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411212320.GA26747@gmail.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
 <20180411190027.GA21274@gmail.com>
 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597486461754248771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 01:55:25PM -0600, Bart Van Assche wrote:
> On 04/11/18 13:00, Alexandru Moise wrote:
> > But the root cause of it is in blkcg_init_queue() when blkg_create() returns
> > an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
> > the entry that we fail to remove at __blk_release_queue().
> 
> Hello Alex,
> 
> Had you considered something like the untested patch below?
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 1c16694ae145..f2ced19e74b8 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1191,14 +1191,17 @@ int blkcg_init_queue(struct request_queue *q)
>  	if (preloaded)
>  		radix_tree_preload_end();
> 
> -	if (IS_ERR(blkg))
> -		return PTR_ERR(blkg);
> +	if (IS_ERR(blkg)) {
> +		ret = PTR_ERR(blkg);
> +		goto destroy_all;
> +	}
> 
>  	q->root_blkg = blkg;
>  	q->root_rl.blkg = blkg;
> 
>  	ret = blk_throtl_init(q);
>  	if (ret) {
> +destroy_all:
>  		spin_lock_irq(q->queue_lock);
>  		blkg_destroy_all(q);
>  		spin_unlock_irq(q->queue_lock);
> 

Hi, I tested it, it doesn't solve the problem.
By the time you get here it's already too late, my patch
prevents this from failing in the first place.

I would have liked this more than my solution though.

../Alex
