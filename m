Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898C2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0898C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH1UhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:37:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1UhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955EA80D;
        Tue, 28 Aug 2018 09:44:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66A413F5BD;
        Tue, 28 Aug 2018 09:44:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F1B4F1AE311D; Tue, 28 Aug 2018 17:45:00 +0100 (BST)
Date:   Tue, 28 Aug 2018 17:45:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] arm64: PCI: Remove node-local allocations when
 initialising host controller
Message-ID: <20180828164449.GB19825@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
 <20180828150513.32458-2-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828150513.32458-2-punit.agrawal@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:05:12PM +0100, Punit Agrawal wrote:
> Memory for host controller data structures is allocated local to the
> node to which the controller is associated with. This has been the
> behaviour since support for ACPI was added in
> commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
> 
> Drop the node local allocation as there is no benefit from doing so -
> the usage of these structures is independent from where the controller
> is located.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 0e2ea1c78542..bb85e2f4603f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> -	int node = acpi_get_node(root->device->handle);
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
>  
> -	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
>  		return NULL;
>  
> -	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> +	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
>  	if (!root_ops) {
>  		kfree(ri);
>  		return NULL;
> -- 
> 2.18.0
> 
