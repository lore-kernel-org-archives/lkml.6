Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeCUWui (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:50:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:40682 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753691AbeCUWuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:50:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="39498811"
From: "Jiang, Dave" <dave.jiang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] libnvdimm, nfit: fix persistence domain reporting
Thread-Topic: [PATCH] libnvdimm, nfit: fix persistence domain reporting
Thread-Index: AQHTwWa4Kd/w6/RH9E+CPgYOn1sIS6PbSxcA
Date: Wed, 21 Mar 2018 22:50:33 +0000
Message-ID: <112A412BB11A1242B37129D931BCE5348309A035@fmsmsx117.amr.corp.intel.com>
References: <152167195887.4609.5407001869524973776.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152167195887.4609.5407001869524973776.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTE1ZjMxMmMtMzg4MS00MjQ3LWJjYzEtZTdiZWYzNzQwNDVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InhLNGxPN1NsM0pxOXpwNkJFNFU5MDY3eUZFdTNQbUJhV3dweWNIMlNDeEk9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LMorgp008013



> -----Original Message-----
> From: Williams, Dan J
> Sent: Wednesday, March 21, 2018 3:39 PM
> To: linux-nvdimm@lists.01.org
> Cc: Jiang, Dave <dave.jiang@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ross Zwisler <ross.zwisler@linux.intel.com>; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] libnvdimm, nfit: fix persistence domain reporting
> 
> The persistence domain is a point in the platform where once writes
> reach that destination the platform claims it will make them persistent
> relative to power loss. In the ACPI NFIT this is currently communicated
> as 2 bits in the "NFIT - Platform Capabilities Structure". The bits
> comprise a hierarchy, i.e. bit0 "CPU Cache Flush to NVDIMM Durability on
> Power Loss Capable" implies bit1 "Memory Controller Flush to NVDIMM
> Durability on Power Loss Capable".
> 
> Commit 96c3a239054a "libnvdimm: expose platform persistence attr..."
> shows the persistence domain as flags, but it's really an enumerated
> hierarchy.
> 
> Fix this newly introduced user ABI to show the closest available
> persistence domain before userspace develops dependencies on seeing, or
> needing to develop code to tolerate, the raw NFIT flags communicated
> through the libnvdimm-generic region attribute.
> 
> Fixes: 96c3a239054a ("libnvdimm: expose platform persistence attr...")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Thanks for the fix!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/nfit/core.c     |   10 +++++++---
>  drivers/nvdimm/region_devs.c |   10 ++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index bbe48ad20886..eb09ef55c38a 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2675,10 +2675,14 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>  	else
>  		ndr_desc->numa_node = NUMA_NO_NODE;
> 
> -	if(acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_CACHE_FLUSH)
> +	/*
> +	 * Persistence domain bits are hierarchical, if
> +	 * ACPI_NFIT_CAPABILITY_CACHE_FLUSH is set then
> +	 * ACPI_NFIT_CAPABILITY_MEM_FLUSH is implied.
> +	 */
> +	if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_CACHE_FLUSH)
>  		set_bit(ND_REGION_PERSIST_CACHE, &ndr_desc->flags);
> -
> -	if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_MEM_FLUSH)
> +	else if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_MEM_FLUSH)
>  		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc->flags);
> 
>  	list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index a8e9d428c0a5..1593e1806b16 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -532,11 +532,13 @@ static ssize_t persistence_domain_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev);
> -	unsigned long flags = nd_region->flags;
> 
> -	return sprintf(buf, "%s%s\n",
> -			flags & BIT(ND_REGION_PERSIST_CACHE) ? "cpu_cache " : "",
> -			flags & BIT(ND_REGION_PERSIST_MEMCTRL) ? "memory_controller " : "");
> +	if (test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags))
> +		return sprintf(buf, "cpu_cache\n");
> +	else if (test_bit(ND_REGION_PERSIST_MEMCTRL, &nd_region->flags))
> +		return sprintf(buf, "memory_controller\n");
> +	else
> +		return sprintf(buf, "\n");
>  }
>  static DEVICE_ATTR_RO(persistence_domain);
> 
