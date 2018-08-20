Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544C72174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ntqzUw+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544C72174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHUBk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:40:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44724 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:40:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id ba4-v6so7784752plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zmdehfLIL6FBOxM84ul/2UsCLpTP9eAPq9bQfBkObjw=;
        b=ntqzUw+tYW6l7GBXWV2Axs9aTzSJb+efmTXyJK2G9YwcGIs/vgm6Px9XvLLd58RQ57
         Jj/RKqMEp5VEPf0MMIBrR+JMIeXdbm0M4/hZr3HSbeFXsIgpZzQo0VpuFjDJemtqRtHS
         7jf0NTYypwi1ZOPzekvjKN9hDy3CFLAwX9GE6W3M8VHzDt9W4urWjlWUoVqhUTZ8Qlcr
         wbelBeMFun4nswYrtduPW35kccq9T+tKEGF0mwrPaY+6gPTbLcxnDJFlT4iKvd38IJTJ
         EnC81Z+8LwALZEfszRRRtnw7aGwDTxDSkiYxD3Fqw6yII0oJWt4e1YXvSz4Ba2WZxpLJ
         8eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zmdehfLIL6FBOxM84ul/2UsCLpTP9eAPq9bQfBkObjw=;
        b=rfQ3BArvKCP9QpZBUXTS7X0nW9oXGBajUl4cxrdHsgi7IVKzV0opK9d91U/cw9ZcYu
         vetwTQhjY5MEty1sE8sAsrlBVu8xbEH+L+2b41oFs5Y+xME+2wiCuReVHZyMDGmSNyij
         nlQh26aXLSBY3SHjXgYU2tgWvr9t+RRN45jyy5TQ/aAB1f/fGcHZnzx4fdVzSbJ29Wcq
         AEmR/HiHEFdJglTjwon00m7wyT88JNASPe34Q88uZ26/YkvwLsfZ6btVBpIhncQZmDPi
         gG65D8OZbFjR/mVM6mLW2heBgZuBEOC8tg0FcQamw7rWmvuPuTj08AE8+OuxgJ5cPPBM
         2elw==
X-Gm-Message-State: AOUpUlEM+NovASCBMLccDXWGs+drs/ZQ84zUylF46FbF0jlVwXbuVTjt
        35nr/927XB6sHelFwT6soid00QIlFM0=
X-Google-Smtp-Source: AA+uWPycSuppCpbjee65+clr+egtjK1NYRRvSNjmSkrOuMZ7zaGtjyiUpuXrQUMgz2Wq8kVwunh7eg==
X-Received: by 2002:a17:902:760b:: with SMTP id k11-v6mr11374103pll.185.1534803778863;
        Mon, 20 Aug 2018 15:22:58 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l3-v6sm13221728pff.8.2018.08.20.15.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 15:22:57 -0700 (PDT)
Date:   Mon, 20 Aug 2018 15:22:57 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Aug 2018 15:16:46 PDT (-0700)
Subject:     Re: [PATCH v4 0/5] riscv: Add support to no-FPU systems
In-Reply-To: <1533698685-18022-1-git-send-email-alankao@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        albert@sifive.com, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, alankao@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-5f2b9f66-c5c6-428f-8440-db3bab15a183@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 20:24:40 PDT (-0700), alankao@andestech.com wrote:
> This patchset adds an option, CONFIG_FPU, to enable/disable floating-
> point procedures.
>
> Kernel's new behavior will be as follows:
>
> * with CONFIG_FPU=y
>   All FPU codes are reserved.  If no FPU is found during booting, a
>   global flag will be set, and those functions will be bypassed with
>   condition check to that flag.
>
> * with CONFIG_FPU=n
>   No floating-point instructions in kernel and all related settings
>   are excluded.
>
> Changes in v4:
>  - Append a new patch to detect existence of FPU and followups.
>  - Add SPDX header to newly created fpu.S.
>  - Fix a build error, sorry for that.
>  - Fix wording, style, etc.
>
> Changes in v3:
>  - Refactor the whole patch into independent ones.
>
> Changes in v2:
>  - Various code cleanups and style fixes.
>
> Alan Kao (5):
>   Extract FPU context operations from entry.S
>   Refactor FPU code in signal setup/return procedures
>   Cleanup ISA string setting
>   Allow to disable FPU support
>   Auto-detect whether a FPU exists
>
>  arch/riscv/Kconfig                 |   9 +++
>  arch/riscv/Makefile                |  19 +++---
>  arch/riscv/include/asm/hwcap.h     |   3 +
>  arch/riscv/include/asm/switch_to.h |  21 ++++++
>  arch/riscv/kernel/Makefile         |   1 +
>  arch/riscv/kernel/cpufeature.c     |  11 +++
>  arch/riscv/kernel/entry.S          |  87 -----------------------
>  arch/riscv/kernel/fpu.S            | 106 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/process.c        |   4 +-
>  arch/riscv/kernel/signal.c         |  79 +++++++++++++--------
>  10 files changed, 214 insertions(+), 126 deletions(-)
>  create mode 100644 arch/riscv/kernel/fpu.S

Aside from the CFLAGS issue this looks good.  I've queued this up in 
kernel.org/palmer/linux.git/next-nofpu, but I'm not going to put this on 
for-next until after the merge window closes.

Thanks!
