Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDFBC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A7020881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A7020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeG2SxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:53:00 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:51171 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbeG2Sw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:52:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6D270837F242;
        Sun, 29 Jul 2018 17:21:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock25_8482a3eb12643
X-Filterd-Recvd-Size: 1829
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Jul 2018 17:21:50 +0000 (UTC)
Message-ID: <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Jul 2018 10:21:49 -0700
In-Reply-To: <20180729170851.2581-8-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
         <20180729170851.2581-8-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
> Use is_broadcast_ether_addr instead of checking each byte of the
> address array for 0xff. Shortens the code and improves readability.

You should show in the commit log that sta_addr is __aligned(2)
as required by is_broadcast_ether_addr, otherwise you could be
introducing runtime alignment defects.

> diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
[]
> @@ -361,9 +361,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		goto exit;
>  	}
>  
> -	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
> -	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
> -	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
> +	if (is_broadcast_ether_addr(param->sta_addr)) {
>  		if (param->u.crypt.idx >= WEP_KEYS) {
>  			ret = -EINVAL;
>  			goto exit;

etc...
