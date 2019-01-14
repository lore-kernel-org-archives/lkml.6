Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C01C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28512206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547484010;
	bh=GIP5HC2O4KqNy7EkcREUu2C1xK30s0cCJUAuRFWLw2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BXJ/vQCbcpGNsJfMkNnOmu8b159oBqNeLXWHCGWkf+eNAcRxvGZ4eDDncWl8Y0b8r
	 OiEfCIlwYa3JUZpleoHs8o/K38n+RM+gHtVMlXVedfbB0wCMwYDxrf6HnKOnVAL6lj
	 tT/7t9rIVzGAe/rgbEL1zV8a2POXRMI9MKTIsrzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfANQkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:52892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbfANQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:40:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52FDEADD2;
        Mon, 14 Jan 2019 16:40:07 +0000 (UTC)
Date:   Mon, 14 Jan 2019 17:40:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Message-ID: <20190114164004.GL21345@dhcp22.suse.cz>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
 <20190114135001.w2wpql53zitellus@kshutemo-mobl1>
 <MWHPR06MB2896ACD09C21B2939959C8A8EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR06MB2896ACD09C21B2939959C8A8EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-01-19 16:29:29, Harrosh, Boaz wrote:
>  Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Fri, Jan 11, 2019 at 03:28:37PM -0800, Mike Kravetz wrote:
> >> Ok, I just wanted to ask the question.  I've seen application code doing
> >> the 'mmap sufficiently large area' then unmap to get desired alignment
> >> trick.  Was wondering if there was something we could do to help.
> >
> > Application may want to get aligned allocation for different reasons.
> > It should be okay for userspace to ask for size + (alignment - PAGE_SIZE)
> > and then round up the address to get the alignment. We basically do the
> > same on kernel side.
> >
> 
> This is what we do and will need to keep doing for old Kernels.
> But it is a pity that those holes can not be reused for small maps, and most important
> that we cannot have "mapping holes" around the mapping that catch memory
> overruns

What does prevent you from mapping a larger area and MAP_FIXED,
PROT_NONE over it to get the protection?
 
> > For THP, I believe, kernel already does The Right Thing™ for most users.
> > User still may want to get speific range as THP (to avoid false sharing or
> > something).
> 
> I'm an OK Kernel programmer.  But I was not able to create a HugePage mapping
> against /dev/shm/ in a reliable way. I think it only worked on Fedora 28/29
> but not on any other distro/version. (MMAP_HUGE)

Are you mixing hugetlb rather than THP?

> We run with our own compiled Kernel on various distros, THP is configured
> in but mmap against /dev/shm/ never gives me Huge pages. Does it only
> work with unanimous mmap ? (I think it is mount dependent which is not
> in the application control)

If you are talking about THP then you have to enable huge pages for the
mapping AFAIR.
-- 
Michal Hocko
SUSE Labs
