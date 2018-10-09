Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56230C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D6A2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nifWcTpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D6A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJJG1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:27:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38427 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:27:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so1553669plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULY//GBZvi+f3kccvWtwKU1JAZlRFthAzqXIIT6GbOU=;
        b=nifWcTpgOCqb7M+dEVVMxs6w4vV69BB/kshkK+Og/jHKLgtQUvlHB381+iuJWyv4zu
         isNTo34VzvYbiE1mze2Dc5hfMYu4dYVj/2dfNPzoXnPl0UYLZ3nh9Aq9qZ7+cZiHCuOd
         MrOQcAcIsFRyM7bPx5HarB13VBIBgns/b3iA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULY//GBZvi+f3kccvWtwKU1JAZlRFthAzqXIIT6GbOU=;
        b=H/cXn/+HVslhEIspNgdWMh2lhLgM4UrULhfTxH5uCYA8cJpAj/lRv5GbJYD/kEXIt8
         UyzGLcd6dSJSnVGnklyJaFx/aDktoPd4K9UxZD4RgFqmeYwJKzhTgYcUe4+jku1f/T0u
         RdUMC4NBVTyYii26Luy2NJd3tqU9qX59yF5Vk/i3vNzbMxH6uP4h1ZlsQ0OIAzeUKRZJ
         do+jdV3V6shPyDajKTwoLylpumeFR5snKVAC20IxtkbQ5z+s/hUFBLjm64p+1j4sWfWZ
         ztv5jT+hIQB7b5bfx/5c+XZjp9J5Vs2pxO5i6cuDTLLJttpp60t7hKRepNyXOheumBzo
         mYUQ==
X-Gm-Message-State: ABuFfohbbcUU+NDaIPPiiSpJ+fugGV16HfCe/98A2CcK58z68Yu67Ti5
        ZRv3KZ4aZBiAAqxYoD4FNao9kg==
X-Google-Smtp-Source: ACcGV60YG/pfhn1yC1xFNMB6WygaN5/F3TTAVOKVEsnN/EF2FSk5pCqcHJmPdVH9+q4Kk8lRfwGLMw==
X-Received: by 2002:a17:902:bb08:: with SMTP id l8-v6mr29701939pls.252.1539126510940;
        Tue, 09 Oct 2018 16:08:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id u62-v6sm28489522pfu.69.2018.10.09.16.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 16:08:29 -0700 (PDT)
Date:   Tue, 9 Oct 2018 16:08:28 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181009230828.GB17911@joelaf.mtv.corp.google.com>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009143859.8b9a700b1caf4e8d1e33a723@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009143859.8b9a700b1caf4e8d1e33a723@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:38:59PM -0700, Andrew Morton wrote:
> On Tue,  9 Oct 2018 13:14:00 -0700 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > Android needs to mremap large regions of memory during memory management
> > related operations. The mremap system call can be really slow if THP is
> > not enabled. The bottleneck is move_page_tables, which is copying each
> > pte at a time, and can be really slow across a large map. Turning on THP
> > may not be a viable option, and is not for us. This patch speeds up the
> > performance for non-THP system by copying at the PMD level when possible.
> > 
> > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > 
> > Before:
> > Total mremap time for 1GB data: 242321014 nanoseconds.
> > Total mremap time for 1GB data: 196842467 nanoseconds.
> > Total mremap time for 1GB data: 167051162 nanoseconds.
> > 
> > After:
> > Total mremap time for 1GB data: 385781 nanoseconds.
> > Total mremap time for 1GB data: 388959 nanoseconds.
> > Total mremap time for 1GB data: 402813 nanoseconds.
> > 
> > Incase THP is enabled, the optimization is skipped. I also flush the
> > tlb every time we do this optimization since I couldn't find a way to
> > determine if the low-level PTEs are dirty. It is seen that the cost of
> > doing so is not much compared the improvement, on both x86-64 and arm64.
> 
> Looks tasty.

Thanks :)

> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >  		drop_rmap_locks(vma);
> >  }
> >  
> > +bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> 
> I'll park this for now, shall plan to add a `static' in there then
> merge it up after 4.20-rc1.

Thanks, I will also add static to the function in my own tree just for the
future in case I'm doing another revision.

- Joel

