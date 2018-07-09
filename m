Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BBB208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BBB208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeGIFss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:48:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIFsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:48:46 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB2E22C;
        Mon,  9 Jul 2018 05:48:45 +0000 (UTC)
Date:   Mon, 9 Jul 2018 07:48:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        stable@vger.kernel.org
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Message-ID: <20180709054842.GB7618@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709044444.6397-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> Depending on ABI "long long" type of a particular 32-bit CPU
> might be aligned by either word (32-bits) or double word (64-bits).
> Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> 
> At least for 32-bit ARC cores ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. Which is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.

So is this something you hit today?  If not, why is this needed for
stable kernels?

> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.

Are you going to hit this code with all types of structures?  What
happens when you do have an unaligned access?

> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You didn't cc: this address :(

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> 
> Changes v1 -> v2:
> 
>  * Reworded commit message
>  * Inserted comment right in source [Thomas]
> 
>  drivers/base/devres.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index f98a097e73f2..466fa59c866a 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
>  
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * Depending on ABI "long long" type of a particular 32-bit CPU
> +	 * might be aligned by either word (32-bits) or double word (64-bits).
> +	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> +	 */
> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));
>  };

Does this change the padding today for any other arches?  If so, does
the increased memory usage cause any noticable issues?

thanks,

greg k-h
