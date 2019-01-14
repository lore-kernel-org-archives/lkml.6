Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8C420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WUM9dg5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfANLI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:08:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58936 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfANLI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:08:58 -0500
Received: from zn.tnic (p200300EC2BC4CA00C95BD7F0398E53C6.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:c95b:d7f0:398e:53c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 184461EC0573;
        Mon, 14 Jan 2019 12:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547464136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EuWqxd+/tXhvJyusdux0s/5XBvPndcb6jfBwCp2vasE=;
        b=WUM9dg5KoDwRXyvRYRAgWKt2nO02fnRCSrk8auH8DH/mP/JW1V85Hzx3AHp+kJZHPQxs2e
        nUlDTYKaiAv/qUzKIkSNzUlmw4cxKzv4qYygLbkJXu38swtoaI0WYRxh6djShTPBEe9zep
        XSQNSgZKcxlRg53nZtGjyE3chfElq8o=
Date:   Mon, 14 Jan 2019 12:08:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/3] ACPI / LPSS: Get rid of custom ICPU() macro
Message-ID: <20190114110854.GK2773@zn.tnic>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
 <20190109165754.90072-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109165754.90072-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:57:53PM +0200, Andy Shevchenko wrote:
> Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5f94c35d165f..633a528bb6ea 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -311,11 +311,9 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
>  	.setup = lpss_deassert_reset,
>  };
>  
> -#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */

Sorry but the previous one was better: INTEL_FAM6_ATOM_SILVERMONT I can
find in the tree...

> -	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
> +	INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT),	/* Valleyview, Bay Trail */

For ATOM_SILVERMONT I find different things:

INTEL_CPU_FAM6(ATOM_SILVERMONT
X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT
ICPU(INTEL_FAM6_ATOM_SILVERMONT
...

so you guys need to sit down and agree on a single form of usage and
stick with it.

And I'd advise against the first one which cuts off the
INTEL_FAM6_ATOM_SILVERMONT and other defines.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
