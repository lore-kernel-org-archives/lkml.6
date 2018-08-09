Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F999C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B758E21528
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yOcSi4tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B758E21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHIWuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeHIWuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:50:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECBC208E3;
        Thu,  9 Aug 2018 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533846222;
        bh=35BHZct5rk/5i87/TcRsNnE8vFA1IblMky1e0O9E0Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOcSi4tzWp2XSArSwx3V04yzEnRZeONLh0BOmj2GzzHz/LFIRG5cKrKRi1cG/Ki4R
         Qq3dSKot13CtjRNF90FP10cJtG5X6b1MuGvzNAQT6G/HusABWtPHYJ9sEBlhsqeXMQ
         Dl1lMR0+VrasTkzWlmpSaAqx3oARZAIBSVC5gv1Q=
Date:   Thu, 9 Aug 2018 15:23:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/3] PCI: NVMe reset quirks
Message-ID: <20180809202340.GE113140@bhelgaas-glaptop.roam.corp.google.com>
References: <153384487209.15793.15203778129263981368.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153384487209.15793.15203778129263981368.stgit@gimli.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:04:03PM -0600, Alex Williamson wrote:
> v4: Fix 0-day i386 build error for readq, simply use readl
>     instead, the bits we're interested in are 24:31 and the NVMe
>     spec indicates that smaller, aligned accesses are allowed.
>     Update bz links for both device specific resets.
> 
> v3: Separate quirks, only for the afflicted devices
> 
> v2: Add bug link, use Samsung vendor ID, add spec references
> 
> Fix two different NVMe device reset issues with device specific
> quirks.  The Samsung controller in patch 2 sometimes doesn't like
> being reset while enabled, so disable the NVMe controller prior to
> FLR.  This quirk is generic to all NVMe class devices, though I've
> dropped the additional delay some devices require between disabling
> and checking ready status.  This can be added later should any of
> those devices need this quirk.  The Intel controller quirk is now
> just a simple delay after FLR, which clearly any device needing
> similar behavior can also use.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (3):
>       PCI: Export pcie_has_flr()
>       PCI: Samsung SM961/PM961 NVMe disable before FLR quirk
>       PCI: Intel DC P3700 NVMe delay after FLR quirk
> 
> 
>  drivers/pci/pci.c    |    3 +
>  drivers/pci/quirks.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |    1 
>  3 files changed, 108 insertions(+), 1 deletion(-)

Applied to pci/virtualization for v4.19, thanks!
