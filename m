Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C432133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJj09i/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C432133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeLETt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:49:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41946 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLETt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:49:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so9486852pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=D9D99FYJdZo2uJ7xtjuViYCT1QHw85VOll4TTwRjMIA=;
        b=jJj09i/76kNT4ioMKbTLgHHVxQu51JbSHE0FaNFywijTbcps2Seg/+R0KKxZ0O341v
         pl5n7kDJSFSrevjyjlw5KzmOFuv/d4aYfejgC/XdvnAf42x+ABB67ATJxuzFFtXdaLPS
         PGI5DG0yI6bOAO7j1Aoo4kkpNxy/G9Z9Y5wc3P5JXR4oZ7xkRUVsK6lYSIX8RS2bWcNL
         AR3g+yNg9aapdlheEHm0ncQP217O7gH/wnNoTdwhLotbLeMNvcBVsv57MWh3W8sv+qPf
         bT31+79beZmC06zcs7l0J8VlepxcbVYYAVw7/mWl24erGpEcrhr7/1fLJtqN6MW0QeXu
         09SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=D9D99FYJdZo2uJ7xtjuViYCT1QHw85VOll4TTwRjMIA=;
        b=YPl1WZTZSI8sYdaXQ8QjQT7sRJjHTsiD3pvNmgsZomDgFXeBODvBHjzDv7L7KnsTyc
         XDthbuYJ48P17scmozOLy2SVqs3kUqHhXUjT04dBwwz98GhLHY4w9/dNnTyfS/GhybN4
         VnU3npvfq8lgvM+LpWJ4+lFo2tsDPiFOLJvlG3tP7ThLFvmjzzs+uZCVBUmnJ2G7bygO
         JIt1rLHyTCppTMx64FFde7S0Puf0HZwdbv+RDS4kMOepiGhv/uNMZksBHhEmO57Bp4/F
         IBE36WW1AWy5vkKpUEjkm6kWkuFz1nzFYuCGIOkjls+kutudEtmMqbGsKpuKc9KxJvc0
         4/pg==
X-Gm-Message-State: AA+aEWaB1jXnjqRQsGDkAPahzU+Isc2zfHCYiOpCy6QdvKPzBOHD2T+w
        bZu8bGoM2DHFaX/v78HIDBkxyQ==
X-Google-Smtp-Source: AFSGD/W6aHVy31bms2/0HFShV5n9vwcyjuRvoE+tvS/8Z+OKX9lYuf6IOREsLwnMaLeChJxNkhKu6Q==
X-Received: by 2002:a62:6a88:: with SMTP id f130mr25972743pfc.201.1544039368101;
        Wed, 05 Dec 2018 11:49:28 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k129sm40161436pgk.29.2018.12.05.11.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:49:27 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:49:26 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <20181205090554.GX1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz> <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com> <20181205090554.GX1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Michal Hocko wrote:

> > The revert is certainly needed to prevent the regression, yes, but I 
> > anticipate that Andrea will report back that patch 2 at least improves the 
> > situation for the problem that he was addressing, specifically that it is 
> > pointless to thrash any node or reclaim unnecessarily when compaction has 
> > already failed.  This is what setting __GFP_NORETRY for all thp fault 
> > allocations fixes.
> 
> Yes but earlier numbers from Mel and repeated again [1] simply show
> that the swap storms are only handled in favor of an absolute drop of
> THP success rate.
>  

As we've been over countless times, this is the desired effect for 
workloads that fit on a single node.  We want local pages of the native 
page size because they (1) are accessed faster than remote hugepages and 
(2) are candidates for collapse by khugepaged.

For applications that do not fit in a single node, we have discussed 
possible ways to extend the API to allow remote faulting of hugepages, 
absent remote fragmentation as well, then the long-standing behavior is 
preserved and large applications can use the API to increase their thp 
success rate.

> Yes, this is understood. So we are getting worst of both. We have a
> numa locality side effect of MADV_HUGEPAGE and we have a poor THP
> utilization. So how come this is an improvement. Especially when the
> reported regression hasn't been demonstrated on a real or repeatable
> workload but rather a very vague presumably worst case behavior where
> the access penalty is absolutely prevailing.
> 

High thp utilization is not always better, especially when those hugepages 
are accessed remotely and introduce the regressions that I've reported.  
Seeking high thp utilization at all costs is not the goal if it causes 
workloads to regress.
