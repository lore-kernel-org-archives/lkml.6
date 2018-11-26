Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF8DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6502086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yS4cihtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6502086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeK0GOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0GOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:14:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D707120664;
        Mon, 26 Nov 2018 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543259989;
        bh=F/Rrwfb3OktQQVsAofxt0AFh39YG60YN99VVAxuAB1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yS4cihtX4FE9z7LWZU+OEUoXt4kKXdAb9l39uRTAtuGStcnC3ttYmGXIk9+Y90P4c
         UH1qrBAsiqPyTDOrzhzSFeBiAB7d1RJdwJkx/De3458YwAEUw+w7XleQPk62nXLW7/
         BnHBI1i0YrRK7gy1OJFQ/8cVerzP0hJC7vu+x2WQ=
Date:   Mon, 26 Nov 2018 20:19:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Message-ID: <20181126191946.GB32208@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122031059.16338-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:10:57AM +0000, kys@linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_hvc.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Using SPDX is good, but:

> +
> +/*
> + * Microsoft Hyper-V hypervisor invocation routines
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.

No need for these two paragraphs at all.  If you add them now, someone
will just come along later and rip them out.  Please don't include them
in the first place.

Not to mention the first paragraph doesn't make sense, think about
"which" version 2 the FSF published (hint, there was 5 or 7 or so...)
That's why we have one in the kernel tree for everyone to rely on.

thanks,

greg k-h
