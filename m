Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeKBRKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:10:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbeKBRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:10:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 097CDAE15;
        Fri,  2 Nov 2018 08:03:57 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:03:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181102073009.GP23921@dhcp22.suse.cz>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 02:45:42, Dexuan Cui wrote:
[...]
> I totally agree. I'm now just wondering if there is any temporary workaround,
> even if that means we have to run the kernel with some features disabled or
> with a suboptimal performance?

One way would be to disable kmem accounting (cgroup.memory=nokmem kernel
option). That would reduce the memory isolation because quite a lot of
memory will not be accounted for but the primary source of in-flight and
hard to reclaim memory will be gone.

Another workaround could be to use force_empty knob we have in v1 and
use it when removing a cgroup. We do not have it in cgroup v2 though.
The file hasn't been added to v2 because we didn't really have any
proper usecase. Working around a bug doesn't sound like a _proper_
usecase but I can imagine workloads that bring a lot of metadata objects
that are not really interesting for later use so something like a
targeted drop_caches...
-- 
Michal Hocko
SUSE Labs
