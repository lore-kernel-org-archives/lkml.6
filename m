Return-Path: <stern+5ad477ca@rowland.harvard.edu>
X-Google-Smtp-Source: AIpwx4+RFeFjcIPzSusBjhJHYGUR2pEYywXBWQBYTa5RG96KqxvGQG5D1pm4bE2X2rEVnpdhu4Q1
ARC-Seal: i=1; a=rsa-sha256; t=1523369707; cv=none;
        d=google.com; s=arc-20160816;
        b=s5PYzdM1OUYPz5OOY3fD//9+ONigOwc81//McWZTwByQ2xrC/3v5XPd11s3fVI0AQe
         8ld5OBg7V9YxN5+b65c7NAf91LoWHKh73bCkMZ46FZl+KYGDcH9pH8BdSF284UeE0XHS
         L7VX3SvC2Gc/EzmEb1GzXKuXvl76OHSEU4GB6x3DIe1oSe+J4Z9zsTdXqJ3+913q3A7I
         VdSi6721axGP78oZBSSjrqmX+nCVzinE2+/KK+Igui1doKVAq5S4PEQ4iS+IjnJvydi1
         3szBZ5aWRQRTdPUBf4ggt94UoEYKeHVv9ftJtIOx9Pcyuk2vol31ItOYNV3Q1hDKhGRt
         MAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=tHXHwN5xD85qTb8A4/Ap9IGUUzA9KvlJCWnIqvUGpkY=;
        b=Chr7m7MmbVw+HPr0+mndGJzQSsPWHmINhvUVNtoqKY2UA3TlrBj9TOrqORgmsEiVl4
         Qs0tT6kRA9766Ite0DdUlTjhnDTt2BTxflKjXOE1U/AQb81MxlN4tE0RrfPiXiSaPI3Y
         N1CSz8dyI0D+KbEzznI2WCMr8zYtpTmAWHu27h2uxf2oWDdRgLV24DTjNB/PWu963YFC
         EbkdssjfVnTbD1ekpC31g7hGSZRGNgx7KQD5eRvXdPf9T/BUvcf/xcUb2wCYj/yA1mSX
         MPq7FLaRTzi7/thBUuRhwDp30kS3eHK4PgEK2AJZMt+zsAbWTmHVBMRve/DM3/0w9JzF
         xfLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5ad477ca@rowland.harvard.edu) smtp.mailfrom=stern+5ad477ca@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5ad477ca@rowland.harvard.edu) smtp.mailfrom=stern+5ad477ca@rowland.harvard.edu
Date: Tue, 10 Apr 2018 10:15:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
cc: gregkh@linuxfoundation.org,  <linux-usb@vger.kernel.org>,
     <usb-storage@lists.one-eyed-alien.net>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: Replace mdelay with msleep in init_freecom
In-Reply-To: <1523323748-28361-1-git-send-email-baijiaju1990@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1804101014460.3142-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597320730498100935?=
X-GMAIL-MSGID: =?utf-8?q?1597368914094327808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Jia-Ju Bai wrote:

> init_freecom() is never called in atomic context.
> 
> init_freecom() is set as ".initFunction" through UNUSUAL_DEV().
> And ->initFunction() is only called by usb_stor_acquire_resources(), 
> which is only called by usb_stor_probe2().
> usb_stor_probe2() is called by *_probe() functions (like alauda_probe()) 
> for each USB driver.
> *_probe() functions are set ".probe" in struct usb_driver.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, init_freecom()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>


> ---
>  drivers/usb/storage/freecom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
> index c0a5d95..c7f886d 100644
> --- a/drivers/usb/storage/freecom.c
> +++ b/drivers/usb/storage/freecom.c
> @@ -477,7 +477,7 @@ static int init_freecom(struct us_data *us)
>  	usb_stor_dbg(us, "result from activate reset is %d\n", result);
>  
>  	/* wait 250ms */
> -	mdelay(250);
> +	msleep(250);
>  
>  	/* clear reset */
>  	result = usb_stor_control_msg(us, us->send_ctrl_pipe,
> @@ -485,7 +485,7 @@ static int init_freecom(struct us_data *us)
>  	usb_stor_dbg(us, "result from clear reset is %d\n", result);
>  
>  	/* wait 3 seconds */
> -	mdelay(3 * 1000);
> +	msleep(3 * 1000);
>  
>  	return USB_STOR_TRANSPORT_GOOD;
>  }
> 
