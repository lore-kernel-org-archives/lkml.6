Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DAF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfBSU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:58:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfBSU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:57:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF9C981DF5;
        Tue, 19 Feb 2019 20:57:58 +0000 (UTC)
Received: from redhat.com (ovpn-122-134.rdu2.redhat.com [10.10.122.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1766600C8;
        Tue, 19 Feb 2019 20:57:54 +0000 (UTC)
Date:   Tue, 19 Feb 2019 15:57:52 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        KVM list <kvm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 0/9] mmu notifier provide context informations
Message-ID: <20190219205751.GD3959@redhat.com>
References: <20190219200430.11130-1-jglisse@redhat.com>
 <CAPcyv4gq23RXk3BTqP2O+gi3FGE85NSGXD8bdLk+_cgtZrn+Kg@mail.gmail.com>
 <20190219203032.GC3959@redhat.com>
 <CAPcyv4gUFSA6u77dGA6XxO41217zQ27DNteiHRG515Gtm_uGgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gUFSA6u77dGA6XxO41217zQ27DNteiHRG515Gtm_uGgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 20:57:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:40:37PM -0800, Dan Williams wrote:
> On Tue, Feb 19, 2019 at 12:30 PM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Feb 19, 2019 at 12:15:55PM -0800, Dan Williams wrote:
> > > On Tue, Feb 19, 2019 at 12:04 PM <jglisse@redhat.com> wrote:
> > > >
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > >
> > > > Since last version [4] i added the extra bits needed for the change_pte
> > > > optimization (which is a KSM thing). Here i am not posting users of
> > > > this, they will be posted to the appropriate sub-systems (KVM, GPU,
> > > > RDMA, ...) once this serie get upstream. If you want to look at users
> > > > of this see [5] [6]. If this gets in 5.1 then i will be submitting
> > > > those users for 5.2 (including KVM if KVM folks feel comfortable with
> > > > it).
> > >
> > > The users look small and straightforward. Why not await acks and
> > > reviewed-by's for the users like a typical upstream submission and
> > > merge them together? Is all of the functionality of this
> > > infrastructure consumed by the proposed users? Last time I checked it
> > > was only a subset.
> >
> > Yes pretty much all is use, the unuse case is SOFT_DIRTY and CLEAR
> > vs UNMAP. Both of which i intend to use. The RDMA folks already ack
> > the patches IIRC, so did radeon and amdgpu. I believe the i915 folks
> > were ok with it too. I do not want to merge things through Andrew
> > for all of this we discussed that in the past, merge mm bits through
> > Andrew in one release and bits that use things in the next release.
> 
> Ok, I was trying to find the links to the acks on the mailing list,
> those references would address my concerns. I see no reason to rush
> SOFT_DIRTY and CLEAR ahead of the upstream user.

I intend to post user for those in next couple weeks for 5.2 HMM bits.
So user for this (CLEAR/UNMAP/SOFTDIRTY) will definitly materialize in
time for 5.2.

ACKS AMD/RADEON https://lkml.org/lkml/2019/2/1/395
ACKS RDMA https://lkml.org/lkml/2018/12/6/1473

For KVM Andrea Arcangeli seems to like the whole idea to restore the
change_pte optimization but i have not got ACK from Radim or Paolo,
however given the small performance improvement figure i get with it
i do not see while they would not ACK.

https://lkml.org/lkml/2019/2/18/1530

Cheers,
Jérôme
