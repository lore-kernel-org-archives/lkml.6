Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E61ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F5220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F5220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbeGTTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:46:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46023 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbeGTTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:46:00 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgaZk-0001Cp-PI; Fri, 20 Jul 2018 19:56:24 +0100
Message-ID: <1532112984.21552.39.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 089/105] media: dvb_frontend: fix locking issues at
 dvb_frontend_get_event()
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 20 Jul 2018 19:56:24 +0100
In-Reply-To: <20180701153155.855633462@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
         <20180701153155.855633462@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 18:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> commit 76d81243a487c09619822ef8e7201a756e58a87d upstream.
> 
> As warned by smatch:
> 	drivers/media/dvb-core/dvb_frontend.c:314 dvb_frontend_get_event() warn: inconsistent returns 'sem:&fepriv->sem'.
> 	  Locked on:   line 288
> 	               line 295
> 	               line 306
> 	               line 314
> 	  Unlocked on: line 303
> 
> The lock implementation for get event is wrong, as, if an
> interrupt occurs, down_interruptible() will fail, and the
> routine will call up() twice when userspace calls the ioctl
> again.
> 
> The bad code is there since when Linux migrated to git, in
> 2005.
[...] 
> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
[...]
> +static int dvb_frontend_test_event(struct dvb_frontend_private *fepriv,
> +				   struct dvb_fe_events *events)
> +{
> +	int ret;
> +
> +	up(&fepriv->sem);
> +	ret = events->eventw != events->eventr;
> +	down(&fepriv->sem);
> +
> +	return ret;
> +}

This is broken.  You must not wait inside a wait condition.  (It would
be nice if this rule was explicitly documented.)

Why not leave the condition as it was and only change the
down_interruptible() to down()?

Ben.

>  static int dvb_frontend_get_event(struct dvb_frontend *fe,
> -			    struct dvb_frontend_event *event, int flags)
> +			          struct dvb_frontend_event *event, int flags)
>  {
>  	struct dvb_frontend_private *fepriv = fe->frontend_priv;
>  	struct dvb_fe_events *events = &fepriv->events;
> @@ -249,13 +261,8 @@ static int dvb_frontend_get_event(struct
>  		if (flags & O_NONBLOCK)
>  			return -EWOULDBLOCK;
>  
> -		up(&fepriv->sem);
> -
> -		ret = wait_event_interruptible (events->wait_queue,
> -						events->eventw != events->eventr);
> -
> -		if (down_interruptible (&fepriv->sem))
> -			return -ERESTARTSYS;
> +		ret = wait_event_interruptible(events->wait_queue,
> +					       dvb_frontend_test_event(fepriv, events));
>  
>  		if (ret < 0)
>  			return ret;
> 
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
