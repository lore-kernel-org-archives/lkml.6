Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9D6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81CC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkt+yX3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81CC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJIP7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIP7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:59:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAFAD2077C;
        Tue,  9 Oct 2018 08:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539074605;
        bh=o/644yRZQRpN354jO8KSkPc5xsxYxJiNUOAweXR8axE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkt+yX3DfPjcbpvhBA55IWD3VFQT8p55YOR+CZ0X4iYc0rZ7eeToeLJLzR9pnwys0
         jh0lAtA+r45LYJKnXMlVguqJ26uOeqJrX3ngPNTNpffEnPAUi2o/vMphI4vM9hibDu
         5ZQWbYOdszhOKw3Asp93nseJEq3Mno3YTIVP1f1k=
Date:   Tue, 9 Oct 2018 10:43:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jorgen S. Hansen" <jhansen@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        pv-drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH] VMCI: Resource wildcard match fixed
Message-ID: <20181009084322.GB16199@kroah.com>
References: <20180921073105.5758-1-jhansen@vmware.com>
 <20181002223502.GA31116@kroah.com>
 <A99A1956-D875-4E55-A344-ED1F3B4FD1E5@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A99A1956-D875-4E55-A344-ED1F3B4FD1E5@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 08:27:41AM +0000, Jorgen S. Hansen wrote:
> 
> 
> On 3 Oct 2018, at 00:35, Greg KH <gregkh@linuxfoundation.org<mailto:gregkh@linuxfoundation.org>> wrote:
> 
> On Fri, Sep 21, 2018 at 12:31:05AM -0700, Jorgen Hansen wrote:
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
> Reported-by: Hangbin Liu <liuhangbin@gmail.com<mailto:liuhangbin@gmail.com>>
> Reviewed-by: Adit Ranadive <aditr@vmware.com<mailto:aditr@vmware.com>>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com<mailto:vdasa@vmware.com>>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com<mailto:jhansen@vmware.com>>
> ---
> drivers/misc/vmw_vmci/vmci_driver.c   | 2 +-
> drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
> 2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
> index d7eaf1eb11e7..003bfba40758 100644
> --- a/drivers/misc/vmw_vmci/vmci_driver.c
> +++ b/drivers/misc/vmw_vmci/vmci_driver.c
> @@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
> 
> MODULE_AUTHOR("VMware, Inc.");
> MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
> -MODULE_VERSION("1.1.5.0-k");
> +MODULE_VERSION("1.1.6.0-k");
> MODULE_LICENSE("GPL v2");
> 
> You do know MODULE_VERSION means nothing, right?  Please just remove it.
> 
> Sure. Do you want a new version of this patch with it removed ? (The reason for asking is that I already got a couple of notifications about the patch being added to char-misc and char-misc-next).

Just send a follow-on patch that removes it please.

thanks,

greg k-h
