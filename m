Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C872075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0UBdtWud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C872075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGQWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbeGQWKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:10:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3037B206B8;
        Tue, 17 Jul 2018 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531863364;
        bh=CDcjd7SbHLYCfTvCU+qAr4k4diKnA3UPG9vqMfhZ7NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UBdtWudNNOVMkDgm0gDfWijaweRvwL4JF2BpTCguAWvPEjWDknBfcQzC/2SEceXs
         XAdbvQqzPct3N6AXPheebs8Iwd7/nwWTWcNJtq3kKhOgaFYaQvWHp/NFvVJtnDtEe1
         0ITbe7nDRz/0jafXMBU1Zfg7b8v489YCHD0+4dH0=
Date:   Tue, 17 Jul 2018 16:36:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oza Pawandeep <poza@codeaurora.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 1/6] PCI/AER: Take severity mask into account while
 clearing error bits
Message-ID: <20180717213601.GC128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
 <1529661494-20936-2-git-send-email-poza@codeaurora.org>
 <20180717190329.GA128988@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717190329.GA128988@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:03:29PM -0500, Bjorn Helgaas wrote:
> Hi Oza,
> 
> Thanks for doing this!
> 
> On Fri, Jun 22, 2018 at 05:58:09AM -0400, Oza Pawandeep wrote:
> > pci_cleanup_aer_uncorrect_error_status() is called by different slot_reset
> > callbacks in case of ERR_NONFATAL.
> 
> IIRC, the current strategy is:
> 
>   ERR_COR: log only
>   ERR_NONFATAL: call driver callbacks (pci_error_handlers)
>   ERR_FATAL: remove device and re-enumerate
> 
> So these slot_reset callbacks are only used for ERR_NONFATAL, which
> are all uncorrectable errors, of course.
> 
> This patch makes it so that when the slot_reset callbacks call
> pci_cleanup_aer_uncorrect_error_status(), we only clear the
> bits set by ERR_NONFATAL events (this is determined by
> PCI_ERR_UNCOR_SEVER).
> 
> That makes good sense to me.  All these status bits are RW1CS, so they
> will be preserved across a reset but will be cleared when we
> re-enumerate, in this path:
> 
>   pci_init_capabilities
>     pci_aer_init
>       pci_cleanup_aer_error_status_regs
>       # clear all PCI_ERR_UNCOR_STATUS and PCI_ERR_COR_STATUS bits
> 
> > AER uncorrectable error status should take severity into account in order
> > to clear the bits, so that ERR_NONFATAL path does not clear the bit which
> > are marked with severity fatal.
> 
> Two comments:
> 
> 1) Can you split this into two patches, one that changes
> pci_cleanup_aer_uncorrect_error_status() so it looks like the error
> clearing code in aer_error_resume(), and a second that factors out the
> duplicate code?
> 
> 2) Maybe use "sev" or "sever" instead of "mask" for the local
> variable, since there is also a separate PCI_ERR_UNCOR_MASK register,
> which is not involved here.

Let me back up a little here: I'm not asking you to do the things
below here.  They're just possible future things, so we can think
about them after this series.  And the things above are things I can
easily do myself.  So no action required from you, unless you think
I'm on the wrong track :)

> 3) The "pci_cleanup_aer_uncorrect_error_status()" name no longer
> really describes what this does.  Something like
> "pci_aer_clear_nonfatal_status()" would be more descriptive.  But I
> see you have a subsequent patch (which I haven't looked at yet) that
> is related to this.
> 
> 4) I don't think the driver slot_reset callbacks should be responsible
> for clearing these AER status bits.  Can we clear them somewhere in
> the pcie_do_nonfatal_recovery() path and remove these calls from the
> drivers?
> 
> 5) In principle, we should only read PCI_ERR_UNCOR_STATUS *once* per
> device when handling an error.  We currently read it three times:
> 
>   aer_isr
>     aer_isr_one_error
>       find_source_device
>         find_device_iter
>           is_error_source
>             read PCI_ERR_UNCOR_STATUS              # 1
>       aer_process_err_devices
>         get_device_error_info(e_info->dev[i])
>           read PCI_ERR_UNCOR_STATUS                # 2
>         handle_error_source
>           pcie_do_nonfatal_recovery
>             ...
>               report_slot_reset
>                 driver->err_handler->slot_reset
>                   pci_cleanup_aer_uncorrect_error_status
>                     read PCI_ERR_UNCOR_STATUS      # 3
> 
> OK, that was more than two comments :)
