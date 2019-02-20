Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075BDC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048A20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfBTB40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:56:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfBTB40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:56:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1C72B0AB5;
        Wed, 20 Feb 2019 01:56:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24CAF1001DE2;
        Wed, 20 Feb 2019 01:56:25 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Vishal Verma <vishal.verma@intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/nfit: Fix bus command validation
References: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 19 Feb 2019 20:56:24 -0500
In-Reply-To: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Thu, 07 Feb 2019 15:57:31 -0800")
Message-ID: <x49lg2bql2v.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 01:56:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Commit 11189c1089da "acpi/nfit: Fix command-supported detection" broke
> ND_CMD_CALL for bus-level commands. The "func = cmd" assumption is only
> valid for:
>
>     ND_CMD_ARS_CAP
>     ND_CMD_ARS_START
>     ND_CMD_ARS_STATUS
>     ND_CMD_CLEAR_ERROR
>
> The function number otherwise needs to be pulled from the command
> payload for:
>
>     NFIT_CMD_TRANSLATE_SPA
>     NFIT_CMD_ARS_INJECT_SET
>     NFIT_CMD_ARS_INJECT_CLEAR
>     NFIT_CMD_ARS_INJECT_GET
>
> Update cmd_to_func() for the bus case and call it in the common path.
>
> Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
> Cc: <stable@vger.kernel.org>
> Cc: Vishal Verma <vishal.verma@intel.com>
> Reported-by: Grzegorz Burzynski <grzegorz.burzynski@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tricky code path, eh?

Tested-by: Jeff Moyer <jmoyer@redhat.com>

-Jeff

> ---
>  drivers/acpi/nfit/core.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index e18ade5d74e9..c34c595d6bb0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -415,7 +415,7 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
>  	if (call_pkg) {
>  		int i;
>  
> -		if (nfit_mem->family != call_pkg->nd_family)
> +		if (nfit_mem && nfit_mem->family != call_pkg->nd_family)
>  			return -ENOTTY;
>  
>  		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
> @@ -424,6 +424,10 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
>  		return call_pkg->nd_command;
>  	}
>  
> +	/* In the !call_pkg case, bus commands == bus functions */
> +	if (!nfit_mem)
> +		return cmd;
> +
>  	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
>  	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
>  		return cmd;
> @@ -454,17 +458,18 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> +	if (cmd == ND_CMD_CALL)
> +		call_pkg = buf;
> +	func = cmd_to_func(nfit_mem, cmd, call_pkg);
> +	if (func < 0)
> +		return func;
> +
>  	if (nvdimm) {
>  		struct acpi_device *adev = nfit_mem->adev;
>  
>  		if (!adev)
>  			return -ENOTTY;
>  
> -		if (cmd == ND_CMD_CALL)
> -			call_pkg = buf;
> -		func = cmd_to_func(nfit_mem, cmd, call_pkg);
> -		if (func < 0)
> -			return func;
>  		dimm_name = nvdimm_name(nvdimm);
>  		cmd_name = nvdimm_cmd_name(cmd);
>  		cmd_mask = nvdimm_cmd_mask(nvdimm);
> @@ -475,12 +480,9 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	} else {
>  		struct acpi_device *adev = to_acpi_dev(acpi_desc);
>  
> -		func = cmd;
>  		cmd_name = nvdimm_bus_cmd_name(cmd);
>  		cmd_mask = nd_desc->cmd_mask;
> -		dsm_mask = cmd_mask;
> -		if (cmd == ND_CMD_CALL)
> -			dsm_mask = nd_desc->bus_dsm_mask;
> +		dsm_mask = nd_desc->bus_dsm_mask;
>  		desc = nd_cmd_bus_desc(cmd);
>  		guid = to_nfit_uuid(NFIT_DEV_BUS);
>  		handle = adev->handle;
>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
