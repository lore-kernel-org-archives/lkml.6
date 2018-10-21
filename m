Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7BC67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 02:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA972174D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 02:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA972174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJUKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 06:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeJUKja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 06:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 219C281DE5;
        Sun, 21 Oct 2018 02:26:55 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15F9F75537;
        Sun, 21 Oct 2018 02:26:53 +0000 (UTC)
Date:   Sun, 21 Oct 2018 10:26:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v9 5/8] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181021022650.GI1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-6-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017102012.872-6-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 21 Oct 2018 02:26:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 at 06:20pm, Chao Fan wrote:
> If KEXEC write the RSDP pointer to cmdline, parse the cmdline
> and use it.
> Imitate from early_param of "acpi_rsdp".
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> index 50fa65cf824d..37b1f4407be8 100644
> --- a/arch/x86/boot/compressed/acpitb.c
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -8,6 +8,9 @@
>  #include <linux/numa.h>
>  #include <linux/acpi.h>
>  
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
>  /* Search EFI table for RSDP table. */
>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  {
> @@ -200,3 +203,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>  		*rsdp_addr = (acpi_physical_address)address;
>  	}
>  }
> +
> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
> +{
> +#ifdef CONFIG_KEXEC
> +	unsigned long long res;
> +	int len = 0;
> +	char *val;
> +
> +	val = malloc(20);

Why is the length 20? Defined a macro?

> +	len = cmdline_find_option("acpi_rsdp", val, 20);
> +
> +	if (len == -1)
> +		return;
> +
> +	if (len > 0) {
> +		val[len] = 0;
> +		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 0, &res);
> +	}
> +#endif
> +}
> -- 
> 2.17.2
> 
> 
> 
