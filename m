Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B8CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFTI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:28:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:58728 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754206AbeFTI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:47 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K8EiJ0006518;
        Wed, 20 Jun 2018 03:14:44 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2jmxynpqs3-1;
        Wed, 20 Jun 2018 03:14:44 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 7ADE3611C8BB;
        Wed, 20 Jun 2018 03:15:38 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Wed, 20 Jun 2018
 09:14:43 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5K8Egj6010589; Wed,
 20 Jun 2018 09:14:42 +0100
Date:   Wed, 20 Jun 2018 09:14:42 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <hias@horus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <patches@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regulator: arizona-ldo1: Use correct device to get
 enable GPIO
Message-ID: <20180620081442.GH18740@imbe.wolfsonmicro.main>
References: <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
 <CAHp75VeytT0aYxoNLbtGzbacubn_kw+44bW8zGZuRVA7=oQWPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VeytT0aYxoNLbtGzbacubn_kw+44bW8zGZuRVA7=oQWPQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=398 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806200095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:46:36PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 6:10 PM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > Currently the enable GPIO is being looked up on the regulator
> > device itself but that does not have its own DT node, this causes
> > the lookup to fail and the regulator not to get its GPIO. The DT
> > node is shared across the whole MFD and as such the lookup needs
> > to happen on that parent device.
> 
> > Moving the lookup to the parent
> > device also means devres can no longer be used as the life time
> > would attach to the wrong device.
> 
> This part I didn't get.
> Why we can't use devm_...(parent_dev, ...) instead?
> 

Because it is possible to unbind the regulator driver itself,
which would leave the GPIO as acquired, since the MFD is never
unbound. Then when you rebind the regulator the GPIO would
already be held by the previous instantiation of the regulator
driver.

Thanks,
Charles
