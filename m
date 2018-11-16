Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB712086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB712086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbeKQBsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:48:03 -0500
Received: from shell.v3.sk ([90.176.6.54]:56698 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeKQBsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:48:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 62DCF4D1EA;
        Fri, 16 Nov 2018 16:35:10 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YPLcAXT-vKbW; Fri, 16 Nov 2018 16:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A4F2E4D4DA;
        Fri, 16 Nov 2018 16:35:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gHJavzzimkga; Fri, 16 Nov 2018 16:35:06 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 802B54D1EA;
        Fri, 16 Nov 2018 16:35:06 +0100 (CET)
Message-ID: <aa352b5c65459d4ca35c2ed48afa611839f4b2a3.camel@v3.sk>
Subject: Re: Regression in next with spi return from transfer_one()
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Date:   Fri, 16 Nov 2018 16:35:05 +0100
In-Reply-To: <20181116000709.GK53235@atomide.com>
References: <20181115211451.GH53235@atomide.com>
         <20181115221241.GQ2089@sirena.org.uk> <20181115234359.GJ53235@atomide.com>
         <20181116000154.GS2089@sirena.org.uk> <20181116000709.GK53235@atomide.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 16:07 -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [181116 00:02]:
> > On Thu, Nov 15, 2018 at 03:44:00PM -0800, Tony Lindgren wrote:
> > 
> > > It seems to be caused because of the now missing "if (ret > 0) {"
> > > line somehow that was there earlier. New code sets ms to 200 it
> > > seems, then dmesg shows:
> > 
> > Doh, of course :(  Sorry I missed that.
> > 
> > > The old code is not updating ms and it's set to 1.
> > 
> > Right, and not waiting either which should be the issue.  Does the
> > following work:
> 
> And it's recalculating the timeout every time now too :) Yup that
> fix works and the problem makes sense now:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

My bad obviously. Sorry.

I'm grateful that you identified and fixed the problem so quickly.

Thanks,
Lubo

> 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 498d3b9bf3ae..430ad637c643 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1114,9 +1114,11 @@ static int spi_transfer_one_message(struct
> > spi_controller *ctlr,
> >  				goto out;
> >  			}
> >  
> > -			ret = spi_transfer_wait(ctlr, msg, xfer);
> > -			if (ret < 0)
> > -				msg->status = ret;
> > +			if (ret > 0) {
> > +				ret = spi_transfer_wait(ctlr, msg,
> > xfer);
> > +				if (ret < 0)
> > +					msg->status = ret;
> > +			}
> >  		} else {
> >  			if (xfer->len)
> >  				dev_err(&msg->spi->dev,
> 
> 

