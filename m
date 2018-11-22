Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F31C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E616D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="arZJHkhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E616D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438338AbeKWGTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:19:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43458 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbeKWGTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:19:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so8527163edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDrRm6Mxj4m+SNUjktWTxBI8e/6BxgzdDZdN1kjUT5Y=;
        b=arZJHkhDHloNyf51b3Ns6vJsyAjFex2i+Ycep6GMqleUWiN/Y/NAbNY1MF5i/Gl/YF
         garN3Uw9R7IDo7NFEHgjRqVChAuVMWQMHlC1OUb2B0IkX5tjSk8mXW64P+gzvVMLoRsd
         dw1wFEFKBV2TVulY2qNa+BU/nTQBBCTLpiFk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDrRm6Mxj4m+SNUjktWTxBI8e/6BxgzdDZdN1kjUT5Y=;
        b=l5v8jbc1AMArbZQzSiWf/nyjglfXheC4zuzgEcQxuDx51BH5qykt27bl8gYJ7BbNH+
         TLYR07tg0GCr/QVnQEz/j/6Z/4vlSpqulI40wfkLfu5MgQO+CdURRrrZNw6t12ZZcSTu
         Hkh/jynevOgQqU8h9aiY3jHunhO+n1BoMyisO3t71ODqUDCzAIAf8n6AnvVNPlxsHP5o
         hsBNnKMLHsGFKxmmkMWtfrtKYsSJSNoZoHry6s+BK+MYM4gs6OjvZaVeH856XDYoBx4Z
         YLPuCuf1o+QiLKYz9iy7rU8lua3g7EdFf32k/tRKv8KC5tm8jPUdQGKlJtyy3cW18z0A
         zuCg==
X-Gm-Message-State: AA+aEWZPmP5cIxruTVBc8zXUogP3G/1geDzNSBXFBksXiyNr/lY07qBu
        W7Uj940Hk3mFXlNUbJXMuK2Yig==
X-Google-Smtp-Source: AFSGD/VQJj/5VVSs4OWjgZmYSRWFiXk/ieYf9zje+gvDiFJWbji9agAAVj8uhaQFKDVeqv23h78YIA==
X-Received: by 2002:a50:a974:: with SMTP id m49-v6mr10725859edc.169.1542915526439;
        Thu, 22 Nov 2018 11:38:46 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id r8sm1719692edo.11.2018.11.22.11.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 11:38:45 -0800 (PST)
Date:   Thu, 22 Nov 2018 20:38:37 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] uprobes: Fix handle_swbp() vs. unregister() + register()
 race once more
Message-ID: <20181122193837.GA3320@andrea>
References: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
 <20181122161942.GG28270@redhat.com>
 <20181122162708.GH28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122162708.GH28270@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:27:09PM +0100, Oleg Nesterov wrote:
> On 11/22, Oleg Nesterov wrote:
> > On 11/22, Andrea Parri wrote:
> > >
> > > Commit 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() +
> > > register() race") added the UPROBE_COPY_INSN flag, and corresponding
> > > smp_wmb() and smp_rmb() memory barriers, to ensure that handle_swbp()
> > > uses fully-initialized uprobes only.
> > > 
> > > However, the smp_rmb() is mis-placed: this barrier should be placed
> > > after handle_swbp() has tested for the flag, thus guaranteeing that
> > > (program-order) subsequent loads from the uprobe can see the initial
> > > stores performed by prepare_uprobe().
> > > 
> > > Move the smp_rmb() accordingly.  Also amend the comments associated
> > > to the two memory barriers to indicate their actual locations.
> > > 
> > > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: stable@kernel.org
> > > Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
> > 
> > Thanks,
> > 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks, Oleg.


> 
> Yes, but I am not sure this is the -stable material...

I'm inclined to leave it to you/the maintainers in question to decide
about this, ;-)  but please let me know if a resend or another action
is needed from me.

  Andrea


> 
> Oleg.
> 
