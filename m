Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9392086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1Lyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:54:39 -0500
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:58866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726611AbfA1Lyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:54:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 919D9837F24A;
        Mon, 28 Jan 2019 11:54:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bell21_4557232275915
X-Filterd-Recvd-Size: 2372
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Jan 2019 11:54:36 +0000 (UTC)
Message-ID: <bbf2f5f03f9813f1bbab23ea36c17f38600432e7.camel@perches.com>
Subject: Re: [PATCH 4/6] staging: rtl8188eu: remove unncessary asignment to
 cleanup long line
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 03:54:34 -0800
In-Reply-To: <20190128095137.26815-4-straube.linux@gmail.com>
References: <20190128095137.26815-1-straube.linux@gmail.com>
         <20190128095137.26815-4-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 10:51 +0100, Michael Straube wrote:
> Instead of first asign 'wrqu.data.length = p - buff' use 'p - buff'
> directly in min_t() in the subsequent asignment. Clears a line over
> 80 characters checkpatch warning.

Thank you.  I believe you should include Larry Finger
in the cc list for this driver

Using scripts/get_maintainer.pl should tell you that.

And while this is true, another way to reduce line length
is to reduce indentation.

In this function, it is reasonable to change the

	if (authmode == _WPA_IE_ID_) {
		...
	}
}

to

	if (authmode != _WPA_IE_ID_)
		return;
	...
}

Another issue with this code is the sprintf.

It expands a u8 buffer of a maximum of IW_CUSTOM_MAX size
into an allocated buffer of IW_CUSTOM_MAX size with %02x;

That could overflow the allocated buffer.

> diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
[]
> @@ -109,8 +109,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
>  			p += sprintf(p, "%02x", sec_ie[i]);
>  		p += sprintf(p, ")");
>  		memset(&wrqu, 0, sizeof(wrqu));
> -		wrqu.data.length = p - buff;
> -		wrqu.data.length = min_t(__u16, wrqu.data.length, IW_CUSTOM_MAX);
> +		wrqu.data.length = min_t(__u16, p - buff, IW_CUSTOM_MAX);
>  		wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
>  		kfree(buff);
>  	}


