Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF18C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40D720871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40D720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeGKOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:18:17 -0400
Received: from ozlabs.org ([203.11.71.1]:48503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeGKOSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:18:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qgz86312zB4MP;
        Thu, 12 Jul 2018 00:13:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Daniel Klamt <eleon@ele0n.de>,
        Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep with usleep_range
In-Reply-To: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
References: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
Date:   Thu, 12 Jul 2018 00:13:39 +1000
Message-ID: <878t6hami4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Klamt <eleon@ele0n.de> writes:
> Replaced msleep for less than 10ms with usleep_range because will
> often sleep longer than intended.
> For original explanation see:
> Documentation/timers/timers-howto.txt
>
> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>
> ---
>  arch/powerpc/sysdev/xive/native.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 311185b9960a..b164b1cdf4d6 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -109,7 +109,7 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
>  		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100)
>  	}

We have actually recently added OPAL_BUSY_DELAY_MS (see opal.h) and
should convert these to use that. eg:

		msleep(OPAL_BUSY_DELAY_MS);


That has the effect of documenting that this is a short sleep to wait
for opal (our firmware), and we aren't concerned about rounding errors
in msleep().

If you send me a patch doing that I'd be happy to merge it.

cheers
