Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F03C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4220989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB4220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeKUVeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:34:01 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:41006 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbeKUVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:34:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wALB00cb006730;
        Wed, 21 Nov 2018 05:00:00 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth986qsx-1;
        Wed, 21 Nov 2018 05:00:00 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 9DB2C611C8B3;
        Wed, 21 Nov 2018 05:02:44 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 10:59:59 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wALAxwS4024750; Wed,
 21 Nov 2018 10:59:59 GMT
Date:   Wed, 21 Nov 2018 10:59:58 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
Message-ID: <20181121105958.GG16508@imbe.wolfsonmicro.main>
References: <CGME20181121101410epcas3p27a2a577c3b5a0608f7808ff733fab9d1@epcas3p2.samsung.com>
 <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
 <c0a2d30d-b18e-e72a-f369-c8678f1854ff@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0a2d30d-b18e-e72a-f369-c8678f1854ff@samsung.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=435 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:42:06AM +0100, Marek Szyprowski wrote:
> On 2018-11-21 11:13, Charles Keepax wrote:
> Linus, Mark: Similar issue is probably in the other regulator drivers,
> which use enable GPIO allocated by devm_gpio_get*(). This driver is
> simply the first one, which we observed it. It would be great if one
> would take a look into regulator_register() error path, because for some
> cases the GPIO will be freed, for the other - not.
> 

Yeah I have managed to reproduce the issue on another on of our
boards now, so it definitely affects other drivers we have. Its a
bit sneaky since the GPIO core only seems to warn on the additional
free if you have some additional debug turned on which masks the
issue most of the time.

I will have a bit of a look and see what else might be affected.

Thanks,
Charles
