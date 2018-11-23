Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4F120685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4F120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503588AbeKWVlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:41:25 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56344 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409538AbeKWVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:41:25 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wANAmZt2028315;
        Fri, 23 Nov 2018 04:57:31 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth98a31m-1;
        Fri, 23 Nov 2018 04:57:31 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id E20FE611C8AA;
        Fri, 23 Nov 2018 04:57:30 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 23 Nov 2018
 10:57:30 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wANAvTqc005667; Fri,
 23 Nov 2018 10:57:29 GMT
Date:   Fri, 23 Nov 2018 10:57:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181123105729.GM16508@imbe.wolfsonmicro.main>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811230087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:40:57AM +0100, Linus Walleij wrote:
> On Thu, Nov 22, 2018 at 6:30 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> 
> > Currently, a GPIO can be requested multiple times when the
> > NONEXCLUSIVE flag is set, however it must still be freed a single
> > time. This makes client code rather complex, since multiple drivers
> > may request the GPIO but only a single one can free it. Rather than
> > manually handling this in each driver add some basic reference
> > counting into the core.  Currently, this is fairly primitive but
> > so is the support for the NONEXCLUSIVE flag and the implementation
> > covers those use-cases.
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> This patch is not fixing anything right now, correct?
> 

It's fixing something in the case of two regulators using the
same GPIO. The direction this patch chain takes is that the end
drivers own the GPIOs not the regulator core (except for the
legacy case). So both of the end drivers will devm_ request their
GPIOs, which means that if those drivers are unbound both of them
will attempt to free the GPIO causing the same double free
warning we saw here. Indeed there is a probably worse problem
that if one is unbound it will free the GPIO and break the second
driver.

Basically the current handling of non-exclusive GPIOs in the GPIO
core requires multiple calls to request the GPIO but only a
single call to free the GPIO. If we want to stick with that
approach, then the regulator core does need to take ownership of
the lifetime of the enable GPIOs and the end drivers can't use
devm, as per my initial patch for wm8994. But it makes getting
the error paths in regulator_register sensible really tricky, and
feels like a less "clean" solution.

> I discussed the notion of pulling reference counting for
> nonexclusive GPIOs into gpiolib with Mark but the benefit is
> a bit unclear: if the subsystem using nonexeclusive GPIOs
> (currently only regulators) would still have to keep its own
> reference count or somehow semantically know when
> the last user is gone, the point is kind of moot.
> 
> I haven't looked closely at the regulators case but I got
> the impression that it is more complex than just reference
> counting so, currently I don't know if this is such a good
> idea.
> 
> Anyway I would like to push this until we have cleaned
> up with the rest of the series I have boiling, if you don't
> mind.
> 

I don't greatly mind delaying it as I don't currently look after
any systems that share enable GPIOs on regulators, but free of
those GPIOs is currently really broken so it feels like it
shouldn't be kicked too far down the road.

Thanks,
Charles

> (Patch 1+2 should be fine anyway.)
> 
> Yours,
> Linus Walleij
