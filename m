Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDC120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeLJWIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:08:54 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:33942 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeLJWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:08:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id DB5E42D7E;
        Mon, 10 Dec 2018 23:08:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gSunzxIAEstH; Mon, 10 Dec 2018 23:08:52 +0100 (CET)
Received: from function.home (unknown [IPv6:2a01:cb19:181:c200:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 346AF2D7D;
        Mon, 10 Dec 2018 23:08:52 +0100 (CET)
Received: from samy by function.home with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gWTjO-0004w5-W9; Mon, 10 Dec 2018 23:08:51 +0100
Date:   Mon, 10 Dec 2018 23:08:50 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: change semaphore to completion
Message-ID: <20181210220850.wq7rbcc77v2ckw3f@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Arnd Bergmann <arnd@arndb.de>, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181210214225.1497552-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210214225.1497552-1-arnd@arndb.de>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann, le lun. 10 déc. 2018 22:41:50 +0100, a ecrit:
> In this driver, both function the same way, but we want to eventually
> kill off semaphores, so a completion is the better choice here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/spk_ttyio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
> index 979e3ae249c1..c92bbd05516e 100644
> --- a/drivers/staging/speakup/spk_ttyio.c
> +++ b/drivers/staging/speakup/spk_ttyio.c
> @@ -10,7 +10,7 @@
>  
>  struct spk_ldisc_data {
>  	char buf;
> -	struct semaphore sem;
> +	struct completion completion;
>  	bool buf_free;
>  };
>  
> @@ -55,7 +55,7 @@ static int spk_ttyio_ldisc_open(struct tty_struct *tty)
>  	if (!ldisc_data)
>  		return -ENOMEM;
>  
> -	sema_init(&ldisc_data->sem, 0);
> +	init_completion(&ldisc_data->completion);
>  	ldisc_data->buf_free = true;
>  	speakup_tty->disc_data = ldisc_data;
>  
> @@ -95,7 +95,7 @@ static int spk_ttyio_receive_buf2(struct tty_struct *tty,
>  
>  	ldisc_data->buf = cp[0];
>  	ldisc_data->buf_free = false;
> -	up(&ldisc_data->sem);
> +	complete(&ldisc_data->completion);
>  
>  	return 1;
>  }
> @@ -286,7 +286,8 @@ static unsigned char ttyio_in(int timeout)
>  	struct spk_ldisc_data *ldisc_data = speakup_tty->disc_data;
>  	char rv;
>  
> -	if (down_timeout(&ldisc_data->sem, usecs_to_jiffies(timeout)) == -ETIME) {
> +	if (wait_for_completion_timeout(&ldisc_data->completion,
> +					usecs_to_jiffies(timeout)) == 0) {
>  		if (timeout)
>  			pr_warn("spk_ttyio: timeout (%d)  while waiting for input\n",
>  				timeout);
> -- 
> 2.20.0
> 

-- 
Samuel
Progress (n.): The process through which the Internet has evolved from
smart people in front of dumb terminals to dumb people in front of smart
terminals.
