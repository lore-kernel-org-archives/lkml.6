Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDAB2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfA3J7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:59:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:48148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730527AbfA3J7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:59:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A919AD76;
        Wed, 30 Jan 2019 09:59:18 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:59:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of
 worker_data
Message-ID: <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
References: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-01-19 17:15:23, Luc Van Oostenryck wrote:
> This variable is declared as:
> 	static struct powerclamp_worker_data * __percpu worker_data;
> In other words, a percpu pointer to struct ...
> 
> But this variable not used like so but as a pointer to a percpu
> struct powerclamp_worker_data.
> 
> So fix the declaration as:
> 	static struct powerclamp_worker_data __percpu *worker_data;
> 
> This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
>   494:49: warning: incorrect type in initializer (different address spaces)
>   494:49:    expected void const [noderef] <asn:3> *__vpp_verify
>   494:49:    got struct powerclamp_worker_data *
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 7571f7c2e..c7cba20bd 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -101,7 +101,7 @@ struct powerclamp_worker_data {
>  	bool clamping;
>  };
>  
> -static struct powerclamp_worker_data * __percpu worker_data;
> +static struct powerclamp_worker_data __percpu * worker_data;

Makes perfect sense. I wonder why I wrote it in the wrong order.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
