Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD70C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4E820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4E820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIKQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:04:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:04:33 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id d4a786d20a3483f6; Tue, 11 Sep 2018 13:05:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] ACPI / x86: utils: Get rid of custom ICPU() macro
Date:   Tue, 11 Sep 2018 13:03:03 +0200
Message-ID: <6995683.CujeQXBDt3@aspire.rjw.lan>
In-Reply-To: <20180831091018.17543-4-andriy.shevchenko@linux.intel.com>
References: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com> <20180831091018.17543-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 31, 2018 11:10:18 AM CEST Andy Shevchenko wrote:
> Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/x86/utils.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 06c31ec3cc70..6bb2a4565386 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -40,8 +40,6 @@ struct always_present_id {
>  	const char *uid;
>  };
>  
> -#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  #define ENTRY(hid, uid, cpu_models, dmi...) {				\
>  	{ { hid, }, {} },						\
>  	{ cpu_models, {} },						\
> @@ -54,24 +52,24 @@ static const struct always_present_id always_present_ids[] = {
>  	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
>  	 * but Linux uses a separate PWM driver, harmless if not used.
>  	 */
> -	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1), {}),
> -	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
> +	ENTRY("80860F09", "1", INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT1), {}),
> +	ENTRY("80862288", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {}),
>  	/*
>  	 * The INT0002 device is necessary to clear wakeup interrupt sources
>  	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
>  	 */
> -	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
> +	ENTRY("INT0002", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {}),
>  	/*
>  	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
>  	 * the touchscreen ACPI device until a certain time
>  	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
>  	 * *and* _STA has been called at least 3 times since.
>  	 */
> -	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
> +	ENTRY("SYNA7500", "1", INTEL_CPU_FAM6_NODATA(HASWELL_ULT), {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>  	      }),
> -	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
> +	ENTRY("SYNA7500", "1", INTEL_CPU_FAM6_NODATA(HASWELL_ULT), {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
>  	      }),
> @@ -87,19 +85,19 @@ static const struct always_present_id always_present_ids[] = {
>  	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
>  	 * node which we should not enable, thus we also check the BIOS date.
>  	 */
> -	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
> +	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
>  		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>  		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>  		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
>  	      }),
> -	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
> +	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
>  		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>  		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>  		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
>  	      }),
> -	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
> +	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
>  		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>  		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


