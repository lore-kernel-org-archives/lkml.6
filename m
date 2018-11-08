Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC87ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC23204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GSeGubkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC23204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKIFJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:09:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeKIFJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:09:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so9754558pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TIK2R+2irgTzLBZnutnmO7Lc4vftZqOCApHzyog2wpk=;
        b=GSeGubkSB+I4iOXXfYrgyGhmdpepc2pi4ErUd+gTvHpg6iaU1Cr2zplCKZ5rhqWYGj
         vs0zeZcNqw6FiaIohWO/QBY1GffRWhj9seYod5IIOUcNWTku2fUkU7rDAWMMvB114k0J
         99mpw2lQ7SRp0xlbP6NyN5cqQr7yhdutsk7pr3zb9AE5R/8WPYOWdlvP8CM64HTcK30W
         VS8SnOGSrAMtaNJdLkKjP8zGlMT686KUuWwt7SGM51tXg5RS+FdpGUqeyQYDl9Tpetj+
         p5w6rGKu1WpmrUeJZY8Iy4upsBKzM+5o+FncLHxrZfbnXa9ESvMkdz3ImpNSi1iv04ko
         Y6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TIK2R+2irgTzLBZnutnmO7Lc4vftZqOCApHzyog2wpk=;
        b=df1xADtP9KML2zbEb8Wyfmga5EN+YI8FDzCBK+YGvzf6tuwl7/BbNnBCU2AH2gAUwV
         RxS2khdWe+xOq0Cd3QSUihVvR6A2fHo/pOrRRrTh0pNXBZOeySVaWiEYGb0SCkV7opSP
         opjqL5A5bFCjx4FHhu1zV/qX5zCJWHv43z6FlEZNyUdADI9BaH0LYrfzW2dpM5dnkReR
         GcvglsmrpHklbqegn1e+R/UDqGDeeLlpLPJcSsDW38Z11SBs74rZJrh6oEDAXJ55PfSK
         jFiD400TtnrXslkTKcjdfdD6slYFaEFYRFPgn60D19GJIOKI56+Nd2AdsB5s548S19X0
         lcxQ==
X-Gm-Message-State: AGRZ1gKboiE9YU2MHF1wB29TdQQcj4F1ZVMUohRD+/EgDYMQSChTbG5E
        3wnrNMjjZ8Hh5p8WTJKv5lZTbA==
X-Google-Smtp-Source: AJdET5d7IC22PPnlCqw2sFPla48l+0M4VDStY8BscG5Wi7dSvTRoNl4ETKw6Sy1MCDVTJeKMUlVuJg==
X-Received: by 2002:a62:3241:: with SMTP id y62-v6mr5921005pfy.218.1541705576361;
        Thu, 08 Nov 2018 11:32:56 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f22-v6sm5046601pff.29.2018.11.08.11.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 11:32:55 -0800 (PST)
Date:   Thu, 08 Nov 2018 11:32:55 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 11:26:45 PST (-0800)
Subject:     Re: [PATCH] riscv: fix warning in arch/riscv/include/asm/module.h
In-Reply-To: <20181108190700.30825-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-1888c072-5274-457c-aa26-b9fa9cb246dd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018 11:07:00 PST (-0800), david.abdurachmanov@gmail.com wrote:
> Fixes warning: 'struct module' declared inside parameter list will not be
> visible outside of this definition or declaration
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/include/asm/module.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
> index 349df33808c4..cd2af4b013e3 100644
> --- a/arch/riscv/include/asm/module.h
> +++ b/arch/riscv/include/asm/module.h
> @@ -8,6 +8,7 @@
>
>  #define MODULE_ARCH_VERMAGIC    "riscv"
>
> +struct module;
>  u64 module_emit_got_entry(struct module *mod, u64 val);
>  u64 module_emit_plt_entry(struct module *mod, u64 val);

Works for me.  Looks like arm64 might have exactly the same issue.  I'll roll 
it up into the next RC.

Thanks!
