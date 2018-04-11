Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523458594; cv=none;
        d=google.com; s=arc-20160816;
        b=Tk3dbDipqJthiU8vSHSBZES43dMdRxfSGz9zAud2Suoa+VlwfJ0ioA4nt34mnG56XS
         MNe3BIP78Wg+J+gMx2jvuPOuKC/2awa1t9LIfSVaFS4mtutlcfB723BBZ4AhoP/Q44xB
         HBv8xIGjUH9kp8ujbkItDqgJv6fb8yprs0kLGs/GDACTa5hf52v0Emr8SB7v/JnUlLQh
         go7yhEemO40BSD7gCUEEyDbLRC4qiwNfqp27H/cE2TYkk1ROKDhF5sfjZZ4PvoXagG8p
         TpQptjAzLUg3wRRceI8pYpvOZFLsnCwHpYqnoMSql5F4j8KJI7nV/WtSvYMzhHhf/pX8
         5nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=y714aS9PQh5eMjjQDObexCbC+C8PapzIXlsmnuKv9KI=;
        b=tQ/jZGOLInkk4/DvNl41b+9ncBPRKa/KR9L/lFfZJgR4MqewK+z6QNg9uIY8Qi36f8
         8kzyciDHDVUQnmaUNzZlfPWPBeXgaasjtRd2QM7JUnn2dvKuJ78E/SpCEjZEr3nmCmTj
         lN3D11blmORY7EtahcVYfoKmaEQGGfz9p+XL7xhTu+AEBBRkpNKHHYOysTIvky38v3+6
         E7MFkXzoKgOQDTWXrnCYmW9nSE3JPuoGo/ppN7dv3yr5i+Q0sc8yyoZ8uwMfBg2dQp8F
         ZyoJbWVR0yItp4ndKy+ox27QKfdWToy4IhZ0heVOGUw3tP/JA/NnCbYLkPhWFVPoAPUE
         3w6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EB8NZvlm;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EB8NZvlm;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx49d68hE1CsRKswN5C6e3G9dP+Flaj08+IXKgvrCfeypuyFji03v2DWLeI2avCvHR6IdXKfPRQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:56:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411145632.GK793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411145123.GJ793541@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597462119457172768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, again.

On Wed, Apr 11, 2018 at 07:51:23AM -0700, Tejun Heo wrote:
> Oh, it wasn't Joseph's change.  It was Bart's fix for a problem
> reported by Joseph.  Bart, a063057d7c73 ("block: Fix a race between
> request queue removal and the block cgroup controller") created a
> regression where a request_queue can be destroyed with blkgs still
> attached.  The original report is..
> 
>  http://lkml.kernel.org/r/20180407102148.GA9729@gmail.com

And looking at the change, it looks like the right thing we should
have done is caching @lock on the print_blkg side and when switching
locks make sure both locks are held.  IOW, do the following in
blk_cleanup_queue()

	spin_lock_irq(lock);
	if (q->queue_lock != &q->__queue_lock) {
		spin_lock(&q->__queue_lock);
		q->queue_lock = &q->__queue_lock;
		spin_unlock(&q->__queue_lock);
	}
	spin_unlock_irq(lock);

Otherwise, there can be two lock holders thinking they have exclusive
access to the request_queue.

Thanks.

-- 
tejun
