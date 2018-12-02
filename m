Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E396C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07FA2145D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPhDIotE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07FA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLBXQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:16:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBXQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HN9Odmodg2EUo9OFRGgQeJSEImyNlltj7Ro9/yh7mAw=; b=OPhDIotEp5DSirgdQz6ZL5F/3
        AMwqS8APLazXMMbrom/DKuLp3skw9DUdleUj9xzWDf5cuT9lveEXfK8ewBo9389xsqKxNW0FXNQO1
        cu9sNWsYWgmZtqaEDsNHE6tew5uG2z4TxlejzyGBJPNbkyvSUD+QZIrnzRC1CAM0jJfVhm6/aFxA2
        ctLNebQFCbYWGloK4BWT29q+0OF9Y51UovBa9KWAk+Hue2l6N3flV1AkQS3jLB+LrVvFl0/TabESy
        uuc25SGY726h2Fo56HAZbtn6gtAl+azptmNnJZlKg4K7RavIfZpcBnTJDU+ZHJjRwDAG/l1WZfBpy
        sC6299q7g==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTaxq-0007OP-ET; Sun, 02 Dec 2018 23:15:50 +0000
Date:   Sun, 2 Dec 2018 15:15:49 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/17] Platform: OLPC: Avoid a warning if the EC
 didn't register yet
Message-ID: <20181202231549.GC23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-8-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:23:53PM +0100, Lubomir Rintel wrote:
> Just return ENODEV, so that whoever attempted to use the EC call can

I think you meant EPROBE_DEFER here, but the language in the commit
message is a bit ambiguous here...

> defer their work.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - EPROBE_DEFER instead of ENODEV
> 
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..9ee993d5d54b 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>  	struct olpc_ec_priv *ec = ec_priv;
>  	struct ec_cmd_desc desc;
>  
> -	/* Ensure a driver and ec hook have been registered */
> -	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +	/* Driver not yet registered. */
> +	if (!ec_driver)
> +		return -EPROBE_DEFER;
> +
> +	if (WARN_ON(!ec_driver->ec_cmd))
>  		return -ENODEV;
>  
>  	if (!ec)
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
