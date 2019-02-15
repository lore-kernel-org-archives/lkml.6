Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33152C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF6B21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hUbaNlyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393773AbfBOKZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:25:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfBOKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:25:06 -0500
Received: from zn.tnic (p200300EC2BCDA500C8964896D8752F51.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:a500:c896:4896:d875:2f51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B37E1EC0324;
        Fri, 15 Feb 2019 11:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550226305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HSghZJ6Q0lV+Tg14QtkPolDDA+QQ13lLFmUiGEXiTqQ=;
        b=hUbaNlyuQwkHOerqPlNswNAPzrAOlfzRrgN39q9++Tse1fLQKgK1iggUp3GeMt6E5De9CG
        tnB2k22q6m3oA88K6BhkxQDghxmy4obQPhnuFJbwfPFBSVW+9XOiBNAq4OGMtwcNSmVIpV
        BGiEOBLLxT/lMiVIACUdqwNlniUD3aw=
Date:   Fri, 15 Feb 2019 11:24:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190215102458.GD10433@zn.tnic>
References: <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:48:16AM +0800, Dave Young wrote:
> Even we make it automatic in kernel, but we have to have some default
> value for swiotlb in case crashkernel can not find a free region under 4G.
> So this default value can not work for every use cases, people need 
> manually use crashkernel=,low and crashkernel=,high in case
> crashkernel=X does not work.

Why would the user need to find swiotlb range? The kernel has all the
information it requires at its finger tips in order to decide properly.

The user wants a crashkernel range, the kernel tries the low range =>
no workie, then it tries the next range => workie but needs to allocate
swiotlb range so that DMA can happen too. Doh, then the kernel does
allocate that too.

Why would the user need to do anything here?!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
