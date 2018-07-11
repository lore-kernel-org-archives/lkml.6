Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8ACC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27E5208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27E5208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeGKL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeGKL5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A423AF48;
        Wed, 11 Jul 2018 11:53:35 +0000 (UTC)
Date:   Wed, 11 Jul 2018 13:53:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180711115332.GM20050@dhcp22.suse.cz>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711103312.GH20050@dhcp22.suse.cz>
 <20180711111311.hrh5kxdottmpdpn2@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711111311.hrh5kxdottmpdpn2@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 14:13:12, Kirill A. Shutemov wrote:
> On Wed, Jul 11, 2018 at 12:33:12PM +0200, Michal Hocko wrote:
> > this is not a small change for something that could be achieved
> > from the userspace trivially (just call madvise before munmap - library
> > can hide this). Most workloads will even not care about races because
> > they simply do not play tricks with mmaps and userspace MM. So why do we
> > want to put the additional complexity into the kernel?
> 
> As I said before, kernel latency issues have to be addressed in kernel.
> We cannot rely on userspace being kind here.

Those who really care and create really large mappings will know how to
do this properly. Most others just do not care enough. So I am not
really sure this alone is a sufficient argument.

I personally like the in kernel auto tuning but as I've said the
changelog should be really clear why all the complications are
justified. This would be a lot easier to argue about if it was a simple
	if (len > THARSHOLD)
		do_madvise(DONTNEED)
	munmap().
approach. But if we really have to care about parallel faults and munmap
consitency this will always be tricky
-- 
Michal Hocko
SUSE Labs
