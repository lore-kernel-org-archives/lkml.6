Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86FC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DWfwx5tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfBLKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:13:28 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36133 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfBLKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:13:28 -0500
Received: by mail-wr1-f54.google.com with SMTP id o17so2018700wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0JsiH41KjwvocfsMp0bTb3XeLXE9iKeGB1xz8dT32A=;
        b=DWfwx5tbB6IVo4HIIiFhkNsfJ4SZ6/zDimJNgTlVGK+CvuSgxyZcPuDigAGLkxqqHn
         aFEj3qBL+1KRbmVapS9XSNRwti4AEpOCmAiow73iKHa6A1utJW1qabjNj/+e7aCRWGFa
         mf406VjNtP0kT3H6Yf5OlhFAOfQwD6DmX8RII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0JsiH41KjwvocfsMp0bTb3XeLXE9iKeGB1xz8dT32A=;
        b=FqKyAJtITlvhWmvTmEwl2Pf5WalXw/+6Saz9Q/1qDCrtNRfOGywmulWJaAgRnEhQqt
         syta9i7vsIEc6XUQHxc1ClMyrZWCAo2X10H56dkc0d6nQgcgw/KKvfW0HNcYVFSJSVr3
         +XZM+LvB5bV+fPPns0Z0n9HxlDqEn6emmOP2FR2ILAURGCTO7vkwU5Ppx16CtcO2MOYB
         efR+scfq+Sj2RiIE30Cre415xDdi5QxaW7CpfD+uu2AsZ6I2J7ONxoAYDReXPDt+8UNd
         WsL+lD0r+DW0kXROXM9Stb5wrxp7noPeBqdExMY/myKfW+krnqNPcUQ5tekCzeUoSkWs
         vimQ==
X-Gm-Message-State: AHQUAuYB8OEHk5Tts8NuEVxySjSzqDyvAJ8391qZqA78RFgbnz0V90qv
        yca53slrpV6oT1XWunRAx//vRw==
X-Google-Smtp-Source: AHgI3IZPZNArtBqTt7cgQ07OzsRJFORv/tckhbBOEZQDfGJt12ChgEvQA3SGdcEssYqkBT43NTRbSw==
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr2340947wre.330.1549966406403;
        Tue, 12 Feb 2019 02:13:26 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id o9sm1809180wmh.3.2019.02.12.02.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:13:25 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:13:16 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190212101316.GA6905@andrea>
References: <20190211083846.18888-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211083846.18888-1-ying.huang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Alternative implementation could be replacing disable preemption with
> rcu_read_lock_sched and stop_machine() with synchronize_sched().

JFYI, starting with v4.20-rc1, synchronize_rcu{,expedited}() also wait
for preempt-disable sections (the intent seems to retire the RCU-sched
update-side API), so that here you could instead use preempt-disable +
synchronize_rcu{,expedited}().  This LWN article gives an overview of
the latest RCU API/semantics changes: https://lwn.net/Articles/777036/.

  Andrea
