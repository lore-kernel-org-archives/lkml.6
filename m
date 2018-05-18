Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1526656451; cv=none;
        d=google.com; s=arc-20160816;
        b=Auq5ejfEqZ0cyNMotuyBorMozNjKbZMxqqj5UsEzuBvAJ406Dl4Xi62kVmnnw4ptOO
         WtEZuYzVBCu7r0Ciegv7MJ2PlD6MFfW1eYhMVNCs3syIjCtlo3kxYJj5hbNeEGo3PaLK
         7Pg2bczmalQhLUDGlcdQ1WfJtap/Qiyr6UpujKJHSBHF/W8zMWh3hyXjQRZkfFvaIOmT
         HfQ+Z0Rfe3GWC+UFnrsOINAoTbHgG+COfaEqaoblIPb4F0KjxR7eoa490iBfLGzaXutP
         antyYi4Q4Q4BvaUeNFMa12BCrR3vrHnNU3ksvHLh9XFwRvJ/zHcPK8rDvNTbPgCyRlt+
         uaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Sdxr38V5YQc092pPjeavYodUwFp9EY3rmLVMEJcULkg=;
        b=A82dtBjs95qn7qsDyF8A/CwgzsSzhw+Ikkhb0NXVXisd23h8PuQk9fiJnDWgRkWHrQ
         hiwnuXZBLOrbA/h9wjkyn5d4TYB4Z1LcsEJjlyY5utXq1iEMPyJPnJCWeLDGgcgDDSSn
         LJLt4fAK1iEjU95e28Y/Jl2/FljGOuu+WJZatYZOyHv7qmzrJ6T9dc4jKvDq3h906kNL
         scZCQUgFJikuTaALE5AIHW/E7tK/G2ct4SW8TSRrorD8mkY9XxS8P0uXPC6g2bVz4avC
         kNn+5AXA8oyeLIHHxr6Y6ngrMM8IJUjLfA12xAvBjpLGTRMH1dm0eQjrtKwNiN3lGh6v
         asMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=0bcwunU9;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=0bcwunU9;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AB8JxZp4o70k8r3AhYVy+u4BmqgVx1qAVl2b/ZVtpTqoPKME0LnGD5fexnkKLidamWhkn0ZaQRT1fA==
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
To: adam.manzanares@wdc.com, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
 gregkh@linuxfoundation.org, bigeasy@linutronix.de, rgoldwyn@suse.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-api@vger.kernel.org
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <51cbf2e9-1ff9-b9e7-fb68-055a64d54da5@kernel.dk>
Date: Fri, 18 May 2018 09:14:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180517203803.2664-4-adam.manzanares@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600745118592233857?=
X-GMAIL-MSGID: =?utf-8?q?1600815315694946092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/17/18 2:38 PM, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> This is the per-I/O equivalent of the ioprio_set system call.
> 
> When IOCB_FLAG_IOPRIO is set on the iocb aio_flags field, then we set the
> newly added kiocb ki_ioprio field to the value in the iocb aio_reqprio field.
> 
> When a bio is created for an aio request by the block dev we set the priority
> value of the bio to the user supplied value.
> 
> This patch depends on block: add ioprio_check_cap function

Actually, one comment on this one:

> diff --git a/fs/aio.c b/fs/aio.c
> index f3eae5d5771b..ff3107aa82d5 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1451,6 +1451,22 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
>  	if (iocb->aio_flags & IOCB_FLAG_RESFD)
>  		req->ki_flags |= IOCB_EVENTFD;
>  	req->ki_hint = file_write_hint(req->ki_filp);
> +	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
> +		/*
> +		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
> +		 * aio_reqprio is interpreted as an I/O scheduling
> +		 * class and priority.
> +		 */
> +		ret = ioprio_check_cap(iocb->aio_reqprio);
> +		if (ret) {
> +			pr_debug("aio ioprio check cap error\n");
> +			return -EINVAL;
> +		}
> +
> +		req->ki_ioprio = iocb->aio_reqprio;
> +		req->ki_flags |= IOCB_IOPRIO;
> +	}

Do we really need IOCB_IOPRIO? All zeroes is no priority set anyway,
so we should be able to get by with just setting ->ki_ioprio to either
the priority, or 0.

> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 7ec920e27065..970bef79caa6 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -355,6 +355,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		bio->bi_write_hint = iocb->ki_hint;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = blkdev_bio_end_io;
> +		if (iocb->ki_flags & IOCB_IOPRIO)
> +			bio->bi_ioprio = iocb->ki_ioprio;

And then this assignment can just happen unconditionally.

-- 
Jens Axboe
