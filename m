Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCMHHa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:07:30 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:20409 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751462AbeCMHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:07:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GXAADyd6dah8uZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQlfygKjWONc4IEgRZtk0SCFQqFJQKDHCE0GAECAQEBAQEBAgE?=
 =?us-ascii?q?CEAEBAQoLCQgoLoI4IoJKAQEBAwE6PwwEAgEIEQMBAQEBHgkHRgkIAgQBDQUIh?=
 =?us-ascii?q?QgIrW+IYYIVhTWCLoM8gy6FKIVjBJpWCYlUhwaOa5FIgSweggtwgxKCMhAMgXl?=
 =?us-ascii?q?3jVaBGAEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GXAADyd6dah8uZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?lfygKjWONc4IEgRZtk0SCFQqFJQKDHCE0GAECAQEBAQEBAgECEAEBAQoLCQgoL?=
 =?us-ascii?q?oI4IoJKAQEBAwE6PwwEAgEIEQMBAQEBHgkHRgkIAgQBDQUIhQgIrW+IYYIVhTW?=
 =?us-ascii?q?CLoM8gy6FKIVjBJpWCYlUhwaOa5FIgSweggtwgxKCMhAMgXl3jVaBGAEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.47,464,1515477600";
   d="scan'208";a="149500528"
X-DLP: DLP_GlobalPCIDSS
To: <linux@dominikbrodowski.net>, <dvhart@infradead.org>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Thread-Topic: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Thread-Index: AQHTupabjdkuaHq0Pk2UI1enckQ/AqPNvRAA
Date: Tue, 13 Mar 2018 07:07:26 +0000
Message-ID: <bddaade724054711ba4682f73ec54264@ausx13mpc120.AMER.DELL.COM>
References: <20180313063213.GA20710@localhost.localdomain>
 <f78e97a8f037461ca7f5a60cb351e1af@ausx13mpc120.AMER.DELL.COM>
 <20180313064334.GA1743@light.dominikbrodowski.net>
In-Reply-To: <20180313064334.GA1743@light.dominikbrodowski.net>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2D77aq3008487

> -----Original Message-----
> From: Dominik Brodowski [mailto:linux@dominikbrodowski.net]
> Sent: Tuesday, March 13, 2018 2:44 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Darren Hart
> <dvhart@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
> 
> On Tue, Mar 13, 2018 at 06:12:04AM +0000, Mario.Limonciello@dell.com wrote:
> > As long as they're ready before dell-laptop's initialization which uses
> > late_initcall that should be fine.
> >
> > Am I correct to presume you're going to propose a patch you can test and
> > confirm your hypothesis rather than Darren reverting my patch to bring
> > them together?
> 
> Thanks for the input; a draft patch (which works fine on my system) is
> attached below.
> 
> On Mon, Mar 12, 2018 at 11:32:13PM -0700, Darren Hart wrote:
> > There is one other caveat, which you'll find documented in
> > dell-laptop.c, namely that dell-laptop needs to init after dell-rbtn
> > (I'm starting to appreciate the monolithic thinkpad-acpi driver).
> >
> > We need things to init in this order (items on the same line have no
> > dependency):
> >
> > 1. DCDBAS, ACPI_WMI
> > 2. DELL_SMBIOS, DELL_RBTN
> > 3. DELL_LAPTOP, DELL_WMI
> >
> > Currently:
> > subsys_initcall: ACPI_WMI, DELL_SMBIOS
> > module_init: DCDBAS, DELL_WMI
> > late_initcall: DELL_LAPTOP
> >
> > From a quick naive glance, it appears as though we might be able to
> > address this as follows:
> >
> > subsys_initcall: DCDBAS, ACPI_WMI
> > module_init: DELL_SMBIOS, DELL_RBTN
> > late_initcall: DELL_LAPTOP, DELL_WMI
> 
> Hmmm. I do not yet understand why you propose to
> 
> a) advance the DCDBAS initialization to subsys_initcall, as only DELL_LAPTOP
>    (running as a late_initcall) requires it to be up and running, and

Actually dell-smbios itself should require this too.  The SMM backend will use
it during initialization to determine if WSMT is enabled.  If it's not operational
yet then we may get invalid results.

So considering this I think Darren's proposal is good to move DCDBAS to earlier.

> 
> b) delay DELL_WMI to late_initcall, as it can safely be initialized as long
>    as ACPI_WMI is ready.

Maybe Darren meant dell-wmi-descriptor not dell-wmi?
Otherwise I would agree that part isn't needed.

> 
> What do I miss?
> 
> Attached patch *seems* to work fine on my system.

At least to me, I think it's better to see 
> 
> Thanks,
> 	Dominik
> 
> ----
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Tue, 13 Mar 2018 07:27:41 +0100
> Subject: [PATCH] platform/x86: dell-smbios: wait for WMI initialization
> 
> If DELL_SMBIOS_WMI is enabled, the combined dell-smbios driver
> needs to wait for ACPI_WMI to be initialized, which occurs at the
> subsys_initcall() level. As the dell-smbios driver only needs to
> be up and running by the time the dell-laptop module is initialized,
> which occurs at the late_initcall() level, it is sufficient to
> initialize the dell-smbios driver at the default device_initcall()
> level.
> 
> Fixes: 25d47027e100 ("platform/x86: dell-smbios: Link all dell-smbios-* modules
> together")
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-
> smbios-base.c
> index 5bcf8a18f785..2485c80a9fdd 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -637,7 +637,7 @@ static void __exit dell_smbios_exit(void)
>  	mutex_unlock(&smbios_mutex);
>  }
> 
> -subsys_initcall(dell_smbios_init);
> +module_init(dell_smbios_init);
>  module_exit(dell_smbios_exit);
> 
>  MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
