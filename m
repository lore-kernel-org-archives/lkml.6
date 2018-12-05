Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE30C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7636A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oK+OVPWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7636A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeLERAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:00:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLERAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:00:17 -0500
Received: from zn.tnic (p200300EC2BC09900993F789616C996F0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:993f:7896:16c9:96f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA4AD1EC04FB;
        Wed,  5 Dec 2018 18:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544029215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=voW4wYeKizkVUlQsV5DHgfU78kjBIXzH1PBWZMim/KI=;
        b=oK+OVPWQ98uZi6/szpHNu4o8almrhr45+z57mmVjFdUO2tUDJkW+uvHtnEgj4FT2RQj9cX
        UQUW3BXZQuYh9nttrMfFaJrxOzr1WXDgGhF2anPQHNlQ01zvGPRqkmk8UBcjVj4+JL10qH
        l0FmVBrjmir7sB6Bj4tbyBVLxRIM+P4=
Date:   Wed, 5 Dec 2018 18:00:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181205170006.GK29510@zn.tnic>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205163037.GC109259@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:30:37PM +0100, Ingo Molnar wrote:
> Would it make sense to organize it a bit more and separate out vendor 
> specific functionality:
> 
>   mce/cpu/intel.c
>   mce/cpu/intel-p5.c
>   mce/cpu/amd.c
>   mce/cpu/winchip.c

That's too fine-grained IMO and look at the path we'd get then:

arch/x86/kernel/cpu/mce/cpu/intel.c
		^^^     ^^^

which brings me to something we already talked about: the "kernel" part
of the arch/x86/ paths. See this thread:

https://lkml.kernel.org/r/20140114185802.GB29871@pd.tnic

from 2014. We practically agreed there that "kernel/" is redundant as it
all is kernel. So maybe we should start moving stuff up into arch/x86/
and then kill kernel/ eventually.

> This way there's a clear separation between low level, vendor specific 
> MCE logic and higher level MCE logic.
> 
> mce/apei.c, if this is an Intel-only feature, could perhaps become 
> mce/cpu/intel-apei.c?

Yeah, I think the pile in mce/ is pretty succinct now. We can always
separate it more later, if it starts to hurt but right now it is ok,
IMO.

> Anyway, your patch is fine too, so whichever subset you decide to use:
> 
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
