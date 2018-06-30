Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F94C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969C42802D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnYy7TBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969C42802D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936236AbeF3BuH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936028AbeF3BuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:50:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FED12802D;
        Sat, 30 Jun 2018 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530323403;
        bh=KyAEAZ27JOcqG2ZCSGZRLUe8xrWodVETpyS48w24eYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnYy7TBuj1pTFURv32E0OUSc1UKOiwR6xmxmqRYd1VF21sfR3cS4LjNnRvS9mNyyZ
         eKHfgftVFlwCiflKUYuPZDcETcGS0kiK0jQ349Wa3FSFHnKHehY4WVh1fb2a52Sozz
         Hz45K4qIwkVgUmYKdQFIAOx1kL8uIHcp1lPSbgOs=
Date:   Fri, 29 Jun 2018 20:50:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     dmeyer@gigaio.com
Cc:     logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
Message-ID: <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 01:18:04PM -0700, dmeyer@gigaio.com wrote:
> From: Doug Meyer <dmeyer@gigaio.com>
> 
> This is a resend of the patch series to enable Microsemi Switchtec
> NTB configurations to run with the IOMMU in the hosts turned on.
> Because of the nature PCI Quirk implementation, it was preferable
> to migrate the Microsemi PCI vendor and device definitions to the
> Linux canonical location. Logan Gunthorpe requested that this
> migration be done as a separate patch in a set, and so this patch
> series was created as shown here.
> 
> The first patch encapsulates the movement of constants from
> switchtec.h to pci_ids.h, with commensurate changes to the source
> files. This patch is not dependent on any other work.
> 
> The second patch is the PCI quirk implementation itself, and is
> completely dependent upon the first patch in this series.
> 
> Testing of the quirk was done on with a 2-host x86-64 system
> with all combinations of IOMMU off/on. The ntb_perf module was
> used as test stimulus. 
> 
> Blessings,
> Doug Meyer
> 
> Changes since v1:
> - Call pci_device_disable() at return points to clean up properly.
> - Changed all dev_* print macros to pci_* macros.
> - Removed superfluous variable initializations.
> 
> Doug Meyer (2):
>   NTB: Migrate PCI Constants to Cannonical PCI Header
>   NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   3 +-
>  drivers/pci/quirks.c                   | 197 +++++++++++++++++++++++++++++++++
>  drivers/pci/switch/switchtec.c         |  15 ++-
>  include/linux/pci_ids.h                |  32 ++++++
>  include/linux/switchtec.h              |   4 -
>  5 files changed, 238 insertions(+), 13 deletions(-)

I applied these with Logan's reviewed-by to my pci/switchtec branch for
v4.19 with the following updates:

  - You removed the SPDX tag from drivers/pci/switch/switchtec.c.  I assume
    that was a mistake, so I restored it.

  - I moved the PCI_VENDOR_ID_MICROSEMI definition to keep the file sorted.

  - I dropped the Device ID definitions per the policy at the top of the
    file (which I mentioned on your v1 posting).

  - I converted all the Device ID definition uses to raw hex constants.  I
    noticed that the following were defined by your patch, but not used:

      PCI_DEVICE_ID_MICROSEMI_PSX24XG3
      PCI_DEVICE_ID_MICROSEMI_PSX32XG3

    I can't tell whether the quirk is supposed to apply to them or not.

Please review and holler if I broke something.

This touches drivers/ntb/hw/..., which isn't my area.  Let me know if you'd
rather take these through a different tree.

Bjorn
