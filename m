Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E967C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A969218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfBRBsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:48:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfBRBsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:48:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAB04461FF;
        Mon, 18 Feb 2019 01:48:37 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCCBA60139;
        Mon, 18 Feb 2019 01:48:30 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:48:20 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
References: <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215102458.GD10433@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 18 Feb 2019 01:48:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/19 at 11:24am, Borislav Petkov wrote:
> On Tue, Feb 12, 2019 at 04:48:16AM +0800, Dave Young wrote:
> > Even we make it automatic in kernel, but we have to have some default
> > value for swiotlb in case crashkernel can not find a free region under 4G.
> > So this default value can not work for every use cases, people need 
> > manually use crashkernel=,low and crashkernel=,high in case
> > crashkernel=X does not work.
> 
> Why would the user need to find swiotlb range? The kernel has all the
> information it requires at its finger tips in order to decide properly.
> 
> The user wants a crashkernel range, the kernel tries the low range =>
> no workie, then it tries the next range => workie but needs to allocate
> swiotlb range so that DMA can happen too. Doh, then the kernel does
> allocate that too.

It is ideal if kernel can do it automatically, but I'm not sure if
kernel can predict the swiotlb reserved size automatically.

Let's add more people to seek for comments. 

> 
> Why would the user need to do anything here?!
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
