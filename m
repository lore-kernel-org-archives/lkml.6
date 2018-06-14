Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7AD67C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267FC208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkX24xCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267FC208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeFNUdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754741AbeFNUdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:33:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51543208C3;
        Thu, 14 Jun 2018 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529008432;
        bh=hJHGyUcDOL6bYYpxdEeR8ciJUy6kiq8UeNsmzDQ9KuQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YkX24xCWeE823YVzbMPTQ2jW4dbQK+Szc21iYG760nydGAO36VRbrQkJUrQNP26sY
         RG8gjphwE6iEdA7VHpWISVf6FzCRR5rQsGocLzS00SmM8V+5IMnvys9Dy1DKEczzcS
         CH/Yacp6oaQK96aVAUe0sD7MtXRsRW0g6tsalLoY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        jason@lakedaemon.net, sudeep.holla@arm.com, tglx@linutronix.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        nicolas.dechesne@linaro.org
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
 <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
 <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
Message-ID: <152900843159.16708.3190914824253841690@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured registers
Date:   Thu, 14 Jun 2018 13:33:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivas Kandagatla (2018-06-14 10:54:43)
> > =

> >> +{
> >> +    struct gic_chip_data *d =3D data;
> >> +
> >> +    d->flags |=3D GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
> >> +
> >> +    return true;
> >> +}
> >> +
> >> +static const struct gic_quirk gicv3_quirks[] =3D {
> >> +    {
> >> +            .desc   =3D "GICV3: Qualcomm MSM8996 WAKER IW",
> > =

> > Please the erratum number in the message. It should read something like:
> > =

> >               "GICv3: Qualcomm erratum BIGNUMBERHERE"
> > =

> >> +            .iidr   =3D 0x00001070,   /* MSM8996 */
> >> +            .mask   =3D 0x0000ffff,
> > =

> > Please match the full GICD_IIDR register, not just the implementer and
> > the revision. Unless you expect all the QC systems to have the same
> > behaviour?
> There seems to be more than one SoC that has this issue,  I will dig up =

> more info before sending next version.
> =


It depends on the firmware and if that firmware decides to block or
allow access to this register space. I don't see how it can be quirked
based on the IIDR at all because there could be different firmware on
the board that doesn't block access to the register. Can a DT property
work?

