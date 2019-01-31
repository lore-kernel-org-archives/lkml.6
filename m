Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CDEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7BF218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935881;
	bh=yeagtBxukxA6Is+Vu0BlJKlmuO6fQGpQ+Jbl9+NyK5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjMt+eFhN9OdVr3cBF823XnaOQ8r49XiwrjImi+wyZJDnCvi5AuNwe0Zdh3mHrvW1
	 /gnJ5oIOVsk6JinLlSN7kdE/yHllyQZTgCFKV4ntY4p9rZT22HzAwI/snoKlgJsASp
	 8Cmq2I8jr5J6ZACZiV8Wc5OnakFc2AVHftoOSL28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfAaL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaL57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:57:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F42218D3;
        Thu, 31 Jan 2019 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548935878;
        bh=yeagtBxukxA6Is+Vu0BlJKlmuO6fQGpQ+Jbl9+NyK5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Dg+5GFppXx1DB4fa+2k9HlPzpKqqPTRrmY/nXDL4yruBrsyjU5h0QlW2j75z+m+P
         wRMQP2TMsyXGu7Hhvb6gq/scvgdQ8zlzhMzepYrSfdgc/lSryNUnFVLZnt+Iq5VzPq
         rYHjNG0bB2IdX/eC0oYDXnoYAqDyw2gzIb4apHDs=
Date:   Thu, 31 Jan 2019 12:57:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lantianyu1986@gmail.com
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        mchehab+samsung@kernel.org, sashal@kernel.org,
        sthemmin@microsoft.com, joro@8bytes.org, x86@kernel.org,
        michael.h.kelley@microsoft.com, mingo@redhat.com,
        Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de,
        haiyangz@microsoft.com, alex.williamson@redhat.com, bp@alien8.de,
        tglx@linutronix.de, vkuznets@redhat.com,
        nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org,
        devel@linuxdriverproject.org, akpm@linux-foundation.org,
        davem@davemloft.net
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Message-ID: <20190131115756.GA19969@kroah.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e81a2db..9d62f33 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -36,6 +36,8 @@
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>  
> +extern int x2apic_phys;

Shouldn't this be in a .h file somewhere instead?

thanks,

greg k-h
