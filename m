Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45934C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110E20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeK0UQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:16:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36560 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729387AbeK0UQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:16:19 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAR9Iw2p002054;
        Tue, 27 Nov 2018 03:18:58 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ny4x63txc-1;
        Tue, 27 Nov 2018 03:18:58 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 20E74611C8B8;
        Tue, 27 Nov 2018 03:18:58 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 09:18:57 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAR9Iu72031018; Tue,
 27 Nov 2018 09:18:56 GMT
Date:   Tue, 27 Nov 2018 09:18:56 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181127091856.GQ16508@imbe.wolfsonmicro.main>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
 <20181123132522.GE2089@sirena.org.uk>
 <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811270084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:53:40PM +0100, Linus Walleij wrote:
> On Fri, Nov 23, 2018 at 2:25 PM Mark Brown <broonie@kernel.org> wrote:
> I suspect maybe the lesser evil is to bite the bullet, invent
> gpiod_get_from_of_node() which is the missing API (we currently
> only have devm_gpiod_get_from_of_node()) and simply
> fix up the converted regulator drivers to avoid devm_*
> retrieveal in the same manner as wm8994 (the already
> queued patch). This will make the regulator core own the
> refcounting as it does today.
> 
> It's a bit unelegant but it's very straight forward and I know
> I can fix it up qucikly.
> 
> Unless anyone thinks it's a bad idea I will try to make a
> small fix series like that and a GPIO patch you can also
> carry in the regulator tree with it.

This issue I ran into following that path is it becomes rather
fiddly to have regulator_register behave sensibly with respect to
the GPIO. Obviously in the success case the core now owns the
GPIO and no issues. However, in the failure case it's not clear if
we want to core to release the GPIO or not, and consistently
doing either is fairly hard. But if your happy to have a go at it
I don't have any objections to it as a solution.

Thanks,
Charles
