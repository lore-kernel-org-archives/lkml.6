Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15773C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174321855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfAWRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:45:59 -0500
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:39024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfAWRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:45:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0AA4A1803BBD2;
        Wed, 23 Jan 2019 17:45:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hook98_50c7cd4ae7c16
X-Filterd-Recvd-Size: 3265
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Jan 2019 17:45:54 +0000 (UTC)
Message-ID: <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Remove space after cast
From:   Joe Perches <joe@perches.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Jan 2019 09:45:53 -0800
In-Reply-To: <20190123163122.GA4807@nishad>
References: <20190123163122.GA4807@nishad>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-23 at 22:01 +0530, Nishad Kamdar wrote:
> This patch removes space after a cast as it
> is not needed.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index 80e7067cfb79..3e959fa73703 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  		}
>  
>  		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> -		range->name = name = (char *) &range[1];
> +		range->name = name = (char *)&range[1];
>  		sprintf(name, "pio");

I find this code unsightly and fragile.
It doesn't test the return of devm_kzalloc for failure.

This might as well be
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 80e7067cfb79..9b52d44abef1 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
 		const __be32 *ngpio, *gpiobase;
 		struct pinctrl_gpio_range *range;
-		char *name;
 
 		if (!of_device_is_available(np))
 			continue;
@@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *) &range[1];
-		sprintf(name, "pio");
+		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+		range->name = "pio";
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
 		range->pin_base = range->base;
	
	

