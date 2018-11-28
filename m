Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58277C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B8E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B8E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeK2CYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:24:47 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47653 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeK2CYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:24:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wASFJLxn002041;
        Wed, 28 Nov 2018 09:22:39 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ny3xu6pgp-1;
        Wed, 28 Nov 2018 09:22:39 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 36200611E127;
        Wed, 28 Nov 2018 09:22:39 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 15:22:38 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wASFMcWg027697; Wed,
 28 Nov 2018 15:22:38 GMT
Date:   Wed, 28 Nov 2018 15:22:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
Message-ID: <20181128152238.GV16508@imbe.wolfsonmicro.main>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=722 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:43:40AM +0100, Linus Walleij wrote:
>  drivers/gpio/gpiolib.h                 |  6 -----
>  drivers/regulator/da9211-regulator.c   |  4 +--
>  drivers/regulator/fixed.c              |  4 ++-
>  drivers/regulator/lm363x-regulator.c   |  8 ++++--
>  drivers/regulator/lp8788-ldo.c         |  4 ++-
>  drivers/regulator/max77686-regulator.c |  3 +--
>  drivers/regulator/max8952.c            |  8 +++---
>  drivers/regulator/max8973-regulator.c  | 12 ++++++---
>  drivers/regulator/s5m8767.c            | 37 ++++++++++++++++++--------
>  drivers/regulator/tps65090-regulator.c | 10 +++----
>  include/linux/gpio/consumer.h          | 13 +++++++++
>  11 files changed, 72 insertions(+), 37 deletions(-)

It looks like the patches are assuming the regulator core,
doesn't free the GPIO on an error, however that is not true in
all cases. If only a single regulator has requested the GPIO then
all the error paths after the call to regulator_ena_gpio_request
in regulator_register will free the GPIO. Although this is not the
case if more than one regulator has requested the GPIO.

Thanks,
charles
