Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E0C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BEF20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BEF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIMWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:48:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51950 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMWsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:48:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7AB80D;
        Thu, 13 Sep 2018 10:38:23 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88F603F703;
        Thu, 13 Sep 2018 10:38:23 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B5BCB1AE3318; Thu, 13 Sep 2018 18:38:40 +0100 (BST)
Date:   Thu, 13 Sep 2018 18:38:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     andrew.murray@arm.com,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        dann.frazier@canonical.com,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        jean-philippe.brucker@arm.com
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Message-ID: <20180913173840.GB20290@arm.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
 <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:00:54PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 13, 2018 at 2:48 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> > prevent users from making I/O accesses outside the expected I/O range -
> > however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> > contradictory to its other users.
> >
> > The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> > amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> > mangling the given port rather than capping it.
> >
> > We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> > implementation of ioport_map by using the comparison operator and
> > returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> > we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> > we don't break existing buggy drivers that somehow rely on this masking.
> >
> > Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> Looks good to me,
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you take this through the arm64 tree?

Yup, I'll queue it up as a fix.

Cheers,

Will
