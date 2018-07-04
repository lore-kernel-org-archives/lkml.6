Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616A0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032AD208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032AD208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbeGDL7S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:59:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:57119 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933113AbeGDL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:59:17 -0400
X-IronPort-AV: E=Sophos;i="5.51,306,1526335200"; 
   d="scan'208";a="335413769"
Received: from wl6-20.enseeiht.fr (HELO hadrien.local) ([147.127.193.20])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 13:59:15 +0200
Date:   Wed, 4 Jul 2018 13:59:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
In-Reply-To: <20180704093449.vryluk7khaudstgp@kili.mountain>
Message-ID: <alpine.DEB.2.20.1807041358580.4387@hadrien>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jul 2018, Dan Carpenter wrote:

> We accidentally removed the check for negative returns without
> considering the issue of type promotion.  The "if_version_length"
> variable is type size_t so if __mei_cl_recv() returns a negative then
> "bytes_recv" is type promoted to a high positive value and treated as
> success.
>
> Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC fixup")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 0208c4b027c5..fa0236a5e59a 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -267,7 +267,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
>
>  	ret = 0;
>  	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0);
> -	if (bytes_recv < if_version_length) {
> +	if (bytes_recv < 0 || bytes_recv < if_version_length) {

Is this preferred to adding an int cast?

julia

>  		dev_err(bus->dev, "Could not read IF version\n");
>  		ret = -EIO;
>  		goto err;
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
