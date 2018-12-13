Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD95C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6139020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeLMTal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:30:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:42552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbeLMTal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:30:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 205D5B005;
        Thu, 13 Dec 2018 19:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Dec 2018 11:30:38 -0800
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jason Baron <jbaron@akamai.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: make sure all elements in ready list are in
 FIFO order
Organization: SUSE Labs
In-Reply-To: <20181212110357.25656-2-rpenyaev@suse.de>
References: <20181212110357.25656-1-rpenyaev@suse.de>
 <20181212110357.25656-2-rpenyaev@suse.de>
Message-ID: <a9b0a9c2c966e60a6887b6658387ddd1@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-12 03:03, Roman Penyaev wrote:
> All coming events are stored in FIFO order and this is also should be
> applicable to ->ovflist, which originally is stack, i.e. LIFO.
> 
> Thus to keep correct FIFO order ->ovflist should reversed by adding
> elements to the head of the read list but not to the tail.

So the window for which the ovflist is used can be actually non-trivial 
(ie lots of copy_to_user) and I just hope nobody out there is relying on 
particular wakeup order. otoh nobody has every complained about this 
"reverse" order and not having the perfect queue. And hopefully the same 
will be for this case.

With that:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/eventpoll.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 2329f96469e2..3627c2e07149 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -722,7 +722,11 @@ static __poll_t ep_scan_ready_list(struct 
> eventpoll *ep,
>  		 * contain them, and the list_splice() below takes care of them.
>  		 */
>  		if (!ep_is_linked(epi)) {
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> +			/*
> +			 * ->ovflist is LIFO, so we have to reverse it in order
> +			 * to keep in FIFO.
> +			 */
> +			list_add(&epi->rdllink, &ep->rdllist);
>  			ep_pm_stay_awake(epi);
>  		}
>  	}

