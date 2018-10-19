Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28896C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF020C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeJSIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeJSIuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:50:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F92280466;
        Fri, 19 Oct 2018 00:46:22 +0000 (UTC)
Received: from sky.random (ovpn-120-228.rdu2.redhat.com [10.10.120.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00E7980300;
        Fri, 19 Oct 2018 00:46:21 +0000 (UTC)
Date:   Thu, 18 Oct 2018 20:46:21 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
Message-ID: <20181019004621.GA30067@redhat.com>
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
 <20181018160827.0cb656d594ffb2f0f069326c@linux-foundation.org>
 <6d6e4733-39aa-a958-c0a2-c5a47cdcc7d0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6e4733-39aa-a958-c0a2-c5a47cdcc7d0@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 19 Oct 2018 00:46:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:16:40PM -0700, Mike Kravetz wrote:
> I was not sure about this, and expected someone could come up with
> something better.  It just seems there are filesystems like huegtlbfs,
> where it makes no sense wasting cycles traversing the filesystem.  So,
> let's not even try.
> 
> Hoping someone can come up with a better method than hard coding as
> I have done above.

It's not strictly required after marking the pages dirty though. The
real fix is the other one? Could we just drop the hardcoding and let
it run after the real fix is applied?

The performance of drop_caches doesn't seem critical, especially with
gigapages. tmpfs doesn't seem to be optimized away from drop_caches
and the gain would be bigger for tmpfs if THP is not enabled in the
mount, so I'm not sure if we should worry about hugetlbfs first.

Thanks,
Andrea
