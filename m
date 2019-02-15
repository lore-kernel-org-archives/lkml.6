Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7001C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D105222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550266085;
	bh=FinDzfO9NFbLMTj3fYKJj6bEymQZrYIJ9z9gXWgH2/Q=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=FkksNGQw9SPChX471VsJym6KSpovyNsmQWtdGCDpCZ4n7/BLGxCwKPNClVIK1XH8n
	 il6Ut3m7nxheDRKv08afs4HTzxjVG8esU0DkPpJL4QXHVMJjkS4Zph06ot0zpQNMwt
	 Xt7nIddkFh74hCYkuVZzD5m/hB7MC4M+VKX5jLyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbfBOV2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392197AbfBOV2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:28:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B4C222BE;
        Fri, 15 Feb 2019 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550266083;
        bh=FinDzfO9NFbLMTj3fYKJj6bEymQZrYIJ9z9gXWgH2/Q=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=jPmnuLF4Z7fJrQJNV1/Y3sVgQPbx9zIl7NGkcEd8cFFv9YUhKHi9b1g6MT0eOEJFc
         wH+PhcPOsfSXvBsCkUUAYZ432y7VUco23G+t9aX15V5i6ny0odeUZbwIAELCFRkP4n
         L1q+lgpRS1CePflme+Pxv1ef4rH0XV72fO4Isy70=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Masney <masneyb@onstation.org>
In-Reply-To: <20190215134733.GA21208@basecamp>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
Message-ID: <155026608236.115909.9007817366859489104@swboyd.mtv.corp.google.com>
References: <20190208021631.30252-1-masneyb@onstation.org> <20190208021631.30252-6-masneyb@onstation.org> <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com> <20190215134733.GA21208@basecamp>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 13:28:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-02-15 05:47:33)
> On Thu, Feb 14, 2019 at 09:51:26PM -0800, Stephen Boyd wrote:
> > > diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> > > index 8eb2528793f9..2f99a98ccee5 100644
> > > --- a/drivers/mfd/qcom-pm8xxx.c
> > > +++ b/drivers/mfd/qcom-pm8xxx.c
> > > @@ -380,6 +380,12 @@ static void pm8xxx_irq_domain_map(struct pm_irq_=
chip *chip,
> > >                                   struct irq_domain *domain, unsigned=
 int irq,
> > >                                   irq_hw_number_t hwirq, unsigned int=
 type)
> > >  {
> > > +       unsigned int old_virq;
> > > +
> > > +       old_virq =3D irq_find_mapping(domain, hwirq);
> > > +       if (old_virq)
> > > +               irq_domain_disassociate(domain, old_virq);
> >=20
> > Is it possible to pass 'true' for the 'realloc' argument to
> > __irq_domain_alloc_irqs() and then this disassociate change isn't
> > needed?
>=20
> The kernel doc for __irq_domain_alloc_irqs() says that the realloc
> parameter is mainly to support legacy IRQs. I don't think its a good
> idea to add new code that'll stay past the end of this patch series
> on top of that legacy interface.
>=20

Ok. The other side of the argument is that this is the only user of
irq_domain_disassociate(), which may also be some sort of legacy
interface that isn't supposed to be used. Looking at the commit that
exposed it, it seems to be that it's there for legacy reasons.

commit 43a775916d63d1c822107b39987192ca5ced445c
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Mon Jun 9 16:20:05 2014 +0800

    genirq: Export irq_domain_disassociate() to architecture interrupt driv=
ers
   =20
    Export irq_domain_disassociate() to architecture interrupt drivers,
    so it could be used to handle legacy IRQ descriptors on x86.

So maybe we should just use the realloc argument and bury the
disassociate API in irqdomain.c because it's not supposed to be used?
Or does the realloc path not work for some reason?
