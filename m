Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A631C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0FE218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RqK3LrPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAaKub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:50:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33834 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfAaKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:50:29 -0500
Received: from zn.tnic (p200300EC2BCC59000D578CD19F54A2D7.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:d57:8cd1:9f54:a2d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE16C1EC04F3;
        Thu, 31 Jan 2019 11:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548931828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iZxgZbiqmspQrT4l2OrjAvZyk2r8+D0wludez4XwuP4=;
        b=RqK3LrPxPgYRIxRaDwU8FvsoNbIKWK+wUjyKreQhK8wqv+bCqW+VFL3ulEJD3LKFIXt3M2
        PWBlCfZGAQu6mzEk5YHl07gSgZjco95Dnou3NGlks4yMTJiCRGEArizDVtdxJElBxYxHYC
        1m069eHjj6A2qVXzI7TA9+lIvaEK9+4=
Date:   Thu, 31 Jan 2019 11:50:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131105019.GB6749@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 01:51:45PM +0800, Pingfan Liu wrote:
> Sorry, can not catch up with you. Do you suggestion
> memblock_find_in_range(0, kernel_start) and
> memblock_find_in_range(kernel_end, mem_end)? But the memory is
> truncated into fraction by many component which call
> memblock_reserve(), besides kernel.

extract_kernel() selects the physical address where the place the
kernel. You can use that physical address to figure out where to
allocate the crash kernel range.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
