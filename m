Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5ED20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5ED20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeK0BY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:24:57 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:1943 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbeK0BY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:24:57 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAQET6Dj017641;
        Mon, 26 Nov 2018 08:30:31 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ny3xu2h0y-1;
        Mon, 26 Nov 2018 08:30:29 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id ECD7E611C8B6;
        Mon, 26 Nov 2018 08:33:57 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 14:30:29 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAQEUSSD000813; Mon,
 26 Nov 2018 14:30:28 GMT
Date:   Mon, 26 Nov 2018 14:30:28 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181126143028.GO16508@imbe.wolfsonmicro.main>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
 <20181123132522.GE2089@sirena.org.uk>
 <20181126130001.GN16508@imbe.wolfsonmicro.main>
 <20181126140927.GD9715@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181126140927.GD9715@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=953 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811260131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:09:27PM +0000, Mark Brown wrote:
> On Mon, Nov 26, 2018 at 01:00:01PM +0000, Charles Keepax wrote:
> > On Fri, Nov 23, 2018 at 01:25:22PM +0000, Mark Brown wrote:
> 
> > > help the multiple users find each other somehow.  I think what we want
> > > to do here is either push the gpiod requests into the regulator core or
> > > change things so that once the regulator is registered with the
> > > regulator core the regulator core owns and is responsible for freeing
> > > the regulator.
> 
> > On the co-ordinating do we expect that the behaviour will
> > be that the GPIO should in the "enabled" state whenever any
> > regulator is requesting it? IE. the GPIO state is an OR of
> > the regulator states. Or are we expecting to handle more
> > complex interaction?
> 
> For the regulators that's what we do, yes - it's like they're all
> sharing a single regulator.  That probably won't be true in general for
> all GPIO users.

Would there perhaps be milage in looking at just making
the regulator core request the GPIO, rather than the end
drivers? Gives us a single request/free point. We don't need
any special flags in the GPIO layer, as its just a single
user as far as GPIO is concerned.

Thanks,
Charles
