Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeLMKZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:25:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMKZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:25:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C47FCC05D3F8;
        Thu, 13 Dec 2018 10:25:04 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F44C60D0B;
        Thu, 13 Dec 2018 10:24:59 +0000 (UTC)
Date:   Thu, 13 Dec 2018 18:24:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: thp: fix flags for pmd migration when split
Message-ID: <20181213102457.GA22285@xz-x1>
References: <20181213051510.20306-1-peterx@redhat.com>
 <20181213095942.3y7lfdwndek6sja4@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213095942.3y7lfdwndek6sja4@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Dec 2018 10:25:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:59:42PM +0300, Kirill A. Shutemov wrote:
> On Thu, Dec 13, 2018 at 01:15:10PM +0800, Peter Xu wrote:
> > When splitting a huge migrating PMD, we'll transfer all the existing
> > PMD bits and apply them again onto the small PTEs.  However we are
> > fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> > or pmd_yound() while actually they don't make sense at all when it's
> > a migration entry.  Fix them up.  Since at it, drop the ifdef together
> > as not needed.
> > 
> > Note that if my understanding is correct about the problem then if
> > without the patch there is chance to lose some of the dirty bits in
> > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > of swap offset instead of bit 2) and it could potentially corrupt the
> > memory of an userspace program which depends on the dirty bit.
> > 
> > CC: Andrea Arcangeli <aarcange@redhat.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: Michal Hocko <mhocko@suse.com>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Souptick Joarder <jrdr.linux@gmail.com>
> > CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > CC: Zi Yan <zi.yan@cs.rutgers.edu>
> > CC: linux-mm@kvack.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Stable?

Sorry I missed the reply from Zi.  I think it should be:

CC: linux-stable <stable@vger.kernel.org> # 4.14+

Thanks,

-- 
Peter Xu
