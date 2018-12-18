Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB34921873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545142963;
	bh=U6eYnHDP79qoRr8beUo2m7L2LIqIFCJ/Yja19MOPzuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=riXIJVEN36B/GDESKdvUk4dYfjjC/3ILePweLKO0TWhieqOeabsbuUATSgrf2ITf3
	 3umQMgeERTF0/T4rgW5nLIH0Lz2WFGqVRriQWox/ZZysuS37fDic0KnCpUyGMWTSvE
	 VyAzyoPmRreyD2L1VEnPsez6QyGkCwjaezP1XE2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLROWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:22:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:52972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeLROWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:22:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55CA8B11B;
        Tue, 18 Dec 2018 14:22:40 +0000 (UTC)
Date:   Tue, 18 Dec 2018 15:22:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, mpe@ellerman.id.au,
        paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out
 of CMA region
Message-ID: <20181218142239.GL30879@dhcp22.suse.cz>
References: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
 <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 15:12:26, Andrew Morton wrote:
> On Wed, 21 Nov 2018 14:52:56 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
> > Subject: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
> 
> Asterisk in title is strange?
> 
> > ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
> > be able to start guest if we fail to allocate hash page table. We have observed
> > hash table allocation failure because we failed to migrate pages out of CMA region
> > because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
> > the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
> > won't be able to migrate those pages. The pages are also pinned for the lifetime of the
> > guest.
> > 
> > Currently we support migration of non-compound pages. With THP and with the addition of
> >  hugetlb migration we can end up allocating compound pages from CMA region. This
> > patch series add support for migrating compound pages. The first path adds the helper
> > get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
> > CMA region before incrementing the reference count. 
> 
> Very little review activity.  Perhaps Andrey and/or Michal can find the
> time..

I will unlikely find some time before the end of the year. Sorry about
that.
-- 
Michal Hocko
SUSE Labs
