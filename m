Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3821223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3821223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeKNF4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:56:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725748AbeKNF4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:56:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28580AFB0;
        Tue, 13 Nov 2018 19:56:57 +0000 (UTC)
Date:   Tue, 13 Nov 2018 20:56:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
In-Reply-To: <20181113184910.26697-1-mhocko@kernel.org>
Message-ID: <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm>
References: <20181113184910.26697-1-mhocko@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> Swap storage is restricted to max_swapfile_size (~16TB on x86_64)
> whenever the system is deemed affected by L1TF vulnerability. Even
> though the limit is quite high for most deployments it seems to be
> too restrictive for deployments which are willing to live with the
> mitigation disabled.
> 
> We have a customer to deploy 8x 6,4TB PCIe/NVMe SSD swap devices
> which is clearly out of the limit.
> 
> Drop the swap restriction when l1tf=off is specified. It also doesn't
> make much sense to warn about too much memory for the l1tf mitigation
> when it is forcefully disabled by the administrator.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  Documentation/admin-guide/l1tf.rst              | 5 ++++-
>  arch/x86/kernel/cpu/bugs.c                      | 3 ++-
>  arch/x86/mm/init.c                              | 2 +-
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 81d1d5a74728..a54f2bd39e77 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2095,6 +2095,8 @@
>  			off
>  				Disables hypervisor mitigations and doesn't
>  				emit any warnings.
> +				It also drops the swap size and available
> +				RAM limit restriction.

Minor nit: I think this should explicitly mention that those two things 
are related to bare metal mitigation, to avoid any confusion (as otherwise 
the l1tf cmdline parameter is purely about hypervisor mitigations).

With that

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

