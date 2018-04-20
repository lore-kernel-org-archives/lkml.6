Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755318AbeDTOjj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:39:39 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:2782 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755147AbeDTOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:39:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H4AABH+tlah2Ka6ERcHgEGDIQVDnooC?=
 =?us-ascii?q?phYNIFAgQ9gkhiBPTsLGxCBAoM8AoJGITQYAQIBAQEBAQECAQECEAEBAQgNCQg?=
 =?us-ascii?q?oIwyCNSINBEspAy8BAQEBAQEBAQEBAQEBAQEBAQEBAQEVAg0iIRoBAQEDAToPM?=
 =?us-ascii?q?AwEAgEIEQMBAQEBHgkHRgkIAgQOBQiEfQioa4g+gimIBoITgQ+DC4MRAoc0Apd?=
 =?us-ascii?q?xCIVbiFyMVhiNGQGCd4ElHIILcIMTCYIXDgkpgxyFFIU+b45PgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2H4AABH+tlah2Ka6ERcHgEGDIQVDnooCphYNIFAgQ9gkhi?=
 =?us-ascii?q?BPTsLGxCBAoM8AoJGITQYAQIBAQEBAQECAQECEAEBAQgNCQgoIwyCNSINBEspA?=
 =?us-ascii?q?y8BAQEBAQEBAQEBAQEBAQEBAQEBAQEVAg0iIRoBAQEDAToPMAwEAgEIEQMBAQE?=
 =?us-ascii?q?BHgkHRgkIAgQOBQiEfQioa4g+gimIBoITgQ+DC4MRAoc0ApdxCIVbiFyMVhiNG?=
 =?us-ascii?q?QGCd4ElHIILcIMTCYIXDgkpgxyFFIU+b45PgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.49,301,1520917200";
   d="scan'208";a="171516519"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>
CC: <andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
 strings too
Thread-Topic: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
 strings too
Thread-Index: AQHT1oS6IeqEU+bE9Eel4U89fMISpaQJFzEAgACmaUA=
Date: Fri, 20 Apr 2018 14:39:32 +0000
Message-ID: <8649d2b7b64741b4beb7b17085aa9d56@ausx13mpc120.AMER.DELL.COM>
References: <1523994356-9598-1-git-send-email-mario.limonciello@dell.com>
 <20180419234324.GA11546@fury>
In-Reply-To: <20180419234324.GA11546@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3KEdlSW028700



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Thursday, April 19, 2018 6:43 PM
> To: Limonciello, Mario
> Cc: Andy Shevchenko; LKML; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
> strings too
> 
> On Tue, Apr 17, 2018 at 02:45:56PM -0500, Mario Limonciello wrote:
> > Sergey reported that some much older Dell systems don't support
> > the OEM string "Dell System" but instead supported www.dell.com
> > in OEM strings.
> >
> > Match both of these to indicate that this driver is running on
> > a Dell system.
> >
> > Reported-by: Sergey Kubushyn <ksi@koi8.net>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > Tested-by: Sergey Kubushyn <ksi@koi8.net>
> > ---
> >  drivers/platform/x86/dell-smbios-base.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-
> smbios-base.c
> > index 2485c80..fbd6557 100644
> > --- a/drivers/platform/x86/dell-smbios-base.c
> > +++ b/drivers/platform/x86/dell-smbios-base.c
> > @@ -555,11 +555,15 @@ static void free_group(struct platform_device *pdev)
> >
> >  static int __init dell_smbios_init(void)
> >  {
> > -	const struct dmi_device *valid;
> > +	const struct dmi_device *valid_dell_system;
> > +	const struct dmi_device *valid_www;
> >  	int ret, wmi, smm;
> >
> > -	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System",
> NULL);
> > -	if (!valid) {
> > +	valid_dell_system =
> > +		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System",
> NULL);
> > +	valid_www =
> > +		dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com",
> NULL);
> > +	if (!valid_dell_system && !valid_www) {
> >  		pr_err("Unable to run on non-Dell system\n");
> >  		return -ENODEV;
> >  	}
> 
> Hrm, rather than introduce another variable that we don't use and always perform
> both tests, when most of the time we only need to do the first, how about
> something like:
> 

Darren,

That looks good to me, thanks!

> 
> From 2cb5959dadec769167350a9bcb1d212a02b17af8 Mon Sep 17 00:00:00 2001
> Message-Id:
> <2cb5959dadec769167350a9bcb1d212a02b17af8.1524181265.git.dvhart@infrad
> ead.org>
> From: Mario Limonciello <mario.limonciello@dell.com>
> Date: Tue, 17 Apr 2018 14:45:56 -0500
> Subject: [PATCH] platform/x86: dell-smbios: Match on www.dell.com in OEM
>  strings too
> 
> Sergey reported that some much older Dell systems don't support
> the OEM string "Dell System" but instead supported www.dell.com
> in OEM strings.
> 
> Match both of these to indicate that this driver is running on
> a Dell system.
> 
> Reported-by: Sergey Kubushyn <ksi@koi8.net>
> Tested-by: Sergey Kubushyn <ksi@koi8.net>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> [dvhart: Simplify DMI logic and eliminate unnecessary variables]
> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> ---
>  drivers/platform/x86/dell-smbios-base.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-
> smbios-base.c
> index 33fb2a20458a..9dc282ed5a9e 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -555,11 +555,10 @@ static void free_group(struct platform_device *pdev)
> 
>  static int __init dell_smbios_init(void)
>  {
> -	const struct dmi_device *valid;
>  	int ret, wmi, smm;
> 
> -	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System",
> NULL);
> -	if (!valid) {
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)
> &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com",
> NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;
>  	}
> --
> 2.14.3
> 
> 
> --
> Darren Hart
> VMware Open Source Technology Center
