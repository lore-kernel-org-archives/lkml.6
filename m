Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9639620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9639620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937169AbeFSDLo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:11:44 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45151 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937096AbeFSDLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:11:43 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C3457240004;
        Tue, 19 Jun 2018 03:11:42 +0000 (UTC)
Date:   Mon, 18 Jun 2018 23:11:36 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180619030850.GA1876@hle-laptop.local>
References: <20180618022400.GA1893@hle-laptop.local>
 <20180618101838.gzbrxabilnqyilsi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618101838.gzbrxabilnqyilsi@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> We need to decrement device->users-- on the error paths as well.
> This function was already slightly broken with respect to counting the
> users, but let's not make it worse.
> 
> I think it's still a tiny bit racy because it's not an atomic type.

Oh right, I missed that. I'll fix it in the v2. :)

> I'm not sure the error handling in open() works either.  It's releasing
> device->rx_buffer but there could be another user.

Agree.

> The ->rx_buffer
> should be allocated in probe() instead of open() probably, no?  And then
> freed in pi433_remove().  Then once we put that in the right layer
> it means we can just get rid of ->users...

It would be great to get rid of this counter, indeed. But how to do it
properly without breaking things ? It seems to be useful to me...

For example, how do you handle the case where remove() is called but
some operations are still running on existing fds ?

What if remove frees the rx_buffer while a read() call executes this ?

copy_to_user(buf, device->rx_buffer, bytes_received)

rx_buffer is freed by release() because it's the only buffer from the
device structure used in read/write/ioctl, meaning that we can only
free it when we are sure that it isn't used anywhere anymore.

So, we can't do it in remove() unless remove() is delayed until the
last release() has returned.

> The lines:
>
>   1008                  if (!device->spi)
>   1009                          kfree(device);
>
> make no sort of sense at all...  Fortunately it's not posssible for
> device->spi to be NULL so it's dead code.

Really ? device->spi is NULL-ed in remove() so that operations on
remaining fds can detect remove() was already called and free remaining
resources:
 
1296         /* make sure ops on existing fds can abort cleanly */
1297         device->spi = NULL;

Thanks for your time !

Regards,
 Hugo

-- 
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA
