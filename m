Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524678857; cv=none;
        d=google.com; s=arc-20160816;
        b=t01cI73qSpS/qD7GSnbwhHyaujJspUmtLFQJQYrYoWTIZOrWheocOw4Ud/5l3Wg5zN
         hC6tEkTSfI5skcvPYUr3hxiJri57a8t2DYg9r+iFPfWTZEPOl5APniP7kIoKfLWORdBQ
         XBOcljZU5x4qO65+212LisDT0IJnBzQIY9E+MxiXYo6fo32IWW0u9RLP+kNcXJsHaDfm
         9RjjeLZ2eJ4Eegd2tns1wI5ysJbJ3fXqfFVu+OXx68Xq7wNAe1PORrtZD+/CKUONY81E
         416H8bCFStgF1YZjVPgSKDyrRRik7QK5h6/bAYzlRhZFS3zzYdPBN8+Uizs0vC3T0REN
         +sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=bcMRzvSLhgvllOPCgHT08OfqMmpqSn7OqbohlY4lbDk=;
        b=iOvdTRKmJGy99wv1+9RoInffHxXEWuZwzPIcHea/NCZqNirneDj3vK9Lk8JXfq5eF1
         9vARYZjNy8XimGtJcE8JFxvkpifuiCfhBe1P2am+6KMxMhUSh5FOi0+7zwOwHQnt3ugX
         NJ63JfGoQhAKCRs1ov7n/v1xeswzds3PM7hghgpOxewGFgKRFfnWe0Oq7Yr/67NEJp89
         w3fbEOV2nwDyuh49ROQZH79SoqTEH5qvCZRVxhNFVTg1v1BIuA5OfW3zCPEOLgqa9D6E
         q7/mS2DRKIPTAY0nLdDdNgPwXOZFbikGrQnV3e/2k5Ob0383qBtkaLlpJc3uZc8AX7p0
         znpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=csEuLFoP;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=csEuLFoP;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/hUeVeWRUlZ3kVeMDhnSql/o9t1DdtWTG+UpnHIJUC01oRCWH6FhGeTUHF5ooFeTJFoO1ohQ==
Date: Thu, 26 Apr 2018 02:54:12 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, byoungyoung@purdue.edu,
	kt0755@gmail.com, bammanag@purdue.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Fix data race in tty_insert_flip_string_fixed_flag
Message-ID: <20180425175411.GB15991@dragonet.kaist.ac.kr>
References: <20180425132047.GA20337@dragonet.kaist.ac.kr>
 <20180425153948.7be2bc57@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425153948.7be2bc57@alans-desktop>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598724459634518298?=
X-GMAIL-MSGID: =?utf-8?q?1598741657400811137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 03:39:48PM +0100, Alan Cox wrote:
> On Wed, 25 Apr 2018 22:20:50 +0900
> DaeRyong Jeong <threeearcat@gmail.com> wrote:
> 
> > tty_insert_flip_string_fixed_flag() copies chars to the buffer indicated
> > by th->used and updates tb->used.
> > But tty_insert_flip_string_fixed_flag() can be executed concurrently and
> > tb->used can be updated improperly.
> 
> The tty input layer does not work if it can be executed concurrently. If
> that is happening in the pty code then the pty code is buggy and that
> needs serializing on the inbound path.
> 
> 
> > -static void tty_write_unlock(struct tty_struct *tty)
> > +void tty_write_unlock(struct tty_struct *tty, int wakeup)
> >  {
> >  	mutex_unlock(&tty->atomic_write_lock);
> > -	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> > +	if (wakeup) {
> > +		wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> > +	}
> 
> And this may cause deadlocks.
> 
> You don't actually need any of the wakeup changes in your code
> 
> > diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> > index d9b561d89432..a54ab91aec90 100644
> > --- a/drivers/tty/tty_ioctl.c
> > +++ b/drivers/tty/tty_ioctl.c
> > @@ -911,12 +911,17 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
> >  			spin_unlock_irq(&tty->flow_lock);
> >  			break;
> >  		case TCOON:
> > +			if (tty_write_lock(tty, 0) < 0)
> > +				return -ERESTARTSYS;
> > +
> >  			spin_lock_irq(&tty->flow_lock);
> >  			if (tty->flow_stopped) {
> >  				tty->flow_stopped = 0;
> >  				__start_tty(tty);
> >  			}
> >  			spin_unlock_irq(&tty->flow_lock);
> > +
> > +			tty_write_unlock(tty, 0);
> 
> If you just used these unmodified it would be simpler and as good,
> however it won't actually fix anything. The pty layer is broken not this
> code.

Yes. I thought the wrong way to resolve the issue.

> 
> The tty layer rule for all the input buffer handling is that you may not
> call *any* of it from multiple threads at once. This works fine for
> normal serial because the IRQ layer or the polling logic has that
> property.
> 
> The bug looks real, your diagnosis looks right, your fix sort of works
> but isn't sufficient.
> 
> So NAK.
> 
> Alan

With your comments, now I know that this patch is incorrect.
Since the bug is real, I will send a new patch with considering all your
comments above.

Thank you a lot for all your comments.

DaeRyong Jeong
