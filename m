Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB72C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1B52054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeH3PHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:07:42 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:43863 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3PHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:07:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id BC5522B52129;
        Thu, 30 Aug 2018 13:06:03 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R1q98qXAr4Az; Thu, 30 Aug 2018 13:06:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id F02F62B5212D;
        Thu, 30 Aug 2018 13:06:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3wSG4rywiIQR; Thu, 30 Aug 2018 13:06:01 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id AEC712B52129;
        Thu, 30 Aug 2018 13:06:01 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 962DD60228; Thu, 30 Aug 2018 13:06:01 +0200 (CEST)
Date:   Thu, 30 Aug 2018 13:06:01 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     paulus@samba.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, mitch@sfgoth.com, mostrows@earthlink.net,
        jchapman@katalix.com, xeb@mail.ru, davem@davemloft.net,
        viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Karsten Keil <isdn@linux-pingi.de>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] ppp: handle PPPIOCGIDLE for 64-bit time_t
Message-ID: <20180830110601.GA19534@alphalink.fr>
References: <20180829140409.833488-1-arnd@arndb.de>
 <20180829140409.833488-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829140409.833488-5-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:03:30PM +0200, Arnd Bergmann wrote:
> The ppp_idle structure is defined in terms of __kernel_time_t, which is
> defined as 'long' on all architectures, and this usage is not affected
> by the y2038 problem since it transports a time interval rather than an
> absolute time.
> 
> However, the ppp user space defines the same structure as time_t, which
> may be 64-bit wide on new libc versions even on 32-bit architectures.
> 
> It's easy enough to just handle both possible structure layouts on
> all architectures, to deal with the possibility that a user space ppp
> implementation comes with its own ppp_idle structure definition, as well
> as to document the fact that the driver is y2038-safe.
> 
> Doing this also avoids the need for a special compat mode translation,
> since 32-bit and 64-bit kernels now support the same interfaces.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/networking/ppp_generic.txt |  2 ++
>  drivers/isdn/i4l/isdn_ppp.c              | 14 ++++++++---
>  drivers/net/ppp/ppp_generic.c            | 18 ++++++++++----
>  fs/compat_ioctl.c                        | 31 ------------------------
>  include/uapi/linux/ppp-ioctl.h           |  2 ++
>  include/uapi/linux/ppp_defs.h            | 14 +++++++++++
>  6 files changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/networking/ppp_generic.txt b/Documentation/networking/ppp_generic.txt
> index 61daf4b39600..fd563aff5fc9 100644
> --- a/Documentation/networking/ppp_generic.txt
> +++ b/Documentation/networking/ppp_generic.txt
> @@ -378,6 +378,8 @@ an interface unit are:
>    CONFIG_PPP_FILTER option is enabled, the set of packets which reset
>    the transmit and receive idle timers is restricted to those which
>    pass the `active' packet filter.
> +  Two versions of this command exist, to deal with user space
> +  expecting times as either 32-bit or 64-bit time_t seconds.
>  
>  * PPPIOCSMAXCID sets the maximum connection-ID parameter (and thus the
>    number of connection slots) for the TCP header compressor and
> diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
> index a7b275ea5de1..1f17126c5fa4 100644
> --- a/drivers/isdn/i4l/isdn_ppp.c
> +++ b/drivers/isdn/i4l/isdn_ppp.c
> @@ -543,11 +543,19 @@ isdn_ppp_ioctl(int min, struct file *file, unsigned int cmd, unsigned long arg)
>  		}
>  		is->pppcfg = val;
>  		break;
> -	case PPPIOCGIDLE:	/* get idle time information */
> +	case PPPIOCGIDLE32:	/* get idle time information */
>  		if (lp) {
> -			struct ppp_idle pidle;
> +			struct ppp_idle32 pidle;
>  			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
> -			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle))))
> +			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle32))))
> +				return r;
> +		}
> +		break;
> +	case PPPIOCGIDLE64:	/* get idle time information */
> +		if (lp) {
> +			struct ppp_idle64 pidle;
> +			pidle.xmit_idle = pidle.recv_idle = lp->huptimer;
> +			if ((r = set_arg(argp, &pidle, sizeof(struct ppp_idle64))))
>  				return r;
>  		}
>  		break;
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 3a7aa2eed415..c8b8aa071140 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -619,7 +619,8 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	struct ppp_file *pf;
>  	struct ppp *ppp;
>  	int err = -EFAULT, val, val2, i;
> -	struct ppp_idle idle;
> +	struct ppp_idle32 idle32;
> +	struct ppp_idle64 idle64;
>  	struct npioctl npi;
>  	int unit, cflags;
>  	struct slcompress *vj;
> @@ -743,10 +744,17 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		err = 0;
>  		break;
>  
> -	case PPPIOCGIDLE:
> -		idle.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> -		idle.recv_idle = (jiffies - ppp->last_recv) / HZ;
> -		if (copy_to_user(argp, &idle, sizeof(idle)))
> +	case PPPIOCGIDLE32:
> +                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> +                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
> +                if (copy_to_user(argp, &idle32, sizeof(idle32)))
> 
Missing 'break;'

> +		err = 0;
> +		break;
> +
> +	case PPPIOCGIDLE64:
> +		idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> +		idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
> +		if (copy_to_user(argp, &idle32, sizeof(idle32)))
> 
I guess you meant 'idle64' instead of 'idle32'.
