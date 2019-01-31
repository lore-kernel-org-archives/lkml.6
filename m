Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD73C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBE0218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfAaH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaH7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:59:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68BB213A98;
        Thu, 31 Jan 2019 07:59:15 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4E5600D7;
        Thu, 31 Jan 2019 07:59:10 +0000 (UTC)
Date:   Thu, 31 Jan 2019 15:59:07 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125140823.GC27998@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 31 Jan 2019 07:59:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/19 at 03:08pm, Borislav Petkov wrote:
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use. 
> > 
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
> 
> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.

Got more about this, actually the thing is for large server with very
huge memory and also possible a lot of io devices.  The UEFI IO drivers
could allocate a lot memory under 896M,  so it will leave small room for
crashkernel=X

Also if the memory is huge, then copying the vmcore will be very slow,
people want to use big makedumpfile bitmap buffer, and multithread, then
kdump kernel needs more memory, they can choose ,high to get more
memory.

But for common use cases, if one does not need so much kdump memory
reserved he/she can just use crashkernel=X.


> 
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.

As Pingfan/me mentioned in another reply, there are two reasons:
1. old kexec-tools can not load kernel to high memory
2. ,high will not work on some systems without some amounts of low
memory so it nees reserve extra low memory, it is bad for people who do
not want it. 

> 
> > Good question, still it may be some historical reason, but it is good to
> > make them clear and rethink about it after long time.
> > 
> > I also want to understand, need dig the log more.
> 
> Good idea. That would be a very nice cleanup. :-)

Let's review these different parameters:
>         crashkernel=size[KMG][@offset[KMG]]

Did not get the initial commit for this, it should be the very old
format, and kernel did not find the base address automatically for the
size

Other arches still use this, for example mips code seems needs explict
@offset, see the function mips_parse_crashkernel in
arch/mips/kernel/setup.c

Probably there are other arches as well which only support this format.

>         crashkernel=range1:size1[,range2:size2,...][@offset]

This is nice param which can help to dynamically reserve different size
depends on system memory.

>         crashkernel=size[KMG],high
>         crashkernel=size[KMG],low

We have talked about these two.  It is not graceful, but seems no way to
improve it due to the swiotlb issue.

Thanks
Dave
