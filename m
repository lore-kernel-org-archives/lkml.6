Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9EE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ohsRJja8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfARL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:26:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41052 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfARL0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:26:36 -0500
Received: from zn.tnic (p200300EC2BCB1B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A5321EC0573;
        Fri, 18 Jan 2019 12:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547810794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y1dNmCKWqwwtJDRAbEC9BU5YBAZMoZ0drcObkWF/4pg=;
        b=ohsRJja87jWpheRc0vmMU0/7Nh6HaWXN1UsHHoNU2WeTk4FihXzM7euDltsX2dU9gftk4K
        pDS+QocEq1hAy/HvMdQTnggpJS4ljJH+5Uj8rReGrB/F/x855D7JVXrGNbd9xhp9AQnGXN
        1mYDAinBOWgv3qI7Wf4eQZEwdl859ik=
Date:   Fri, 18 Jan 2019 12:26:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec
 usage
Message-ID: <20190118112628.GC622@zn.tnic>
References: <20190118111310.29589-1-kasong@redhat.com>
 <20190118111310.29589-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118111310.29589-3-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 07:13:09PM +0800, Kairui Song wrote:
> Currently we have acpi_os_get_root_pointer as the universal function
> to get RSDP address. But the function itself and some functions it
> depends on are in .init section and make it not easy to retrieve the
> RSDP value once kernel is initialized.
> 
> And for kexec, it need to retrive RSDP again if EFI is disabled, because
> the second kernel will not be able get the RSDP value in such case, so
> it expects either the user specify the RSDP value using kernel cmdline,
> or kexec could retrive and pass the RSDP value using boot_params.
> 
> This patch stores the RSDP address when initialized is done, and
> introduce an acpi_os_get_root_pointer_late for later kexec usage.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/acpi/osl.c   | 10 ++++++++++
>  include/linux/acpi.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f29e427d0d1d..6340d34d0df1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
>  	return kstrtoul(arg, 16, &acpi_rsdp);
>  }
>  early_param("acpi_rsdp", setup_acpi_rsdp);
> +
> +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> +	return acpi_rsdp;
> +}
> +
> +static int __init acpi_store_root_pointer(void) {
> +	acpi_rsdp = acpi_os_get_root_pointer();
> +	return 0;
> +}

No, this is getting completely nuts: there's a bunch of functions which
all end up returning boot_params's field except pvh_get_root_pointer().

And now you're adding a late variant. And the cmdline paramater
acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...

Wait until Chao Fan's stuff is applied, then do your changes ontop
an drop all that ifdeffery. We will make this RDSP thing enabled
unconditionally so that there's no need for ifdeffery and function
wrappers.

Also, after Chao's stuff, you won't need to call
acpi_os_get_root_pointer() because the early code would've done that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
