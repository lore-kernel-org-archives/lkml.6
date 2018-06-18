Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A59C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67FA20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67FA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936156AbeFRTM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:12:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:27769 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935860AbeFRTM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:12:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 12:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="60214678"
Received: from vverma7-mobl4.lm.intel.com ([10.254.25.146])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2018 12:12:56 -0700
Date:   Mon, 18 Jun 2018 13:12:56 -0600
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm, pmem: Fix memcpy_mcsafe() return code
 handling in nsio_rw_bytes()
Message-ID: <20180618191255.GA4226@vverma7-mobl4.lm.intel.com>
References: <152934432951.24427.11070204367866836632.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152934432951.24427.11070204367866836632.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18, Dan Williams wrote:
> Commit 60622d68227d "x86/asm/memcpy_mcsafe: Return bytes remaining"
> converted callers of memcpy_mcsafe() to expect a positive 'bytes
> remaining' value rather than a negative error code. The nsio_rw_bytes()
> conversion failed to return success. The failure is benign in that
> nsio_rw_bytes() will end up writing back what it just read.
> 
> Fixes: 60622d68227d ("x86/asm/memcpy_mcsafe: Return bytes remaining")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/claim.c |    1 +
>  1 file changed, 1 insertion(+)

Ah good catch. Looks good to me.
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 2e96b34bc936..fb667bf469c7 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -278,6 +278,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>  			return -EIO;
>  		if (memcpy_mcsafe(buf, nsio->addr + offset, size) != 0)
>  			return -EIO;
> +		return 0;
>  	}
>  
>  	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {
> 
