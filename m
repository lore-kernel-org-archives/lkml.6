Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id so8OHSeHHlv5OgAAmS7hNA
	; Mon, 11 Jun 2018 14:29:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 534A660850; Mon, 11 Jun 2018 14:29:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DC4960791;
	Mon, 11 Jun 2018 14:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DC4960791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934653AbeFKO3n (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:29:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56243 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeFKO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:29:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fSNp7-0003SV-EC; Mon, 11 Jun 2018 15:29:33 +0100
Message-ID: <1528727372.2289.120.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 059/268] xen-netfront: Fix race between device setup
 and open
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 11 Jun 2018 15:29:32 +0100
In-Reply-To: <20180528100208.647996715@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100208.647996715@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
> 
> [ Upstream commit f599c64fdf7d9c108e8717fb04bc41c680120da4 ]
[...]
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
[...]
> @@ -1839,6 +1824,7 @@ static int talk_to_netback(struct xenbus
>  		goto out;

This "goto out" is outside the locked section...

>  	}
>  
> +	rtnl_lock();
>  	if (info->queues)
>  		xennet_destroy_queues(info);
>  
> @@ -1849,6 +1835,7 @@ static int talk_to_netback(struct xenbus
>  		info->queues = NULL;
>  		goto out;
>  	}
> +	rtnl_unlock();
>  
>  	/* Create shared ring, alloc event channel -- for each queue */
>  	for (i = 0; i < num_queues; ++i) {
> @@ -1945,8 +1932,10 @@ abort_transaction_no_dev_fatal:
>  	xenbus_transaction_end(xbt, 1);
>   destroy_ring:
>  	xennet_disconnect_backend(info);
> +	rtnl_lock();
>  	xennet_destroy_queues(info);
>   out:
> +	rtnl_unlock();

...so this will be an unmatched unlock.

You need to add another label below the rtnl_unlock().

Ben.

>  	device_unregister(&dev->dev);
>  	return err;
>  }
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
