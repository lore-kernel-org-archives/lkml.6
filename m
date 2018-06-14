Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9530CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563B4208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563B4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936363AbeFNOuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936323AbeFNOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36E0A6146A;
        Thu, 14 Jun 2018 14:50:18 +0000 (UTC)
Received: from w520.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB2935988E;
        Thu, 14 Jun 2018 14:50:15 +0000 (UTC)
Date:   Thu, 14 Jun 2018 08:50:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: Requirement to get BAR pci_bus_address in user space
Message-ID: <20180614085015.3f39b367@w520.home>
In-Reply-To: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
        <20180614102001.GA20836@lst.de>
        <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
        <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
        <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 14 Jun 2018 14:50:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 16:18:15 +0530
Srinath Mannam <srinath.mannam@broadcom.com> wrote:

> Hi Sinan Kaya,
> 
> Here are the details,
> 
> The issue is, For CMB cards SQs are allocated inside device BAR memory
> which is different from normal cards.
> In Normal cards SQ memory allocated at host side.
> In both the cases physical address of CQ memory is programmed in NVMe
> controller register.
> This method works for normal cards because CQ memory is at host side.
> But in CMB cards pci bus address equivalent to CQ memory needs to program.
> 
> More details are in the patch: nvme-pci: Use PCI bus address for
> data/queues in CMB.
> 
> With the above patch issue is fixed in the NVMe kernel driver, But
> similar fix is required in SPDK library also.
> So, We need a mechanism to get pci_bus_address in user space libraries
> to address this issue.

I don't understand the CQ vs CMB, but I think I gather that there's some
sort of buffer that's allocated from within the devices MMIO BAR and
some programming of the device needs to reference that buffer.
Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
the BAR into the IOVA address space and you can then use the IOVA +
offset into the BAR for the device to reference the buffer?  It seems
this is the same way we'd setup a peer-to-peer mapping, but we're using
it for the device to reference itself effectively.  Thanks,

Alex
