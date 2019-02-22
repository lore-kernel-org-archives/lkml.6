Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA820836
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBVCBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:01:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBVCBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:01:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70C098762D;
        Fri, 22 Feb 2019 02:01:38 +0000 (UTC)
Received: from redhat.com (ovpn-120-13.rdu2.redhat.com [10.10.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FFBD19C58;
        Fri, 22 Feb 2019 02:01:36 +0000 (UTC)
Date:   Thu, 21 Feb 2019 21:01:35 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Haggai Eran <haggaie@mellanox.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Aviad Yehezkel <aviadye@mellanox.com>
Subject: Re: [PATCH 1/1] RDMA/odp: convert to use HMM for ODP
Message-ID: <20190222020134.GC10607@redhat.com>
References: <20190129165839.4127-1-jglisse@redhat.com>
 <20190129165839.4127-2-jglisse@redhat.com>
 <f48ed64f-22fe-c366-6a0e-1433e72b9359@mellanox.com>
 <20190212161123.GA4629@redhat.com>
 <20190220222020.GE8415@mellanox.com>
 <20190220222924.GE29398@redhat.com>
 <20190221225937.GS17500@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221225937.GS17500@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 22 Feb 2019 02:01:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:59:37PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 20, 2019 at 05:29:24PM -0500, Jerome Glisse wrote:
> > > > 
> > > > Yes it is safe, the hmm struct has its own refcount and mirror holds a
> > > > reference on it, the mm struct itself has a reference on the mm
> > > > struct.
> > > 
> > > The issue here is that that hmm_mirror_unregister() must be a strong
> > > fence that guarentees no callback is running or will run after
> > > return. mmu_notifier_unregister did not provide that.
> > > 
> > > I think I saw locking in hmm that was doing this..
> > 
> > So pattern is:
> >     hmm_mirror_register(mirror);
> > 
> >     // Safe for driver to call within HMM with mirror no matter what
> > 
> >     hmm_mirror_unregister(mirror)
> > 
> >     // Driver must no stop calling within HMM, it would be a use after
> >     // free scenario
> 
> This statement is the opposite direction
> 
> I want to know that HMM doesn't allow any driver callbacks to be
> running after unregister - because I am going to kfree mirror and
> other memory touched by the driver callbacks.

Sorry i miss-understood your question. Yes after hmm_mirror_unregister()
you will no longer get a callback from HMM ie it is safe for you to free
any data structure associated with HMM.

Cheers,
Jérôme
