Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837CB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zmtorP9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837CB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeGWXOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbeGWXOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:14:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F26420852;
        Mon, 23 Jul 2018 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532383890;
        bh=Wdm50P1xvTxdjHlqcjGYz8EGxsFDLpIJI8lhSnJjQcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmtorP9NwRgwKiQHO1K8lvFWwBr5adEq2HGunDAuPwTB19Rjieo+BYDOy7NQnux6f
         H0JkR+TIs8PJtY+3bsAToxfIXnGQFFb7omkEmj50KLbEglCbvJBIM7wC8FFCSN0c8v
         5kk75VlBx752u6hSXxRfcojiwFRxXA2qarW/4VwI=
Date:   Mon, 23 Jul 2018 17:11:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/probe: Move variable bridge inside ifdef
Message-ID: <20180723221129.GW128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180721214556.25651-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180721214556.25651-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 11:45:56PM +0200, Anders Roxell wrote:
> When CONFIG_PCI_QUIRKS isn't enabled we get the warning below:
> drivers/pci/probe.c: In function ‘pci_bus_read_dev_vendor_id’:
> drivers/pci/probe.c:2221:18: warning: unused variable ‘bridge’ [-Wunused-variable]
>   struct pci_dev *bridge = bus->self;
>                   ^~~~~~
> 
> Move the declaration of variable bridge to inside the ifdef
> CONFIG_PCI_QUIRKS.
> 
> Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I folded this into the original commit on pci/enumeration, thanks!

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c581346c5b9..7a5323798312 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  				int timeout)
>  {
> +#ifdef CONFIG_PCI_QUIRKS
>  	struct pci_dev *bridge = bus->self;
>  
> -#ifdef CONFIG_PCI_QUIRKS
>  	/*
>  	 * Certain IDT switches have an issue where they improperly trigger
>  	 * ACS Source Validation errors on completions for config reads.
> -- 
> 2.18.0
> 
