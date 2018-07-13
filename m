Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A77ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62012124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62012124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeGMIOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:14:10 -0400
Received: from nautica.notk.org ([91.121.71.147]:37818 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbeGMIOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:14:09 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 10826C01A; Fri, 13 Jul 2018 10:00:38 +0200 (CEST)
Date:   Fri, 13 Jul 2018 10:00:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
Message-ID: <20180713080023.GB9638@nautica>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713074455.GA6859@himanshu-Vostro-3559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Himanshu Jha wrote on Fri, Jul 13, 2018:
> > I expect each maintainer will pick their share of the patchs if they
> > agree with it and the rest will just be dropped?
> 
> Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
> so please cc him or your patch would be lost.

Thanks, will do.

> > +virtual patch
> > +virtual context
> 
> You might consider adding context rule or remove this line perhaps ?

Victim of copypasta, I'll remove this.

> > +-strncpy@p(
> > ++strlcpy(
> > +  dest, src, sz);
> > +-dest[sz - 1] = '\0';
> 
> The above rule produces an output that I think is not correct:
> --------------------------------------------------------------
> diff = 
> diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
> --- a//ti/wl1251/acx.c
> +++ b//ti/wl1251/acx.c
> @@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
>  	}
>  
>  	/* be careful with the buffer sizes */
> -	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> -
> -	/*
> -	 * if the firmware version string is exactly
> -	 * sizeof(rev->fw_version) long or fw_len is less than
> -	 * sizeof(rev->fw_version) it won't be null terminated
> -	 */
> -	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
> +	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> 
> -----------------------------------------------------------------
> 
> I think the comment is useful and should not be removed.

I agree this comment is useful now that I'm taking a closer look, I
glanced at this too fast.
I'm not sure how to make coccinelle not remove comments between lines
though?

> Also, consider changing Confidence level appropriately.

I am (was?) pretty confident on the change itself, the only exceptions
would be if someone relied on strncpy to fill the end of the buffer with
zero to not leak data somewhere but that is not easy to judge by itself
(although I hope rare enough)

I'm honestly not sure what would be appropriate in this case.

-- 
Dominique Martinet
