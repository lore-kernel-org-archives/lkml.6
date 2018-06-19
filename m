Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE13C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ABA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ABA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756648AbeFSOHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:07:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:40140 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750816AbeFSOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:07:42 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JE3glm003384;
        Tue, 19 Jun 2018 09:07:33 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2jmyy2d4c7-1;
        Tue, 19 Jun 2018 09:07:33 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id AA134611C8AA;
        Tue, 19 Jun 2018 09:07:32 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Tue, 19 Jun 2018
 15:07:32 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5JE7UtB004250; Tue,
 19 Jun 2018 15:07:31 +0100
Date:   Tue, 19 Jun 2018 15:07:30 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matthias Reichl <hias@horus.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <linus.walleij@linaro.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: arizona-ldo1: Use correct device to get
 enable GPIO
Message-ID: <20180619140730.GG18740@imbe.wolfsonmicro.main>
References: <20180619093245.1261-1-ckeepax@opensource.cirrus.com>
 <20180619122432.6rgh4zjqrfk45ofs@camel2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180619122432.6rgh4zjqrfk45ofs@camel2.lan>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806190159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:24:33PM +0200, Matthias Reichl wrote:
> On Tue, Jun 19, 2018 at 10:32:45AM +0100, Charles Keepax wrote:
> > +	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
> > +					      GPIOD_OUT_HIGH);
> 
> The WM5102 datasheet lists LDOENA as an active-high input,
> so GPIOD_OUT_HIGH causes arizona-ldo1 to start up enabled.
> Not sure about the other devices from the Arizona family.
> 

Yeah all active high.

> I did some tests monitoring ldoena and reset gpios with my scope:
> 
> With commit e1739e86f0cb reverted ldoena changes from low to high
> about 1.6ms before reset changes from low to high.
> 
> With your patch ldoena goes high about 11.5ms before reset goes high.
> 
> With your patch and GPIOD_OUT_HIGH changed to GPIOD_OUT_LOW
> the delay is again about 1.6ms.
> 
> So I guess it'd be better to adjust the comment and change
> to gpiod flag to GPIOD_OUT_LOW.

Yeah I am inclined to agree would be better to keep the behaviour
the same as it has always been given these parts are fairly
mature I will respin the patch to add that change too.

Thanks,
Charles
