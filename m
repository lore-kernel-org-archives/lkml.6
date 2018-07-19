Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66E520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66E520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbeGSOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:46:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38407 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:46:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so6514846wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbFI6JQ/85K+eVwZz779IDBrNMHIhdTSFXXfoPurDYM=;
        b=qsQbk4rlvR6slcXb5aG7IE9BFRelq29+1fkh8EBfvQfexDag+LMwWEngAXN0J7ofc7
         ITJoicz0FxHo8lBVhoNEqoxuz6e2q+hcVqrVJTze8hs+aCaToVxzQMG+W9ZXWfMC3Ixi
         m71sMyXyfn4hVAq8AhdbJtHWhtlYfo/HPfEPb+3kJfhe9YLKXOnVgchmt6qE99pG2JgV
         tpOVk3jUfuGpyB8bx5Ey+UJOhnWyrKYeSRRC0xJMfJ/2fE/O5vRP5PfcTH3Gtvj9L55x
         TtD7vhY9qZYGJC8NTyVSpTOmy6zqMpKpNZgTi6HFKwGjKiBXscjnfWlDk6U1g9Dyqgb8
         c8iA==
X-Gm-Message-State: AOUpUlEr/Qizs+D1cQEBYC6cKV9/SnwRBRxpC2AmR7KW5vfSB0GzT7Fi
        Mhjk0tM/pbVV8wM+GX+TQt0=
X-Google-Smtp-Source: AAOMgpdBXq6mkocmsJ+3kxe2924dbDb1qUdnCTOxmtAtgGWArfpf3huWuzc7Y4avUZ2/a1iWuMUmLw==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr4170306wme.13.1532009009299;
        Thu, 19 Jul 2018 07:03:29 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q1-v6sm9720936wrw.42.2018.07.19.07.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 07:03:28 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 02BF412418D; Thu, 19 Jul 2018 16:03:27 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:03:27 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180719140327.GB10988@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719134417.GC7193@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:44:17PM +0200, Michal Hocko wrote:
> On Thu 19-07-18 15:27:38, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > In free_area_init_core we calculate the amount of managed pages
> > we are left with, by substracting the memmap pages and the pages
> > reserved for dma.
> > With the values left, we also account the total of kernel pages and
> > the total of pages.
> > 
> > Since memmap pages are calculated from zone->spanned_pages,
> > let us only do these calculcations whenever zone->spanned_pages is greather
> > than 0.
> 
> But why do we care? How do we test this? In other words, why is this
> worth merging?
 
Uhm, unless the values are going to be updated, why do we want to go through all
comparasions/checks?
I thought it was a nice thing to have the chance to skip that block unless we are going to
update the counters.

Again, if you think this only adds complexity and no good, I can drop it.

Thanks
-- 
Oscar Salvador
SUSE L3
