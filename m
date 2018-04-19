Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeDSU0h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:26:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56123 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDSU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:26:34 -0400
X-Google-Smtp-Source: AIpwx4/Si6dA5Vj5SCIb+Xg/C8Xv8SxaiFLYlVMHIvbPPg6Un4YriRLtIvsBZTFzxWLCBERpXu4bWA==
Date: Thu, 19 Apr 2018 14:26:32 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Message-ID: <20180419202632.GE14063@ziepe.ca>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:56:23PM -0400, Sinan Kaya wrote:
> The infiniband adapter might be connected to a PCI hotplug slot. Performing
> secondary bus reset on a hotplug slot causes PCI link up/down interrupts.
> 
> Hotplug driver removes the device from system when a link down interrupt
> is observed and performs re-enumeration when link up interrupt is observed.
> 
> This conflicts with what this code is trying to do. Try secondary bus reset
> only if pci_reset_slot() fails/unsupported.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>  drivers/infiniband/hw/hfi1/pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 83d66e8..75f49e3 100644
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -908,7 +908,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)

The code above this hunk is:

/*
 * Trigger a secondary bus reset (SBR) on ourselves using our parent.
 *
 * Based on pci_parent_bus_reset() which is not exported by the
 * kernel core.
 */
static int trigger_sbr(struct hfi1_devdata *dd)
{

[..]

This really seems like something the PCI core should be helping with,
drivers shouldn't be doing stuff like this. I get the feeling this
should be a common need if drivers support various error recovery
schemes?

Bjorn, would be appropriate to export pci_parent_bus_reset() or some
variation therin??

Thanks,
Jason
