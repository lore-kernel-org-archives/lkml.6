Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeE2FDr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:03:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38555 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeE2FDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:03:45 -0400
X-Google-Smtp-Source: AB8JxZqcUzfaxcewOvr7dtf6V/FqFj4fGLkW8/OGKwAzDZPHfBfP46jk2HRdRR+ARvX6c6P6dhg+PQ==
Date: Mon, 28 May 2018 22:05:23 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: Introduce prepare/unprepare ops for rproc
 coredump
Message-ID: <20180529050523.GG2259@tuxbook-pro>
References: <20180521184559.20864-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521184559.20864-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 May 11:45 PDT 2018, Sibi Sankar wrote:

> In some occasions the remoteproc device might need to
> prepare some hardware before the coredump can be performed
> and cleanup the state afterwards.
> 
> Q6V5 modem requires the mba to be loaded before the
> coredump and some cleanup of the resources afterwards.
> 

This describes two different changes, so please put it in two+ patches.

[..]
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index dfdaede9139e..010819e01279 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -333,6 +333,8 @@ struct firmware;
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>   * @da_to_va:	optional platform hook to perform address translations
>   * @load_rsc_table:	load resource table from firmware image
> + * @prepare_coredump:	prepare function, called before coredump
> + * @unprepare_coredump:	unprepare function, called post coredump

I believe there will be other cases where we will need driver-specific
logic to extract the memory content of the segments, e.g. through custom
hardware sequences or non-mmio reads.

To support this I think we should extend the struct rproc_dump_segment
to carry an optional "dump" function that if specified will be used
instead of the memcpy in rproc_coredump(). Drivers can then for each
segment specify this function, if needed.

Through some restructuring in the msa driver and your patch you should
be able to implement this using such a mechanism instead - and it would
be useful to these other cases as well.


PS. I hope we can get away from some of the conditionals in your patch
through some restructuring of the code.

Regards,
Bjorn
