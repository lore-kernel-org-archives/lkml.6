Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489EDC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1FE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1FE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJSJvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:51:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeJSJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:51:18 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AF03872A;
        Fri, 19 Oct 2018 01:47:27 +0000 (UTC)
Date:   Thu, 18 Oct 2018 18:47:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
Message-Id: <20181018184726.fb8da5c733da5e0c6a235101@linux-foundation.org>
In-Reply-To: <20181019004621.GA30067@redhat.com>
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
        <20181018160827.0cb656d594ffb2f0f069326c@linux-foundation.org>
        <6d6e4733-39aa-a958-c0a2-c5a47cdcc7d0@oracle.com>
        <20181019004621.GA30067@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 20:46:21 -0400 Andrea Arcangeli <aarcange@redhat.com> wrote:

> On Thu, Oct 18, 2018 at 04:16:40PM -0700, Mike Kravetz wrote:
> > I was not sure about this, and expected someone could come up with
> > something better.  It just seems there are filesystems like huegtlbfs,
> > where it makes no sense wasting cycles traversing the filesystem.  So,
> > let's not even try.
> > 
> > Hoping someone can come up with a better method than hard coding as
> > I have done above.
> 
> It's not strictly required after marking the pages dirty though. The
> real fix is the other one? Could we just drop the hardcoding and let
> it run after the real fix is applied?
> 
> The performance of drop_caches doesn't seem critical, especially with
> gigapages. tmpfs doesn't seem to be optimized away from drop_caches
> and the gain would be bigger for tmpfs if THP is not enabled in the
> mount, so I'm not sure if we should worry about hugetlbfs first.

I guess so.  I can't immediately see a clean way of expressing this so
perhaps it would need a new BDI_CAP_NO_BACKING_STORE.  Such a
thing hardly seems worthwhile for drop_caches.

And drop_caches really shouldn't be there anyway.  It's a standing
workaround for ongoing suckage in pagecache and metadata reclaim
behaviour :(

