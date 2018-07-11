Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58351C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D315208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D315208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeGKMCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:02:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:59136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbeGKMCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:02:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31F81ADBE;
        Wed, 11 Jul 2018 11:58:25 +0000 (UTC)
Date:   Wed, 11 Jul 2018 13:58:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180711115824.GN20050@dhcp22.suse.cz>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 14:10:52, Kirill A. Shutemov wrote:
[...]
> It's okay. I have another suggestion that also doesn't require VM_DEAD
> trick too :)
> 
> 1. Take mmap_sem for write;
> 2. Adjust VMA layout (split/remove). After the step all memory we try to
>    unmap is outside any VMA.
> 3. Downgrade mmap_sem to read.
> 4. Zap the page range.
> 5. Drop mmap_sem.
> 
> I believe it should be safe.
> 
> The pages in the range cannot be re-faulted after step 3 as find_vma()
> will not see the corresponding VMA and deliver SIGSEGV.
> 
> New VMAs cannot be created in the range before step 5 since we hold the
> semaphore at least for read the whole time.
> 
> Do you see problem in this approach?

Yes this seems to be safe. At least from the first glance.
-- 
Michal Hocko
SUSE Labs
