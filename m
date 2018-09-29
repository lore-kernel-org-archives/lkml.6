Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B880C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7702073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bdgMqlpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7702073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeI2IMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:12:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2IMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:12:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so5622419pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+fuGy+pifrRZFj/cFZF/CSeVl9uFYeegfIF9yaeB2zg=;
        b=bdgMqlpAMNX//TL3q2S0Ijv+ZbJwfamvgvdFpDq/pZM7s6c77h+0vHNv1ZR9SeV7tx
         zFE9M4hI7uCoIbHaBeujmFMk1rtmyPs1R7SAx3z34+erUuV+xOlEqHL+/Y9RpIgCz8l4
         U0SUrfrvs5dc7SN5T0j04RVp1KoNDNIOLJ48cUEElKU22BPToRROZoxPiVEXK/7blfU3
         DL7OCsv9VmBXdhX2BEdcfu8yex07g5ucn9m8q4fePiGMWbhwc5gehkajE9UkMLAFlF+R
         2UJe6b+Q3Rl5O2hmKnv+oshXtcySzcbEQ10XB79+QIfy4ipLa0dI0V5ezWJHrPPsrAgB
         4N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+fuGy+pifrRZFj/cFZF/CSeVl9uFYeegfIF9yaeB2zg=;
        b=H9KOYTXt0ip79GG3nJiqP7UBbJHoaZb1k62T6vNq986rROExM0eoIGz1oghgyHQYkE
         UhVcelvCEbFJWCM2fnggLYGuiiasg4yUknbGN1jgGkiU5RUwzBYAp15il0KFbSQ38BwJ
         kCEVZcfdxE6fMusL6nmisxR6CeMIxyECRWh4Kbed8wB0T5oKPJXFYodRfGRub0K7Jv3i
         4/Y+myHpxnV8ZTt5y9PAwp/wEadQaqsTsYk94aEOA+95Bed0ewyROtRb8Rugg67Wan8r
         dHsKHwpHioL0Y9i8L3QobM16m9HhIQx5MYV96NrUCPyFT+F9lfwHgMd6AIWNf1MR1PzJ
         LK/A==
X-Gm-Message-State: ABuFfoiP/pccHyK17usQqvFbu3tOs4548YaftP544pPsl5psJIVnxjX/
        Y1WKkTB4iCa2hR6tC4OrMnsprg==
X-Google-Smtp-Source: ACcGV61XpzBFyBsC9g4XWcGC3m8QZKgvbmv7znUK8vG/mJxog+GlSx/C02Y7wNP4NWfMiZeUbPytoA==
X-Received: by 2002:a63:2c01:: with SMTP id s1-v6mr1027381pgs.367.1538185571029;
        Fri, 28 Sep 2018 18:46:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j184-v6sm9432085pge.77.2018.09.28.18.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:46:09 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:46:09 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 18:44:32 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
In-Reply-To: <20180912143822.21948-1-anup@brainfault.org>
CC:     aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-f8bcf381-8d26-4082-876a-781fe87ee721@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 07:38:22 PDT (-0700), anup@brainfault.org wrote:
> Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
> is in-correct. This patch shows CPU ID and Hart ID separately
> in /proc/cpuinfo using cpuid_to_hardid_map().
>
> With this patch, contents of /proc/cpuinfo looks as follows:
> cpu	: 0
> hart	: 1
> isa	: rv64imafdcsu
> mmu	: sv48
>
> cpu	: 1
> hart	: 0
> isa	: rv64imafdcsu
> mmu	: sv48
>
> cpu	: 2
> hart	: 3
> isa	: rv64imafdcsu
> mmu	: sv48
>
> cpu	: 3
> hart	: 2
> isa	: rv64imafdcsu
> mmu	: sv48
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/kernel/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f0f0ec2737b7..7c1342e242e6 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,7 +87,8 @@ static int c_show(struct seq_file *m, void *v)
>  						   NULL);
>  	const char *compat, *isa, *mmu;
>
> -	seq_printf(m, "hart\t: %lu\n", cpu_id);
> +	seq_printf(m, "cpu\t: %lu\n", cpu_id);
> +	seq_printf(m, "hart\t: %lu\n", cpuid_to_hardid_map(cpu_id));
>  	if (!of_property_read_string(node, "riscv,isa", &isa)
>  	    && isa[0] == 'r'
>  	    && isa[1] == 'v')

I like this, but it doesn't appear to apply.  Do you mind sending something 
against Linus' master?  Then I should be able to sort it out.

Thanks!
