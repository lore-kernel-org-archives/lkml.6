Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14BEC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6020645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE6020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJMBsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31E36C04B95A;
        Fri, 12 Oct 2018 18:14:28 +0000 (UTC)
Received: from redhat.com (ovpn-125-5.rdu2.redhat.com [10.10.125.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A37282CA;
        Fri, 12 Oct 2018 18:14:27 +0000 (UTC)
Date:   Fri, 12 Oct 2018 14:14:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, stable@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] mm: Merge hmm into devm_memremap_pages, mark
 GPL-only
Message-ID: <20181012181425.GF6593@redhat.com>
References: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Oct 2018 18:14:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:49:31AM -0700, Dan Williams wrote:
> [ apologies for the resend, script error ]
> 
> Changes since v6 [1]:
> * Rebase on next-20181008 and fixup conflicts with the xarray conversion
>   and hotplug optimizations
> * It has soaked on a 0day visible branch for a few days without any
>   reports.
> 
> [1]: https://lkml.org/lkml/2018/9/13/104
> 
> ---
> 
> Hi Andrew,
> 
> Jérôme has reviewed the cleanups, thanks Jérôme. We still disagree on
> the EXPORT_SYMBOL_GPL status of the core HMM implementation, but Logan,
> Christoph and I continue to support marking all devm_memremap_pages()
> derivatives EXPORT_SYMBOL_GPL.
> 
> HMM has been upstream for over a year, with no in-tree users it is clear
> it was designed first and foremost for out of tree drivers. It takes
> advantage of a facility Christoph and I spearheaded to support
> persistent memory. It continues to see expanding use cases with no clear
> end date when it will stop attracting features / revisions. It is not
> suitable to export devm_memremap_pages() as a stable 3rd party driver
> api.
> 
> devm_memremap_pages() is a facility that can create struct page entries
> for any arbitrary range and give out-of-tree drivers the ability to
> subvert core aspects of page management. It, and anything derived from
> it (e.g. hmm, pcip2p, etc...), is a deep integration point into the core
> kernel, and an EXPORT_SYMBOL_GPL() interface. 
> 
> Commit 31c5bda3a656 "mm: fix exports that inadvertently make put_page()
> EXPORT_SYMBOL_GPL" was merged ahead of this series to relieve some of
> the pressure from innocent consumers of put_page(), but now we need this
> series to address *producers* of device pages.
> 
> More details and justification in the changelogs. The 0day
> infrastructure has reported success across 152 configs and this survives
> the libnvdimm unit test suite. Aside from the controversial bits the
> diffstat is compelling at:
> 
> 	7 files changed, 126 insertions(+), 323 deletions(-)
> 
> Note that the series has some minor collisions with Alex's recent series
> to improve devm_memremap_pages() scalability [2]. So, whichever you take
> first the other will need a minor rebase.
> 
> [2]: https://www.lkml.org/lkml/2018/9/11/10

I am fine with this patchset going in (i reviewed it and tested it with
HMM on nouveau), Dan and Christoph did author the original code around
devm_memremap_pages() and thus ultimately they are the one who should
decide over GPL export or not.

Cheers,
Jérôme
