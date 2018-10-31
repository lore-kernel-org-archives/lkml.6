Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZaagSOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeJaXYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbeJaXYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:24:25 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D68205F4;
        Wed, 31 Oct 2018 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540995969;
        bh=iTdI3PcKb3WYFvgfSFAAbWJqUh/yxX97Wq6VNE4qmA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WZaagSOn9GAiiBvCkhwwdHNVpV1vEF+iDKSIqgY1GESWZZczTczhZuif9+Zvlqna3
         gKsKPNuZnKxpAMjYOdI1+3vo2H+j0OMyFWkpD/Vy4hUAohdyNwITHdf84VmgWrWEnc
         kzqsCfO3BgNTquFTSt3IQRIXGj+M0etOsZGkymnc=
Received: by mail-qk1-f180.google.com with SMTP id e4so9711910qkh.6;
        Wed, 31 Oct 2018 07:26:09 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLxKF/Q/li6DLnGrdkQZNgYN4Ac0WaeQVlAy6pKns83HPhY7bd2
        uMXckH6RmBqm1iUzoW2vC1GFBDzlNqvCc/Gdaw==
X-Google-Smtp-Source: AJdET5ePSkkt7QiSi/rcCV2eqINF3tYgpihZZyt6dVv7VLo1RlHO8oS4LxbaAotSNWJ+uTGShfTLzPc0TUwvmrEKeAk=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr2888818qvb.218.1540995968603;
 Wed, 31 Oct 2018 07:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-21-robh@kernel.org>
 <87r2g6ffm8.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2g6ffm8.fsf@concordia.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Oct 2018 09:25:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mZD5cgzOQoC0bd-Bi-1i=eK=Xa3hLNtZ2phR8=5dN5A@mail.gmail.com>
Message-ID: <CAL_Jsq+mZD5cgzOQoC0bd-Bi-1i=eK=Xa3hLNtZ2phR8=5dN5A@mail.gmail.com>
Subject: Re: NXP P50XX/e5500 secondary CPUs not onlined with current mainline
 (was [PATCH 20/21] of: use for_each_of_cpu_node iterator)
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, chzigotzky@xenosoft.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:46 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Rob,
>
> This change is breaking some powerpc machines, ...
>
> Rob Herring <robh@kernel.org> writes:
> > Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> > has the side effect of defaulting to iterating using "cpu" node names in
> > preference to the deprecated (for FDT) device_type == "cpu".
> >
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack and I will take via the DT tree. This is dependent on the
> > first 2 patches.
> >
> >  drivers/of/base.c    |  2 +-
> >  drivers/of/of_numa.c | 15 ++-------------
> >  2 files changed, 3 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 6389aeb2f48c..8285c07cab44 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -389,7 +389,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
> >  {
> >       struct device_node *cpun;
> >
> > -     for_each_node_by_type(cpun, "cpu") {
> > +     for_each_of_cpu_node(cpun) {
> >               if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
> >                       return cpun;
> >       }
>
> Previously we just looked for any node with a type of "cpu", but now
> we're using for_each_of_cpu_node(), which does:
>
>         for (; next; next = next->sibling) {
>                 if (!(of_node_name_eq(next, "cpu") ||
>                       (next->type && !of_node_cmp(next->type, "cpu"))))
>                         continue;
>
>                 if (!__of_device_is_available(next))
>                         continue;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>                 if (of_node_get(next))
>                         break;
>         }
>
>
> ie. the available check is new.
>
> On this machine the 2nd CPU is not marked as available:
>
>   root@p5020ds:/proc/device-tree/cpus/PowerPC,e5500@1# lsprop status
>   status           "disabled"
>
> This has the effect of preventing the SMP code from finding the 2nd CPU
> in order to bring it up (in smp_85xx_start_cpu()). And so only the boot
> CPU is onlined.
>
> The device tree is built from a dts:
>
>   arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
>
> But we don't set the status in there, so presumably u-boot is changing
> the status during boot? (not a u-boot expert).

Ah, status for cpus is a bit different. For most nodes, it should be
equivalent to the node not being present, but for cpus it means
offline if disabled. Though ARM platforms have never used it in that
way.

> We could work around this in the platform code presumably, but I'm
> worried this might break other things as well. You didn't mention the
> addition of the available check in the change log so I wonder if it was
> deliberate or just seemed like a good idea?

Just seemed like a good idea...

I'll send a patch now dropping those 2 lines.

Rob
