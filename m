Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0DC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE20251CA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg6M9fBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE20251CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeF3Vbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 17:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeF3Vbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 17:31:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED6324094;
        Sat, 30 Jun 2018 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530394302;
        bh=aV5Ioz4+RwQU5/5Xf4M7DQbDJ7Jo8Z5z+38CO5PwwHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg6M9fBgIjYOLyOuupS0NJrkjcn175ZiGfo8P9IRKaV91RcuTugps4wtwEEfMGpo4
         iwj6YfDR6kCwD/67gNu8v8eJjZ0jM71gWsEkjdrrAMY25oVScdIgY3DxJxVuaeDY4H
         V2pglhEvzduZqBzhEXokbnUXN9D86qjMlhaJFdbk=
Date:   Sat, 30 Jun 2018 16:31:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
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

[+cc Borislav, linux-acpi, since this involves APEI/HEST]

On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
> According to the documentation, "pcie_ports=native", linux should use
> native AER and DPC services. While that is true for the _OSC method
> parsing, this is not the only place that is checked. Should the HEST
> table list PCIe ports as firmware-first, linux will not use native
> services.

Nothing in ACPI-land looks at pcie_ports_native.  How should ACPI
things work in the "pcie_ports=native" case?  I guess we still have to
expect to receive error records from the firmware, because it may
certainly send us non-PCI errors (machine checks, etc) and maybe even
some PCI errors (even if the Linux AER driver claims AER interrupts,
we don't know what notification mechanisms the firmware may be using).

I guess best-case, we'll get ACPI error records for all non-PCI
things, and the Linux AER driver will see all the AER errors.
Worst-case, I don't really know what to expect.  Duplicate reporting
of AER errors via firmware and Linux AER driver?  Some kind of
confusion about who acknowledges and clears them?

Out of curiosity, what is your use case for "pcie_ports=native"?
Presumably there's something that works better when using it, and
things work even *better* with this patch?

I know people do use it, because I often see it mentioned in forums
and bug reports, but I really don't expect it to work very well
because we're ignoring the usage model the firmware is designed
around.  My unproven suspicion is that most uses are in the black
magic category of "there's a bug here, and we don't know how to fix
it, but pcie_ports=native makes it work better".

Obviously I would much rather find and fix those bugs so people
wouldn't have to stumble over the problem in the first place.

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
> +
>  	}
>  	return aer_firmware_first;
>  }
> -- 
> 2.14.3
> 
