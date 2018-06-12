Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9834FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608C2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqxqdZP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4608C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934723AbeFLXJx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeFLXJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:09:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA202084E;
        Tue, 12 Jun 2018 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528844991;
        bh=8sRZe2dpKc8iFEmseYeTt+Wvfu3WiFL9RiLmI4vIBKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqxqdZP19wJCifUrm76rVDriNrc90exgI0ODZKV9W966JWQT4DLRit2gO1hxdu5oz
         9Tl/AVdOc6gIfyxIu2ubn+76dY9SgCU83PVP0ti5Zrx5azhR0GYhdQBJmtuuWKg9Zx
         eZqGKE/LsCd33cP2FjNSw79rPFDkiTZRy6PcrjQw=
Date:   Tue, 12 Jun 2018 18:09:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        shawn.lin@rock-chips.com
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
Message-ID: <20180612230950.GB96078@bhelgaas-glaptop.roam.corp.google.com>
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:08:53PM -0700, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 2:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)
> 
> Could we please see *reasons* for this series of commits?
> 
> Those commit messages have trivial "what", but no explanations "why".

The reason for this was to consolidate the AER-related code in one
file instead of several little ones:

  $ wc -l drivers/pci/pcie/aer/*
    141 drivers/pci/pcie/aer/aerdrv_acpi.c
    371 drivers/pci/pcie/aer/aerdrv.c
    496 drivers/pci/pcie/aer/aerdrv_core.c
    260 drivers/pci/pcie/aer/aerdrv_errprint.c
     95 drivers/pci/pcie/aer/aerdrv.h
    550 drivers/pci/pcie/aer/aer_inject.c
    117 drivers/pci/pcie/aer/ecrc.c
     29 drivers/pci/pcie/aer/Kconfig
     19 drivers/pci/pcie/aer/Kconfig.debug
     13 drivers/pci/pcie/aer/Makefile

The original separation made logical sense but ended up being a hassle
in practice because following a thread of execution is always being
interrupted by having to find something in a different file.

Bjorn
