Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeDWH5D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:57:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeDWH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:56:55 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>, Keith Busch <keith.busch@intel.com>,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Tighten up ASPM L1.2 and LTR usage
Date: Mon, 23 Apr 2018 09:56:46 +0200
Message-ID: <7042555.G8Gd07mvkX@aspire.rjw.lan>
In-Reply-To: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 19, 2018 11:05:19 PM CEST Bjorn Helgaas wrote:
> The ASPM L1.2 substate depends on LTR information.  Per the PCI
> Firmware spec, the OS is supposed to negotiate with the platform for
> control of the LTR feature, but previously we didn't do that.
> 
> In addition, we must not enable LTR in an endpoint unless the Root
> Complex and all intermediate switches also support LTR.  We already
> took care of that in pci_configure_ltr(), but we didn't ensure that
> LTR was enabled before allowing ASPM L1.2 to be enabled.
> 
> These patches fix both of these issues.  Or rather, they *should* fix
> them.  I don't have hardware to test them, so any help with testing
> would be appreciated.
> 
> I think the most likely issue would be a platform where the hardware
> supports LTR and the ASPM L1.2 substate, but the BIOS doesn't support
> LTR in _OSC.  In that case, we previously could have enabled ASPM L1.2
> (though it probably wouldn't work correctly), and after these patches,
> we should not enable ASPM L1.2.
> 
> You can look for issues by comparing dmesg and "lspci -vv" output
> before and after these patches.
> 
> It would also be interesting to collect an acpidump from platforms
> that support LTR, even if there's no endpoint that supports ASPM L1.2.
> The acpidump should show that _OSC supports LTR.
> 
> I included some NVMe folks because these were motivated by Srinath's
> recent report of LTR and ASPM issues with a Samsung NVMe SSD
> Controller SM961/PM961 device, so this is sort of FYI in case you see
> similar issues or are in a position to test these.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR
>       PCI/ACPI: Request LTR control from platform before using it

For both:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
