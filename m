Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3800C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B0B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B0B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLCUM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:12:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:18155 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeLCUM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:12:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 12:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="106963995"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.254.190.169]) ([10.254.190.169])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2018 12:12:25 -0800
Subject: Re: [PATCH] acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather
 than "ARS-short"
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Jacek Zloch <jacek.zloch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <6345bd3b-b5c0-eb51-bd81-878cd764e66d@intel.com>
Date:   Mon, 3 Dec 2018 13:12:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/2018 11:30 AM, Dan Williams wrote:
> A "short" ARS (address range scrub) instructs the platform firmware to
> return known errors. In contrast, a "long" ARS instructs platform
> firmware to arrange every data address on the DIMM to be read / checked
> for poisoned data.
>
> The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
> Address Range Scrub completion tracking", changed the meaning of passing
> '0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now '0'
> is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-type
> behavior of user-initiated ARS sessions.
>
> Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion tracking")
> Reported-by: Jacek Zloch <jacek.zloch@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/nfit/core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14d9f5bea015..5912d30020c7 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1308,7 +1308,7 @@ static ssize_t scrub_store(struct device *dev,
>   	if (nd_desc) {
>   		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>   
> -		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
> +		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>   	}
>   	device_unlock(dev);
>   	if (rc)
>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
