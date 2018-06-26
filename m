Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EE726D99
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdIy+nnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EE726D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeFZQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeFZQus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:50:48 -0400
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com [209.85.214.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE1D26DA5;
        Tue, 26 Jun 2018 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530031848;
        bh=iNB0z4XmwdJp6Fc7Fe0duWZ/7snAOsGpRd/BDKd27nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cdIy+nnhT1roz6/uOPbkGs4n+mqC+kapWqHK5V/cEgvPRhB6CwBjm7BvDTmdezpVi
         NeUgjtJIAHTWOWsAk5TtDUDsROEGdPALPfCoNTuC8yVm3PEXWSgqxlq48EBAHrStaj
         2DxrWBQ9WUBZTD27fR4L5pHZk28DWFggC40SlnhY=
Received: by mail-it0-f46.google.com with SMTP id p185-v6so3276277itp.4;
        Tue, 26 Jun 2018 09:50:48 -0700 (PDT)
X-Gm-Message-State: APt69E3PoRkW2i/y29DEBzL7ozdstu9UD34NkYLbGwpITnrb1q9LDhHC
        lPG4rjrVGKijvVM6QAmLESdicN8WBWuwzAHJtg==
X-Google-Smtp-Source: AAOMgpcscfEPkeiI5UiWdS/RQ6XmsuzHHlYlfXItofYnPUybG5gKVQUJhmusnDcdEZwVGsZDhQZoWfSb09YrweuJ9zA=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr2020459jaa.46.1530031847703;
 Tue, 26 Jun 2018 09:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com> <20180626155928.GA7233@red-moon>
In-Reply-To: <20180626155928.GA7233@red-moon>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Jun 2018 10:50:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbXFxemR+1gLuE-Wj=jfhoyhnXoXBK4JZS7NsiU=eYCg@mail.gmail.com>
Message-ID: <CAL_JsqLbXFxemR+1gLuE-Wj=jfhoyhnXoXBK4JZS7NsiU=eYCg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch Kconfig
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 9:58 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Jun 19, 2018 at 12:21:05PM +0100, Lorenzo Pieralisi wrote:
> > Commit 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> > added configuration options to allow PCI host controller drivers to be
> > compile tested on all architectures.
> >
> > Some host controller drivers (eg PCIE_ALTERA) config entries select
> > the PCI_DOMAINS config option to enable PCI domains management in
> > the kernel. Now that host controller drivers can be compiled on
> > all architectures, this triggers build regressions on arches that
> > do not implement the PCI_DOMAINS required API (ie pci_domain_nr()):
> >
> > drivers/ata/pata_ali.c: In function 'ali_init_chipset':
> > drivers/ata/pata_ali.c:469:38: error:
> >         implicit declaration of function 'pci_domain_nr';
> >                                           did you mean 'pci_iomap_wc'?
> >
> > Furthemore, some software configurations (ie Jailhouse) require a
> > PCI_DOMAINS enabled kernel to configure multiple host controllers
> > without having an explicit dependency on the ARM platform on which
> > they run.
> >
> > Make PCI_DOMAINS a visible configuration option on ARM so that software
> > configurations that need it can manually select it and move the
> > PCI_DOMAINS selection from PCI controllers configuration file to ARM
> > sub-arch config entries that currently require it, fixing the issue.
> >
> > Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> > Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us.net
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Scott Branden <scott.branden@broadcom.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > ---
>
> Bjorn, Rob,
>
> if you are OK with this patch I think it is ready to go, hopefully for
> -rc3 since currently sparc allmodconfig is still broken as Guenter
> reported in the Link I embedded in the patch itself, please let me
> know, thanks.

LGTM

Acked-by: Rob Herring <robh@kernel.org>
