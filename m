Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4B218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfA3Jyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:54:46 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9517 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbfA3Jyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:54:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539640800"; 
   d="scan'208";a="293767244"
Received: from unknown (HELO function) ([193.50.110.115])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2019 10:54:27 +0100
Received: from samy by function with local (Exim 4.92-RC4)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gomZf-00044o-LG; Wed, 30 Jan 2019 10:54:27 +0100
Date:   Wed, 30 Jan 2019 10:54:27 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Okash Khawaja <okash.khawaja@gmail.com>
Subject: Re: [PATCH] staging: speakup: fix tty-operation NULL derefs
Message-ID: <20190130095427.yzaxbuuctd7uyqje@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Okash Khawaja <okash.khawaja@gmail.com>
References: <20190130094934.4231-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130094934.4231-1-johan@kernel.org>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold, le mer. 30 janv. 2019 10:49:34 +0100, a ecrit:
> The send_xchar() and tiocmset() tty operations are optional. Add the
> missing sanity checks to prevent user-space triggerable NULL-pointer
> dereferences.
> 
> Fixes: 6b9ad1c742bf ("staging: speakup: add send_xchar, tiocmset and input functionality for tty")
> Cc: stable <stable@vger.kernel.org>     # 4.13
> Cc: Okash Khawaja <okash.khawaja@gmail.com>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Indeed.

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/spk_ttyio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
> index c92bbd05516e..005de0024dd4 100644
> --- a/drivers/staging/speakup/spk_ttyio.c
> +++ b/drivers/staging/speakup/spk_ttyio.c
> @@ -265,7 +265,8 @@ static void spk_ttyio_send_xchar(char ch)
>  		return;
>  	}
>  
> -	speakup_tty->ops->send_xchar(speakup_tty, ch);
> +	if (speakup_tty->ops->send_xchar)
> +		speakup_tty->ops->send_xchar(speakup_tty, ch);
>  	mutex_unlock(&speakup_tty_mutex);
>  }
>  
> @@ -277,7 +278,8 @@ static void spk_ttyio_tiocmset(unsigned int set, unsigned int clear)
>  		return;
>  	}
>  
> -	speakup_tty->ops->tiocmset(speakup_tty, set, clear);
> +	if (speakup_tty->ops->tiocmset)
> +		speakup_tty->ops->tiocmset(speakup_tty, set, clear);
>  	mutex_unlock(&speakup_tty_mutex);
>  }
>  
> -- 
> 2.20.1
> 

-- 
Samuel
R: Parce que ça renverse bêtement l'ordre naturel de lecture!
Q: Mais pourquoi citer en fin d'article est-il si effroyable?
R: Citer en fin d'article
Q: Quelle est la chose la plus désagréable sur les groupes de news?
