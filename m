Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D0020838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBKK6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:58:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfBKK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:58:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C153EA78;
        Mon, 11 Feb 2019 02:57:59 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC9B3F557;
        Mon, 11 Feb 2019 02:57:58 -0800 (PST)
Date:   Mon, 11 Feb 2019 10:57:55 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190211105755.GB30880@fuggles.cambridge.arm.com>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 07:34:53PM +0100, AngeloGioacchino Del Regno wrote:
> From 33fb6d036de273bb71ac1c67d7a91b7a5148e659 Mon Sep 17 00:00:00 2001
> From: "Angelo G. Del Regno" <kholk11@gmail.com>
> Date: Sat, 9 Feb 2019 18:56:46 +0100
> Subject: [PATCH] arm64/io: Don't use WZR in writel
> 
> This is a partial revert of commit ee5e41b5f21a
> ("arm64/io: Allow I/O writes to use {W,X}ZR")
> 
> When we try to use the zero register directly on some SoCs,
> their security will make them freeze due to a firmware bug.
> This behavior is seen with the arm-smmu driver freezing on
> TLBI and TLBSYNC on MSM8996, MSM8998, SDM630, SDM660.

Hmm, this sounds very fragile. I hope they're not trapping and emulating
MMIO accesses and treating the zero register as the stack pointer...

Wouldn't this also be triggerable from userspace by mmap()ing either
/dev/mem or e.g. a PCI bar via sysfs?

> Allocating a temporary register to store the zero for the
> write actually solves the issue on these SoCs.

I don't think this catches all MMIO accesses, so I think we need to
understand more about the actual issue here. For example, is it only the
SMMU that causes this problem? Also, any workaround should be specific to
the broken SoCs.

Will
