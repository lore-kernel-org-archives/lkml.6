Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E19EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC262098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JimfSSER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC262098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeHBTQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:16:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35616 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeHBTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:16:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so1531638pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CartgWcyMGNYkrVQg9gKV81p9yJ8BPdE1rjLFM4ML7M=;
        b=JimfSSERlwlcKT4rHBAE7lrnEQzPjMULpYjR+8TMCbLUhecXWlthkCpN9psK880R/L
         vCh5UT4EVwz63Kv3x3ZHrs/NBHTCUdvk34f3TM5PlGGL8Pb4EFRj047yhVXyHlj4YYRV
         x0265svDhYhc0kA5614/1Juv8jPc6OYYLxDxEwK5GPL3BeBkcqtWjFDV6oSfu35pxxjt
         Qs6V43MHlqh7JgXAPgZfbpwH6Kz00NIzmHgTOQI+TZTyvlr72I9kLKqt55uLUx4Enrfd
         PVEZUDfSQxvmSH8EA0KiivmK5O0QfrQSSh5IE66EQoxVuUz0NDqvXAH/6ozvNopM8/Cm
         PdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CartgWcyMGNYkrVQg9gKV81p9yJ8BPdE1rjLFM4ML7M=;
        b=cK1nvpxNcof8wldxf2IJMLIn6GzRq/g4qH76AwPd9AkkeYNgUVD3oVExQCq8gkwu6R
         nu4tFkUkjGxJpP0P9BXIYev1vL0toDyq7lz31LySddT43JFy3iDWuVpB8hIfMORs2PoR
         /C+b7tk6pZ0FM4db2nODJI1wr5D9jyHREObJMzLizKQh7i9tC2TWI086rdc3jBNs6TBo
         MeAU+Dyg1cGi195bnwO0MVxZRugz/rJKbLkECAvjGPpaZoWfyjRtHf17xvOMmS5mY+tH
         jU1Nbu7HKlFbwz0e3k3HMf3ge0F+t3oIQKAXkYlJyMuLpoXQPuwpFMxkY2TV0b7k2AbJ
         0VGg==
X-Gm-Message-State: AOUpUlE+aXpxPZs7fgeLHLa9zz2I4yiIfKaDXwefw7SAd+DmPBrKe13K
        UzPIRQ6XCanP6hHEsgAx0q8a7A==
X-Google-Smtp-Source: AAOMgpfGvwwXqlmTX5O1m5vnoCTT15qnEuLK+yRTyyXQvvYGu4d7P1J7Xzcz/MDfKLWXhtOkP/f+Vw==
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr413534pfi.172.1533230652769;
        Thu, 02 Aug 2018 10:24:12 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f3-v6sm2485426pgq.49.2018.08.02.10.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:24:11 -0700 (PDT)
Date:   Thu, 02 Aug 2018 10:24:11 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 10:24:05 PDT (-0700)
Subject:     Re: simplified RISC-V interrupt and clocksource handling v2
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anup@brainfault.org,
        atish.patra@wdc.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-1a7030e5-19c4-481b-9f7c-e0976214eb18@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2018 04:49:57 PDT (-0700), Christoph Hellwig wrote:
> This series tries adds support for interrupt handling and timers
> for the RISC-V architecture.
>
> The basic per-hart interrupt handling implemented by the scause
> and sie CSRs is extremely simple and implemented directly in
> arch/riscv/kernel/irq.c.  In addition there is a irqchip driver
> for the PLIC external interrupt controller, which is called through
> the set_handle_irq API, and a clocksource driver that gets its
> timer interrupt directly from the low-level interrupt handling.
>
> Compared to previous iterations this version does not try to use an
> irqchip driver for the low-level interrupt handling.  This saves
> a couple indirect calls and an additional read of the scause CSR
> in the hot path, makes the code much simpler and last but not least
> avoid the dependency on a device tree for a mandatory architectural
> feature.
>
> A git tree is available here (contains a few more patches before
> the ones in this series)
>
>     git://git.infradead.org/users/hch/riscv.git riscv-irq-simple.2
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple.2
>
> Changes since v1:
>  - rename the plic driver to irq-sifive-plic
>  - switch to a default compatible of sifive,plic0 (still supporting the
>    riscv,plic0 name for compatibility)
>  - add a reference for the SiFive PLIC register layout
>  - fix plic_toggle addressing for large numbers of hwirqs
>  - remove the call to ack_bad_irq
>  - use a raw spinlock for plic_toggle_lock
>  - use the irq_desc cpumask in the plic enable/disable methods
>  - add back OF contexid parsing in the plic driver
>  - don't allow COMPILE_TEST builds of the clocksource driver, as it
>    depends on <asm/sbi.h>
>  - default the clocksource driver to y
>  - clean up naming in the clocksource driver
>  - remove the MINDELTA and MAXDELTA #defines
>  - various DT binding fixes

Ah, thank you so much.  This is great!  With this patch set applied on top of 
rc7 I can boot QEMU master and get to the Fedora root file system.  I'll review 
the patch set properly, but at least for now I think a

Tested-by: Palmer Dabbelt <palmer@sifive.com>

is warranted.  What's the best way to go about merging this?  There's quite a 
bit of arch/riscv diff here so I don't mind taking it through the RISC-V tree, 
but there's also some irqchip and clocksource stuff as well so I'm not sure if 
that's OK to do.
