Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C993C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0CE21748
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ICCp/d9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0CE21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHDKyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:54:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHDKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iJ9KKibEH6YiXFwHzrSthkCT/xhPRTH5nSYTv6ScgsA=; b=ICCp/d9wytkSvJKjsgTY4wYl8
        VBH7OtxM/Cy6s7ws05SvMBQFyxm30PnbT4BTBNj1TJG0oyY4ipSbdrf+lYz3MNmJ52Q33EntKR3lR
        6tFjJi56PGhDET8jz5+lqJDlaU6sbl3plovW58BpVdGs5RZ6/kDbR7TgnhIYc8ABXUYtady8YjtQG
        WRBD0g7OzC8HjaqkeM58fVd9k08FfCd7R1VmEWPIqHfLoWsiHJklFDquEe+3oVrn92TcXXRCigtiU
        AS3x2zEDoGjXjuxL+UF5z1fJank/lYAz0na2hNQyR7ufckHIe2TRQB2cafQ0HU0THF+ZUXT6geeuC
        ibVeT6JOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flsKc-0005vU-Jw; Sat, 04 Aug 2018 08:54:38 +0000
Date:   Sat, 4 Aug 2018 01:54:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, Marcus Comstedt <marcus@mc.pp.se>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180804085438.GA15840@infradead.org>
References: <20180803195344.22271-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803195344.22271-1-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> index 818655b0d535..882a6aa09a33 100644
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ b/arch/riscv/include/uapi/asm/syscalls.h
> @@ -1,10 +1,11 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0

/* */ is the required style for headers, // is only for other files.

> +/* There is explicitly no include guard here because this file is expected to
> + * be included multiple times in order to define the syscall macros via
> + * __SYSCALL. */

Normal Linux comment style would be:

/*
 * There is explicitly no include guard here because this file is expected to
 * be included multiple times in order to define the syscall macros via
 * __SYSCALL.
 */

Also syscalls.h isn't included directly anywhere, but through
<asm/unistd.h>, so we'll probably need a similar comment there as well.
