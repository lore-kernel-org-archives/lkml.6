Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E5217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxtL2tAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83E5217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeHEAaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 20:30:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32970 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeHEAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 20:30:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so4499782pgv.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szJdlIA4K2JhXIT1uFendEgVsZjjT5okEg94tAFG6+8=;
        b=kxtL2tASejAEzEgizI6BBYgEoCLwgFVCh8hzbp0cIK/1hnpV6dQxuR9ywpgh4lA8W6
         fEFSgGPVei0HcWypWOir918zM9jasyAvMwGuEBLcK5ERWek3m22QY2VFzGRiUtvYqInt
         tBq9Gj2+EPv0C1YVghKvcJ+n1jQyioI4kRrWFeiiLFstjOp/Hh2CMJ886yoq1CHS9dMG
         0DbADNl/RH2lhMv2jpMaTUDCQ0fNwKy6T6PiJPCePG90x0aQpBiC7+t3lUR7Re9Hr0fx
         jW2GfT0qM1dkGyRsTp6ZO0jOgfrO6u/hm4ZHdlm1iuw8U42NmIs0SEiwllcuM4cL7ifd
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=szJdlIA4K2JhXIT1uFendEgVsZjjT5okEg94tAFG6+8=;
        b=dEL7sb8O08OAauXlzZWS8awQdEV1ck9JuEIJM5aG8A/zSzCC8ObL3s5n+B6kE08hC7
         Ly/vpjwSIi5iC9tiQ6syaCnXVg1TO7APTkzJbbc8noOG0uRe+EtncRGaQ80k05BGwqvC
         Abp1C4vIaotfM5k9zk/6ERFP97GjRUhlixX6iJ56AURbCaJ8ukoVGp8UKxSkXFltKQf6
         zDWXw3QFmg+aNWDgwWEmzGxrGlaYr5nZ609d6gEFHq4/A7+Oq6ExSv/UV6x6AokGsH6G
         UXnrS9bfM28za2u0I5UdpZaDApGjong0X9s8wJ7xiDvv9kwQLVQPoOOj0lvwNMdudHma
         r6Zw==
X-Gm-Message-State: AOUpUlHuc1TX3CTRGriA8bjNHTSW4m/qpoxU6fvIsUusVp0UxkzBOkJk
        eR4uv+GBkfngqBjaHcuViK8=
X-Google-Smtp-Source: AAOMgpelKnuYQH06Bbk2NXiUo4k4DHFlBvChMv2L6qkL1Aq/ZzSliy+UBFu/1U4R5Vy9komb9o9zmw==
X-Received: by 2002:a63:614d:: with SMTP id v74-v6mr8882194pgb.328.1533421691217;
        Sat, 04 Aug 2018 15:28:11 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g7-v6sm11063598pfi.175.2018.08.04.15.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:28:09 -0700 (PDT)
Date:   Sat, 4 Aug 2018 15:28:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        efault@gmx.de, kernel-team@fb.com, mingo@kernel.org,
        dave.hansen@intel.com, Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
Message-ID: <20180804222808.GA8011@roeck-us.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716190337.26133-2-riel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:03:31PM -0400, Rik van Riel wrote:
> The mm_struct always contains a cpumask bitmap, regardless of
> CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
> simplify things, and simply have one bitmask at the end of the
> mm_struct for the mm_cpumask.
> 
> This does necessitate moving everything else in mm_struct into
> an anonymous sub-structure, which can be randomized when struct
> randomization is enabled.
> 
> The second step is to determine the correct size for the
> mm_struct slab object from the size of the mm_struct
> (excluding the cpu bitmap) and the size the cpumask.
> 
> For init_mm we can simply allocate the maximum size this
> kernel is compiled for, since we only have one init_mm
> in the system, anyway.
> 
> Pointer magic by Mike Galbraith, to evade -Wstringop-overflow
> getting confused by the dynamically sized array.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Tested-by: Song Liu <songliubraving@fb.com>

Hi,

this patch causes unicore32 build failures.

In file included from include/linux/mm.h:17,
                 from arch/unicore32/kernel/asm-offsets.c:17:
include/linux/mm_types.h:497: error:
	flexible array member in otherwise empty struct

Build reference: next-20180803
gcc version: unicore32-linux-gcc (UC4_1.0.5_20100917) 4.4.2

I understand this is an old compiler, but it is the only available
version as far as I know.

Guenter
