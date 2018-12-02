Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03575C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB8720892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WHvpqN98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLBXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:35:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeLBXfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0kH665vhbUf2eI9G20oKpGZ49nFsld92hekZ4ynOsw8=; b=WHvpqN98tUZtK89Zu/93Yr5F/
        omOuwCxdZDDzr7zf8zVtueZIdvKVTZhtlUZGFYk0XtTI4T+lb3d8G3hGPTNIB6uOXQP6uC/3a14r2
        J97HNNmp5ZkIgCqKRMPsZDwne6+shve7PGghAOTlBrSJX4ZNmRITChGMjOU3tAM3u4YGNcwWHtfLj
        a34xi2JS1pnigGioOA5D9SC7R6e+pcOGr+++SxI3NgPKeOVo/eiVA0kq/Vii6rAQifSuMRGXI5+Dx
        aTUsmQ2PsQDXth+ashoFrP58FMl9KyvbiUL57CUIP6I6SwhM1RWqvbdUvwgFH0HxGXPR+AwDPlrbe
        /4LJ7Qy7g==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTbGN-0004uO-CA; Sun, 02 Dec 2018 23:34:59 +0000
Date:   Sun, 2 Dec 2018 15:34:58 -0800
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
Subject: Re: [PATCH v2 17/17] power: supply: olpc_battery: Add OLPC XO 1.75
 support
Message-ID: <20181202233458.GE23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-18-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-18-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:24:03PM +0100, Lubomir Rintel wrote:
> The battery and the protocol are essentially the same as OLPC XO 1.5,
> but the responses from the EC are LSB first.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> - s/u16 ec_byte/u16 ec_word/
> 
>  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c

...

> @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
>  	if (ecver > 0x44) {
>  		/* XO 1 or 1.5 with a new EC firmware. */
>  		data->new_proto = 1;
> +	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {

This if/else blocks concerns me a bit, but I might just be missing some
context.

This tests both ecver as well as the OF compatible string, is this reliable? Do
we know that for all xo1.75-ec compatible nodes the ecver will be <= 0x44? Or,
is ecver undefined? If the latter, then perhaps this test should be performed
first?

if (of_find_compatible_node....x01.75-ec...)
	...
else if (ecver > 0x44)
	...
else
	...

And what happens when ecver == 0x44? We test for > and < but not ==, <=,
or >= in this block

> +		/* XO 1.75 */
> +		data->new_proto = 1;
> +		data->little_endian = 1;
>  	} else if (ecver < 0x44) {
>  		/*
>  		 * We've seen a number of EC protocol changes; this driver
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
