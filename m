Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C785ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE5F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ht/a+Od6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE5F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGQMuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:50:20 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57053 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbeGQMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:50:20 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 67DEA25BEBD;
        Tue, 17 Jul 2018 22:17:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531829875; bh=Z/rf9VbXzABrpd78lm3tl+kNWysE3SLlzVis07nPW10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ht/a+Od6mawSz2J9CDNdC2IC0I4U6avbTBmsZt7G7vo42cZrDNpNs15XHw4NuBF3/
         XdSaTzwzU1YMug6Vjh1v0U1MDpp4mioJvcDeH9b9hKBygZdyvkWI0/FwHyceFEmRcQ
         sSQak7flPZ1t8K5VwnVGRgvxSAzY9EWUtkIQvjRQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6DEDB940456; Tue, 17 Jul 2018 14:17:53 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:17:53 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Fix use-after-free on subsequent port
 startup
Message-ID: <20180717121752.jdsefuqhlidxkztp@verge.net.au>
References: <20180717085810.23502-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717085810.23502-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:58:10AM +0200, Geert Uytterhoeven wrote:
> sci_request_irq() checks port->irqstr[j] for a NULL pointer, to decide
> if a fallback interrupt name string should be allocated or not.
> 
> While this string is freed during port shutdown, the pointer is not
> zeroed.  Hence on a subsequent startup of the port, it will still be
> pointing to the freed memory, leading to e.g.
> 
>     WARNING: CPU: 0 PID: 404 at fs/proc/generic.c:388 __proc_create+0xbc/0x260
>     name len 0
> 
> or to a crash (the latter is more likely with CONFIG_DEBUG_SLAB=y, due
> to the poisoning of freed memory).
> 
> Instead of zeroeing the pointer at multiple places, preinitialize
> port->irqstr[j] to zero to fix this.
> 
> Fixes: 8b0bbd956228ae87 ("serial: sh-sci: Add support for R7S9210")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

