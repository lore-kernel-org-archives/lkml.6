Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143FF217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBFUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:50:29 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:33835 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBFUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:50:29 -0500
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1grU95-00074p-ED; Wed, 06 Feb 2019 15:50:24 -0500
Date:   Wed, 6 Feb 2019 15:49:42 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Julien Gomes <julien@arista.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        marcelo.leitner@gmail.com, vyasevich@gmail.com,
        lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190206204942.GB16887@hmswarspite.think-freely.org>
References: <20190206201430.18830-1-julien@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206201430.18830-1-julien@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
> structures longer than the current definitions.
> 
> This should prevent unjustified setsockopt() failures due to struct
> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
> binaries that should be compatible, but were built with later kernel
> uapi headers.
> 
> Signed-off-by: Julien Gomes <julien@arista.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 9644bdc8e85c..f9717e2789da 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
>  	int i;
>  
>  	if (optlen > sizeof(struct sctp_event_subscribe))
> -		return -EINVAL;
> +		optlen = sizeof(struct sctp_event_subscribe);
>  
I'm not sure I like this.  If you have a userspace application built against
more recent uapi headers than the kernel you are actually running on, then by
defintion you won't have this check in place, and you'll get EINVAL returns
anyway.  If you just backport this patch to an older kernel, you'll not get the
EINVAL return, but you will get silent failures on event subscriptions that your
application thinks exists, but the kernel doesn't recognize.  

This would make sense if you had a way to communicate back to user space the
unrecognized options, but since we don't (currently) have that, I would rather
see the EINVAL returned than just have things not work.

Neil

>  	if (copy_from_user(&subscribe, optval, optlen))
>  		return -EFAULT;
> -- 
> 2.20.1
> 
> 
