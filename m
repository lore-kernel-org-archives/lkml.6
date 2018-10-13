Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB0C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF01320895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t/bdXm4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF01320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJMJKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:10:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeJMJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:10:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so6683717plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
        b=t/bdXm4ahfHUsC1W/kmIGtZM4IaaXFvhptMHyl/MsEl85wogOLcBRPLXwHtXoa2xTR
         d2M48uB6euL4d5IaKV5t6nT5ABUr0y0qRBKJlUNuiclAcNB1bktYaPSMWAk89SYK1P2v
         +doypv+PPbaJGW2yXU+EaPjAWnWnd1ZXLhamE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
        b=MBQzjk2Xm9Plm5+r4pi2Xa89JXldz6NRFngZD3Jutj2KGPXyuRM4fGuxj8xeJw8Ddj
         0ve9jHWpDlnKo6AZ6lGSHxkLzeI/ReoEio6UthZCsxpThdubhpeAtbG2uY5ZgGagPsyx
         NdBKm/7Ct3WvzLkjkcnctTHcVvCcekkNfEdr3ojDVzIQnDMp1Hu753qyjWTYrm8t6arz
         inggrWwvSU4NyqOewzbGzn4AIdX8D7cstyvp8ANjIXZyc9rIFqhcIG6lOHTmOetUQNia
         ZhhW6nHGWMjRvU9c1AbyWR3b69NhM9gouYaWcBxGm7UlxaJzADcVo6QlUl+w9RA/EiAU
         L5zA==
X-Gm-Message-State: ABuFfoi5MIQMY9KiiAKXrXMpupqypmQuD/cAO0Pf/bFYzXPEK1uYNQQc
        GK1uvqwt85EXnl5o35XB+cEZ6w==
X-Google-Smtp-Source: ACcGV63YcGHLeWFH+zMcDfPGfwOAvPK81iWmstN1Bsc/dCjm29V/T1DgWrxlTjwp6QBDN3hA/VReOg==
X-Received: by 2002:a17:902:d20a:: with SMTP id t10-v6mr8118444ply.256.1539394543039;
        Fri, 12 Oct 2018 18:35:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 20-v6sm3688934pge.77.2018.10.12.18.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 18:35:41 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:35:40 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     David Miller <davem@davemloft.net>
Cc:     kirill@shutemov.name, linux-kernel@vger.kernel.org,
        kernel-team@android.com, minchan@kernel.org, pantin@google.com,
        hughd@google.com, lokeshgidra@google.com, dancol@google.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
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
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org, peterz@infradead.org,
        richard@nod.at
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012.111836.1569129998592378186.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
[...]
> > Also, do we not flush the caches from any path when we munmap
> > address space?  We do call do_munmap on the old mapping from mremap
> > after moving to the new one.
> 
> Sparc makes sure that shared mapping have consistent colors.  Therefore
> all that's left are private mappings and those will be initialized by
> block stores to clear the page out or similar.
> 
> Also, when creating new mappings, we flush the D-cache when necessary
> in update_mmu_cache().
> 
> We also maintain a bit in the page struct to track when a page which
> was potentially written to on one cpu ends up mapped into another
> address space and flush as necessary.
> 
> The cache is write-through, which simplifies the preconditions we have
> to maintain.

Makes sense, thanks. For the moment I sent patches to enable this on arm64
and x86. We can enable it on sparc as well at a later time as it sounds it
could be a safe optimization to apply to that architecture as well.

thanks,

 - Joel

