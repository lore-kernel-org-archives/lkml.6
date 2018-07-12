Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5936420BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5936420BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeGLLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:54:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:59418 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeGLLyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:54:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6CBj8oX017464;
        Thu, 12 Jul 2018 06:45:10 -0500
Message-ID: <a51a3b8168a30379bf7528aeb387ca03e682eea2.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 3/5] fsi: master-ast-cf: Add new FSI master using
 Aspeed ColdFire
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Jul 2018 21:45:08 +1000
In-Reply-To: <CACPK8XdZKbh2NLQaiZOx66FAo+3csS_D9-BXjJKeppKm8aEM6w@mail.gmail.com>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
         <20180712034847.12878-4-benh@kernel.crashing.org>
         <CACPK8XdZKbh2NLQaiZOx66FAo+3csS_D9-BXjJKeppKm8aEM6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 17:53 +1000, Joel Stanley wrote:
> On 12 July 2018 at 13:48, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > The Aspeed AST2x00 can contain a ColdFire v1 coprocessor which
> > is currently unused on OpenPower systems.
> > 
> > This adds an alternative to the fsi-master-gpio driver that
> > uses that coprocessor instead of bit banging from the ARM
> > core itself. The end result is about 4 times faster.
> > 
> > The firmware for the coprocessor and its source code can be
> > found at https://github.com/ozbenh/cf-fsi and is system specific.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  drivers/fsi/Kconfig                      |    9 +
> >  drivers/fsi/Makefile                     |    1 +
> >  drivers/fsi/cf-fsi-fw.h                  |  157 +++
> >  drivers/fsi/fsi-master-ast-cf.c          | 1438 ++++++++++++++++++++++
> >  include/trace/events/fsi_master_ast_cf.h |  150 +++
> >  5 files changed, 1755 insertions(+)
> >  create mode 100644 drivers/fsi/cf-fsi-fw.h
> >  create mode 100644 drivers/fsi/fsi-master-ast-cf.c
> >  create mode 100644 include/trace/events/fsi_master_ast_cf.h
> > 
> > diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> > index 322cec393cf2..e0220d1e1357 100644
> > --- a/drivers/fsi/Kconfig
> > +++ b/drivers/fsi/Kconfig
> > @@ -27,6 +27,15 @@ config FSI_MASTER_HUB
> >         allow chaining of FSI links to an arbitrary depth.  This allows for
> >         a high target device fanout.
> > 
> > +config FSI_MASTER_AST_CF
> > +       tristate "FSI master based on Aspeed ColdFire coprocessor"
> > +       depends on GPIOLIB
> > +       depends on GPIO_ASPEED
> > +       ---help---
> > +       This option enables a FSI master using the AST2400 and AST2500 GPIO
> > +       lines driven by the internal ColdFire coprocessor. This requires
> > +       the corresponding machine specific ColdFire firmware to be available.
> 
> The "machine specific" part isn't true anymore, is it?

Right, I'll fixup the changelog before pushing if that's the last spin.

> I gave this a spin on a palmetto and it appeared to work fine for me.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>

Thanks !

Cheers,
Ben
.
