Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E952C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2F020824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2F020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404795AbeKWECH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:02:07 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50202 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733155AbeKWECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:02:07 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAMHLhBP009817;
        Thu, 22 Nov 2018 11:21:44 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth98913p-1;
        Thu, 22 Nov 2018 11:21:43 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 0E405611C8B2;
        Thu, 22 Nov 2018 11:24:29 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 17:21:43 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAMHLf5F029236; Thu,
 22 Nov 2018 17:21:41 GMT
Date:   Thu, 22 Nov 2018 17:21:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
Message-ID: <20181122172141.GJ16508@imbe.wolfsonmicro.main>
References: <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
 <CACRpkdb3HSQ_h1+9RvBUEDRDSCih7bv7kcf+=cc3-c0Hn6A0bg@mail.gmail.com>
 <CACRpkdb9KStEkMigDX2kA4Q-tr6DuuWqqTuF6jXZK67Zp+DxmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdb9KStEkMigDX2kA4Q-tr6DuuWqqTuF6jXZK67Zp+DxmA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=600 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811220154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:47:20PM +0100, Linus Walleij wrote:
> On Thu, Nov 22, 2018 at 3:19 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Nov 21, 2018 at 11:13 AM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> >
> > > The regulator core takes over managing the lifetime of the enable GPIO
> > > once the regulator is registered. As such we shouldn't register the
> > > enable GPIO using devm, or it will be freed twice.
> > >
> > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Oh no this is not the right solution I think.
> 

Yes I agree I actually am just about to send another series, I
guess I will send that and we can look at that and any
suggestions you have.

> All drivers passing a descriptor (config->ena_gpiod) do their
> own refcounting, including some using a function that has no
> non-devm* counterpart.
> 
> It is better if we teach the core to not gpiod_put() those.
> 

Yeah that is exactly what my patch chain is doing.

> The other patch series I am floating to get rid of the legacy
> GPIO handling from the core will do away with all the
> legacy GPIO handling anyway, so let me introduce a bit
> of ugliness (that can be backported) and then delete that
> ugliness with an updated series v8 of my legacy GPIO
> cleanup.
> 
> Sorry for the inconvenience.
> 
> Will send a patch soon.
> 
> Yours,
> Linus Walleij

Thanks,
Charles
