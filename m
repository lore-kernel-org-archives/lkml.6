Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05828C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB50213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB50213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJDAPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:15:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:7766 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:15:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 10:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="78436290"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2018 10:26:23 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g7kuk-00013E-1z; Wed, 03 Oct 2018 20:26:22 +0300
Date:   Wed, 3 Oct 2018 20:26:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1] ras: Use consistent types for UUIDs
Message-ID: <20181003172622.GO15943@smile.fi.intel.com>
References: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:10:27PM +0300, Andy Shevchenko wrote:
> The commit
> 
>   297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")
> 
> brought inconsistency in UUID types which are used across the RAS subsystem.
> 
> Fix this by moving to use guid_t everywhere.

Any comments on this?

> 
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ras/ras.c       | 2 +-
>  include/ras/ras_event.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 3f38907320dc..95540ea8dd9d 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -14,7 +14,7 @@
>  #define TRACE_INCLUDE_PATH ../../include/ras
>  #include <ras/ras_event.h>
>  
> -void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
> +void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  			    const char *fru_text, const u8 sev, const u8 *err,
>  			    const u32 len)
>  {
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index a0794632fd01..36c5c5e38c1d 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -27,7 +27,7 @@
>  TRACE_EVENT(extlog_mem_event,
>  	TP_PROTO(struct cper_sec_mem_err *mem,
>  		 u32 err_seq,
> -		 const uuid_le *fru_id,
> +		 const guid_t *fru_id,
>  		 const char *fru_text,
>  		 u8 sev),
>  
> @@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
>  		__field(u8, sev)
>  		__field(u64, pa)
>  		__field(u8, pa_mask_lsb)
> -		__field_struct(uuid_le, fru_id)
> +		__field_struct(guid_t, fru_id)
>  		__string(fru_text, fru_text)
>  		__field_struct(struct cper_mem_err_compact, data)
>  	),
> @@ -218,8 +218,8 @@ TRACE_EVENT(arm_event,
>   */
>  TRACE_EVENT(non_standard_event,
>  
> -	TP_PROTO(const uuid_le *sec_type,
> -		 const uuid_le *fru_id,
> +	TP_PROTO(const guid_t *sec_type,
> +		 const guid_t *fru_id,
>  		 const char *fru_text,
>  		 const u8 sev,
>  		 const u8 *err,
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


