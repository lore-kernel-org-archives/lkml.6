Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427892089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427892089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeKPJyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:54:02 -0500
Received: from muru.com ([72.249.23.125]:54184 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeKPJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:54:02 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AA3208107;
        Thu, 15 Nov 2018 23:44:03 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:44:00 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: Regression in next with spi return from transfer_one()
Message-ID: <20181115234359.GJ53235@atomide.com>
References: <20181115211451.GH53235@atomide.com>
 <20181115221241.GQ2089@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115221241.GQ2089@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [181115 22:12]:
> On Thu, Nov 15, 2018 at 01:14:51PM -0800, Tony Lindgren wrote:
> 
> > Commit 810923f3bf06 ("spi: Deal with slaves that return from
> > transfer_one() unfinished") causes a regression at least on
> > droid 4 with SPI PMIC and regulators on the PMIC. During boot
> > the device just hangs there waiting for rootfs to appear on
> > MMC. Reverting 810923f3bf06 makes things work again.
> 
> > Any ideas why this might be?
> 
> Wow, that's not obvious...  as far as I can tell the code in the !slave
> case is identical so unless the controller is somehow getting mistakenly
> flagged as a slave it looks like it should be something to do with it
> being pushed into a function.  Could you try logging what the timeout
> ends up getting set to?

It seems to be caused because of the now missing "if (ret > 0) {"
line somehow that was there earlier. New code sets ms to 200 it
seems, then dmesg shows:

SPI transfer timed out

The old code is not updating ms and it's set to 1.

Regards,

Tony
