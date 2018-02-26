Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeBZSXD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbeBZSXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:23:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A3021719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 26 Feb 2018 12:22:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 0/2] pci: endpoint: Fix double free in pci_epf_create()
Message-ID: <20180226182259.GD25159@bhelgaas-glaptop.roam.corp.google.com>
References: <20180226171617.10016-1-embedded24@evers-fischer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226171617.10016-1-embedded24@evers-fischer.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 06:16:15PM +0100, Rolf Evers-Fischer wrote:
> This is version 2 of a patchset to avoid double free in function
> 'pci_epf_create()'.
> 
> When I accidentally created a new endpoint device with an empty name,
> the kernel warned about "attempted to be registered with empty name!"
> and crashed afterwards.
> 
> It turned out that the crash was not caused by the 'device_add()'
> function itself, but by a double kfree of 'epf->name' and 'epf'.
> 
> The first patch just simplifies the code, while the second patch
> fixes the problem.
> 
> Changes in v2:
> - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> - Change IDs removed
> - First patch completely reworked in order to eliminate the
>   need for the second 'kstrdup' allocation and the 'kfree' of
>   the first allocation.
>   It was tested with name="pci_epf_test.0" and name="pci_epb":
>   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
> 
> Rolf Evers-Fischer (2):
>   pci: endpoint: Simplify name allocation for epf device
>   pci: endpoint: Fix kernel panic after put_device()

$ git log --oneline --no-merges drivers/pci/endpoint/
fc41df28f89e PCI: endpoint: Fix EPF device name to support multi-function devices
4494738de0d9 PCI: endpoint: Add the function number as argument to EPC ops
b330104fa76d PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()
35ad61921f49 PCI: endpoint: Fix find_first_zero_bit() usage
0c47cd7a9b6c PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
...

Please make yours match.
