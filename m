Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943E8223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943E8223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=magewell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeKNSnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:43:15 -0500
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:56422 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbeKNSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:43:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09372924|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.DIbWQb8_1542184805;
Received: from John(mailfrom:yong.deng@magewell.com fp:SMTPD_---.DIbWQb8_1542184805)
          by smtp.aliyun-inc.com(10.147.40.44);
          Wed, 14 Nov 2018 16:40:06 +0800
Date:   Wed, 14 Nov 2018 16:40:05 +0800
From:   Yong <yong.deng@magewell.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v12 0/2] Initial Allwinner V3s CSI Support
Message-Id: <20181114164005.76477b7401345e346def53d7@magewell.com>
In-Reply-To: <20181113133518.6nnh4m37s6awfw6d@flea>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
        <20181113133518.6nnh4m37s6awfw6d@flea>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 13 Nov 2018 14:35:18 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi Yong,
> 
> On Tue, Oct 30, 2018 at 04:09:48PM +0800, Yong Deng wrote:
> > I can't make v4l2-compliance always happy.
> > The V3s CSI support many pixformats. But they are not always available.
> > It's dependent on the input bus format (MEDIA_BUS_FMT_*). 
> > Example:
> > V4L2_PIX_FMT_SBGGR8: MEDIA_BUS_FMT_SBGGR8_1X8
> > V4L2_PIX_FMT_YUYV: MEDIA_BUS_FMT_YUYV8_2X8
> > But I can't get the subdev's format code before starting stream as the
> > subdev may change it. So I can't know which pixformats are available.
> > So I exports all the pixformats supported by SoC.
> > The result is the app (v4l2-compliance) is likely to fail on streamon.
> > 
> > This patchset add initial support for Allwinner V3s CSI.
> > 
> > Allwinner V3s SoC features a CSI module with parallel interface.
> > 
> > This patchset implement a v4l2 framework driver and add a binding 
> > documentation for it. 
> 
> I've tested this version today, and I needed this patch to make it
> work on top of v4.20:
> http://code.bulix.org/9o8fw5-503690?raw
> 
> Once that patch applied, my tests were working as expected.
> 
> If that make sense, could you resubmit a new version with these merged
> so that we can try to target 4.21?

OK. I will check it.

Thanks,
Yong
