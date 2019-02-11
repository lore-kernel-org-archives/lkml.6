Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89BAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90326222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfBKRso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:48:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBKRsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:48:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F53640229;
        Mon, 11 Feb 2019 17:48:43 +0000 (UTC)
Received: from redhat.com (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 161A95D736;
        Mon, 11 Feb 2019 17:48:40 +0000 (UTC)
Date:   Mon, 11 Feb 2019 12:48:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 2/4] kvm: Add host side support for free memory hints
Message-ID: <20190211124203-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181546.12095.81356.stgit@localhost.localdomain>
 <20190209194108-mutt-send-email-mst@kernel.org>
 <39c915a7-e317-db01-0286-579230f37da2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c915a7-e317-db01-0286-579230f37da2@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Feb 2019 17:48:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:41:19AM -0800, Dave Hansen wrote:
> On 2/9/19 4:44 PM, Michael S. Tsirkin wrote:
> > So the policy should not leak into host/guest interface.
> > Instead it is better to just keep the pages pinned and
> > ignore the hint for now.
> 
> It does seems a bit silly to have guests forever hinting about freed
> memory when the host never has a hope of doing anything about it.
> 
> Is that part fixable?


Yes just not with existing IOMMU APIs.

It's in the paragraph just above that you cut out:
	Yes right now assignment is not smart enough but generally
	you can protect the unused page in the IOMMU and that's it,
	it's safe.

So e.g.
	extern int iommu_remap(struct iommu_domain *domain, unsigned long iova,
				     phys_addr_t paddr, size_t size, int prot);


I can elaborate if you like but generally we would need an API that
allows you to atomically update a mapping for a specific page without
perturbing the mapping for other pages.

-- 
MST
