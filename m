Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02481208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02481208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeLCScD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:32:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:29573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeLCScD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:32:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115586726"
Received: from ahduyck-desk1.amr.corp.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 10:32:00 -0800
Message-ID: <714716fde90865e195848f1a9a38e9134e75ad29.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] kvm: Use huge pages for DAX-backed files
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Barret Rhoden <brho@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Date:   Mon, 03 Dec 2018 10:32:00 -0800
In-Reply-To: <20181203124051.05c1d2ce@gnomeregan.cam.corp.google.com>
References: <20181109203921.178363-1-brho@google.com>
         <20181114215155.259978-1-brho@google.com>
         <CAPcyv4jga=HnsfHffWoo+JjRUBf3stD4VP3B5X5xSOZb=yh+Mw@mail.gmail.com>
         <20181203124051.05c1d2ce@gnomeregan.cam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 12:40 -0500, Barret Rhoden wrote:
> On 2018-11-14 at 16:55 Dan Williams <dan.j.williams@intel.com> wrote:
> > [ add Alex who is looking into removing PageReserved for DAX pages. ]
> 
> Thanks.  I can keep my eye out for his patches and repost once that's
> done.  
> 
> Alternatively, if you all want to merge this before the PageReserved /
> DAX changes, then I can repost - just Ack/Review tags.  It's harmless
> with the existing PageReserved behavior.
> 
> Thanks,
> 
> Barret

So the latest version of my generic memory init patches are up at:

https://lore.kernel.org/lkml/154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com/

To be honest I am not entirely convinced that dropping PageReserved is
the right thing to do for DAX pages. I've been trying to work out a few
different issues but not having much luck. It seems like the main issue
is that the PageReserved bit is being used to indicate 2 different
things in a few spots throughout the kernel.

The definition of the PG_reserved flag reads like it should apply to
DAX pages:
  PG_reserved is set for special pages, which can never be swapped out.
  Some of them might not even exist...

PageReserved essentially means you aren't supposed to be migrating or
swapping the page. The problem here is that I believe this logic should
apply to DAX pages and so in many cases it makes sense to leave the
flag set for DAX pages. Otherwise you have to go through and start
special casing all the spots where normal memory falls through and add
a check to see if we have a DAX page.

The second use for the PG_reserved flag is to test for if you can pin
the page or not. This I think is the reason why many are just assuming
PageReserved == MMIO like KVM does. However this is a bad assumption to
be making since the introduction of DAX, HMM, and P2PDMA allows MMIO
memory to start doing different things like supporting pinning. I also
believe it would be a bad reason to clear the flag for DAX pages.

Thanks.

- Alex

