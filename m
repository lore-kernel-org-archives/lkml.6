Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dEJyChk5GVvhBQAAmS7hNA
	; Thu, 07 Jun 2018 14:16:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8AF7E608BF; Thu,  7 Jun 2018 14:16:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10C836063F;
	Thu,  7 Jun 2018 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10C836063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeFGOQt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:16:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933100AbeFGOQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:16:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43294818BAF1;
        Thu,  7 Jun 2018 14:16:46 +0000 (UTC)
Received: from redhat.com (ovpn-122-144.rdu2.redhat.com [10.10.122.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AF561002957;
        Thu,  7 Jun 2018 14:16:42 +0000 (UTC)
Date: Thu, 7 Jun 2018 10:16:41 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Airlie <airlied@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
Message-ID: <20180607141640.GA4518@redhat.com>
References: <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
 <CAPM=9tzMJq=KC+ijoj-JGmc1R3wbshdwtfR3Zpmyaw3jYJ9+gw@mail.gmail.com>
 <CAPcyv4g2XQtuYGPu8HMbPj6wXqGwxiL5jDRznf5fmW4WgC2DTw@mail.gmail.com>
 <CAPM=9twm=17t=2=M27ELB=vZWzpqM7GuwCUsC891jJ0t3JM4vg@mail.gmail.com>
 <CAPcyv4jTty4k1xXCOWbeRjzv-KjxNH1L4oOkWW1EbJt66jF4_w@mail.gmail.com>
 <20180605184811.GC4423@redhat.com>
 <CAPM=9twgL_tzkPO=V2mmecSzLjKJkEsJ8A4426fO2Nuus0N_UQ@mail.gmail.com>
 <CAPcyv4gSEYdnJKd=D-_yc3M=sY0HWjYzYhh5ha-v7KA4-40dsg@mail.gmail.com>
 <20180606000822.GE4423@redhat.com>
 <CAPcyv4gsS4xDXahZdOggURBHS2y-oJ5tPG9vXPDdY2p6jPufxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gsS4xDXahZdOggURBHS2y-oJ5tPG9vXPDdY2p6jPufxA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 07 Jun 2018 14:16:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 07 Jun 2018 14:16:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 06:33:04PM -0700, Dan Williams wrote:
> On Tue, Jun 5, 2018 at 5:08 PM, Jerome Glisse <jglisse@redhat.com> wrote:
> > On Tue, Jun 05, 2018 at 04:06:12PM -0700, Dan Williams wrote:
> [..]
> >> I want the EXPORT_SYMBOL_GPL on devm_memremap_pages() primarily for
> >> development purposes. Any new users of devm_memremap_pages() should be
> >> aware that they are subscribing to the whims of the core-VM, i.e. the
> >> ongoing evolution of 'struct page', and encourage those drivers to be
> >> upstream to improve the implementation, and consolidate use cases. I'm
> >> not qualified to comment on your "nor will it change anyone's legal
> >> position.", but I'm saying it's in the Linux kernel's best interest
> >> that new users of this interface assume they need to be GPL.
> >
> > Note that HMM isolate the device driver from struct page as long as
> > the driver only use HMM helpers to get to the information it needs.
> > I intend to be pedantic about that with any driver using HMM. I want
> > HMM to be an impedance layer that provide stable and simple API to
> > device driver while preserving freedom of change to mm.
> >
> 
> I would not classify redefining put_page() and recompiling the
> entirety of the kernel to turn on HMM as "isolating the driver from
> 'struct page'". HMM is instead isolating these out of drivers from
> ever needing to go upstream.

Well i guess it is better to leave it there as i don't think we can
agree on that. I spelled out the API contract HMM is providing and it
can be implemented in other ways. The fact that it uses ZONE_DEVICE is
an implementation details to driver using HMM. In essence driver is
not subscribing in anyway to the whims of the core-VM.

> 
> Unless the nouveau patches are using the entirety of what is already
> upstream for HMM, we should look to pare HMM back.

Nouveau patches use everything in HMM, including ZONE_DEVICE private,
excluding ZONE_DEVICE public for now. The ZONE_DEVICE public is only
meaningful on PowerPC platform for now and it requires Volta GPU.

Volta GPU is in the process of being enabled in the open source driver
and it will take few months before we reach the point where we will look
into adding ZONE_DEVICE public support for PowerPC.


> There is plenty of precedent of building a large capability
> out-of-tree and piecemeal merging it later, so I do not buy the
> "chicken-egg" argument. The change in the export is to make sure we
> don't repeat this backward "merge first, ask questions later" mistake
> in the future as devm_memremap_pages() is continuing to find new users
> like peer-to-peer DMA support and Linux is better off if that
> development is upstream. From a purely technical standpoint
> devm_memremap_pages() is EXPORT_SYMBOL_GPL because it hacks around
> several implementation details in the core kernel to achieve its goal,
> and it leaks new assumptions all over the kernel. It is strictly not a
> self contained interface.

HMM is self contain interface but i doubt i can convince you of that.

Cheers,
Jérôme
