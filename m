Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C82C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EA820666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeJCFUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:20:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeJCFUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:20:42 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 041BB1020;
        Tue,  2 Oct 2018 22:35:03 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:35:02 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH] VMCI: Resource wildcard match fixed
Message-ID: <20181002223502.GA31116@kroah.com>
References: <20180921073105.5758-1-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921073105.5758-1-jhansen@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:31:05AM -0700, Jorgen Hansen wrote:
> When adding a VMCI resource, the check for an existing entry
> would ignore that the new entry could be a wildcard. This could
> result in multiple resource entries that would match a given
> handle. One disastrous outcome of this is that the
> refcounting used to ensure that delayed callbacks for VMCI
> datagrams have run before the datagram is destroyed can be
> wrong, since the refcount could be increased on the duplicate
> entry. This in turn leads to a use after free bug. This issue
> was discovered by Hangbin Liu using KASAN and syzkaller.
> 
> Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_driver.c   | 2 +-
>  drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
> index d7eaf1eb11e7..003bfba40758 100644
> --- a/drivers/misc/vmw_vmci/vmci_driver.c
> +++ b/drivers/misc/vmw_vmci/vmci_driver.c
> @@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
>  
>  MODULE_AUTHOR("VMware, Inc.");
>  MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
> -MODULE_VERSION("1.1.5.0-k");
> +MODULE_VERSION("1.1.6.0-k");
>  MODULE_LICENSE("GPL v2");

You do know MODULE_VERSION means nothing, right?  Please just remove it.

thanks,

greg k-h
