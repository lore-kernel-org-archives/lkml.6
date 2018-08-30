Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8D2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF8D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeH3SOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:14:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728970AbeH3SOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:14:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A152C40201BD;
        Thu, 30 Aug 2018 14:12:18 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 751332166B41;
        Thu, 30 Aug 2018 14:12:16 +0000 (UTC)
Date:   Thu, 30 Aug 2018 22:12:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830141202.GA14702@192.168.1.2>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 14:12:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 14:12:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > This was suggested by Kirill several months ago, I worked out several
> > patches to fix, then interrupted by other issues. So sort them out
> > now and post for reviewing.
> 
> Thanks for doing this.
> 
> > The current upstream kernel supports 5-level paging mode and supports
> > dynamically choosing paging mode during bootup according to kernel
> > image, hardware and kernel parameter setting. This flexibility brings
> > several issues for kexec/kdump:
> > 1)
> > Switching between paging modes, requires changes into target kernel.
> > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > kernel if 4-level paging kernel doesn't include changes. 
> > 
> > 2)
> > Switching from 5-level paging to 4-level paging kernel would fail, if
> > kexec() put kernel image above 64TiB of memory.
> 
> I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> machines with that wide physical address space (which don't support
> 5-level paging too).

Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
which physical RAM can mapped to. We have 256TB for the whole address
space for 4-level paging, that includes user space and kernel space,
it might not allow 256TB entirely for the direct mapping.
And the direct mapping is only for physical RAM mapping, and
kexec/kdump only cares about the physical RAM space and load them
inside.

# define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)

Not sure if my understanding is right, please correct me if I am wrong.

Thanks
Baoquan
