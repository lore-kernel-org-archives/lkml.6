Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C552085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AV0quuhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C552085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJKPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:37:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43369 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:37:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id 80-v6so3791564pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01WX93wgyiwnLNpq4HsiYe5Hp/fghDwKSyyAXQyo5W0=;
        b=AV0quuhfo89lhGys6MundcE6OzdsSwbXRx/6P8WuZllQe2dn1whNdBgueE37/ZZXvh
         Yro5ZzKHLihsfKJpZ1myXlvYyjIAtcoZNyDnTTXttMTCXjaNxsJa9rD/FfYP90SQIxih
         5AsdorjnvipNHPGOScQ0mtRoyi08cRObTrX5yY9EBn1QxaDw0nSwfbk+FSVzwb3YHCQ7
         pfXNNMiNvD67+XS0vAirAAyQ6c1/mjj8QN23sQtkggS+SJOXDjxIcB8UqHuO8O2siMPu
         JeawBF5W6kLQg1cI9OTIDr+uNtSyqJR29/8Jf3tATxNimdldEvzxT9wFa6bkUCt/h11Y
         pW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01WX93wgyiwnLNpq4HsiYe5Hp/fghDwKSyyAXQyo5W0=;
        b=PoLrkarTwwd19QmFPnuqCHlcIf1Sn9JPBhZDMbw559mWCN7rIhqwsTMutrAzdr1yVy
         FT5LYOcWY47+k1s8Lsp4td/Rhg3uFJ1U4R7+DbGfpkYMi2Hw0XqAqLuvHkjYQ21p9Xoz
         i6sjhA6PzCtOpfmwyW7Ja17V3y6/QJ8yGgM0zTy9yi1WrVCFFQJCDv867fL0eqR/eYp+
         FtD1UpqOE3mxCqjm41uVAtjabnbpIAQdCEGODnP+ymVHZ/McHRsriDOto4BKg7jgq9A8
         Q+b5DrWj+yO/7zxBqh73O5GIxqzgt+eXH6AT8UDLia81Rs+20XJ8MG0vhjIAXlnmAE8z
         v5WA==
X-Gm-Message-State: ABuFfoiHgf8748Xgj26x7oNP4Q0gjEiTiZZzD5i6b3pXIFNtUEndBliY
        CSDT0KiK35JfpXO0IK8q5Qi7Jg==
X-Google-Smtp-Source: ACcGV62D8ZbwCoueMYEFSuwvRYUeziAkW8OLnDrnrjv9igfmuhsVfXiRNOOrEAnk+qr1jVfbBYQsJg==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr569258pfj.152.1539245477157;
        Thu, 11 Oct 2018 01:11:17 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id z15-v6sm32686777pfn.170.2018.10.11.01.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:11:15 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 9F3EC30002F; Thu, 11 Oct 2018 11:11:11 +0300 (+03)
Date:   Thu, 11 Oct 2018 11:11:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>, g@kshutemo-mobl1
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181011081111.mfbhuantvxmkd33p@kshutemo-mobl1>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
 <20181011004618.GA237677@joelaf.mtv.corp.google.com>
 <20181011051419.2rkfbooqc3auk5ji@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011051419.2rkfbooqc3auk5ji@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:14:19AM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 10, 2018 at 05:46:18PM -0700, Joel Fernandes wrote:
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > index 391ed2c3b697..8a33f2044923 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > @@ -192,14 +192,12 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
> >  	return (pgtable_t)pmd_page_vaddr(pmd);
> >  }
> >  
> > -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> > -					  unsigned long address)
> > +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >  {
> >  	return (pte_t *)pte_fragment_alloc(mm, address, 1);
> >  }
> 
> This is obviously broken.

I've checked pte_fragment_alloc() and it doesn't use the address too.
We need to modify it too.

-- 
 Kirill A. Shutemov
