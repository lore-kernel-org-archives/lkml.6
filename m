Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD18ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42B2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWiyagfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B42B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeIRCW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRCW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:22:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99132206B2;
        Mon, 17 Sep 2018 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537217635;
        bh=2T+rkmWwuu4N0+cZBNvGNXTvuCYiUxqEoEXRwUJVfHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWiyagfdcQeL9yu7OURCU199TnFCr7v92efbTBAVKFMj6m/D9VPEsT3mV5OZEL89v
         F8yTAR5oICfSqD4mwt8GxOwpS4nDn54x12KqoqpcPkpxYp0MgXfKBctChF34xTP4Nw
         4wQ56CIKlrN0iRfibqJcaLApzrj8igP6/paOgPok=
Date:   Mon, 17 Sep 2018 15:53:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v2] PCI hotplug Eq v2
Message-ID: <20180917205354.GB54859@bhelgaas-glaptop.roam.corp.google.com>
References: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:11:59PM -0600, Jon Derrick wrote:
> Hi Bjorn,
> 
> Sorry for the delay on this one and pushing it after RC1.
> Feel free to queue it up for 4.20 if it looks fine.
> 
> I've added comments to the git log and source explaining why
> calculate_iosize was left unchanged. Basically I could not
> synthesize a condition where it would have affected the topology.

In other words, the only reason you didn't change the
calculate_iosize() path was because you couldn't test it?

I appreciate your desire to avoid untested changes, but I think it's
very important to preserve and even improve the symmetry between
calculate_memsize() and calculate_iosize().  For example, it's not
obvious why the order is different here:

  calculate_iosize():
    size = ALIGN(size + size1, align);
    if (size < old_size)
      size = old_size;

  calculate_memsize():
    if (size < old_size)
      size = old_size;
    size = ALIGN(size + size1, align);

So I don't want to diverge them further unless there's a real
functional reason why we need to handle I/O port space differently
than MMIO space.

You've tested the MMIO path, and I'm willing to take the risk of
doing the same thing in the I/O port path.

Bjorn
