Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1D8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858C821A56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858C821A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeGBR5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:57:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeGBR5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B68FBADB8;
        Mon,  2 Jul 2018 17:57:50 +0000 (UTC)
Date:   Mon, 2 Jul 2018 19:57:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, willy@infradead.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 5/5] x86: check VM_DEAD flag in page fault
Message-ID: <20180702175749.GG19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-6-git-send-email-yang.shi@linux.alibaba.com>
 <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
 <20180702121528.GM19043@dhcp22.suse.cz>
 <80406cbd-67f4-ca4c-cd54-aeb305579a72@linux.vnet.ibm.com>
 <20180702124558.GP19043@dhcp22.suse.cz>
 <e6f8d0e2-48c1-f610-c00b-d05d4bd0d9eb@linux.vnet.ibm.com>
 <20180702133733.GU19043@dhcp22.suse.cz>
 <6fd4eb3d-ef66-7a37-4adb-05c22ac51d95@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd4eb3d-ef66-7a37-4adb-05c22ac51d95@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 10:24:27, Yang Shi wrote:
> 
> 
> On 7/2/18 6:37 AM, Michal Hocko wrote:
> > On Mon 02-07-18 15:33:11, Laurent Dufour wrote:
> > > 
> > > On 02/07/2018 14:45, Michal Hocko wrote:
> > > > On Mon 02-07-18 14:26:09, Laurent Dufour wrote:
> > > > > On 02/07/2018 14:15, Michal Hocko wrote:
> > [...]
> > > > > > We already do have a model for that. Have a look at MMF_UNSTABLE.
> > > > > MMF_UNSTABLE is a mm's flag, here this is a VMA's flag which is checked.
> > > > Yeah, and we have the VMA ready for all places where we do check the
> > > > flag. check_stable_address_space can be made to get vma rather than mm.
> > > Yeah, this would have been more efficient to check that flag at the beginning
> > > of the page fault handler rather than the end, but this way it will be easier
> > > to handle the speculative page fault too ;)
> > The thing is that it doesn't really need to be called earlier. You are
> > not risking data corruption on file backed mappings.
> 
> OK, I just think it could save a few cycles to check the flag earlier.

This should be an extremely rare case. Just think about it. It should
only ever happen when an access races with munmap which itself is
questionable if not an outright bug.

> If nobody think it is necessary, we definitely could re-use
> check_stable_address_space(),

If we really need this whole VM_DEAD thing then it should be better
handled at the same place rather than some ad-hoc places.

> just return VM_FAULT_SIGSEGV for VM_DEAD vma,
> and check for both shared and non-shared.

Why would you even care about shared mappings?
-- 
Michal Hocko
SUSE Labs
