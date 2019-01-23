Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C632184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548261137;
	bh=1BDIS6KXx9yzhx3iZaDJM4GCMAdD+MohMdr82FfajPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eWYb6Iy8j1Lk0jiKE5vomEXDooYPjKCDyHd+qwHlf7hG9VtGiUTq48fbeEai8tpHq
	 cjdIy1gcmdkrIuYNvB5KmXUcuQ0Ui6KvDGeZYEw0Pl0q2EiLqbaYkJg416Pe+ocXCs
	 /HgfvmNevgK4djCyz0N/KCdD7MSzGrPzXQ2VgKU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfAWQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfAWQcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:32:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2616B217D4;
        Wed, 23 Jan 2019 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548261133;
        bh=1BDIS6KXx9yzhx3iZaDJM4GCMAdD+MohMdr82FfajPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVMA+P7UjtQTDSLDVnRR97LBRoVzrbAi+7tdyCf7qbqVTg0Rg+ckdtGbvHKnoX695
         mU2DNIAnUbRTi+BBi7q9QgY60MhyqFEsE0tE3NCoD9nQnF/hnXVlgMyGirUuWyN/vz
         ddjFPmRecXH1sj5BdqgBeyHglUczzQBZyJBCoTg8=
Date:   Wed, 23 Jan 2019 17:32:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     stable@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, it+lkml@molgen.mpg.de
Subject: Re: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
Message-ID: <20190123163211.GA31955@kroah.com>
References: <8520014d-6805-ce87-143d-fffbeb94d11d@molgen.mpg.de>
 <78de72f8-e218-f91f-97b2-768ff5a920e4@acm.org>
 <9ca94005-e2e4-cd5a-67bd-30c3d8680281@molgen.mpg.de>
 <fe18b975-a577-8b09-c1cc-488356fc60a7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe18b975-a577-8b09-c1cc-488356fc60a7@molgen.mpg.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:27:51PM +0100, Paul Menzel wrote:
> From: Corey Minyard <cminyard@mvista.com>
> Date: Thu, 15 Feb 2018 16:58:26 -0600
> 
> [ upstream commit bc48fa1b9d3b04106055b27078da824cd209865a ]
> 
> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
> KCS controller, but whatever it is, it's not one.  Ignore it if seen.
> 
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Daniel Drake <drake@endlessm.com>
> 
> [ Commit 13d0b35c (ipmi_si: Move PCI setup to another file) from Linux
>   4.15-rc1 has not been back ported, so the PCI code is still in
>   `drivers/char/ipmi/ipmi_si_intf.c`, requiring to apply the commit
>   manually.
> 
>   This fixes a 100 s boot delay on the HP EliteDesk 705 G4 MT with Linux
>   4.14.94. ]
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index c04aa11f0e21..6d18f8090cea 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2447,6 +2447,15 @@ static int ipmi_pci_probe_regspacing(struct smi_info *info)
>  	return DEFAULT_REGSPACING;
>  }
>  
> +static struct pci_device_id ipmi_pci_blacklist[] = {
> +        /*
> +         * This is a "Virtual IPMI device", whatever that is.  It appears
> +         * as a KCS device by the class, but it is not one.
> +         */
> +        { PCI_VDEVICE(REALTEK, 0x816c) },
> +        { 0, }
> +};
> +
>  static int ipmi_pci_probe(struct pci_dev *pdev,
>  				    const struct pci_device_id *ent)
>  {
> @@ -2454,6 +2463,9 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
>  	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
>  	struct smi_info *info;
>  
> +        if (pci_match_id(ipmi_pci_blacklist, pdev))
> +                return -ENODEV;
> +

Your patch does not have tabs where it should have tabs :(

Can you fix this up and resend?

thanks,

greg k-h
