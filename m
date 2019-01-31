Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E50CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAF62087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dOaTz3H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAaXru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:47:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfAaXru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:47:50 -0500
Received: from zn.tnic (p200300EC2BCC5900604F5F4DB2DDD4A2.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:604f:5f4d:b2dd:d4a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 683EC1EC00EE;
        Fri,  1 Feb 2019 00:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548978468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V7cFe6jdr8idNow2ocyuWL3XVGrMRuEFEUqKcnlSqoI=;
        b=dOaTz3H/KB9bvEBUHdhWm8XjhS5eTwvql5mpzwHwfhiX0+xL3HfGddX0aTglojdJzqUNIQ
        Yr6aGSVgEWF2qno+CSJlGCFd8uDAKLJZTuvflQlQPJSGzLhl8xRQskQVg3j9AV3p5W9ZmZ
        lT9qTtmAOfmLvCVX1wBuCdo+Q67HSmA=
Date:   Fri, 1 Feb 2019 00:47:40 +0100
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
Message-ID: <20190131234740.GO6749@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131222732.GA946@anatevka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:27:32PM -0700, Jerry Hoemann wrote:
> So even if a system administrator is diligent and tests
> that a chosen kdump configuration works, that configuration
> might not work on some random reboot 7 months in the future.

Jerry, did you read the rest of the thread where I'm *actually*
suggesting to make the allocation code more robust against such
failures?

Doesn't look like it...

Now let's look at the code:

The "high" allocation does:

                crash_base = memblock_find_in_range(CRASH_ALIGN,
                                                    high ? CRASH_ADDR_HIGH_MAX
                                                         : CRASH_ADDR_LOW_MAX,
                                                    crash_size, CRASH_ALIGN);

where high=true and CRASH_ADDR_HIGH_MAX on 64-bit is MAXMEM:

# define CRASH_ADDR_HIGH_MAX    MAXMEM

The second fallback in the suggested patch does the same:

+               /*
+                * crashkernel=X reserve below 4G fails? Try MAXMEM
+                */
+               if (!high && !crash_base)
+                       crash_base = memblock_find_in_range(CRASH_ALIGN,
+                                               CRASH_ADDR_HIGH_MAX,
+                                               crash_size, CRASH_ALIGN);

and yet I get back that falling back to "high" if the first allocation
doesn't succeed is not something we should do by default because of
reasons. But this patch *practically* *does* it.

So no, until this hasn't been done cleanly and properly explained, we'll
be in a holding pattern.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
