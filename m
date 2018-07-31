Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D27C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C9C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C9C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeGaWcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:32:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35917 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeGaWcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:32:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so3108231wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DyJqw0MbnW7bnoItYJ7cc4XhtBLnvWYUWi60o67LZeA=;
        b=PrD/jg35ZO/UV6YIaSmQKp2kaQVdbhKmkk9NVl5yNY4WmtmwgPkaYaZ6EbKQcirEIC
         CN8LJij8vnrp2eQ83YLcy78PFle/mwvTK4G1QPUNl+sxRjCQg3Bpclu/OcBwITN0AyUL
         ROH24X/m8Km90ZpsoIHiW/PrArzmJqxGJ97RrZ3HFcg+62a++zzy5FmhzvkHZph8k8Ms
         bc+kgu9tzGPeB9WniPJRshFnj/S8bsE9GJNYhPMus8oiT41no0zsfpAOmQBO8nTVzug+
         YuEdUmtU7btB2z/+RX1rb1bwM54WTfed3c8a2LNM3nYU2FU4b5w7ryYRVKdWUXpj6lmD
         EkYw==
X-Gm-Message-State: AOUpUlENnq06ijbsUIKWWM43GrSmeWa9O/y8Whz/chDP5Vc1IErIwTxl
        an/gbhDYEDoJE7aVdUnXhwKP+zz4LWg=
X-Google-Smtp-Source: AAOMgpeDygXd7Xj56q8XCGD+iMJc0pwAYf7niOMXmZ67PQ2lMmgI2rl2JsInBvtpgecnEgQ+OF8dOA==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr761403wma.128.1533070204671;
        Tue, 31 Jul 2018 13:50:04 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l11-v6sm18988814wru.25.2018.07.31.13.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:50:03 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2C01312451A; Tue, 31 Jul 2018 22:50:03 +0200 (CEST)
Date:   Tue, 31 Jul 2018 22:50:03 +0200
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
Message-ID: <20180731205003.GA3277@techadventures.net>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net>
 <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
 <20180731145125.GB1499@techadventures.net>
 <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
 <20180731150115.GC1499@techadventures.net>
 <CAGM2reZ+KhsuFhOVvJzRkQO=66TosvxDW0BYAXNf8Gw8zoRQXQ@mail.gmail.com>
 <CAGM2reaniWqEJ1hArMoreyGn5M+eSYge+wYYMxTrRHth-hxzOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reaniWqEJ1hArMoreyGn5M+eSYge+wYYMxTrRHth-hxzOQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:23:33AM -0400, Pavel Tatashin wrote:
> Yes we free meminit when no CONFIG_MEMORY_HOTPLUG
> See here:
> http://src.illumos.org/source/xref/linux-master/include/asm-generic/vmlinux.lds.h#107

Oh, I got the point now.
Somehow I missed that we were freeing up the memory when CONFIG_MEMORY_HOTPLUG
was not in place.

So your patch makes sense to me now, sorry.

Since my patchset [1] + cleanup patch [2] remove almost all __paginginit,
leaving only pgdat_init_internals() and zone_init_internals(), I think
it would be great if you base your patch on top of that.
Or since the patchset has some cleanups already, I could add your patch
into it (as we did for the zone_to/set_nid() patch) and send a v6 with it.

What do you think?

[1] https://patchwork.kernel.org/patch/10548861/
[2] <20180731101752.GA473@techadventures.net>

Thanks
-- 
Oscar Salvador
SUSE L3
