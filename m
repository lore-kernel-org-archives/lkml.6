Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C05DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5685020827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5685020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeKFSqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:46:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:46:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89575B11D;
        Tue,  6 Nov 2018 09:21:46 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:21:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mike.kravetz@oracle.com, Pavel.Tatashin@microsoft.com,
        prasad.singamsetty@oracle.com, rdunlap@infradead.org,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181106092145.GF27423@dhcp22.suse.cz>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105172931.GP4361@dhcp22.suse.cz>
 <20181106012955.br5swua3ykvolyjq@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106012955.br5swua3ykvolyjq@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 17:29:55, Daniel Jordan wrote:
> On Mon, Nov 05, 2018 at 06:29:31PM +0100, Michal Hocko wrote:
> > On Mon 05-11-18 11:55:45, Daniel Jordan wrote:
> > > Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> > > ktask threads now run at the lowest priority on the system to avoid disturbing
> > > busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> > > The plan to address your other comments is explained below.
> > 
> > I have only glanced through the documentation patch and it looks like it
> > will be much less disruptive than the previous attempts. Now the obvious
> > question is how does this behave on a moderately or even busy system
> > when you compare that to a single threaded execution. Some numbers about
> > best/worst case execution would be really helpful.
> 
> Patches 4 and 5 have some numbers where a ktask and non-ktask workload compete
> against each other.  Those show either 8 ktask threads on 8 CPUs (worst case) or no ktask threads (best case).
> 
> By single threaded execution, I guess you mean 1 ktask thread.  I'll run the
> experiments that way too and post the numbers.

I mean a comparision of how much time it gets to accomplish the same
amount of work if it was done singlethreaded to ktask based distribution
on a idle system (best case for both) and fully contended system (the
worst case). It would be also great to get some numbers on partially
contended system to see how much the priority handover etc. acts under
different CPU contention.
-- 
Michal Hocko
SUSE Labs
