Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E74C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E32720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbfAOUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389878AbfAOUjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:39:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A6D383F3E;
        Tue, 15 Jan 2019 20:39:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E3C5C234;
        Tue, 15 Jan 2019 20:39:14 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] acpi/nfit: Fix command-supported detection
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49tvia80r0.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4htfew=7D_B1QDGTwSkMTx7BK2BZ+Gq+9UL1NTtqtL9FQ@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 15 Jan 2019 15:39:13 -0500
In-Reply-To: <CAPcyv4htfew=7D_B1QDGTwSkMTx7BK2BZ+Gq+9UL1NTtqtL9FQ@mail.gmail.com>
        (Dan Williams's message of "Tue, 15 Jan 2019 08:48:18 -0800")
Message-ID: <x49k1j57j0u.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 20:39:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Jan 15, 2019 at 6:16 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > Changes since v1 [1]:
>> > * Include another patch make sure that function-number zero can be
>> >   safely used as an invalid function number (Jeff)
>> > * Add a comment clarifying why zero is an invalid function number (Jeff)
>> > * Pass nfit_mem to cmd_to_func() (Jeff)
>> > * Collect a Tested-by from Sujith
>> > [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019435.html
>>
>> For the series:
>>
>> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>>
>> Thanks, Dan!
>
> Thanks, although I just realized one more change. The ND_CMD_CALL case
> should zero out command after the function translation, otherwise
> userspace can call functions that the kernel is blocking in the
> dsm_mask.
>
> Holler if this invalidates your "Reviewed-by".

AAAAAAAHHHHHHHHHH!!!!

:)

> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 87e02f281e51..d7747aceb7ab 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -463,6 +463,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
> *nd_desc, struct nvdimm *nvdimm,
>                 func = cmd_to_func(nfit_mem, cmd, buf);
>                 if (func < 0)
>                         return func;
> +               /*
> +                * In the ND_CMD_CALL case we're now dependent on 'func'
> +                * being validated by the dimm's dsm_mask
> +                */
> +               if (cmd == ND_CMD_CALL)
> +                       cmd = 0;
>                 dimm_name = nvdimm_name(nvdimm);
>                 cmd_name = nvdimm_cmd_name(cmd);
>                 cmd_mask = nvdimm_cmd_mask(nvdimm);
                dsm_mask = nfit_mem->dsm_mask;
                desc = nd_cmd_dimm_desc(cmd);

That sure doesn't look right.  Now cmd_name and desc will be wrong.

> @@ -477,8 +483,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
> *nd_desc, struct nvdimm *nvdimm,
>                 cmd_name = nvdimm_bus_cmd_name(cmd);
>                 cmd_mask = nd_desc->cmd_mask;
>                 dsm_mask = cmd_mask;
> -               if (cmd == ND_CMD_CALL)
> +               if (cmd == ND_CMD_CALL) {
>                         dsm_mask = nd_desc->bus_dsm_mask;
> +                       cmd = 0;
> +               }
>                 desc = nd_cmd_bus_desc(cmd);

And again here.

We could reorder the zeroing, or you could modify the check for a valid
comand/function.  Something like this?

	/*
         * Check for a valid command.  For ND_CMD_CALL, we also
         * have to make sure that the DSM function is supported.
         */
	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
        	return -ENOTTY;
	else if (!test_bit(cmd, &cmd_mask))
		return -ENOTTY;

Which way do you think is cleaner?

Cheers,
Jeff
