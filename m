Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeDSXn3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:43:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeDSXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:43:28 -0400
Date: Thu, 19 Apr 2018 16:43:24 -0700
From: Darren Hart <dvhart@infradead.org>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
 strings too
Message-ID: <20180419234324.GA11546@fury>
References: <1523994356-9598-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523994356-9598-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 02:45:56PM -0500, Mario Limonciello wrote:
> Sergey reported that some much older Dell systems don't support
> the OEM string "Dell System" but instead supported www.dell.com
> in OEM strings.
> 
> Match both of these to indicate that this driver is running on
> a Dell system.
> 
> Reported-by: Sergey Kubushyn <ksi@koi8.net>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Tested-by: Sergey Kubushyn <ksi@koi8.net>
> ---
>  drivers/platform/x86/dell-smbios-base.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
> index 2485c80..fbd6557 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -555,11 +555,15 @@ static void free_group(struct platform_device *pdev)
>  
>  static int __init dell_smbios_init(void)
>  {
> -	const struct dmi_device *valid;
> +	const struct dmi_device *valid_dell_system;
> +	const struct dmi_device *valid_www;
>  	int ret, wmi, smm;
>  
> -	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
> -	if (!valid) {
> +	valid_dell_system =
> +		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
> +	valid_www =
> +		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL);
> +	if (!valid_dell_system && !valid_www) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;
>  	}

Hrm, rather than introduce another variable that we don't use and always perform
both tests, when most of the time we only need to do the first, how about
something like:


>From 2cb5959dadec769167350a9bcb1d212a02b17af8 Mon Sep 17 00:00:00 2001
Message-Id: <2cb5959dadec769167350a9bcb1d212a02b17af8.1524181265.git.dvhart@infradead.org>
From: Mario Limonciello <mario.limonciello@dell.com>
Date: Tue, 17 Apr 2018 14:45:56 -0500
Subject: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
 strings too

Sergey reported that some much older Dell systems don't support
the OEM string "Dell System" but instead supported www.dell.com
in OEM strings.

Match both of these to indicate that this driver is running on
a Dell system.

Reported-by: Sergey Kubushyn <ksi@koi8.net>
Tested-by: Sergey Kubushyn <ksi@koi8.net>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
[dvhart: Simplify DMI logic and eliminate unnecessary variables]
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/dell-smbios-base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 33fb2a20458a..9dc282ed5a9e 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -555,11 +555,10 @@ static void free_group(struct platform_device *pdev)
 
 static int __init dell_smbios_init(void)
 {
-	const struct dmi_device *valid;
 	int ret, wmi, smm;
 
-	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
-	if (!valid) {
+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.14.3


-- 
Darren Hart
VMware Open Source Technology Center
