Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE05C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5136720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfAaKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:04:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:47846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfAaKEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:04:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4BCBADA2;
        Thu, 31 Jan 2019 10:04:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E9CB1E3FFD; Thu, 31 Jan 2019 11:04:00 +0100 (CET)
Date:   Thu, 31 Jan 2019 11:04:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     'Jason Gunthorpe' <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jack@suse.de" <jack@suse.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190131100400.GC19222@quack2.suse.cz>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
 <20190128233140.GA12530@ziepe.ca>
 <20190129044607.GL25106@ziepe.ca>
 <20190129185005.GC10129@iweiny-DESK2.sc.intel.com>
 <20190129231903.GA5352@ziepe.ca>
 <2807E5FD2F6FDA4886F6618EAC48510E79BA6A27@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79BA6A27@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 18:01:33, Weiny, Ira wrote:
> > 
> > On Tue, Jan 29, 2019 at 10:50:05AM -0800, Ira Weiny wrote:
> > > > .. and I'm looking at some of the other conversions here.. *most
> > > > likely* any caller that is manipulating rlimit for get_user_pages
> > > > should really be calling get_user_pages_longterm, so they should not
> > > > be converted to use _fast?
> > >
> > > Is this a question?  I'm not sure I understand the meaning here?
> > 
> > More an invitation to disprove the statement
> 
> Generally I agree.  But would be best if we could get fast GUP for
> performance.  I have not worked out if that will be possible with the
> final "longterm" solutions.

Initially probably not, longer-term it might be added if there are
performance data supporting that (i.e., showing real workload that would
benefit). In principle there's nothing that would prevent gup_fast like
functionality for long-term pins but I expect there will be always
additional overhead (compared to plain gup_fast()) of establishing
something like leases to identify long-term pins. But we haven't figured
out the details yet. For now we concentrate on fixing short-term pins and
issues with those.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
