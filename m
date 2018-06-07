Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HeE/OQwoGVsKewAAmS7hNA
	; Thu, 07 Jun 2018 12:45:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C15A3608B8; Thu,  7 Jun 2018 12:45:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47BFE607E7;
	Thu,  7 Jun 2018 12:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47BFE607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeFGMpJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:45:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52021 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeFGMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:45:08 -0400
X-Originating-IP: 96.22.60.141
Received: from localhost (modemcable141.60-22-96.mc.videotron.ca [96.22.60.141])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4E32D60014;
        Thu,  7 Jun 2018 14:45:04 +0200 (CEST)
Date: Thu, 7 Jun 2018 08:45:03 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
Message-ID: <20180607124216.GA2329@hle-laptop.local>
References: <20180602175649.GA2816@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602175649.GA2816@hle-laptop.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add a mutex fixing a potential NULL pointer dereference in the pi433
> driver.
> 
> If pi433_release and pi433_ioctl are concurrently called,
> pi433_release might set filp->private_data to NULL while pi433_ioctl
> is still accessing it, leading to NULL pointer dereference. This issue
> might also affect pi433_write and pi433_read.
> 
> The newly introduced mutex makes sure that instance data
> will not be modified simultaneously by pi433_release, pi433_write,
> pi433_read or pi433_ioctl.
> 
> The mutex is stored in a newly introduced struct pi433_data, which
> wraps struct pi433_instance and its mutex.
> 
> Make filp->private_data point to a struct pi433_data, allowing to
> acquire the lock before accessing the struct pi433_instance.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
> Changes in v2:
>  	- Use mutex instead of rw semaphore. 
>  	- Introduce struct pi433_data in order to allow functions to lock
>  	  before dereferencing instance pointer.
>  	- Make filp->private_data point to a struct pi433_data.
>  	- Add missing braces.

After discussing this issue on the kernel newbies mailing list[0] we
came to the conclusion that it is very unlikely that pi433_release and
pi433_ioctl would ever run concurrently in this case. This is also
true for read/write. Unless one can find a situation where this might
happen, I think we should not add this potentially unnecessary lock.

Regards,
 Hugo

[0] http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-June/019131.html 

-- 
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA
