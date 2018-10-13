Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9306C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D52F20868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TX0jPv1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJMJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:19:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45564 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeJMJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:19:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so6598641pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOwbPFoajGZi3/uQe5h542M6UYdoOEkmWBYBoXp9OV8=;
        b=TX0jPv1mV+ruD3G3qgqRA9UMXe+0i0YS6UXGUy6KTVLywoPyxQGhhjXFi4dn2iQI3x
         x/BukZ3beT2AFdW61n55JqI5ANyPOWfr1rNKfv8VAcertpXgkQEbv+tQZOTO68qVwDHs
         51gxQI0b3N3xdtlX+SiDVTyY2dpjIIcZ8JErQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOwbPFoajGZi3/uQe5h542M6UYdoOEkmWBYBoXp9OV8=;
        b=ZgviZjsjreUO8QO5zm4UjWow1Ob/2tuJAD3RzJbl9ZscS+5/VMWEGYPafBzd8s2wCP
         F9OOyyP04qN6UG8jtgtWaz/RI1FMERYvHyXyoozHKNX1RUeUOziAnKCp/yXJCxM6zJW5
         GX3VRUtZNZH5GpQ7Bg3w426NcMdvQyiMwpvMYLDEcnp3nf5ZhaDC5BRqwUzmINmBbtoN
         i1Giqs4IIXznqxC7ckAlXKBbEXC9q+nvgFDVzW8iTi4yB22veJHIJvB14kI7Zsyseydw
         h2A5NqGPtrE+g8lSpTrig9RwN68zQOPK8eew+Cn4x0pGRP9M4uED2wfSk57+0hYB9Rwn
         p31w==
X-Gm-Message-State: ABuFfojJbd9SOg4qYQFx340MgtJNON+20nqGds2sbXH9IB2yKFYVfDE6
        WlAitL7y4gBvfVKDqr1uzAj+tw==
X-Google-Smtp-Source: ACcGV63XxXW9pGHxVnF8xzzLyeXhR7XaYBjfw87dDDQ+CF+OqnNRmShTWlj1H1kUQbwXg/j2G4ghiQ==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr8356398pfk.191.1539395071806;
        Fri, 12 Oct 2018 18:44:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r81-v6sm6155322pfa.110.2018.10.12.18.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 18:44:30 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:44:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>, hughd@google.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, chris@zankel.net,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, jonas@southpole.se, Julia.Lawall@lip6.fr,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013014429.GB207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 06:39:45PM -0700, Daniel Colascione wrote:
> Not 32-bit ARM?

Well, I didn't want to enable every possible architecture we could in a
single go. Certainly arm32 can be a follow on enablement as can be other
architectures. The point of this series is to upstream this feature and
enable a hand-picked few architectures as a first step.

thanks,

 - Joel

