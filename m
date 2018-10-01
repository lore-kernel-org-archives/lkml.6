Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF15C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13ED204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="FfkiVAZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13ED204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeJAWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:42:25 -0400
Received: from vern.gendns.com ([206.190.152.46]:55959 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeJAWmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UWbcjZtkouA+yL6TDCKP8xSGHrLyA/Qwy8Xm9cxg3RI=; b=FfkiVAZE7Clxt9Yt/BFfyp9w0q
        D3P83SCamLS70n56a3rjJreFMzYZY11JRd9rXzLA0RdFuG5JzFTXnhlEhW382iPjMZO2RCCNKqHyR
        KOduhjfHyaskKlYgzNSBWvXj4rVdHN0abm2zOggvEpMCbjVJXnmohCuJP2E87WuEyphkbX7cVYe8w
        LdmzTw12aX68mKeIxzgFb6qzyqfRb5nFhaI+8wc5F+crgl2YNsd2rgZ7LffxoplDOruoZXh/leP19
        8c8/zZxWoAnP4mMmKu00g/YAiciRBiP8+2lPLj/WAo802UCYpiaANPdyRYXRaC1LZ+p0el5p59Yl1
        BMpoL3Ig==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60196 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g70fm-001lmQ-38; Mon, 01 Oct 2018 12:03:50 -0400
Subject: Re: [PATCH] nvmem: fix nvmem_cell_get_from_lookup()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20181001100052.3580-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <44adbace-6849-e37f-70f0-d11661e6bdc9@lechnology.com>
Date:   Mon, 1 Oct 2018 11:03:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001100052.3580-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 05:00 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We check if the pointer returned by __nvmem_device_get() is not NULL
> while we should actually check if it is not IS_ERR(nvmem). Fix it.
> 
> While we're at it: fix the next error path where we should assign an
> error value to cell before returning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ad1227df1984..8249621d11a6 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   		    (strcmp(lookup->con_id, con_id) == 0)) {
>   			/* This is the right entry. */
>   			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
> -			if (!nvmem) {
> +			if (IS_ERR(nvmem)) {
>   				/* Provider may not be registered yet. */
> -				cell = ERR_PTR(-EPROBE_DEFER);
> +				cell = (struct nvmem_cell *)nvmem;

perhaps ERR_CAST() would better indicate the intent here?

>   				goto out;
>   			}
>   
> @@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   						       lookup->cell_name);
>   			if (!cell) {
>   				__nvmem_device_put(nvmem);
> +				cell = ERR_PTR(-ENOENT);
>   				goto out;
>   			}
>   		}
> 

