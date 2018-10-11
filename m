Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5020835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Bw9lZqJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB5020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJKMj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:39:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36568 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeJKMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:39:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so3593971pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 22:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrax6q2VCgf5vW7u/O7ruCVm9esLHcgYBrrtqzp53V4=;
        b=Bw9lZqJnlzIe3CkGBgQoadRNPp+LJe2gQT6i3nRSvGLO0RvXikKsgLT9VUmOwWrPNS
         InKsbjYr6MIWgqgd9t4MS7dqSXtRZocU0+YkrNhwm5Ek8vKohtKZZq28pm372BSFbvDY
         6shVOCJvoGNWU4hTTuSzyEHShhvuuJrmNDhIAsohLz1akqcv/ZtzBy22ZqlVJDAERt5d
         iHs7c+J8zabuP1OgmO/ncYXzF2XU6rYP1gP18NIbNn+YPQzVsGEVmec2/nI7ro33ZI3B
         dbaDLgm5I/QAs+9YmmtqUj5oSExTuDVRxoE1WRhkGUkTC8uvc+6zp7hRVJP+GnSllNWZ
         2HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrax6q2VCgf5vW7u/O7ruCVm9esLHcgYBrrtqzp53V4=;
        b=RuoCJjNtEvkt9TEk5HsEhe60lq9ZtMs2viPIr+9ndWersU94HAOHwd3l2wJr2EY6Wu
         ktDY1TT2LwGz6XX3iK4+OPckfSM98wV2XCkt0Va3YfYvvkLkQ86KJfj+D0v+LKf4YFvN
         atPrhjCHxeqdZ51bGsKRTsPqg1m9OVwZWzNpV5x1Jf3JghBK85D7pbUdOyFG2ETziF0B
         eGptesIzhjLlzi3O7hTSQaJo8XgooltwAvgIKAJOTBvLn66+OrdEYlTr4O04ju8rNQ4F
         lJAz64Zyp/dQ1qeC68eqqWKSwxGaWvbsT5dzPUK6KJdKlgpXe3xPUcLsWSf2fEInER6d
         qNHw==
X-Gm-Message-State: ABuFfogXJ3mBFhgZgDpgN/t37QMtMJj0bHIcP5JS67Qyf6zkaC81aYJQ
        SmWFnIE2XnMcWwh3Gl8nbXBPjg==
X-Google-Smtp-Source: ACcGV61s9w/udDZ6aOW7WzaRCRs2yjwjJ7fqcDogvOlP3GdPwehOaBVIH7072l9PKO9HbcSsvuVUPg==
X-Received: by 2002:a63:790e:: with SMTP id u14-v6mr70979pgc.111.1539234864437;
        Wed, 10 Oct 2018 22:14:24 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id i29-v6sm45454693pfj.82.2018.10.10.22.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 22:14:23 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 56DA130002F; Thu, 11 Oct 2018 08:14:19 +0300 (+03)
Date:   Thu, 11 Oct 2018 08:14:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181011051419.2rkfbooqc3auk5ji@kshutemo-mobl1>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
 <20181011004618.GA237677@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011004618.GA237677@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:46:18PM -0700, Joel Fernandes wrote:
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 391ed2c3b697..8a33f2044923 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -192,14 +192,12 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
>  	return (pgtable_t)pmd_page_vaddr(pmd);
>  }
>  
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
>  	return (pte_t *)pte_fragment_alloc(mm, address, 1);
>  }

This is obviously broken.

-- 
 Kirill A. Shutemov
