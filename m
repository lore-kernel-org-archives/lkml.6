Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B69C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E02083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6E02083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeIAAy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:54:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAAy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:54:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so12286918wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LjIpWjS+ISYtZ6DKNmf7IFHatd0ydPnTvHxFhRdBC/o=;
        b=eBDz+qYp96P8a9w+LM37jtIteGXkKAtCWgF025Dam3dgo3LELEm1tazzDl48nzOIRI
         QlVNtTdnSZkxsiG33H8mH/haclb2S6QzCQ9Df1MW7444mTtN9XDL4ppX0/CerI6mDK0a
         wZQN9b1dMi8T7wn8EQNwUmF+DdQEBbs7HiKh6GSWZ/qa5dmGbDf1ko4KNxrdHWQW9UpO
         gkhUBbqxttMFg48RTI8tF2nhYszHKdbs/+A/3SuqNpQWXLiXLLM7mUjiBm3an9kOzsYE
         +y5PU2EQ0jMb+SLFShTi0YLVVZ0+SX3Wf3OMzuLLZ3+2oTmtjMSA5fyFGXIB9Ae3eCvt
         nX+A==
X-Gm-Message-State: APzg51DIoawvDOy0MUoN5O2WLKyGSyXUepBblUAQo2B0VY2K8L/Of/cB
        G70iKQWcbCuhOQnHidJmlLM=
X-Google-Smtp-Source: ANB0VdY2LJaROxDMWXBFZcf6lFUNx0uWhkDk9X8HXpzRYDANopZ/EUTczMinDqO7MEbdUZuib+WygQ==
X-Received: by 2002:adf:a644:: with SMTP id k62-v6mr11844091wrc.78.1535748344984;
        Fri, 31 Aug 2018 13:45:44 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 60-v6sm12822257wre.82.2018.08.31.13.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:45:44 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 62B92124D49; Fri, 31 Aug 2018 22:45:43 +0200 (CEST)
Date:   Fri, 31 Aug 2018 22:45:43 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Message-ID: <20180831204543.GA3885@techadventures.net>
References: <20180828210158.4617-1-osalvador@techadventures.net>
 <332d9ea1-cdd0-6bb6-8e83-28af25096637@microsoft.com>
 <20180831122401.GA2123@techadventures.net>
 <b2fea9ef-84e9-84dc-c847-5b944a8d832f@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fea9ef-84e9-84dc-c847-5b944a8d832f@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 02:04:59PM +0000, Pasha Tatashin wrote:
> Are you saying the code that is in mainline is broken? Because we set
> node_set_state(nid, N_NORMAL_MEMORY); even on node with N_HIGH_MEMORY:
> 
> 6826			if (N_NORMAL_MEMORY != N_HIGH_MEMORY &&
> 6827			    zone_type <= ZONE_NORMAL)
> 6828				node_set_state(nid, N_NORMAL_MEMORY);

Yes, and that is fine. Although the curent code is subtle for the reasons
I expplained in the changelog.
What I am saying is that the code you suggested would not work
because your code either sets N_NORMAL_MEMORY or N_HIGH_MEMORY and then
breaks the loop.

That is wrong because when we are on a CONFIG_HIGHMEM system,
it can happen that we have a node with both types, so we have to set
both types of memory.

N_HIGH_MEMORY, and N_NORMAL_MEMORY if the zone is <= ZONE_NORMAL.

Thanks
-- 
Oscar Salvador
SUSE L3
