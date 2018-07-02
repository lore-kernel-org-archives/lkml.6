Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06285C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17AD2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17AD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeGBR6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752821AbeGBR6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:58:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1216EAF43;
        Mon,  2 Jul 2018 17:58:36 +0000 (UTC)
Date:   Mon, 2 Jul 2018 19:58:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 3/5] mm: refactor do_munmap() to extract the
 common part
Message-ID: <20180702175835.GH19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180702134226.GX19043@dhcp22.suse.cz>
 <5aa8953d-3781-8b22-89f6-994a52ea0172@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa8953d-3781-8b22-89f6-994a52ea0172@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 09:59:06, Yang Shi wrote:
> 
> 
> On 7/2/18 6:42 AM, Michal Hocko wrote:
> > On Sat 30-06-18 06:39:43, Yang Shi wrote:
> > > Introduces two new helper functions:
> > >    * munmap_addr_sanity()
> > >    * munmap_lookup_vma()
> > > 
> > > They will be used by do_munmap() and the new do_munmap with zapping
> > > large mapping early in the later patch.
> > > 
> > > There is no functional change, just code refactor.
> > There are whitespace changes which make the code much harder to review
> > than necessary.
> > > +static inline bool munmap_addr_sanity(unsigned long start, size_t len)
> > >   {
> > > -	unsigned long end;
> > > -	struct vm_area_struct *vma, *prev, *last;
> > > +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE - start)
> > > +		return false;
> > > -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> > > -		return -EINVAL;
> > e.g. here.
> 
> Oh, yes. I did some coding style cleanup too.

If you want to do some coding style cleanups make them a separate patch.
The resulting diff would be much easier to review.

-- 
Michal Hocko
SUSE Labs
