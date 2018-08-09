Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EDCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072F921480
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6QYx86c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072F921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHJBah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbeHJBag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:30:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98FB20657;
        Thu,  9 Aug 2018 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533855814;
        bh=zSfUb5d8bCceFxiGT1b3jFpD4Wy81XMkn5fT7/DCnA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6QYx86cB51720V6UkRlprwvTV5tG8Lswt+hwKPLnFMgjQQCn/nGn9ijngN6UZO0E
         tiwlwJOcZmJQMN38v6dIe5zlF2wBMxAChpGadryCPWzw3ud96VGYq6rAgQzp0GKCHz
         FddDgwEj0wiMdB77LuBleDU/GILcj5IfiJqcclms=
Date:   Thu, 9 Aug 2018 18:03:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 0/4] Add parameter for disabling ACS redirection for
 P2P
Message-ID: <20180809230332.GH113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730161840.13733-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730161840.13733-1-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:18:36AM -0600, Logan Gunthorpe wrote:
> Changes since v6:
> * Fixed order of operations for device specific disable function as
>   noticed by Alex
> * Rebased onto v4.18-rc5 (no conflicts)
> 
> Changes since v5:
> * Add a quirk to handle the Intel SPT PCH case (as pointed out by Alex)
> * Warn in the case that we try to disable ACS redirect on a device
>   that doesn't have the ACS capability (also suggested by Alex)
> * Collect reviewed-by tag from Alex
> * Rebased onto v4.18-rc4 (no conflicts)
> 
> Changes since v4:
> * Fixed a couple documentation mistakes spotted by Randy
> 
> Changes since v3:
> * Removed some of the cruft that was copied from the resource_alignment
>   paramater (per Alex)
> * A number of docuemntation fixes as noticed by Alex and Willy
> 
> Changes since v2:
> * Rebased onto v4.18-rc1 (no conflicts)
> * Minor tweaks to the documentation per Andy
> * Removed the "path:" prefix and use the path parsing code
>   for simple devices (as it works the same). Per a suggestion from Alex
> 
> Changes since v1:
> * Reworked pci_dev_str_match_path using strrchr as suggested by Alex
> * Collected Christian's Acks
> 
> 
> Logan Gunthorpe (4):
>   PCI: Make specifying PCI devices in kernel parameters reusable
>   PCI: Allow specifying devices using a base bus and path of devfns
>   PCI: Introduce disable_acs_redir quirk
>   PCI: Introduce the disable_acs_redir parameter
> 
>  Documentation/admin-guide/kernel-parameters.txt |  41 +++-
>  drivers/pci/pci.c                               | 310 +++++++++++++++++++-----
>  drivers/pci/quirks.c                            |  78 +++++-
>  include/linux/pci.h                             |   5 +
>  4 files changed, 361 insertions(+), 73 deletions(-)

I reorganized this a bit and split the quirk code into a couple
patches an put the result on my pci/peer-to-peer branch for v4.19.

I think the result is equivalent, but let me know if I made a mistake.

Bjorn
