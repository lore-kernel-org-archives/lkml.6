Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35910C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6920844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz9NelQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E6920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbeGYCmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:42:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32986 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbeGYCmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:42:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id u14-v6so4293570lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rWCQLzHYthqwSLNObBEn88/JuK+fQuRSAhkyzTRA02Q=;
        b=Tz9NelQR1zlSgaUZ9MtTZIQsv6Mxxvte/T/J9hKU96vKz+2S+dLXHXHbMsGHYrkmKr
         FtP8K5hJuahvuIsb0uI85kXNMhgLC1zHGH3culaEy2MXA8PA8vlg1EU+SKWTwCutckj1
         GLqEeq0PNOKe/cu52bgprMLPDEAGH0moiNydY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rWCQLzHYthqwSLNObBEn88/JuK+fQuRSAhkyzTRA02Q=;
        b=qiHVPu2Q2s9sIw5q5MSW09+gGMQd+d0W7U77Y0iAxLXAC5rryjMt9bNd5w88Nje9GG
         fZoaG0IGX1+b9DL2et082A+trx3+zWn2SyIqvVmyjyDgBW/RwtYqSM0vmG0rAzU1TEpK
         AZdOPb72auDZ8Op8ml/uHunw2mfemTfi9gIcFYbMyJh/CF6RhI/I62E6onK6yo6LyomG
         8gzhoP/+ujGk+0jdCeL7zy7CCe9OYxCUZ694mxqBqkP2o0l6cqBqG/jvwf6frP53BU6+
         Hoc9gKydyvMVbnPKUjeW47cjTB8S0cg5CZApPlDoAFkT+2muGDhwyo9EuIP2/IpQP7v0
         ze3g==
X-Gm-Message-State: AOUpUlG152mv0oed5+XaljQJI/HsbPoqwlMxwkRs75PNmD5F/FUvqPEU
        JDVWv+T9EosIcGnBoQJRGwxrDw==
X-Google-Smtp-Source: AAOMgpfNw/EQtILEWBQwix7BOnNqyYD8GbkrKFRjICopdyBZL35x/wTU0XKsZA5UfGoPbh3XZP4qZA==
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr12013831lfj.111.1532482384335;
        Tue, 24 Jul 2018 18:33:04 -0700 (PDT)
Received: from localhost.localdomain (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id z90-v6sm2517169ljb.59.2018.07.24.18.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 18:33:03 -0700 (PDT)
Date:   Wed, 25 Jul 2018 03:00:52 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, songliubraving@fb.com,
        torvalds@linux-foundation.org, riel@surriel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        linux-tip-commits@vger.kernel.org, rafael.tinoco@linaro.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Leave lazy TLB mode at page table free
 time
Message-ID: <20180725010052.GA2502@localhost.localdomain>
References: <20180716190337.26133-3-riel@surriel.com>
 <tip-2ff6ddf19c0ec40633bd14d8fe28a289816bd98d@git.kernel.org>
 <20180717114647.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180717114647.GW2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-17 13:46, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 02:34:07AM -0700, tip-bot for Rik van Riel wrote:
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 3063125197ad..e811ef7b8350 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -303,4 +303,14 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
> >  
> >  #define tlb_migrate_finish(mm) do {} while (0)
> >  
> > +/*
> > + * Used to flush the TLB when page tables are removed, when lazy
> > + * TLB mode may cause a CPU to retain intermediate translations
> > + * pointing to about-to-be-freed page table memory.
> > + */
> > +#ifndef HAVE_TLB_FLUSH_REMOVE_TABLES
> > +#define tlb_flush_remove_tables(mm) do {} while (0)
> > +#define tlb_flush_remove_tables_local(mm) do {} while (0)
> > +#endif
> 
> Is there a reason these are not inline functions, which gets us type
> checking and the like?

More to that, when building (linux-next tag: next-20180724) on arm 32
there is this build error when CONFIG_MMU is enabled, asm-generic/tlb.h
isn't included, see arch/arm/include/asm/tlb.h.

  CC      mm/memory.o
mm/memory.c: In function ‘tlb_remove_table_smp_sync’:
mm/memory.c:339:2: error: implicit declaration of function ‘tlb_flush_remove_tables_local’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables_local(mm);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table
mm/memory.c: In function ‘tlb_table_flush’:
mm/memory.c:372:2: error: implicit declaration of function ‘tlb_flush_remove_tables’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables(tlb->mm);
  ^~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table


Alternative could be setting in every architecture's asm/tlb.h but that
doesn't make much sense. Other way would be to include prototype in
arch/arm/include/asm/tlb.h, not sure if that would be the best. Is
there any other place this could be defined for fixing issue in arm 32
bit ?


Cheers,
Anders
