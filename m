Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeGXR0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388319AbeGXR0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D64D83084038;
        Tue, 24 Jul 2018 16:18:50 +0000 (UTC)
Received: from t450s.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98984100164C;
        Tue, 24 Jul 2018 16:18:50 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:18:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
Message-ID: <20180724101849.36f635eb@t450s.home>
In-Reply-To: <20180724161446.2729.78211.stgit@gimli.home>
References: <20180724160440.2729.75178.stgit@gimli.home>
        <20180724161446.2729.78211.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 24 Jul 2018 16:18:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 10:14:46 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Add a device specific reset for Intel DC P3700 NVMe device which
> exhibits a timeout failure in drivers waiting for the ready status to
> update after NVMe enable if the driver interacts with the device too
> quickly after FLR.  As this has been observed in device assignment
> scenarios, resolve this with a device specific reset quirk to add an
> additional, heuristically determined, delay after the FLR completes.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

I forgot to link the bz in this one, if this somehow becomes the final
version, please add:

Link: https://bugzilla.redhat.com/show_bug.cgi?id=159265

Thanks,
Alex
 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3899cdd2514b..08fafd804588 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3751,6 +3751,27 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/*
> + * Intel DC P3700 NVMe controller will timeout waiting for ready status
> + * to change after NVMe enable if the driver starts interacting with the
> + * device too quickly after FLR.  A 250ms delay after FLR has heuristically
> + * proven to produce reliably working results for device assignment cases.
> + */
> +static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> +{
> +	if (!pcie_has_flr(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	pcie_flr(dev);
> +
> +	msleep(250);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3759,6 +3780,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
> +	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
>  	{ 0 }
> 

