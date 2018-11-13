Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A27922419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RaCphhxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A27922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeKMLsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:48:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46645 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:48:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id s9-v6so5182535pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2oSmhKmuYz22VsiIbL0Er1kOPvtZ16z8NsPX4MyzuSs=;
        b=RaCphhxUi1tjoWc4FuQQy0WBICkIfi8u0t1PWgfraQwhdaJKJUC42ySd/dE/yrqPBM
         adEjurjXSr62Ns3WVuUUAbO0BxKG6dDNBtqvhjXkKVdrjD9Px9LMNPXZkGLxcEC0mpNT
         zTqC9yBZlJJzUfaq84gTlxBUPQ5rIw7cUQXCcLTd4aogGyY2slA6XZO43KrmylvP6iLp
         qLAlZpNzyL/M1mWSmigeKdyyfOqghMqGSrDyHwMxokvfBeqjZNlpHs8Yfx/icv1X0wF6
         y73evpajyAV6ACbAj6vL3SZ+3g9qPFgGGCMjmkuO0nL1UCBKdIiJ4TbNsHpSsEjyoom/
         Ygnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2oSmhKmuYz22VsiIbL0Er1kOPvtZ16z8NsPX4MyzuSs=;
        b=Vh5LQB4ol0Bf9BoUjRk2RbCze4Yi0yOxIbHLrU1yrfmJx9vzfZfU5U5A0c3rZ8dDpl
         +ZYBLfcWnSnvKBUq24614lpQ6U1dCtk+saOvemXM3RtRpg3Cq+dXFM/ickq+rBH8wxzD
         00QeC5WTuHHuEOIUzcgC5dTdy7VxtfaayZZd9ei+FY7Vh5WXKl74LNC/lSBtHojDjTsT
         UDBLypXLcAgIjee9/hvHdyLKuA20gNNbgJFN+XnrP3oMk9VOgd3p6U9CXop1MBAd/ALr
         ToWoK6LmvXUtQSmJ/MVX/W9JctMakDL/RcKV96xrrL4QfRqgA5wK6ZiMxmWvsZnCtbyk
         m3mg==
X-Gm-Message-State: AGRZ1gJ01iP9wSF9aRCDryHCzZDepL1tygbdgUyw19BYhY084iLlX/hj
        tKmODjk/2CMYGPJWoH+LdP6KEw==
X-Google-Smtp-Source: AJdET5cq80jR0vlCEJExucld2HbSDNcPWHPMfYOIEvCIsPfi4J5EgTzmh+YhHpjeeYMfmtCvqkg7qw==
X-Received: by 2002:a63:f241:: with SMTP id d1mr2999087pgk.2.1542073945852;
        Mon, 12 Nov 2018 17:52:25 -0800 (PST)
Received: from localhost ([216.9.110.13])
        by smtp.gmail.com with ESMTPSA id 80-v6sm20941686pfv.154.2018.11.12.17.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 17:52:25 -0800 (PST)
Date:   Mon, 12 Nov 2018 17:52:25 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 17:46:44 PST (-0800)
Subject:     Re: [PATCH 0/2] riscv: add ARCH_HAS_SG_CHAIN to Kconfig
In-Reply-To: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, green.hu@gmail.com, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-8aec482b-66bf-4190-8d73-e8c06bcac316@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 03:01:05 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> This should improve virtio-gpu support for riscv.
>
> David Abdurachmanov (2):
>   riscv: add ARCH_HAS_SG_CHAIN
>   doc: re-run features-refresh.sh
>
>  Documentation/features/io/sg-chain/arch-support.txt           | 4 ++--
>  .../features/locking/queued-spinlocks/arch-support.txt        | 2 +-
>  Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
>  Documentation/features/vm/pte_special/arch-support.txt        | 2 +-
>  arch/riscv/Kconfig                                            | 1 +
>  5 files changed, 6 insertions(+), 5 deletions(-)

I'm not opposed to this, but I have no idea what it does or why it's in 
arch/*/Kconfig.  I've added the first patch to next-sg_chain, but I'm going to 
re-do the second one as it looks like it batches up a bunch of updates.

Thanks!
