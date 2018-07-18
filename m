Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD77ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEEE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEEE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbeGRCXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:23:43 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:60700 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbeGRCXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:23:43 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffbZd-0007Ek-CM; Wed, 18 Jul 2018 03:48:13 +0200
Date:   Wed, 18 Jul 2018 03:48:13 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: Re: [PATCH 1/3] vt: avoid a VLA in the unicode screen scroll function
Message-ID: <20180718014813.ygcbgqxk4yo3ydbl@angband.pl>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
 <20180718010242.5254-2-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718010242.5254-2-nicolas.pitre@linaro.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:02:40PM -0400, Nicolas Pitre wrote:
> The nr argument is typically small: most often nr == 1. However this
> could be abused with a very large explicit scroll in a resized screen.
> Make the code scroll lines one at a time in all cases to avoid the VLA.
> Anything smarter is most likely not warranted here.

Even though nr can be 32767 at most, your new version is O(nr*nr) for no
reason.  Instead of O(n) memory or O(n²) time, a variant of the original
that copies values one at a time would be shorter and faster.

> Requested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  drivers/tty/vt/vt.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 2d14bb195d..03e79f7787 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -433,20 +433,22 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  
>  	if (uniscr) {
>  		unsigned int s, d, rescue, clear;
> -		char32_t *save[nr];
>  
>  		s = clear = t;
> -		d = t + nr;
> -		rescue = b - nr;
> +		d = t + 1;
> +		rescue = b - 1;
>  		if (dir == SM_UP) {
>  			swap(s, d);
>  			swap(clear, rescue);
>  		}
> -		memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));
> -		memmove(uniscr->lines + d, uniscr->lines + s,
> -			(b - t - nr) * sizeof(*uniscr->lines));
> -		memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
> -		vc_uniscr_clear_lines(vc, clear, nr);
> +		while (nr--) {
> +			char32_t *tmp;
> +			tmp = uniscr->lines[rescue];
> +			memmove(uniscr->lines + d, uniscr->lines + s,
> +				(b - t - 1) * sizeof(*uniscr->lines));
> +			uniscr->lines[clear] = tmp;
> +			vc_uniscr_clear_lines(vc, clear, 1);
> +		}
>  	}
>  }

What the function does is rotating an array (slice [t..b) here), by nr if
SM_DOWN or by -nr ie (b - t - nr) if SM_UP.  A nice problem that almost every
"code interview questions" book includes :)

Please say if you don't have time for such games, I've just refreshed what's
a good answer. :þ


Meow.
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
