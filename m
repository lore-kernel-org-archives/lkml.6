Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA9C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FE20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZpWet7PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBEIQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:16:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEIQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:16:00 -0500
Received: from zn.tnic (p200300EC2BCB6B008896F3D5E1C66173.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:8896:f3d5:e1c6:6173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4556B1EC0911;
        Tue,  5 Feb 2019 09:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549354558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tkgFnKewGz8bffz+e/keKpf1PnYtWA6EtvbcPOHKqQg=;
        b=ZpWet7PYkPmIdtRlOLvqKagYDEsDCojZVJXdhUHInIU7pjAjyHsUL6JdEQUATSWVMc+d1M
        dTqzz42mPbbj7g4B1J2jAssa+fP5tHCnxC9xRheocexRv7XJnWiA7NYXVmsd0xYGjxXfFg
        2d+nMxf4UYQaQJJAHdHkZVB0fir6jxE=
Date:   Tue, 5 Feb 2019 09:15:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Dave Young <dyoung@redhat.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190205081552.GG21801@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204223016.GB11986@anatevka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> Is your objection only to the second fallback of allocating
> memory above >= 4GB?   Or are you objecting to allocating from
> (896 .. 4GB) as well?

My problem is why should the user need to specify high or low allocation
explicitly when we can handle all that in the kernel automatically.

The presence of crashkernel= on the cmdline sure means that the user
wants to allocate memory for a second kernel.

Now, if the requested allocation fails, we say:

  Error reserving crashkernel

So, instead of saying that, we can *try* *again* and say

  Error reserving requested crashkernel at @..., attempting a high range.

and run memblock_find_in_range() on the other regions which we deemed
are ok to allocate from.

Why aren't we doing that by default instead of placing all those
different options in front of the user and expecting her/him to know
something about all those magic ranges?

I don't think most of the users care about where the kernel gets
allocated - all they want is a working kdump setup.

> Falling back to allocating < 4GB probably satisfes most of the cases
> where the original allocation fails.

Yes. Now make that automatic.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
