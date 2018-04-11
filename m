Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523466021; cv=none;
        d=google.com; s=arc-20160816;
        b=cG6lJoFvtmS1wKVNQbvG+ELga6fmsiMbB5bVCzK9thzPtqbjzpc5m8ozGhqwQfhELw
         Rpru7K5PKBiA1M4kOSvTOaerZ7RhiJVKAlqzsuYnXY/63fQShk21ZcNQLGgxovhhnoCw
         zbVve23t1h1jSBjJsM88mZcBQMChOtv6dfDmOK7edA8cbPR8/U/hjBT+Yxz5Wjxjp+Bv
         mmSmN77S1ywY7AAvrfND3LMEyBBZ8R+rhBiQKU9VCnErglJOqXTEgMSShWf63gJYLo8N
         6WR/Zh9cXQPu8QUOi2DKBk6qTXq8ZcU+8D03fI9BmhB3B1N7fINDDym8pgP7uV4oWYA6
         Xq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=GYym7hPTZ11Ql9fg7AFi5M/NcNDqGI6PSRyDRQzJioM=;
        b=fRA1SjNGt4S4po2S0IF8bj6E/a33GdH6sZFmjNjLUFAb0vCgj5rjLGH+rwO0DTIE1F
         Uw1iF08536ne/DYhKkgSMvOLsmGxT0wMrvnGhWqIztlqJBb8zQrH4opcl5NG+xNma5Gs
         63rCDmTrEzperUpt6rs69NQvP4FoYmyvyg8R2xo/OYKo0QDJsZFVDQE7nqKxHYmTG7iq
         JGZJBWlcALKEUJ278eHfOSig+iiHKU4/6wvEfl68OcKJKu6tlqItGMXUbMGp6PH+WEft
         AXK20nnYLR4GUM1FCnuQZrLL6ZzK5cSWKQbgRRk/Zt0uPmXci6LnSoJuZNWxEee1Q84i
         mmew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=enTb34EZ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=enTb34EZ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4/Gx0Upddpz71eZcLbWUBjDlLyYs9kV6JSDp2npMKDZ8I4q711tWPL9BJMLEN5C4lnoT4M34A==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:00:18 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411170018.GL793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597469906937679417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 04:42:55PM +0000, Bart Van Assche wrote:
> On Wed, 2018-04-11 at 07:56 -0700, Tejun Heo wrote:
> > And looking at the change, it looks like the right thing we should
> > have done is caching @lock on the print_blkg side and when switching
> > locks make sure both locks are held.  IOW, do the following in
> > blk_cleanup_queue()
> > 
> > 	spin_lock_irq(lock);
> > 	if (q->queue_lock != &q->__queue_lock) {
> > 		spin_lock(&q->__queue_lock);
> > 		q->queue_lock = &q->__queue_lock;
> > 		spin_unlock(&q->__queue_lock);
> > 	}
> > 	spin_unlock_irq(lock);
> > 
> > Otherwise, there can be two lock holders thinking they have exclusive
> > access to the request_queue.
> 
> I think that's a bad idea. A block driver is allowed to destroy the
> spinlock it associated with the request queue as soon as blk_cleanup_queue()
> has finished. If the block cgroup controller would cache a pointer to the
> block driver spinlock then that could cause the cgroup code to attempt to
> lock a spinlock after it has been destroyed. I don't think we need that kind
> of race conditions.

I see, but that problem is there with or without caching as long as we
have queu_lock usage which reach beyond cleanup_queue, right?  Whether
that user caches the lock for matching unlocking or not doesn't really
change the situation.

Short of adding protection around queue_lock switching, I can't think
of a solution tho.  Probably the right thing to do is adding queue
lock/unlock helpers which are safe to use beyond cleanup_queue.

Thanks.

-- 
tejun
