Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9761AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1642526C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1642526C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeGBMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:15:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751761AbeGBMPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:15:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D935AD06;
        Mon,  2 Jul 2018 12:15:29 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:15:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 5/5] x86: check VM_DEAD flag in page fault
Message-ID: <20180702121528.GM19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-6-git-send-email-yang.shi@linux.alibaba.com>
 <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 10:45:03, Laurent Dufour wrote:
> On 30/06/2018 00:39, Yang Shi wrote:
> > Check VM_DEAD flag of vma in page fault handler, if it is set, trigger
> > SIGSEGV.
> > 
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > ---
> >  arch/x86/mm/fault.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 9a84a0d..3fd2da5 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1357,6 +1357,10 @@ static inline bool smap_violation(int error_code, struct pt_regs *regs)
> >  		bad_area(regs, error_code, address);
> >  		return;
> >  	}
> > +	if (unlikely(vma->vm_flags & VM_DEAD)) {
> > +		bad_area(regs, error_code, address);
> > +		return;
> > +	}
> 
> This will have to be done for all the supported architectures, what about doing
> this check in handle_mm_fault() and return VM_FAULT_SIGSEGV ?

We already do have a model for that. Have a look at MMF_UNSTABLE.

-- 
Michal Hocko
SUSE Labs
