Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1137C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E2D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SEk+Wt4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E2D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeKPBHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:07:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44146 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeKPBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:07:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so9323236pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=24JG3cUKzQWrcKQyIOLhenCWTe3cRMt7frjOX9/e/2U=;
        b=SEk+Wt4WCYLIr1NCgAvQlQB97RcZg4cCG5VKofuQ3NE1+GDriRyCBm/xgY+uLLsnt2
         IO+miovqipaPJ2Hz3fT2L5KXCc6HYr1rWAM7JtRQe0h0SiGBSwbIWrXnmgZiKGJaXPJy
         aiEybmsg95bXcrBeKNwMdfbZta+v3nz8zQsSJeeGJ0K523T0hSGV1EHGsyYBzOIksaIE
         g/WvFh6LrnAco18uNvzDAJVEJkc7eD9dB7Wn9fjjUEdjjWChOOoi0L4LFj2zOa8I3a10
         gnq+msRduQHYJnildlvMAXEMIVxTEwGqYFcalh4RutEev7g2feee3Y8GTvmJEQhiYG/g
         xCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=24JG3cUKzQWrcKQyIOLhenCWTe3cRMt7frjOX9/e/2U=;
        b=sIC6XaTuhgkD2IzLXm6SHAnvkSoPdPztgN5id2ugYk3VvjcfjW57HWbvbHLdPht8RB
         qzOnK9+4pAnOIDPs6HJ3AmVfM0jzv5ZL0ipl70yLZrSJEIg/xNkCc/ELRilhAlUN6b1m
         11ltGEm6Awwkc/CHE1u773fgqlVGz3Dazh4tQMcz/IQtqp3U8deupMKC6SyxFWRQc3Wx
         F84futy+5iiT5GPtKnnstuTAtRO0uLjag1cVl1QMVOlbnIdVI7T4tEzrImR8EMcsvmiU
         xrCXc/z0HrWAzELs3aH3DWKveETQ197gArBWnfgorBDwH2hd3Sl672nqFFACwEcFV2Bw
         4X2g==
X-Gm-Message-State: AGRZ1gItMR5WIT1Vwk00W8Mthv3tTFsEJyDJlqUgADi/s0vlCL3VACBV
        AIeg+hmyt3j/HYnwOsQwM0WJkw==
X-Google-Smtp-Source: AJdET5fikEuezpg+8evxWbxaEoQI4neyR57oXZ0MoazVwAMbfZoTNas87zquQZ6VLDC/WpZ0imazwg==
X-Received: by 2002:a63:af45:: with SMTP id s5-v6mr6101120pgo.125.1542293946495;
        Thu, 15 Nov 2018 06:59:06 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id g5sm23690020pgu.57.2018.11.15.06.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 06:59:05 -0800 (PST)
Date:   Thu, 15 Nov 2018 06:59:05 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:50:43 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Fix raw_copy_{to,from}_user()
In-Reply-To: <20181115002755.24195-1-olof@lixom.net>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Olof Johansson <olof@lixom.net>
Message-ID: <mhng-4c28d7f1-e034-4506-9ace-40fc2abd1668@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 16:27:55 PST (-0800), Olof Johansson wrote:
> Sparse highlighted it, and appears to be a pure bug (from vs to).
>
> ./arch/riscv/include/asm/uaccess.h:403:35: warning: incorrect type in argument 1 (different address spaces)
> ./arch/riscv/include/asm/uaccess.h:403:39: warning: incorrect type in argument 2 (different address spaces)
> ./arch/riscv/include/asm/uaccess.h:409:37: warning: incorrect type in argument 1 (different address spaces)
> ./arch/riscv/include/asm/uaccess.h:409:41: warning: incorrect type in argument 2 (different address spaces)
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/riscv/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 473cfc84e412f..8c3e3e3c8be12 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -400,13 +400,13 @@ extern unsigned long __must_check __asm_copy_from_user(void *to,
>  static inline unsigned long
>  raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return __asm_copy_to_user(to, from, n);
> +	return __asm_copy_from_user(to, from, n);
>  }
>
>  static inline unsigned long
>  raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return __asm_copy_from_user(to, from, n);
> +	return __asm_copy_to_user(to, from, n);
>  }
>
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);

Oh, no idea how I missed that one.  This looks like it's been in for a long 
time, so I'm surprised anything works at all!

I'm going to add a stable CC and PR this to Linus this week, assuming I get 
some time to at least give it a minimal test.

Thanks for catching this!
