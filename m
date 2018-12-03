Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5AA20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5AA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLCXh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:37:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeLCXh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3816E30014DC;
        Mon,  3 Dec 2018 23:37:56 +0000 (UTC)
Received: from redhat.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BDF460923;
        Mon,  3 Dec 2018 23:37:53 +0000 (UTC)
Date:   Mon, 3 Dec 2018 18:37:52 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, stable@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 0/7] mm: Merge hmm into devm_memremap_pages, mark
 GPL-only
Message-ID: <20181203233751.GA20742@redhat.com>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 03 Dec 2018 23:37:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:20:55PM -0800, Andrew Morton wrote:
> On Tue, 20 Nov 2018 15:12:49 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

[...]

> > I am also concerned that HMM was designed in a way to minimize further
> > engagement with the core-MM. That, with these hooks in place,
> > device-drivers are free to implement their own policies without much
> > consideration for whether and how the core-MM could grow to meet that
> > need. Going forward not only should HMM be EXPORT_SYMBOL_GPL, but the
> > core-MM should be allowed the opportunity and stimulus to change and
> > address these new use cases as first class functionality.
> > 
> 
> The arguments are compelling.  I apologize for not thinking of and/or
> not being made aware of them at the time.

So i wanted to comment on that part. Yes HMM is an impedence layer
that goes both way ie device driver are shielded from core mm and
core mm folks do not need to understand individual driver to modify
mm, they only need to understand what is provided to the driver by
HMM (and keeps HMM promise intact from driver POV no matter how it
is achieve). So this is intentional.

Nonetheless I want to grow core mm involvement in managing those
memory (see patchset i just posted about hbind() and heterogeneous
memory system). But i do not expect that core mm will be in full
control at least not for some time. The historical reasons is that
device like GPU are not only use for compute (which is where HMM
gets use) but also for graphics (simple desktop or even games).
Those are two differents workload using different API (CUDA/OpenCL
for compute, OpenGL/Vulkan for graphics) on the same underlying
hardware.

Those API expose the hardware in incompatible way when it comes to
memory management (especialy API like Vulkan). Managing memory page
wise is not well suited for graphics. The issues comes from the
fact that we do not want to exclude either workload from happening
concurrently (running your destkop while some compute job is running
in the background). So for this to work we need to keep the device
driver in control of its memory (hence why callback when page are
freed for instance). We also need to forbid things like pinning any
device memory pages ...


I still expect some commonality to emerge accross different hardware
so that we can grow more things and share more code into core mm but
i want to get their organicaly, not forcing everyone into a design
today. I expect this will happens by going from high level concept,
how things get use in userspace from end user POV, and working back-
ward from there to see what common API (if any) we can provided to
catter those common use case.

Cheers,
Jérôme
