Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD2C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2337520663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359109;
	bh=cNspcHC6ZcAmA8AA1+aF4uSP33/ftN6Tcz9z2UT04jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uvivwb2K9z/0oJCg86owk6aCTwN67DeAgFVjaDV4ob7o5ZbKnAw+CD6FNIWw2creF
	 gG/bWU84PFBSnzrLnLl93VbSVMmaEW2rG87fVxS9MtgtI4NpSh071x/pmu7aQLOamm
	 rGjRcfMCLY1IeljYrlYM12alvPKGhOJPUnmYjveg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfAXTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388173AbfAXTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:45:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568CA218D2;
        Thu, 24 Jan 2019 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359103;
        bh=cNspcHC6ZcAmA8AA1+aF4uSP33/ftN6Tcz9z2UT04jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDymnMA5ZWysP3UhwBxnHvIQpwqGnFs1L8a49sQrL0wQgFE7Pk85Po2cIZASDmoeC
         +QIjljwE1uJrPzlPv7e980y/ktK0flPH7H16QsPGzXQa1pvau2EmYuus1i+kkg9g3d
         eWWF/fYuF+411Q7EZR1zSgGfhcfncoksnDug8Ako=
Date:   Thu, 24 Jan 2019 20:35:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ACPI: debug: Clean up acpi_aml_init()
Message-ID: <20190124193547.GA13425@kroah.com>
References: <2715517.7WDaClUie6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2715517.7WDaClUie6@aspire.rjw.lan>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:25:59AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The err_exit label in acpi_aml_init() is not used any more after
> commit 9ec6dbfbdc0a ("ACPI: no need to check return value of
> debugfs_create functions"), but the other label in there is not
> necessary too, so rearrange the code to get rid of them both.
> 
> No intentional functional impact.
> 
> Fixes: 9ec6dbfbdc0a ("ACPI: no need to check return value of debugfs_create functions")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_dbg.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_dbg.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_dbg.c
> +++ linux-pm/drivers/acpi/acpi_dbg.c
> @@ -750,29 +750,28 @@ static const struct acpi_debugger_ops ac
>  
>  int __init acpi_aml_init(void)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	/* Initialize AML IO interface */
>  	mutex_init(&acpi_aml_io.lock);
>  	init_waitqueue_head(&acpi_aml_io.wait);
>  	acpi_aml_io.out_crc.buf = acpi_aml_io.out_buf;
>  	acpi_aml_io.in_crc.buf = acpi_aml_io.in_buf;
> +
>  	acpi_aml_dentry = debugfs_create_file("acpidbg",
>  					      S_IFREG | S_IRUGO | S_IWUSR,
>  					      acpi_debugfs_dir, NULL,
>  					      &acpi_aml_operations);
> -	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
> -	if (ret)
> -		goto err_fs;
> -	acpi_aml_initialized = true;
>  
> -err_fs:
> +	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
>  	if (ret) {
>  		debugfs_remove(acpi_aml_dentry);
>  		acpi_aml_dentry = NULL;
> +		return ret;
>  	}
> -err_exit:
> -	return ret;
> +
> +	acpi_aml_initialized = true;
> +	return 0;
>  }
>  

Odd that 0-day never reported this :(

Sorry about it, and thanks for the patch:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
