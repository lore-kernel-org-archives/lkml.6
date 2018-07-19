Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981EAECDFB4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qwvf5Rzj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SspuwOKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeGSEeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:34:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeGSEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:34:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4448D60481; Thu, 19 Jul 2018 03:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531972428;
        bh=z3B8kmwzoEPkyawhET2X0o8s6vlc60hReJBzgB6qZKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qwvf5Rzjig1aPz8w3KyNH5WuQ6alfjcLIL0h6hveM1i48mIrpZVtqpNHyr4fSaxni
         Cfg8R5spQwkNeZ/Jb/KRichcakHf5pE20176sW31N0vmN36HKBBvmi8aVG77lcN3Mc
         NSuH6LAIlQ+ICoWhdsW4HG2K/RP67OOb7dNLc2Bw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 592E260481;
        Thu, 19 Jul 2018 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531972427;
        bh=z3B8kmwzoEPkyawhET2X0o8s6vlc60hReJBzgB6qZKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SspuwOKYc2wNbj+1DbzaRo1oQiy3yplhSTTrStURyR13rxzxBP++U+X5RnUl8oyFD
         npTnV568qAiuCzQBSnry4s1eLuFStI12+ZZyj0lg+ry1oMl4I9fVGcZfvj1xapKP4T
         HBrfIPAW0AmM+CQfGhMIc9/0XJEOx7zg6k3oTW0k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Jul 2018 09:23:47 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <35f60c57a8e8fe9503d63a62fd4776bf@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 01:14, Bjorn Helgaas wrote:
> This is a v3 of Oza's patches [1].  It's available at [2] if you prefer
> git.
> 
> v3 changes:
>   - Add pci_aer_clear_fatal_status() to clear ERR_FATAL bits, only 
> called
>     from pcie_do_fatal_recovery().  Moved to first in series to avoid a
>     window where ERR_FATAL recovery only clears ERR_NONFATAL bits.  
> Visible
>     only inside the PCI core.
>   - Instead of having pci_cleanup_aer_uncorrect_error_status() do 
> different
>     things based on dev->error_state, use this only for ERR_NONFATAL 
> bits.
>     I didn't change the name because it's used by many drivers.
>   - Rename pci_cleanup_aer_error_device_status() to
>     pci_aer_clear_device_status(), make it void, and make it visible 
> only
>     inside the PCI core.
>   - Remove pcie_portdrv_err_handler.slot_reset altogether instead of 
> making
>     it a stub function.  Possibly pcie_portdrv_err_handler could be 
> removed
>     completely?
> 
> [1]
> https://lkml.kernel.org/r/1529661494-20936-1-git-send-email-poza@codeaurora.org
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/06-22-oza-aer
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI/AER: Clear only ERR_FATAL status bits during fatal recovery
> 
> Oza Pawandeep (6):
>       PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
>       PCI/AER: Factor out ERR_NONFATAL status bit clearing
>       PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
>       PCI/AER: Clear device status bits during ERR_FATAL and 
> ERR_NONFATAL
>       PCI/AER: Clear device status bits during ERR_COR handling
>       PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset
> 
> 
>  drivers/pci/pci.h              |    5 ++++
>  drivers/pci/pcie/aer.c         |   47 
> +++++++++++++++++++++++++++-------------
>  drivers/pci/pcie/err.c         |   15 +++++--------
>  drivers/pci/pcie/portdrv_pci.c |   25 ---------------------
>  4 files changed, 43 insertions(+), 49 deletions(-)

looks good to me.
Thanks for the corrections.
some x86 compilation errors, you want me to to fix it and push v4 ?

Regards,
Oza.





