Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B66C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FvSkHogA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E6qOUXDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfAKN5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:57:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46462 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfAKN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:57:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D98A8608CB; Fri, 11 Jan 2019 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547215053;
        bh=3tZMh+UElyxy+Uv2GzOWYUOuVkiglLNTPV2YqwKyY5U=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FvSkHogATNQXh4rqok2JPq13S4BW22CZNaNTh8h9sDlUEL8hEapgPLfrtyRcJ66iL
         zUD0YrqugqLAmsBTjW4Yxy7cTP80Yvuwqt56g39xUrN1LV2ajA7HyNV4M1r4iN+Frz
         n1UW7BCDj1X1bOI+6y0E1WMpy6wQQb0PwdWZgslM=
Received: from [10.204.78.166] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD547601B4;
        Fri, 11 Jan 2019 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547215050;
        bh=3tZMh+UElyxy+Uv2GzOWYUOuVkiglLNTPV2YqwKyY5U=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=E6qOUXDdnV+t1MyDkKUxv6xFOuGl7tLFb1hc+Gj1QhOTf3nTgxpG7Na2YT3MU6xe7
         E+fzpjwFMfmcnv1KRRjk1HWvoPs6oLtB5EmV5AEKjGKHsDrnlG2kAJK1310cdHUEIv
         IAr6dt9PgFFjb2qGTc7TFHYD6iVq41eA73VtfxDI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD547601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH][v2] tty: fix race between flush_to_ldisc and tty_open
To:     Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org,
        jslaby@suse.com, gregkh@linuxfoundation.org, alan@linux.intel.com
References: <1545619432-8875-1-git-send-email-lirongqing@baidu.com>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <fc359e35-6b07-832b-6770-46f00d1a84c6@codeaurora.org>
Date:   Fri, 11 Jan 2019 19:27:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1545619432-8875-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it don't seems to be good idea to put lock on one function and unlock in 
some other function. If in future some one has to call tty_init_dev, how 
he can track the unlocking as well of ldisc lock.

Regards
Gaurav

On 12/24/2018 8:13 AM, Li RongQing wrote:
> There still is a race window after the commit b027e2298bd588
> ("tty: fix data race between tty_init_dev and flush of buf"),
> if receive_buf call comes before tty initialization completes
> in n_tty_open and tty->driver_data may be NULL.
> 
> CPU0                             CPU1
> ----                             ----
>                                   n_tty_open
>                                     tty_init_dev
>                                       tty_ldisc_unlock
>                                         schedule
> flush_to_ldisc
>    n_tty_receive_buf
>      uart_flush_chars
>        uart_start
>        /*tty->driver_data is NULL*/
>                                     tty->ops->open
>                                     /*init tty->driver_data*/
> 
> Extending ldisc semaphore lock in tty_init_dev to driver_data
> initialized completely after tty->ops->open().
> 
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/staging/speakup/spk_ttyio.c |  1 +
>   drivers/tty/pty.c                   |  2 ++
>   drivers/tty/serdev/serdev-ttyport.c |  2 ++
>   drivers/tty/tty_io.c                | 14 +++++++++++---
>   drivers/tty/tty_ldisc.c             |  1 +
>   5 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
> index 979e3ae249c1..c31f08c98383 100644
> --- a/drivers/staging/speakup/spk_ttyio.c
> +++ b/drivers/staging/speakup/spk_ttyio.c
> @@ -155,6 +155,7 @@ static int spk_ttyio_initialise_ldisc(struct spk_synth *synth)
>   	else
>   		ret = -ENODEV;
>   
> +	tty_ldisc_unlock(tty);
>   	if (ret) {
>   		tty_unlock(tty);
>   		return ret;
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 00099a8439d2..1b9684d4f718 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -873,9 +873,11 @@ static int ptmx_open(struct inode *inode, struct file *filp)
>   
>   	tty_debug_hangup(tty, "opening (count=%d)\n", tty->count);
>   
> +	tty_ldisc_unlock(tty);
>   	tty_unlock(tty);
>   	return 0;
>   err_release:
> +	tty_ldisc_unlock(tty);
>   	tty_unlock(tty);
>   	// This will also put-ref the fsi
>   	tty_release(inode, filp);
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index fa1672993b4c..ce16cb303e28 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -123,6 +123,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
>   	if (ret)
>   		goto err_close;
>   
> +	tty_ldisc_unlock(tty);
>   	tty_unlock(serport->tty);
>   
>   	/* Bring the UART into a known 8 bits no parity hw fc state */
> @@ -145,6 +146,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
>   err_close:
>   	tty->ops->close(tty, NULL);
>   err_unlock:
> +	tty_ldisc_unlock(tty);
>   	tty_unlock(tty);
>   	tty_release_struct(tty, serport->tty_idx);
>   
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 687250ec8032..199f45e2e1b1 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1351,7 +1351,6 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
>   	retval = tty_ldisc_setup(tty, tty->link);
>   	if (retval)
>   		goto err_release_tty;
> -	tty_ldisc_unlock(tty);
>   	/* Return the tty locked so that it cannot vanish under the caller */
>   	return tty;
>   
> @@ -1926,7 +1925,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
>    *	  - concurrent tty removal from driver table
>    */
>   static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
> -					     struct file *filp)
> +					     struct file *filp, bool *unlock)
>   {
>   	struct tty_struct *tty;
>   	struct tty_driver *driver = NULL;
> @@ -1970,6 +1969,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
>   		}
>   	} else { /* Returns with the tty_lock held for now */
>   		tty = tty_init_dev(driver, index);
> +		*unlock = true;
>   		mutex_unlock(&tty_mutex);
>   	}
>   out:
> @@ -2007,6 +2007,7 @@ static int tty_open(struct inode *inode, struct file *filp)
>   	int noctty, retval;
>   	dev_t device = inode->i_rdev;
>   	unsigned saved_flags = filp->f_flags;
> +	bool unlock = false;
>   
>   	nonseekable_open(inode, filp);
>   
> @@ -2017,7 +2018,7 @@ static int tty_open(struct inode *inode, struct file *filp)
>   
>   	tty = tty_open_current_tty(device, filp);
>   	if (!tty)
> -		tty = tty_open_by_driver(device, inode, filp);
> +		tty = tty_open_by_driver(device, inode, filp, &unlock);
>   
>   	if (IS_ERR(tty)) {
>   		tty_free_file(filp);
> @@ -2042,6 +2043,10 @@ static int tty_open(struct inode *inode, struct file *filp)
>   	if (retval) {
>   		tty_debug_hangup(tty, "open error %d, releasing\n", retval);
>   
> +		if (unlock) {
> +			unlock = false;
> +			tty_ldisc_unlock(tty);
> +		}
>   		tty_unlock(tty); /* need to call tty_release without BTM */
>   		tty_release(inode, filp);
>   		if (retval != -ERESTARTSYS)
> @@ -2067,6 +2072,9 @@ static int tty_open(struct inode *inode, struct file *filp)
>   		  tty->driver->subtype == PTY_TYPE_MASTER);
>   	if (!noctty)
>   		tty_open_proc_set_tty(filp, tty);
> +
> +	if (unlock)
> +		tty_ldisc_unlock(tty);
>   	tty_unlock(tty);
>   	return 0;
>   }
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index fc4c97cae01e..dd9b41f66c18 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -339,6 +339,7 @@ void tty_ldisc_unlock(struct tty_struct *tty)
>   	clear_bit(TTY_LDISC_HALTED, &tty->flags);
>   	__tty_ldisc_unlock(tty);
>   }
> +EXPORT_SYMBOL_GPL(tty_ldisc_unlock);
>   
>   static int
>   tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
