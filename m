Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F73EC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 04:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C763B208DC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 04:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1cSFKwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C763B208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeHZI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 04:28:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37409 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbeHZI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 04:28:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id c6-v6so2702400pls.4;
        Sat, 25 Aug 2018 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=voT4wz7o2eSITINViC56kxcXSssfMeFKzS2ncXOHuN4=;
        b=P1cSFKwJLdBp/+bZl+hbsBNjLpzumbBldCdRb9XhGzNHkwBbR1vy5CUcXNUIBffd/Y
         tnBv7Kgqh/7169ARHoHe8ZayjEVpjV/oSnJVRgOo7bYuzDxoaPU6uju/q71HAL0y6Utw
         JN5GUNEOlHNnDaxOIRcWm1VPpqdrO16q9sCqm6Ym1Q1TZ8t32aEVCv4uwQPLGxiAmjGd
         sUkbwWOoRoQwVOYUb2yPQDBoYCxMQpawX9VnTPes8qCnkPCf2QEMizgGFcrDaYnKx7da
         ea4h67mwPU+aqJXgJMA0VP2fp0T8Za5OhBQEenCrybckJaa/TghHSpPrgIO6H4tzbKYj
         TheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=voT4wz7o2eSITINViC56kxcXSssfMeFKzS2ncXOHuN4=;
        b=T2MWdASnoh9Aszh1IQxynKWeO2SdpDsAoClOeZYBzX+DYZ/J3VvTqb2njEHE0+31i1
         NleAINXUelRp73IJEd26kh8VCRoqdV8NXo6hwWruQojLaOc//MGIWkkt0H1qyadIpqI4
         RqNzmAQ+UH1UOb2EHdlfpftH1B6+Hin8Hko7LZEjE6IufF73crHy3wa9hu5EofjI4zZM
         ut+B5gE6AICu7jl+mLhT+JJ3JNqRdARPpF5dfPCWg2TB4vz92tVA1/uWxTkumzpPzkYw
         vkP/kGCUldsuYYovAwAA+gqHlcbnZR1n33FWwMrcpbAEVVWWGp7TMS3DL+0QDxyFCrJb
         Eh5w==
X-Gm-Message-State: APzg51D+yHnlicOoVgFB5RoVh4naISQ/cqYQclDWsAAlRa3qGNlMuVhX
        lskZTKeCra5q2xnTAwy4eAc=
X-Google-Smtp-Source: ANB0Vda9hHNxuBmXGnxayHBwkCNo5pB1cA+vwlt+MIklT6QosKSEBwOCarSQBp/imCZiuTvIEXJ2JA==
X-Received: by 2002:a17:902:b702:: with SMTP id d2-v6mr8022746pls.12.1535258808515;
        Sat, 25 Aug 2018 21:46:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r23-v6sm16906647pfj.5.2018.08.25.21.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 21:46:47 -0700 (PDT)
Date:   Sat, 25 Aug 2018 21:46:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bernhard.kaindl@thalesgroup.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180826044646.GA24782@roeck-us.net>
References: <20180825135015.33547-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180825135015.33547-1-andi@firstfloor.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 06:50:15AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Patch for stable only to fix boot resets caused by the L1TF patches.
> 
> Stable trees reverted the following patch
> 
> Revert "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"
> 
>     This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
>     commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.
> 
> but the L1TF patch backported here
> 
>    x86/mm/pat: Make set_memory_np() L1TF safe
> 
>     commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> 
>     set_memory_np() is used to mark kernel mappings not present, but it has
>     it's own open coded mechanism which does not have the L1TF protection of
>     inverting the address bits.
> 
> assumed that cpa->pfn contains a PFN. With the above patch reverted
> it does not, which causes the PMD to be set to an incorrect address
> shifted by 12 bits, which can cause early boot reset on some
> systems, like an Apollo Lake embedded system.
> 
> Convert the address to a PFN before passing it to pmd_pfn()
> 
> Thanks to Bernhard for bisecting and testing.
> 

Thanks a lot to you for tracking it down, and sorry for messing it up.

> Cc: stable@vger.kernel.org # 4.4 and 4.9

LGTM for v4.4.y but ... are you sure that this patch applies to v4.9.y ?
Commit edc3b9129cec is 'native' in v4.9.y and has not been reverted there.

$ git log --oneline v4.4..linux-4.9.y | grep "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"
edc3b9129cec x86/mm/pat: Ensure cpa->pfn only contains page frame numbers

Guenter

> Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Tested-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/mm/pageattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 27610c2d1821..1007fa80f5a6 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -1006,7 +1006,7 @@ static int populate_pmd(struct cpa_data *cpa,
>  
>  		pmd = pmd_offset(pud, start);
>  
> -		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
> +		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
>  					canon_pgprot(pmd_pgprot))));
>  
>  		start	  += PMD_SIZE;
