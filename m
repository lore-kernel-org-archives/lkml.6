Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3457521479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3457521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeKUUlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:41:39 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36458 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbeKUUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:41:39 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wALA4K0F000633;
        Wed, 21 Nov 2018 04:07:46 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth986m4j-1;
        Wed, 21 Nov 2018 04:07:45 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id CEEB4611C8B3;
        Wed, 21 Nov 2018 04:10:29 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 10:07:44 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wALA7hat014725; Wed,
 21 Nov 2018 10:07:44 GMT
Date:   Wed, 21 Nov 2018 10:07:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
Message-ID: <20181121100743.GF16508@imbe.wolfsonmicro.main>
References: <CGME20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386@epcas1p2.samsung.com>
 <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
 <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
 <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=886 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811210092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:26:30AM +0100, Marek Szyprowski wrote:
> On 2018-11-20 18:25, Marek Szyprowski wrote:
> > On 2018-11-20 18:01, Charles Keepax wrote:
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2421
> > regulator_ena_gpio_free+0x70/0xa0
> 
> I've checked a bit more and it looks that the issue is caused by
> gpiod_put() in regulator_ena_gpio_free(). I've removed gpiod_put() call
> from wm8994_ldo_remove(), switched to regulator_register() in
> wm8994_ldo_probe() and added regulator_unregister() in
> wm8994_ldo_remove(). This way the warning is gone. If there is any
> other, simpler way to fix it, let me know. When regulator_register()
> fails, gpiod will be freed only in some cases, depending what caused
> failure. It looks that this needs some clarification...
> 

Ah.. ok, so is perhaps what is happening here that both the
devm_gpio_get and the regualtor_ena_gpio_free are both trying to
free the GPIO? I assume the regulator core does this to handle
the case of shared GPIOs, so presumably the correct fix would
just be to switch from devm_gpiod_get to just plain gpiod_get and
not add the additional gpiod_put in wm8994_ldo_remove, as the
regulator core will handle freeing the GPIO for us.

I will respin the patch and lets see where that gets us to.

Thanks,
Charles
