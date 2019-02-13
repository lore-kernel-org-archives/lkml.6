Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0548C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89112190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391682AbfBMLO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:14:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:4817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391691AbfBMLOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:14:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="126113237"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 03:14:43 -0800
Date:   Wed, 13 Feb 2019 13:14:43 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     bsz@semihalf.com, matthewgarrett@google.com
Cc:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        ard.biesheuvel@linaro.org, tweek@google.com, mingo@kernel.org,
        hdegoede@redhat.com, leif.lindholm@linaro.org, mw@semihalf.com
Subject: Re: [PATCH 1/5] tpm: Copy calc_tpm2_event_size() to TPM library
Message-ID: <20190213111443.GE7087@linux.intel.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
 <20190211143052.3128-2-bsz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211143052.3128-2-bsz@semihalf.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:30:48PM +0100, bsz@semihalf.com wrote:
> From: Bartosz Szczepanek <bsz@semihalf.com>
> 
> Function to calculate event size in TPM 2.0 log will also be needed in EFI
> stub. Separate it to library to make it accessible out of TPM character
> driver.
> 
> It will be removed from tpm2.c in subsequent commit.
> 
> Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>

Collides with Matthew's patch set, which has priority over this because
it was sent earlier.

Matthew, what you think of this? Maybe could replace 1/4 with this in
your patch set? Somehow feels a bit cleaner approach.

> ---
>  lib/tpm.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 lib/tpm.c
> 
> diff --git a/lib/tpm.c b/lib/tpm.c
> new file mode 100644
> index 000000000000..aaeeafe52426
> --- /dev/null
> +++ b/lib/tpm.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 IBM Corporation

Do we want copyright statements to new files? I'm sure that this code
would have more copyright holders than just IBM (eg VMWare). Git
documents this anyway. This is something that will be left unmaintained.

> + * Parts of this file based on earlier work by:
> + *      Nayna Jain <nayna@linux.vnet.ibm.com>
> + *      Petr Vandrovec <petr@vmware.com>

Please remove these three lines. These type of lists are just inaccurate
presentaion of the commit log.

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.

You already have SPDX identifier. Unncessary repeat.

> + */
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/string.h>
> +#include <linux/tpm_eventlog.h>
> +
> +/*
> + * calc_tpm2_event_size() - calculate the event size, where event
> + * is an entry in the TPM 2.0 event log. The event is of type Crypto
> + * Agile Log Entry Format as defined in TCG EFI Protocol Specification
> + * Family "2.0".
> +
> + * @event: event whose size is to be calculated.
> + * @event_header: the first event in the event log.
> + *
> + * Returns size of the event. If it is an invalid event, returns 0.
> + */
> +int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
> +			 struct tcg_pcr_event *event_header)
> +{
> +	struct tcg_efi_specid_event *efispecid;
> +	struct tcg_event_field *event_field;
> +	void *marker;
> +	void *marker_start;
> +	u32 halg_size;
> +	size_t size;
> +	u16 halg;
> +	int i;
> +	int j;
> +
> +	marker = event;
> +	marker_start = marker;
> +	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
> +		+ sizeof(event->count);
> +
> +	efispecid = (struct tcg_efi_specid_event *)event_header->event;
> +
> +	/* Check if event is malformed. */
> +	if (event->count > efispecid->num_algs)
> +		return 0;
> +
> +	for (i = 0; i < event->count; i++) {
> +		halg_size = sizeof(event->digests[i].alg_id);
> +		memcpy(&halg, marker, halg_size);
> +		marker = marker + halg_size;
> +		for (j = 0; j < efispecid->num_algs; j++) {
> +			if (halg == efispecid->digest_sizes[j].alg_id) {
> +				marker +=
> +					efispecid->digest_sizes[j].digest_size;
> +				break;
> +			}
> +		}
> +		/* Algorithm without known length. Such event is unparseable. */
> +		if (j == efispecid->num_algs)
> +			return 0;
> +	}
> +
> +	event_field = (struct tcg_event_field *)marker;
> +	marker = marker + sizeof(event_field->event_size)
> +		+ event_field->event_size;
> +	size = marker - marker_start;
> +
> +	if ((event->event_type == 0) && (event_field->event_size == 0))
> +		return 0;
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(calc_tpm2_event_size);
> -- 
> 2.14.4
> 
