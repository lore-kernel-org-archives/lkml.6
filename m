Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F92C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B693720870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B693720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeGaQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:42:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeGaQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:42:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so17009071wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efmPJEJTuYeH1q8IWdsasHdRIifD74hWF970LXIXLy4=;
        b=dCa9svgW8n4cfKKcjhBV87v+JK14t4/IjQ9rsJ/Umtkhkh/jOqimQppNa0n1Cd2Uoj
         26wcrCf81woabLzHp++stve1mWTrcK4JhMVMxYz/uo5ql2TvlHSBS/85HjrIYX6C5I0+
         SqzXXfZERVbSAZkVZA3M6YCHhlwQjVJACC4WgvA1hX4jqbGMjgWHp8ptJCBLAktAIf5y
         eYaHL15/6vGlUi691iTyY52Ry1J3WIgyJNNoRIh/1hxPYcJLmtJ1nE9m+jPp9ZU2NDTE
         SDGYovh3XSj1c9T7eexaVjEVG9szVkm7Q/9TlmPWOcgNq6vlOIruMjYi5aqOQVykvy7b
         9HAw==
X-Gm-Message-State: AOUpUlEZAR3IwjIledBjVLlN/j+DZK0HRClyNA97XdsyZztisXX3fswU
        203q4QQ5grUWd3KXqYPnqj0=
X-Google-Smtp-Source: AAOMgpcCFd6YfJceo6vmxngPY4Uk7C+qfqWdWbzY69zO3QoW1D3u0KsGhNp9HMylfSEB3AObqtU4Bw==
X-Received: by 2002:a5d:6892:: with SMTP id h18-v6mr21233674wru.108.1533049276607;
        Tue, 31 Jul 2018 08:01:16 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2513999wmh.29.2018.07.31.08.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:01:15 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6118C1244F8; Tue, 31 Jul 2018 17:01:15 +0200 (CEST)
Date:   Tue, 31 Jul 2018 17:01:15 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Message-ID: <20180731150115.GC1499@techadventures.net>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net>
 <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
 <20180731145125.GB1499@techadventures.net>
 <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:53:52AM -0400, Pavel Tatashin wrote:
> Thats correct on arches where no sparsemem setup_usemap() will not be
> freed up. It is a tiny function, just a few instructions. Not a big
> deal.
> 
> Pavel
> On Tue, Jul 31, 2018 at 10:51 AM Oscar Salvador
> <osalvador@techadventures.net> wrote:
> >
> > On Tue, Jul 31, 2018 at 10:45:45AM -0400, Pavel Tatashin wrote:
> > > Here the patch would look like this:
> > >
> > > From e640b32dbd329bba5a785cc60050d5d7e1ca18ce Mon Sep 17 00:00:00 2001
> > > From: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > Date: Tue, 31 Jul 2018 10:37:44 -0400
> > > Subject: [PATCH] mm: remove __paginginit
> > >
> > > __paginginit is the same thing as __meminit except for platforms without
> > > sparsemem, there it is defined as __init.
> > >
> > > Remove __paginginit and use __meminit. Use __ref in one single function
> > > that merges __meminit and __init sections: setup_usemap().
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> >
> > Uhm, I am probably missing something, but with this change, the functions will not be freed up
> > while freeing init memory, right?
> Thats correct on arches where no sparsemem setup_usemap() will not be
> freed up. It is a tiny function, just a few instructions. Not a big
> deal.

I must be missing something.

What about:

calc_memmap_size
free_area_init_node
free_area_init_core
 
These functions are marked with __meminit now.
If we have CONFIG_PARSEMEM but not CONFIG_MEMORY_HOTPLUG, these functions will
be left there.

I mean, it is not that it is a big amount, but still.

Do not we need something like:

diff --git a/include/linux/init.h b/include/linux/init.h
index 2538d176dd1f..3b3a88ba80ed 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -83,8 +83,12 @@
 #define __exit          __section(.exit.text) __exitused __cold notrace
 
 /* Used for MEMORY_HOTPLUG */
+#ifdef CONFIG_MEMORY_HOTPLUG
 #define __meminit        __section(.meminit.text) __cold notrace \
 						  __latent_entropy
+#else
+#define __meminit	 __init
+#endif
 #define __meminitdata    __section(.meminit.data)
 #define __meminitconst   __section(.meminit.rodata)
 #define __memexit        __section(.memexit.text) __exitused __cold notrace

on top?

Thanks
-- 
Oscar Salvador
SUSE L3
