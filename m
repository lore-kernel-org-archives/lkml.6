Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21667C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588F208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JKaNLHAh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VmJwcDiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C588F208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeHBIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:23:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHBIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:23:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59D1C60B12; Thu,  2 Aug 2018 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533191657;
        bh=YjzwDaVx+IdtJKLDRVPKQBG2mNSCiWNoILooSu3HrH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JKaNLHAhTzafose24lzKkq5kLwWJCUXUd23sUVEDw6pPr9clSICJJNY2PK3PLI9bl
         ME64ONwy3Fhw9rUca19DhKxZYWYVB8a+NTTdKY5Q6YbjEbPxhwbTfpWdPMphxy2sAh
         0Nr2+RDVMdff3g7i1C98Qeif1F0L9krE22m/95bk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CEA276035F;
        Thu,  2 Aug 2018 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533191656;
        bh=YjzwDaVx+IdtJKLDRVPKQBG2mNSCiWNoILooSu3HrH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VmJwcDiD1rJOaflt+eQrQnRo/BVT+xjKCOF65nUCJ0z5xH09Jgy/shBJBUQ+9Guz5
         /UFm5DycSWxWW00zaqsNHl6PBbQf/UKG/gZc5MMh27FgGi/GzNANQrSC6y9OqfsN4D
         ibc1izknU9OeY5y8vTjIvfCzpMS0eIqiYQBkxT1U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 12:04:16 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] PCI/AER: Remove duplicate PCI_EXP_AER_FLAGS definition
In-Reply-To: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <b26226ae6c1d0a78f2ab1fac9894df7a@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 04:20, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI_EXP_AER_FLAGS was defined twice (with identical definitions), once
> under #ifdef CONFIG_ACPI_APEI, and again at the top level.  This looks 
> like
> my merge error from these commits:
> 
>   fd3362cb73de ("PCI/AER: Squash aerdrv_core.c into aerdrv.c")
>   41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
> 
> Remove the duplicate PCI_EXP_AER_FLAGS definition.
> 
> Fixes: 41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2b344c9e2d46..c6cc855bfa22 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -329,8 +329,6 @@ int pcie_aer_get_firmware_first(struct pci_dev 
> *dev)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
>  }
> -#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE 
> | \
> -				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
> 
>  static bool aer_firmware_first;


Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
