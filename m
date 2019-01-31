Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6763DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317272087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AZPtvn+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfAaK5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:57:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:57:37 -0500
Received: from zn.tnic (p200300EC2BCC59000D578CD19F54A2D7.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:d57:8cd1:9f54:a2d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 638A71EC027A;
        Thu, 31 Jan 2019 11:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548932256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O0xgpUBrruCmEZcMdSUBZ+v15pkz7mxCV1nrHgWcCFM=;
        b=AZPtvn+j6oO8yD2eN1UK9iRzEm6i390ECajihAC3AWkgyQ9LHt3U1YIauLXOFuJg1EThaY
        j5hGYvUEz/k4Yg3Rs33MeQoyJl4+otw8JHaln3VZGV6wOzxBV5WJMKsjDq2xTExhwnNsMQ
        KV5Q0/qvZww9uBMOBWwp2EE+9dPx7+I=
Date:   Thu, 31 Jan 2019 11:57:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131105732.GC6749@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:59:07PM +0800, Dave Young wrote:
> As Pingfan/me mentioned in another reply, there are two reasons:
> 1. old kexec-tools can not load kernel to high memory
> 2. ,high will not work on some systems without some amounts of low
> memory so it nees reserve extra low memory, it is bad for people who do
> not want it.

Let's see: we don't enable high by default because of old kexec-tools
and some systems which do some funky reservations.

But this patch kinda enables high by trying a couple more regions.

So we don't really need this - we simply need to tell people to use high
if it fails with KASLR, AFAICT.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
