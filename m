Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B40BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD724208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3DgRYbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD724208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936383AbeFORxt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932194AbeFORxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:53:46 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D41208B8;
        Fri, 15 Jun 2018 17:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529085226;
        bh=5AxGlVGUnOZoQ3+OJp3zlmtUjz81vWwr3zi95TS/wZA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=M3DgRYbzW8I6zVAUOLjR273x6gnRZXnMS9cIc1msBl7q/oWD2onfX3kwn83nmJZKo
         7Wx678XgQKv0/GnttIUi3I1LnC2yA2rt30IkG23+w+l/g6yhhwtoZDQfsECvdD0y86
         JqDujxBpIKpTpTY+/U5jxexC+qc+eFBV3WmfYdvk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        jason@lakedaemon.net, sudeep.holla@arm.com, tglx@linutronix.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <61229c8f-7de0-a798-5af4-ba5e0ea78001@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        nicolas.dechesne@linaro.org
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
 <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
 <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
 <152900843159.16708.3190914824253841690@swboyd.mtv.corp.google.com>
 <61229c8f-7de0-a798-5af4-ba5e0ea78001@arm.com>
Message-ID: <152908522534.16708.13094007571453293776@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured registers
Date:   Fri, 15 Jun 2018 10:53:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2018-06-15 01:16:02)
> On 14/06/18 21:33, Stephen Boyd wrote:
> > Quoting Srinivas Kandagatla (2018-06-14 10:54:43)
> >>>
> >>>> +{
> >>>> +    struct gic_chip_data *d =3D data;
> >>>> +
> >>>> +    d->flags |=3D GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
> >>>> +
> >>>> +    return true;
> >>>> +}
> >>>> +
> >>>> +static const struct gic_quirk gicv3_quirks[] =3D {
> >>>> +    {
> >>>> +            .desc   =3D "GICV3: Qualcomm MSM8996 WAKER IW",
> >>>
> >>> Please the erratum number in the message. It should read something li=
ke:
> >>>
> >>>               "GICv3: Qualcomm erratum BIGNUMBERHERE"
> >>>
> >>>> +            .iidr   =3D 0x00001070,   /* MSM8996 */
> >>>> +            .mask   =3D 0x0000ffff,
> >>>
> >>> Please match the full GICD_IIDR register, not just the implementer and
> >>> the revision. Unless you expect all the QC systems to have the same
> >>> behaviour?
> >> There seems to be more than one SoC that has this issue,  I will dig u=
p =

> >> more info before sending next version.
> >>
> > =

> > It depends on the firmware and if that firmware decides to block or
> > allow access to this register space. I don't see how it can be quirked
> > based on the IIDR at all because there could be different firmware on
> > the board that doesn't block access to the register. Can a DT property
> > work?
> =

> Are you saying that the IIDR doesn't isn't unique per implementation of
> the firmware (which, as far as the kernel is concerned in this case,
> implements the GIC)? That would be another erratum. If we did change the
> behaviour of the vGIC in KVM, we'd certainly change the IIDR value! This
> is the exact same case.

I don't know for certain. All I know is that we can't assume all QC
systems have a firmware that brings the whole system down when you read
the WAKER register. Hopefully Srini can find out if reads to IIDR are
being trapped by the hypervisor and emulated as something different.

