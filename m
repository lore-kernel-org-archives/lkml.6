Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB6020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB6020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeILOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbeILOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:14:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03F00B00A;
        Wed, 12 Sep 2018 09:11:09 +0000 (UTC)
Date:   Wed, 12 Sep 2018 11:11:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, dave.hansen@intel.com,
        oleg@redhat.com, srikar@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v9 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180912091105.GB10951@dhcp22.suse.cz>
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536699493-69195-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180911211645.GA12159@bombadil.infradead.org>
 <b69d3f7d-e9ba-b95c-45cd-44489950751b@linux.alibaba.com>
 <20180912022921.GA20056@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912022921.GA20056@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 19:29:21, Matthew Wilcox wrote:
> On Tue, Sep 11, 2018 at 04:35:03PM -0700, Yang Shi wrote:
[...]

I didn't get to read the patch yet.

> > And, Michal prefers have VM_HUGETLB and VM_PFNMAP handled separately for
> > safe and bisectable sake, which needs call the regular do_munmap().
> 
> That can be introduced and then taken out ... indeed, you can split this into
> many patches, starting with this:
> 
> +		if (tmp->vm_file)
> +			downgrade = false;
> 
> to only allow this optimisation for anonymous mappings at first.

or add a helper function to check for special cases and make the
downgrade behavior conditional on it.
-- 
Michal Hocko
SUSE Labs
