Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E207AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CF321E17
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CF321E17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeHJCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:54:41 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:55515 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbeHJCyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:54:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 61BCA1800E8C9;
        Fri, 10 Aug 2018 00:27:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sail25_7a37f512d0543
X-Filterd-Recvd-Size: 2408
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Aug 2018 00:27:19 +0000 (UTC)
Message-ID: <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
From:   Joe Perches <joe@perches.com>
To:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 09 Aug 2018 17:27:18 -0700
In-Reply-To: <1533840383-7841-1-git-send-email-okaya@kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 18:46 +0000, Sinan Kaya wrote:
> If _OSC execution fails today for platforms without an _OSC
> entry, code is printing a misleading message saying disabling
> ASPM as follows:
> 
> acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> 
> We need to ensure that platform supports ASPM to begin with.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/acpi/pci_root.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
[]
> @@ -455,8 +455,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	decode_osc_support(root, "OS supports", support);
>  	status = acpi_pci_osc_support(root, support);
>  	if (ACPI_FAILURE(status)) {
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			 acpi_format_exception(status));
> +		char *aspm_msg = "";
> +
> +		if (pcie_aspm_support_enabled())
> +			aspm_msg = "; disabling ASPM";
> +
> +		dev_info(&device->dev, "_OSC failed (%s) %s\n",
> +				 acpi_format_exception(status), aspm_msg);

I think this would read better not using a temporary and
using a ternary instead.

		dev_info(&device->dev, "_OSC failed (%s)%s\n",
			 acpi_format_exception(status),
			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");

>  		*no_aspm = 1;
>  		return;
>  	}
