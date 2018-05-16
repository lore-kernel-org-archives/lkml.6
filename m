Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeEPTTA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:19:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:62918 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeEPTS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:18:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="41508945"
From: "Moore, Robert" <robert.moore@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC: "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>
Subject: RE: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
Thread-Topic: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
Thread-Index: AQHT7Q9zFf4ZLtB3okuE5+Gc7MpnD6Qyuxpw
Date: Wed, 16 May 2018 19:18:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B776DF31@ORSMSX108.amr.corp.intel.com>
References: <2406722.gU2bUHd7bl@aspire.rjw.lan>
 <1877957.ohNgiH8Sko@aspire.rjw.lan>
In-Reply-To: <1877957.ohNgiH8Sko@aspire.rjw.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU2OTk5M2MtMjMzYy00YzAzLThjZTgtM2U4Y2RkM2Y3Y2U3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrUXlaSW0rd3BNUm5iK3RITEd2RzQ0cVNhVUpwbVpOaElNSm1yV3FrWlROWHRSZ1NVb2xoWDlcL0p2UFpsQWdHayJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure why this is necessary, please explain.

Is the implication here that some driver is going to poll on acpi_dispatch_gpe?

Bob


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Wednesday, May 16, 2018 5:12 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Zhang, Rui <rui.zhang@intel.com>; Linux PM <linux-
> pm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Schmauss, Erik
> <erik.schmauss@intel.com>; Moore, Robert <robert.moore@intel.com>; Wang,
> Wendy <wendy.wang@intel.com>
> Subject: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce acpi_dispatch_gpe() as a wrapper around acpi_ev_detect_gpe()
> for checking if the given GPE (as represented by a GPE device handle and
> a GPE number) is currently active and dispatching it (if that's the
> case) outside of interrupt context.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evgpe.c   |    6 ++++++
>  drivers/acpi/acpica/evxfgpe.c |   22 ++++++++++++++++++++++
>  include/acpi/acpixf.h         |    1 +
>  3 files changed, 29 insertions(+)
> 
> Index: linux-pm/drivers/acpi/acpica/evgpe.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evgpe.c
> +++ linux-pm/drivers/acpi/acpica/evgpe.c
> @@ -634,6 +634,12 @@ acpi_ev_detect_gpe(struct acpi_namespace
> 
>  	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
> 
> +	if (!gpe_event_info) {
> +		gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device,
> gpe_number);
> +		if (!gpe_event_info)
> +			goto error_exit;
> +	}
> +
>  	/* Get the info block for the entire GPE register */
> 
>  	gpe_register_info = gpe_event_info->register_info;
> Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
> +++ linux-pm/drivers/acpi/acpica/evxfgpe.c
> @@ -639,6 +639,28 @@ ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
> 
> 
> /***********************************************************************
> ********
>   *
> + * FUNCTION:    acpi_gispatch_gpe
> + *
> + * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for
> GPE0/GPE1
> + *              gpe_number          - GPE level within the GPE block
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Detect and dispatch a General Purpose Event to either a
> function
> + *              (e.g. EC) or method (e.g. _Lxx/_Exx) handler.
> + *
> +
> +***********************************************************************
> +*******/ void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number)
> +{
> +	ACPI_FUNCTION_TRACE(acpi_dispatch_gpe);
> +
> +	acpi_ev_detect_gpe(gpe_device, NULL, gpe_number); }
> +
> +ACPI_EXPORT_SYMBOL(acpi_dispatch_gpe)
> +
> +/**********************************************************************
> +*********
> + *
>   * FUNCTION:    acpi_finish_gpe
>   *
>   * PARAMETERS:  gpe_device          - Namespace node for the GPE Block
> Index: linux-pm/include/acpi/acpixf.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpixf.h
> +++ linux-pm/include/acpi/acpixf.h
> @@ -753,6 +753,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
>  						     u32 gpe_number,
>  						     acpi_event_status
>  						     *event_status))
> +void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number);
>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> acpi_disable_all_gpes(void))
> ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> acpi_enable_all_runtime_gpes(void))
>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
> acpi_enable_all_wakeup_gpes(void))
