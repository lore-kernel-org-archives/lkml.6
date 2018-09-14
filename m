Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47452ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7B20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYdTJM6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeINSgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:36:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41695 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeINSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:36:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so7846507lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+2A7233tsqjJxo8IhlhR8GhFgAA/qDWNMRUFNmfJeU=;
        b=EYdTJM6V5laxnhPPqcd43agJA9cBtvAJviklLH0EkxaYxTdkHATmmrCrJDBMJBOQBB
         QsjnkXM8VFTOOm6zb9HaoSPqQcCJ1MyGQV+ejcaES745eiix6wvyTJ+vmaljVNvZuygz
         QNDM42q6oAe40S0w5SzrGKly3eVWX0gjmP4O9GwKCIMLusCJNruuQpBIeCrUZz3Pd+Wc
         z6oYRT45kkN9pfTiwW/x+ubVkIKFqvmupgZ6XMztSj/6hOs1o3DHm4vYUYT3DhbTQ9sA
         ef7nvKJ9BpYHNHUNKzr/bPs+Vnc+zIo6/0SpBkPS22yrTtvUR/eTpxAeyiSXvHN/mcVw
         ptQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+2A7233tsqjJxo8IhlhR8GhFgAA/qDWNMRUFNmfJeU=;
        b=FyQuex2E9PR/V0oVPpyimRpL53HXvTGyBJtjdOmxwNnKnfU2Y3hjmxTwKvA1DNqxt0
         8YnR/6Hh5A/okdaAHHXQTuvJ9eaM+1V4/GTY9CJkml8n7FA1iZ4HFrHugQYLAzh0cope
         KtS8EA6E7VXqElEG6/yKSwVsgU74j3TtZH+2nigmVUyasmrswb+JGAduDYVjb67fHicY
         Ru0P/Ik5BmHzpEKjeQBcIocGaPl0h+3MyaqCGdvIF6aIs94GhtewFPEYjuDCI9v4qoJa
         4cvMI5yMfbVPB9koJWIPUX5H5p7osnYJUJk5uzJ6gjynY0m8YJ5gw5qEL9z1ahth5NDN
         uyOg==
X-Gm-Message-State: APzg51DMEh9Ly5IXjQeIAptg5Gf9lyWNzoIxnpTmVQ5QLLeOf7JqIyao
        nw74uyNM5ldY+X9gHliYnxyD4kp0
X-Google-Smtp-Source: ANB0VdZi5gbYs6b4QAxTxXenJmoBVU+4PcJtdGzH7lb2Z7cfzW/4Iuq/WjHEdYgcOyhKGSNf0gc/Yw==
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr8295747lfi.126.1536931335835;
        Fri, 14 Sep 2018 06:22:15 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1186766ljd.61.2018.09.14.06.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:22:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0o36-0002bh-LZ; Fri, 14 Sep 2018 15:22:16 +0200
Date:   Fri, 14 Sep 2018 15:22:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/50] tty_ioctl(): start taking TIOC[SG]SERIAL into
 separate methods
Message-ID: <20180914132216.GC1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-5-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-5-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:04AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ->set_serial() and ->get_serial() resp., both taking tty and
> a kernel pointer to serial_struct.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/tty/tty_io.c       | 36 ++++++++++++++++++++++++++++++------
>  include/linux/tty_driver.h |  3 +++
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 2b34ccf269e0..91d73732e11c 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -97,6 +97,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/serial.h>
>  #include <linux/ratelimit.h>
> +#include <linux/compat.h>

Looks like you don't need this (just yet anyway).

>  #include <linux/uaccess.h>
>  
> @@ -2455,22 +2456,40 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
>  	return 0;
>  }

[...]

> +static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *ss)
> +{
> +	struct serial_struct v;
> +	int err;

Missing newline.

> +	memset(&v, 0, sizeof(struct serial_struct));
> +
> +	if (!tty->ops->set_serial)

You want get_serial here.

> +		return -ENOIOCTLCMD;
> +	err = tty->ops->get_serial(tty, &v);
> +	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
> +		err = -EFAULT;
> +	return err;
>  }
>  
>  /*
> @@ -2602,8 +2621,13 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		}
>  		break;
>  	case TIOCSSERIAL:
> -		tty_warn_deprecated_flags(p);
> -		break;
> +		retval = tty_tiocsserial(tty, p);
> +		if (retval != -ENOIOCTLCMD)
> +			return retval;

Missing break.

> +	case TIOCGSERIAL:
> +		retval = tty_tiocgserial(tty, p);
> +		if (retval != -ENOIOCTLCMD)
> +			return retval;

Missing break.

>  	case TIOCGPTPEER:
>  		/* Special because the struct file is needed */
>  		return ptm_open_peer(file, tty, (int)arg);

Johan
