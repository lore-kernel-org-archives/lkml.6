Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCURZ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:25:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbeCURZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:25:28 -0400
Subject: Re: Why two irq chips for MSI
To: valmiki <valmikibow@gmail.com>, linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
References: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <adf13928-d1da-e8af-5b32-efc199ac6ba9@arm.com>
Date: Wed, 21 Mar 2018 17:25:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/18 17:12, valmiki wrote:
> Hi,
> 
> In most of the RP drivers, why two irq chips are being used for MSI ?
> 
> One at irq_domain_set_info (which uses irq_compose_msi_msg and 
> irq_set_affinity methods) and another being registered with struct 
> msi_domain_info (which uses irq_mask/irq_unmask methods).
> 
> When will each chip be used w.r.t to virq ?

A simple way to think of it is that you have two pieces of HW involved:
an end-point that generates an interrupt, and a controller that receives it.

Transpose this to the kernel view of things: one chip implements the PCI
MSI, with the PCI semantics attached to it (how to program the
payload/doorbell into the end-point, for example). The other implements
the MSI controller part of it, talking to the HW that deals with the
interrupt.

Does it makes sense? Admittedly, this is not always that simple, but
that the general approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
