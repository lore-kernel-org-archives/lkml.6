Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BDFC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E35208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E35208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeGHQqx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:46:53 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:41910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932162AbeGHQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:46:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BECEC18045D11;
        Sun,  8 Jul 2018 16:46:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horn12_3bce14379b362
X-Filterd-Recvd-Size: 2692
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Jul 2018 16:46:50 +0000 (UTC)
Message-ID: <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
Subject: Re: [PATCH 3/6] staging: rtl8723bs: fix indentation
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Jul 2018 09:46:49 -0700
In-Reply-To: <20180708103855.12473-3-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
         <20180708103855.12473-3-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-08 at 12:38 +0200, Michael Straube wrote:
> Remove unrequired extra indentations.
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
[]
> @@ -69,16 +69,16 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
>  
>  uint rtw_is_cckrates_included(u8 *rate)
>  {
> -		u32 i = 0;
> +	u32 i = 0;
>  
> -		while (rate[i] !=  0) {
> -			if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
> -			     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
> -				return true;
> -			i++;
> -		}
> +	while (rate[i] !=  0) {
> +		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
> +		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
> +			return true;
> +		i++;
> +	}
>  
> -		return false;
> +	return false;
>  }

Hi Michael.

Please try to improve the code for human readers and/or
reduce overall object size over merely shutting up checkpatch
style warnings.

For instance:

You could reduce object size a little by eliminating the
multiple use of 0x7f and index and dereferencing the
pointer instead.

$ size drivers/staging/rtl8723bs/core/rtw_ieee80211.o*
   text	   data	    bss	    dec	    hex	filename
  10085	     76	      0	  10161	   27b1	drivers/staging/rtl8723bs/core/rtw_ieee80211.o.new
  10149	     76	      0	  10225	   27f1	drivers/staging/rtl8723bs/core/rtw_ieee80211.o.old

Something like:

uint rtw_is_cckrates_included(u8 *rate)
{
	while (*rate) {
		u8 r = *rate & 0x7f;

		if (r == 2 || r == 4 || r == 11 || r == 22)
			return true;
		rate++;
	}

	return false;
}

uint rtw_is_cckratesonly_included(u8 *rate)
{
	while (*rate) {
		u8 r = *rate & 0x7f;

		if (r != 2 && r != 4 && r != 11 && r != 22)
			return false;
		rate++;
	}

	return true;
}

