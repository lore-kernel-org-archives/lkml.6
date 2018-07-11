Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20172089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20172089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeGKMwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:52:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:37932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGKMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:52:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 738DCADAB;
        Wed, 11 Jul 2018 12:48:02 +0000 (UTC)
Date:   Wed, 11 Jul 2018 14:48:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com
Subject: Re: [PATCH] mm: hugetlb: don't zero 1GiB bootmem pages.
Message-ID: <20180711124801.GO20050@dhcp22.suse.cz>
References: <20180710184903.68239-1-cannonmatthews@google.com>
 <20180711124711.GA20172@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711124711.GA20172@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 14:47:11, Michal Hocko wrote:
> On Tue 10-07-18 11:49:03, Cannon Matthews wrote:
> > When using 1GiB pages during early boot, use the new
> > memblock_virt_alloc_try_nid_raw() function to allocate memory without
> > zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
> > memset() call is very slow, and can make early boot last upwards of
> > 20-30 minutes on multi TiB machines.
> > 
> > To be safe, still zero the first sizeof(struct boomem_huge_page) bytes
> > since this is used a temporary storage place for this info until
> > gather_bootmem_prealloc() processes them later.
> > 
> > The rest of the memory does not need to be zero'd as the hugetlb pages
> > are always zero'd on page fault.
> > 
> > Tested: Booted with ~3800 1G pages, and it booted successfully in
> > roughly the same amount of time as with 0, as opposed to the 25+
> > minutes it would take before.
> 
> The patch makes perfect sense to me. I wasn't even aware that it
> zeroying memblock allocation. Thanks for spotting this and fixing it.
> 
> > Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
> 
> I just do not think we need to to zero huge_bootmem_page portion of it.
> It should be sufficient to INIT_LIST_HEAD before list_add. We do
> initialize the rest explicitly already.

Forgot to mention that after that is addressed you can add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
