Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F85C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B11D216B7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B11D216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0Snn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:43:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeI0Snn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:43:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so5165834wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b88dDxTrGoai73Q1rgb8VsJ3rxjPkVTsNfjYYRh81Us=;
        b=MuWzWp8FgBa4+m0PqkfYggzHR9LkZwvmKRmJUDVLAdrJJxm5KUcuy5DQw/7bpHEZk5
         n/AKK7NC1X+X5BJR3XcYfMxqQyTgp3jQzVcR2sBHtkFBLWzWpdLT8fSJ9fn/Qq9AE7xb
         dkQxiaft6lf3MT9N3I+3r8tevnNKG4qzT9/zYTbZOfEIOyaJCs2vbYBsBv0j+Xcpi3eJ
         E6dmZKJXUd96zGM98j4tVsPXAjzPbbNs1u7qWv4s8LrHdBAME2zYEZQQLzXna++KR6NS
         rAtMDXJ+Fzx7yNjvPqWZYxiBrWgUzw33Ym9rOtvGwrzfrRajhChGRt/oW/kbl9BxDgxA
         a4yA==
X-Gm-Message-State: ABuFfoj2GclnMd3y0AYQ57cASyQy8ezp2fKRSHgbuVAOds4fQ+d1uWH6
        SjXN62GUdg7aV6F8joMszGU=
X-Google-Smtp-Source: ACcGV60K2w53p2os5vtrdIxeExW4hkCwGNO+2UljWNXSY0OvsZ0mOJyyZSFey57FMb5CNcyk9XbiEg==
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr7780067wmd.145.1538051138864;
        Thu, 27 Sep 2018 05:25:38 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1753831wrw.35.2018.09.27.05.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:25:37 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 45B21125618; Thu, 27 Sep 2018 14:25:37 +0200 (CEST)
Date:   Thu, 27 Sep 2018 14:25:37 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        dave.hansen@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20180927122537.GA20378@techadventures.net>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
 <20180927110926.GE6278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927110926.GE6278@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:09:26PM +0200, Michal Hocko wrote:
> > So there were a few things I wasn't sure we could pull outside of the
> > hotplug lock. One specific example is the bits related to resizing the pgdat
> > and zone. I wanted to avoid pulling those bits outside of the hotplug lock.
> 
> Why would that be a problem. There are dedicated locks for resizing.

True is that move_pfn_range_to_zone() manages the locks for pgdat/zone resizing,
but it also takes care of calling init_currently_empty_zone() in case the zone is empty.
Could not that be a problem if we take move_pfn_range_to_zone() out of the lock?

-- 
Oscar Salvador
SUSE L3
