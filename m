Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfACJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:10:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50392 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfACJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:10:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so28685002wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pQqlWlJObUFmfp62/GvZebXdx8AXlXpB4xlCOortMec=;
        b=GVEzofbE9ChdPfZoXn8rY2xppeVcRThRg1zZptMJO7Z+3Iwz1MlY1DtTjatYaIv1kq
         1J4qxfwt+Pm4qXrRJafm+ryMMhUF7q5Y2oohtto2Y9iGVWs4okzpL1vDNrrrtH6SqTfG
         DhBotlrUq9TniOj9mdtpuR5xsWnnV6yTFLkImN+I2+I5oFVBqUNpB2nfcQRjbAJs4yMi
         k9KQ3/J+hhsWyuQSqoXVv/rGQCgIYfPrFFfRofEBuMnqVMV6rm2HP10/BiWrrSD+/RAE
         rj0pcrhPFhwfiaw81ayiRmsQC99NUf/w5pUuAyOU+vc/u+gC6vnM4O2g6BHp7Nvty/38
         GDXw==
X-Gm-Message-State: AJcUukd3E/GqvizvVsl69PJBayhpHK8yiouc1ZaJpehQIXuZ0qC+3LB7
        b+b17CnepOYFoaKmbc4eCcaOacPY
X-Google-Smtp-Source: ALg8bN7cBMeOpBPNSit9utnb3p9nV6nTj+3RPwlJjDMnp+25XUBV7zjKV06AFo3lw3Lcj/2gEGxWag==
X-Received: by 2002:a1c:4807:: with SMTP id v7mr38535187wma.53.1546506597294;
        Thu, 03 Jan 2019 01:09:57 -0800 (PST)
Received: from [192.168.1.104] (185-219-167-241-static.vivo.cz. [185.219.167.241])
        by smtp.gmail.com with ESMTPSA id r12sm52577679wrq.3.2019.01.03.01.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 01:09:56 -0800 (PST)
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Fulghum <paulkf@microgate.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
Date:   Thu, 3 Jan 2019 10:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 01. 19, 16:04, Tetsuo Handa wrote:
> +	if (wait_event_interruptible(tty->read_wait,
> +	     (ret = -EIO, test_bit(TTY_OTHER_CLOSED, &tty->flags)) ||
> +	     (ret = 0, tty_hung_up_p(file)) ||
> +	     (rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list)) != NULL ||
> +	     (ret = -EAGAIN, tty_io_nonblock(tty, file))))
> +		return -EINTR;

Oh, that looks really ugly. Could you move all this to a function
returning a bool and taking &ret and &rbuf as parameters?

> +	if (rbuf) {
> +		if (rbuf->count > nr)
> +			/* too large for caller's buffer */
> +			ret = -EOVERFLOW;
> +		else if (copy_to_user(buf, rbuf->buf, rbuf->count))
> +			ret = -EFAULT;
> +		else
> +			ret = rbuf->count;
> +		if (n_hdlc->rx_free_buf_list.count > DEFAULT_RX_BUF_COUNT)
> +			kfree(rbuf);
> +		else
> +			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list, rbuf);
>  	}
> -
> -	remove_wait_queue(&tty->read_wait, &wait);
> -	__set_current_state(TASK_RUNNING);
> -
>  	return ret;
> -	
>  }	/* end of n_hdlc_tty_read() */
>  
>  /**
> @@ -645,21 +612,13 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
>  static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
>  			    const unsigned char *data, size_t count)
>  {
> -	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
> +	struct n_hdlc *n_hdlc;
>  	int error = 0;
> -	DECLARE_WAITQUEUE(wait, current);
> -	struct n_hdlc_buf *tbuf;
> +	struct n_hdlc_buf *tbuf = NULL;
>  
>  	if (debuglevel >= DEBUG_LEVEL_INFO)	
>  		printk("%s(%d)n_hdlc_tty_write() called count=%zd\n",
>  			__FILE__,__LINE__,count);
> -		
> -	/* Verify pointers */
> -	if (!n_hdlc)
> -		return -EIO;
> -
> -	if (n_hdlc->magic != HDLC_MAGIC)
> -		return -EIO;
>  
>  	/* verify frame size */
>  	if (count > maxframe ) {
> @@ -670,40 +629,14 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
>  				maxframe );
>  		count = maxframe;
>  	}
> -	
> -	add_wait_queue(&tty->write_wait, &wait);
>  
> -	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> -	
> -		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
> -		if (tbuf)
> -			break;
> -
> -		if (tty_io_nonblock(tty, file)) {
> -			error = -EAGAIN;
> -			break;
> -		}
> -		schedule();
> -			
> -		n_hdlc = tty2n_hdlc (tty);
> -		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || 
> -		    tty != n_hdlc->tty) {
> -			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
> -			error = -EIO;
> -			break;
> -		}
> -			
> -		if (signal_pending(current)) {
> -			error = -EINTR;
> -			break;
> -		}
> -	}
> -
> -	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&tty->write_wait, &wait);
> -
> -	if (!error) {		
> +	if (wait_event_interruptible(tty->write_wait,
> +	     (error = -EIO, n_hdlc = tty2n_hdlc(tty), /* Verify pointers */
> +	      !n_hdlc || n_hdlc->magic != HDLC_MAGIC || tty != n_hdlc->tty) ||
> +	     (tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list)) != NULL ||
> +	     (error = -EAGAIN, tty_io_nonblock(tty, file))))
> +		return -EINTR;

This is even worse. So detto as above?

> +	if (tbuf) {
>  		/* Retrieve the user's buffer */
>  		memcpy(tbuf->buf, data, count);
>  
> @@ -711,8 +644,9 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
>  		tbuf->count = error = count;
>  		n_hdlc_buf_put(&n_hdlc->tx_buf_list,tbuf);
>  		n_hdlc_send_frames(n_hdlc,tty);
> +	} else if (error == -EIO) {
> +		printk("n_hdlc_tty_write: %p invalid!\n", n_hdlc);
>  	}
> -
>  	return error;
>  	
>  }	/* end of n_hdlc_tty_write() */
> 

thanks,
-- 
js
suse labs
