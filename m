Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5720855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550774828;
	bh=yFFI4WzSH5Qu3zfQKbyIb4YqnJd8BFkTbp578pF9/kM=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=mj9EwQVKRDSWxIiWsea2Y0HxteDt+N+0oqzTExfyZ1AhOou12399V4z+d+6CuHgtT
	 77qpOG/vtVzmxNYFlymbfrLwikjB5i1sw195CPlajErc9H6/MR9ODxcjbWLm+Btibn
	 iJ6i+wIANursvclL/XI/mQ5kswPYMccxwcf4B6gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfBUSrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUSrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:47:06 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53EB2084D;
        Thu, 21 Feb 2019 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550774824;
        bh=yFFI4WzSH5Qu3zfQKbyIb4YqnJd8BFkTbp578pF9/kM=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=SHLgnpSZLZsioXqLb5nC7UM3PubLF4MS+yWs1oAVTPlsptLX5txaBuIjhb5aLfs0M
         hlnE9laF96JwG0HoAOX8tvrh1ibP9+NsxkZqap4GhMGBOrfRea/V+HhTGz1fVAveLP
         2c6RQt3phzuKkZjbUWpKWB9k+SCWPp1Fps2zdnlM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
Message-ID: <155077482380.77512.11109337732610217265@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190208021631.30252-1-masneyb@onstation.org> <20190208021631.30252-6-masneyb@onstation.org> <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com> <20190215134733.GA21208@basecamp> <155026608236.115909.9007817366859489104@swboyd.mtv.corp.google.com> <20190216002359.GA24752@basecamp>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190216002359.GA24752@basecamp>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 21 Feb 2019 10:47:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-02-15 16:23:59)
> On Fri, Feb 15, 2019 at 01:28:02PM -0800, Stephen Boyd wrote:
> > Quoting Brian Masney (2019-02-15 05:47:33)
> > > On Thu, Feb 14, 2019 at 09:51:26PM -0800, Stephen Boyd wrote:
> > > > > diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> > > > > index 8eb2528793f9..2f99a98ccee5 100644
> > > > > --- a/drivers/mfd/qcom-pm8xxx.c
> > > > > +++ b/drivers/mfd/qcom-pm8xxx.c
> > > > > @@ -380,6 +380,12 @@ static void pm8xxx_irq_domain_map(struct pm_=
irq_chip *chip,
> > > > >                                   struct irq_domain *domain, unsi=
gned int irq,
> > > > >                                   irq_hw_number_t hwirq, unsigned=
 int type)
> > > > >  {
> > > > > +       unsigned int old_virq;
> > > > > +
> > > > > +       old_virq =3D irq_find_mapping(domain, hwirq);
> > > > > +       if (old_virq)
> > > > > +               irq_domain_disassociate(domain, old_virq);
> > > >=20
> > > > Is it possible to pass 'true' for the 'realloc' argument to
> > > > __irq_domain_alloc_irqs() and then this disassociate change isn't
> > > > needed?
> > >=20
> > > The kernel doc for __irq_domain_alloc_irqs() says that the realloc
> > > parameter is mainly to support legacy IRQs. I don't think its a good
> > > idea to add new code that'll stay past the end of this patch series
> > > on top of that legacy interface.
> > >=20
> >=20
> > Ok. The other side of the argument is that this is the only user of
> > irq_domain_disassociate(), which may also be some sort of legacy
> > interface that isn't supposed to be used. Looking at the commit that
> > exposed it, it seems to be that it's there for legacy reasons.
> >=20
> > commit 43a775916d63d1c822107b39987192ca5ced445c
> > Author: Jiang Liu <jiang.liu@linux.intel.com>
> > Date:   Mon Jun 9 16:20:05 2014 +0800
> >=20
> >     genirq: Export irq_domain_disassociate() to architecture interrupt =
drivers
> >    =20
> >     Export irq_domain_disassociate() to architecture interrupt drivers,
> >     so it could be used to handle legacy IRQ descriptors on x86.
> >=20
> > So maybe we should just use the realloc argument and bury the
> > disassociate API in irqdomain.c because it's not supposed to be used?
> > Or does the realloc path not work for some reason?
>=20
> I haven't tried the realloc path yet. Let's back up further so that we
> are both starting with the same assumptions. Do you want to keep either
> your proposed change (realloc argument) or the existing
> irq_domain_disassociate change in mainline past the end of this patch
> series? If it is going to continue to be a temporary shim that will be
> reverted at the end of the patch series (like I did here), then I don't
> see the point in this extra work since this patch is only here to keep
> it bisectable and works. We're not using any legacy interfaces by the
> end of this patch series.

The main concern I have is that we're changing the binding to avoid a
larger discussion we could have about whether or not the binding is
wrong to list out the hierarchical irqs as part of an 'interrupts'
property. We have one case where hardware irq numbers are remapped to
other hardware irq number spaces and it seems perfectly valid to use the
'interrupts' property to indicate this, i.e. chained interrupt
controllers.

Those controllers typically have a single 'interrupts' specifier for the
chained irq of the parent interrupt controller, but when it comes to
hierarchical interrupts we seem to have various different ways of
expressing the mapping from one number space to another. I've seen
approaches varying between hardcoding everything in the kernel to
hardcoding everything in DT.

I'm mostly wondering if having an interrupts property listing all the
parent interrupts in corresponding specifier slots for the interrupt
controller's hardware irq space is wrong. It seems to describe the
mapping between the two number spaces already, so maybe it would make
sense to use the realloc argument and keep listing them as interrupts in
DT. Obviously things are already moving forward with the new DT binding,
so maybe I just need to be told that having an interrupts property there
is wrong. If it is wrong, then nothing needs to be kept around and the
binding can easily be changed.

