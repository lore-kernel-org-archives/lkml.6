Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5AAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439B2253F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXL9ENka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439B2253F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeGBNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeGBNTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:19:25 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2DB2154C;
        Mon,  2 Jul 2018 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530537564;
        bh=GkXS6+YoD3lJWCoyDMzFG0WFb9c1x9rm7mnG+MQD1zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXL9ENkax/jE7XE0Y2rLt30S46KY3G0ixQQ8yGvMtZiaLDCLx+uCxr6Bh92Ygl2B2
         9KU9394sD4A4DFZTDYxoEPxUQ247kwd/YdE0IYxVz4e/NJso6tasta1NhMVKP9a8+K
         BZp6UQ6UTs8zOkrpv9kgvBtZL0JW7r8oqNgPzgqk=
Date:   Mon, 2 Jul 2018 08:19:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619195835.5423-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
> According to the documentation, "pcie_ports=native", linux should use
> native AER and DPC services. While that is true for the _OSC method
> parsing, this is not the only place that is checked. Should the HEST
> table list PCIe ports as firmware-first, linux will not use native
> services.
> 
> This happens because aer_acpi_firmware_first() doesn't take
> 'pcie_ports' into account. This is wrong. DPC uses the same logic when
> it decides whether to load or not, so fixing this also fixes DPC not
> loading.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Changes since v1:
>  - Re-tested with latest and greatest (v4.18-rc1) -- works great
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..98ced0f7c850 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -291,7 +291,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  
>  	rc = apei_hest_parse(aer_hest_parse, &info);
>  
> -	if (rc)
> +	if (rc || pcie_ports_native)
>  		pci_dev->__aer_firmware_first = 0;
>  	else
>  		pci_dev->__aer_firmware_first = info.firmware_first;
> @@ -327,6 +327,9 @@ bool aer_acpi_firmware_first(void)
>  		apei_hest_parse(aer_hest_parse, &info);
>  		aer_firmware_first = info.firmware_first;
>  		parsed = true;
> +		if (pcie_ports_native)
> +			aer_firmware_first = 0;

Trivial comment for both of these hunks: if we test for
pcie_ports_native *first*, we won't have to run apei_hest_parse().
It's fairly obvious that we ignore the result of apei_hest_parse()
anyway, but I think it's a courtesy to the reader if we don't run it
at all, so we don't have to worry about side effects.

> +
>  	}
>  	return aer_firmware_first;
>  }
> -- 
> 2.14.3
> 
