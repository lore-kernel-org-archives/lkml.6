Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F3AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965A0244F8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965A0244F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGCGRQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932360AbeGCGRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05A16ADCC;
        Tue,  3 Jul 2018 06:17:14 +0000 (UTC)
Date:   Tue, 3 Jul 2018 08:17:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, willy@infradead.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 5/5] x86: check VM_DEAD flag in page fault
Message-ID: <20180703061713.GB16767@dhcp22.suse.cz>
References: <1530311985-31251-6-git-send-email-yang.shi@linux.alibaba.com>
 <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
 <20180702121528.GM19043@dhcp22.suse.cz>
 <80406cbd-67f4-ca4c-cd54-aeb305579a72@linux.vnet.ibm.com>
 <20180702124558.GP19043@dhcp22.suse.cz>
 <e6f8d0e2-48c1-f610-c00b-d05d4bd0d9eb@linux.vnet.ibm.com>
 <20180702133733.GU19043@dhcp22.suse.cz>
 <6fd4eb3d-ef66-7a37-4adb-05c22ac51d95@linux.alibaba.com>
 <20180702175749.GG19043@dhcp22.suse.cz>
 <a5b4888c-6518-df47-bc0d-d4173984daa9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b4888c-6518-df47-bc0d-d4173984daa9@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 11:10:23, Yang Shi wrote:
> On 7/2/18 10:57 AM, Michal Hocko wrote:
[...]
> > Why would you even care about shared mappings?
> 
> Just thought about we are dealing with VM_DEAD, which means the vma will be
> tore down soon regardless it is shared or non-shared.
> 
> MMF_UNSTABLE doesn't care about !shared case.

Let me clarify some more. MMF_UNSTABLE is there to prevent from
unexpected page faults when the mm is torn down by the oom reaper. And
oom reaper only cares about private mappings because we do not touch
shared ones. Disk based shared mappings should be a non-issue for
VM_DEAD because even if you race and refault a page back then you know
it is the same one you have seen before. Memory backed shared mappings
are a different story because you can get a fresh new page. oom_reaper
doesn't care because it doesn't tear those down. You would have to but
my primary point was that we already have MMF_UNSTABLE so all you need
is to extend it to memory backed shared mappings (shmem and hugetlb).

-- 
Michal Hocko
SUSE Labs
