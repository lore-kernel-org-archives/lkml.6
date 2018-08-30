Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD01C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0C32073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0C32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeH3TA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:00:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbeH3TA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:00:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EA7FB5CB;
        Thu, 30 Aug 2018 14:57:55 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D13A9465E;
        Thu, 30 Aug 2018 14:57:54 +0000 (UTC)
Date:   Thu, 30 Aug 2018 22:57:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830145751.GC14702@192.168.1.2>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
 <20180830141202.GA14702@192.168.1.2>
 <20180830142739.gfpa23nvex7xbkkf@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830142739.gfpa23nvex7xbkkf@black.fi.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:57:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 14:57:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 at 05:27pm, Kirill A. Shutemov wrote:
> On Thu, Aug 30, 2018 at 02:12:02PM +0000, Baoquan He wrote:
> > On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> > > On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > > > This was suggested by Kirill several months ago, I worked out several
> > > > patches to fix, then interrupted by other issues. So sort them out
> > > > now and post for reviewing.
> > > 
> > > Thanks for doing this.
> > > 
> > > > The current upstream kernel supports 5-level paging mode and supports
> > > > dynamically choosing paging mode during bootup according to kernel
> > > > image, hardware and kernel parameter setting. This flexibility brings
> > > > several issues for kexec/kdump:
> > > > 1)
> > > > Switching between paging modes, requires changes into target kernel.
> > > > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > > > kernel if 4-level paging kernel doesn't include changes. 
> > > > 
> > > > 2)
> > > > Switching from 5-level paging to 4-level paging kernel would fail, if
> > > > kexec() put kernel image above 64TiB of memory.
> > > 
> > > I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> > > paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> > > machines with that wide physical address space (which don't support
> > > 5-level paging too).
> > 
> > Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
> > which physical RAM can mapped to. We have 256TB for the whole address
> > space for 4-level paging, that includes user space and kernel space,
> > it might not allow 256TB entirely for the direct mapping.
> > And the direct mapping is only for physical RAM mapping, and
> > kexec/kdump only cares about the physical RAM space and load them
> > inside.
> > 
> > # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
> > 
> > Not sure if my understanding is right, please correct me if I am wrong.
> 
> IIRC, we only care about the place kexec puts the kernel before it gets
> decompressed. After the decompression kernel will be put into the right
> spot.
> 
> Decompression is done in early boot where we use 1-to-1 mapping (not a
> usual kernel virtual memory layout). All 256TiB should be reachable.

My understanding that is although it's 1:1 identity mapping, it still
has to be inside available physical RAM region. I don't remember what
the old code did, now in __startup_64(), you can see that there's a
check like below, and at this time, it's still identity mapping.

        /* Is the address too large? */
        if (physaddr >> MAX_PHYSMEM_BITS)
                for (;;);

Thanks
Baoquan
