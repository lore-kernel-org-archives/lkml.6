Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE0C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C378B216E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C378B216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHOLML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:12:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47613 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeHOLML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:12:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7FB5420802; Wed, 15 Aug 2018 10:20:56 +0200 (CEST)
Received: from localhost (unknown [78.250.39.94])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2837920723;
        Wed, 15 Aug 2018 10:20:56 +0200 (CEST)
Date:   Wed, 15 Aug 2018 10:20:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     a.zummo@towertech.it, baruch@tkos.co.il, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace
 the open code
Message-ID: <20180815082055.GV943@piout.net>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
 <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
 <20180814161541.GP943@piout.net>
 <5B73D368.5010205@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B73D368.5010205@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2018 15:16:56+0800, zhong jiang wrote:
> On 2018/8/15 0:15, Alexandre Belloni wrote:
> > Hi,
> >
> > On 13/08/2018 19:31:24+0800, zhong jiang wrote:
> >> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> >> just replace them rather than duplicating its implement.
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  drivers/rtc/rtc-digicolor.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
> >> index b253bf1..fd6850c 100644
> >> --- a/drivers/rtc/rtc-digicolor.c
> >> +++ b/drivers/rtc/rtc-digicolor.c
> >> @@ -202,10 +202,8 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
> >>  	platform_set_drvdata(pdev, rtc);
> >>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> >>  						&dc_rtc_ops, THIS_MODULE);
> >> -	if (IS_ERR(rtc->rtc_dev))
> >> -		return PTR_ERR(rtc->rtc_dev);
> >>  
> >> -	return 0;
> >> +	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> > As many other maintainers, I don't find that kind of change useful and
> > I'm not taking them unless there are other improvements in the driver.
> >
> >
> Hi,  Alexandre
> 
> The issue is detected with the help of  Coccinelle.  It simplify the code with specific
> function rather than duplicating its implementation.
> 
> The patch clean up the code.   of course,  it is not a bug.  if you do not care about it.
> I am ok with that.
> 

But this does not simplify or make the code clearer and as soon as you
need to add code between the devm_rtc_device_register call and the end
of the function, the patch will need to be undone.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
