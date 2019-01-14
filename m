Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F130A20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfANPTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:19:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfANPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:19:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24736C06778B;
        Mon, 14 Jan 2019 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70BA2100194B;
        Mon, 14 Jan 2019 15:19:22 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Sujith Pandel <sujith_pandel@dell.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] acpi/nfit: Fix command-supported detection
References: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 14 Jan 2019 10:19:21 -0500
In-Reply-To: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Fri, 11 Jan 2019 15:59:16 -0800")
Message-ID: <x49sgxvclmu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 14 Jan 2019 15:19:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The _DSM function number validation only happens to succeed when the
> generic Linux command number translation corresponds with a
> DSM-family-specific function number. This breaks NVDIMM-N
> implementations that correctly implement _LSR, _LSW, and _LSI, but do
> not happen to publish support for DSM function numbers 4, 5, and 6.
>
> Recall that the support for _LS{I,R,W} family of methods results in the
> DIMM being marked as supporting those command numbers at
> acpi_nfit_register_dimms() time. The DSM function mask is only used for
> ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
> Cc: <stable@vger.kernel.org>
> Link: https://github.com/pmem/ndctl/issues/78
> Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Sujith, this is a larger change than what you originally tested, but it
> should behave the same. I wanted to consolidate all the code that
> handles Linux command number to DIMM _DSM function number translation.
>
> If you have a chance to re-test with this it would be much appreciated.
>
> Thanks for the report!
>
>  drivers/acpi/nfit/core.c |   43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 790691d9a982..d5d64e90ae71 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -409,6 +409,29 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
>  	return true;
>  }
>  
> +static int cmd_to_func(struct nvdimm *nvdimm, unsigned int cmd,
> +		struct nd_cmd_pkg *call_pkg)
> +{
> +	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);

Minor nit: Seems like the function could take an nfit_mem parameter instead of an nvdimm.

> +
> +	if (cmd == ND_CMD_CALL) {
> +		int i;
> +
> +		if (call_pkg && nfit_mem->family != call_pkg->nd_family)
> +			return -ENOTTY;
> +
> +		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
> +			if (call_pkg->nd_reserved2[i])
> +				return -EINVAL;
> +		return call_pkg->nd_command;
> +	}
> +
> +	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
> +	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
> +		return cmd;
> +	return 0;

Function zero?  Is that really the right thing to return here?

Cheers,
Jeff
