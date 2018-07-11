Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D19220B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="YizqwXot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D19220B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeGKKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:35:10 -0400
Received: from onstation.org ([52.200.56.107]:38930 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeGKKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:35:10 -0400
Received: from localhost (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2E6B02F7;
        Wed, 11 Jul 2018 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531305090;
        bh=ey09jrjK0JbUL4vI7nVfUQmEOIrLK3sDknKmC2+LWUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YizqwXotcr6guub71aOp6Nn+1ytai8HoWqqAOUeY9PRvM8cSaR85guYRMaSWejIh7
         4bJtCg9v4I5mVk29N5QxPWK0B82d+lckqV+8ksWEUg6rhGzjU1xg8BInL7EkzbSdMk
         tqhpPTfhT/r3M2AWD32h0ptKXH9PxhTCIpc74znE=
Date:   Wed, 11 Jul 2018 06:31:29 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711103129.ql4txni63i2m7m4r@d08157822050>
References: <20180711010932.20313-1-masneyb@onstation.org>
 <20180711010932.20313-3-masneyb@onstation.org>
 <20180711100442.GA30019@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711100442.GA30019@himanshu-Vostro-3559>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:34:43PM +0530, Himanshu Jha wrote:
> Hi Brain,
> 
> On Tue, Jul 10, 2018 at 09:09:31PM -0400, Brian Masney wrote:
> > This patch adds support for the regulator framework to the mpu6050
> > driver.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > ---
> >  }
> >  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
> >  
> > +int inv_mpu_core_remove(struct inv_mpu6050_state *st)
> > +{
> > +	return regulator_disable(st->vddio_supply);
> > +}
> EXPORT_SYMBOL_GPL(inv_mpu_core_remove); ?
> 
> This is causing 0-day test build failure perhaps.

You are right. It compiles if I have CONFIG_INV_MPU6050_IIO built into
the kernel, which is what I'm using to boot the board, but fails when
compiled as a module. Good catch 0-day!

The patch won't apply to Linus's current master branch and I assumed
that iio/togreg didn't have the required changes as well. Sorry about
the noise.

I'll send a v2 before the weekend.

Brian
