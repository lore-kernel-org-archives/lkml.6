Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544787167;
	bh=HZJzZK6JGc4uHm5JgFujyMo1TUiJbddnc/PxtMGJwuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bLXOgfDsmKdQrb17HBc6nDWEtbCZlFncA6I4oxT26fPyDpVgCERGTQ1zZoxo0+pFk
	 NOQiXk7SzaRb6Q4zdkXRyhtrsgSPC0sQSKXQVsFpW4YYfZAAsjUM/1JRj7x85IcQkK
	 V6nMQqzJArachvR9eafvfpjlnLpX9MwUEFdFHpl0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeLNLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:32:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:35316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeLNLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:32:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B228AE54;
        Fri, 14 Dec 2018 11:32:43 +0000 (UTC)
Date:   Fri, 14 Dec 2018 12:32:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181214113241.GC5343@dhcp22.suse.cz>
References: <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
 <20181210044916.GC24097@redhat.com>
 <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
 <20181212095051.GO1286@dhcp22.suse.cz>
 <20181212170016.GG1130@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212170016.GG1130@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 12:00:16, Andrea Arcangeli wrote:
[...]
> Adding MADV_THISNODE/MADV_NODE_RECLAIM, will guarantee his proprietary
> software binary will run at maximum performance without cache
> interference, and he's happy to accept the risk of massive slowdown in
> case the local node is truly OOM. The fallback, despite very
> inefficient, will still happen without OOM killer triggering.

I believe this fits much better into a MPOL_$FOO rather than MADV_$FOO.
But other than that I full agree. There are reasonable usecases for the
node reclaim like behavior. As a bonus you do not get local node only
but all nodes within reclaim distance as well.
-- 
Michal Hocko
SUSE Labs
