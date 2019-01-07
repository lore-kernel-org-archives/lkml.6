Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfAGSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:02:49 -0500
Received: from shell.v3.sk ([90.176.6.54]:44274 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfAGSCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:02:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8788DFFD76;
        Mon,  7 Jan 2019 19:02:43 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id W11ZjhyktRhx; Mon,  7 Jan 2019 19:02:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 253C0FFD78;
        Mon,  7 Jan 2019 19:02:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g_IdK83M7cJM; Mon,  7 Jan 2019 19:02:39 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DA6AAFFD76;
        Mon,  7 Jan 2019 19:02:38 +0100 (CET)
Message-ID: <d541d82647338c07fa59b0f2ef63880610733505.camel@v3.sk>
Subject: Re: [PATCH v2 17/17] power: supply: olpc_battery: Add OLPC XO 1.75
 support
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Darren Hart <dvhart@infradead.org>
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
Date:   Mon, 07 Jan 2019 19:02:37 +0100
In-Reply-To: <20181202233458.GE23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
         <20181116162403.49854-18-lkundrak@v3.sk> <20181202233458.GE23087@wrath>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-02 at 15:34 -0800, Darren Hart wrote:
> On Fri, Nov 16, 2018 at 05:24:03PM +0100, Lubomir Rintel wrote:
> > The battery and the protocol are essentially the same as OLPC XO 1.5,
> > but the responses from the EC are LSB first.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> > - s/u16 ec_byte/u16 ec_word/
> > 
> >  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> 
> ...
> 
> > @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
> >  	if (ecver > 0x44) {
> >  		/* XO 1 or 1.5 with a new EC firmware. */
> >  		data->new_proto = 1;
> > +	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> 
> This if/else blocks concerns me a bit, but I might just be missing some
> context.
> 
> This tests both ecver as well as the OF compatible string, is this reliable? Do
> we know that for all xo1.75-ec compatible nodes the ecver will be <= 0x44? Or,
> is ecver undefined? If the latter, then perhaps this test should be performed
> first?
> 
> if (of_find_compatible_node....x01.75-ec...)
> 	...
> else if (ecver > 0x44)
> 	...
> else
> 	...
> 
> And what happens when ecver == 0x44? We test for > and < but not ==, <=,
> or >= in this block

You're right, the conditionals are not correct. On XO 1.75 the
versioning is different (now at level 0x05) and uninteresting,
therefore the XO 1.75 check needs to go first.

On XO 1 and XO 1.75, we don't support < 0x44. 0x44 is okay, though uses
stays with an old protocol, and > 0x44 uses a new protocol.

Will follow up with a new version of the patch soon.

> 
> > +		/* XO 1.75 */
> > +		data->new_proto = 1;
> > +		data->little_endian = 1;
> >  	} else if (ecver < 0x44) {
> >  		/*
> >  		 * We've seen a number of EC protocol changes; this driver
> > -- 
> > 2.19.1

Thanks
Lubo

