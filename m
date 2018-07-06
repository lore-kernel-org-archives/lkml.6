Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E01C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C80224B2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NcshXBv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C80224B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933320AbeGFXYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:24:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeGFXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IeOSZwXdCoRO4/gJjAF4hk8AwagB7nqnBm8pzUaBleg=; b=NcshXBv9reOLmvqH2b5dJ1EWQ
        NU9iqTII8bY//06v1fmUbirPcitdHP4o94Maa9fP/p51+oESxJvLaqN5ktMVd9ofj9mCDfAYKbRUo
        ygRmN88BPcdq4h/LLan/Buh4oHkZ6HlrE/wVd8YRwshsjvjG7u5H+v2Qp9DgHRezL0a0uAcoEwSH4
        IgUps3o+htusakjmwd/Ku/N07t3YNKv+EsLEYSshTngtvEGaAMLbgdxpuQdreIMSTAu1EYbU27cds
        yDKAdL49YGyklMEtzhGkQIhXFrqSIeCvrFHtpuwggWXqbTzXMajKIbX6linYAEeEFugBG7aisqmqJ
        EHTOpA7qw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fba5U-0006w1-MO; Fri, 06 Jul 2018 23:24:28 +0000
Date:   Fri, 6 Jul 2018 16:24:27 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mattia Dongili <malattia@linux.it>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: sony-laptop: Mark expected switch
 fall-through
Message-ID: <20180706232427.GC3041@fury>
References: <20180705204703.GA12352@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705204703.GA12352@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:47:03PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/platform/x86/sony-laptop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index b205b03..e614cb7 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -4427,6 +4427,7 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
>  	default:
>  		dprintk("Resource %d isn't an IRQ nor an IO port\n",
>  			resource->type);
> +		/* fall through */

Here too, I wonder if this is intentional. Either way, from what I can see, the
final line in the function:

	return AE_CTRL_TERMINATE;

Is unreachable as there are no "break" statements in the switch, and the default
falls through to return AE_OK. Something doesn't seem right here.

-- 
Darren Hart
VMware Open Source Technology Center
