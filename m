Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E69C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8289C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBHBoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:44:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:39460 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfBHBoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:44:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 17:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="298118289"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2019 17:44:20 -0800
Date:   Thu, 7 Feb 2019 17:44:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190208014403.GA32701@iweiny-DESK2.sc.intel.com>
References: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard>
 <20190207052310.GA22726@ziepe.ca>
 <CAPcyv4jd4gxvt3faYYRbv5gkc6NGOKjY_Z-P0Ph=ss=gWZw7sA@mail.gmail.com>
 <20190207171736.GD22726@ziepe.ca>
 <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:54:58PM -0800, Dan Williams wrote:
> On Thu, Feb 7, 2019 at 9:17 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > Insisting to run RDMA & DAX without ODP and building an elaborate
> > revoke mechanism to support non-ODP HW is inherently baroque.
> >
> > Use the HW that supports ODP.
> >
> > Since no HW can do disable of a MR, the escalation path is SIGKILL
> > which makes it a non-production toy.
> >
> > What you keep missing is that for people doing this - the RDMA is a
> > critical compoment of the system, you can't just say the kernel will
> > randomly degrade/kill RDMA processes - that is a 'toy' configuration
> > that is not production worthy.
> >
> > Especially since this revoke idea is basically a DOS engine for the
> > RDMA protocol if another process can do actions to trigger revoke. Now
> > we have a new class of security problems. (again, screams non
> > production toy)
> >
> > The only production worthy way is to have the FS be a partner in
> > making this work without requiring revoke, so the critical RDMA
> > traffic can operate safely.
> >
> > Otherwise we need to stick to ODP.
> 
> Thanks for this it clears a lot of things up for me...
> 
> ...but this statement:
> 
> > The only production worthy way is to have the FS be a partner in
> > making this work without requiring revoke, so the critical RDMA
> > traffic can operate safely.
> 
> ...belies a path forward. Just swap out "FS be a partner" with "system
> administrator be a partner". In other words, If the RDMA stack can't
> tolerate an MR being disabled then the administrator needs to actively
> disable the paths that would trigger it. Turn off reflink, don't
> truncate, avoid any future FS feature that might generate unwanted
> lease breaks. We would need to make sure that lease notifications
> include the information to identify the lease breaker to debug escapes
> that might happen, but it is a solution that can be qualified to not
> lease break. In any event, this lets end users pick their filesystem
> (modulo RDMA incompatible features), provides an enumeration of lease
> break sources in the kernel, and opens up FS-DAX to a wider array of
> RDMA adapters. In general this is what Linux has historically done,
> give end users technology freedom.

To back off the details of this thread a bit...

The details of limitations imposed and how they would be tracked within the
kernel would be a great thing to discuss face to face.  Hence the reason for my
proposal as a topic.

Ira

