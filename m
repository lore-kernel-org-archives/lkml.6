Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4698720675
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545252740;
	bh=qG3c/FD4QBjCKVrnUM9/Hy6dHaTuvWC+ovuob7H8NXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dfiB4/Jh3CrOrbm1I09VC7ZWzencIJTGRvVrRqXZJNNA2V3YqLmL4g2UfiFFGzP0T
	 5eU1lCYTn17BL9y+cfYfMxgT8VWRcOTQkbaB8bZZa/z3/yiLmOJ7hLUw6kldHAGg2S
	 dR6TI1mp6C/Pdocfji2bqd4XnLhBDQvif+IMtY2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeLSUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:52:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbeLSUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:52:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCFF4AEDB;
        Wed, 19 Dec 2018 20:52:16 +0000 (UTC)
Date:   Wed, 19 Dec 2018 21:52:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "prakash.sangappa" <prakash.sangappa@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
Message-ID: <20181219205215.GC5689@dhcp22.suse.cz>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
 <20180914055637.GH20287@dhcp22.suse.cz>
 <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
 <20180924171443.GI18685@dhcp22.suse.cz>
 <41af45a9-c428-ccd8-ca10-c355d22c56a7@oracle.com>
 <79d5e991-d9f6-65e2-cb77-0f999fa512fe@oracle.com>
 <c81d912f-157f-749a-92fb-78f5e836da85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81d912f-157f-749a-92fb-78f5e836da85@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 15:46:45, prakash.sangappa wrote:
[...]
> Dave Hansen asked how would it scale, with respect reading this file from
> a large process. Answer is, the file contents are generated using page
> table walk, and copied to user buffer. The mmap_sem lock is drop and
> re-acquired in the process of walking the page table and copying file
> content. The kernel buffer size used determines how long the lock is held.
> Which can be further improved to drop the lock and re-acquire after a
> fixed number(512) of pages are walked.

I guess you are still missing the point here. Have you tried a larger
mapping with interleaved memory policy? I would bet my hat that you are
going to spend a large part of the time just pushing the output to the
userspace... Not to mention the parsing on the consumer side.

Also you keep failing (IMO) explaining _who_ is going to be the consumer
of the file. What kind of analysis will need such an optimized data
collection and what can you do about that?

This is really _essential_ when adding a new interface to provide a data
that is already available by other means. In other words tell us your
specific usecase that is hitting a bottleneck that cannot be handled by
the existing API and we can start considering a new one.

-- 
Michal Hocko
SUSE Labs
