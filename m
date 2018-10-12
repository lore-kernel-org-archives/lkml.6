Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C5C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E52085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M1kp9MWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4E52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJLJR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:17:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:17:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so5336753pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hps4X0r/zbjefBalAQqG9RVbtlwJEFOGV2BoSuf9LMg=;
        b=M1kp9MWN9uHno4BwMMw7juAdNvS6j3b/aZ3mH4+4fBFTQKxnEWGby8AfzsLpdHN3+M
         FaqtGF+eJxp/fl+8fioT39V6jyG1pIgVjJi+syVwtnH1J07eU7WjQ6jNNa4psF7dPD3o
         sQPQrtj0XfgXOOYvOsyJ/TsYSzDINkIv4+GFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hps4X0r/zbjefBalAQqG9RVbtlwJEFOGV2BoSuf9LMg=;
        b=Kgqek4PuUDPYYuceOqhp7SSVD4JqKjuiJMdDG6l3Gxh0hCf25lsFp0i80SwGxwYUak
         tZ3aZqQIbStu+CAmtDheEyc4358xdABpEIGztVv8ieyIO27Q2tu7taF83Q3f3Ftyfd/T
         sX91rk0dXXSCk3YrgZY9QnbEr1y/0M/N5SQk7C5CnBgSKApA8Z4ScjYzBNX2HmGrMO1E
         CIO1qZJ6YJJ8EUZUGx/YeOJ1CR5F+z0D01ga+LDaaBr79sTzSr1/bXbkzULoFtQhbkhK
         vLvbg7SSoZV3iYFln+5SzmUhQZhHppZuE/hlrPsOxACxWz1qaIJvZp8m94xXny9Qtpcv
         IeRQ==
X-Gm-Message-State: ABuFfogVRlCVPVU0NzzgC1KHp4WFY8uz+aM0Dz8hIbDzCf6v0GqGnjJW
        xzBSV128eMhP7V2yyEbDu2wpU1RXHmA=
X-Google-Smtp-Source: ACcGV62jAGa4A/hLUSFgc1JLJaIP6eVmFlzWAubkLYGs1RyMdy3vqRsn1pdCOw1ntkK7DFej56scDg==
X-Received: by 2002:aa7:850d:: with SMTP id v13-v6mr4060249pfn.83.1539308848311;
        Thu, 11 Oct 2018 18:47:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 72-v6sm58103246pfr.115.2018.10.11.18.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 18:47:26 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:47:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     g@kshutemo-mobl1, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181012014725.GA12431@joelaf.mtv.corp.google.com>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
 <20181011004618.GA237677@joelaf.mtv.corp.google.com>
 <20181011051419.2rkfbooqc3auk5ji@kshutemo-mobl1>
 <20181011081111.mfbhuantvxmkd33p@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011081111.mfbhuantvxmkd33p@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:11:11AM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 08:14:19AM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 10, 2018 at 05:46:18PM -0700, Joel Fernandes wrote:
> > > diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > > index 391ed2c3b697..8a33f2044923 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > > @@ -192,14 +192,12 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
> > >  	return (pgtable_t)pmd_page_vaddr(pmd);
> > >  }
> > >  
> > > -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> > > -					  unsigned long address)
> > > +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> > >  {
> > >  	return (pte_t *)pte_fragment_alloc(mm, address, 1);
> > >  }
> > 
> > This is obviously broken.

I was actually aware of this, I was in the early stages of writing the script
but just shared the diff to give an idea the number of changes.

> I've checked pte_fragment_alloc() and it doesn't use the address too.
> We need to modify it too.

I rewrote the Coccinelle script and manually fixed pte_fragment_alloc in
that. I sent an update with you and Michal on CC, please check it. Thanks a
lot.

 - Joel

