Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB53ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1D120856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLUAPNuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1D120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeJ0QgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:36:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeJ0QgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2Ui2SWN6W0PFZ3iYhvFkFtR/Jm6345qBXBUwoIBs3U=; b=lLUAPNuLWEfi5ZkWqm9WgIgxd
        dxt5T25Ts9xPldIIk54G6SGi5bNUhzVPz8WoSnVd9T9+I56i+Y2THijsAjV4utnhcxo7b2FzmIZEI
        bqTR1Ig15yEz27uAySQ0FXq7IvktMifvm7itGIUbBLSBRCdnbt7LEPSDW0kKptZbeTsmg/vOSIPvB
        zdWmhcDkU8CrDTuxA5U6VXjqxkA2KeFJyZK2FT0bQlOlXe9OlsuK5EUyONGEltSDWDCrKcza7Wf8u
        jdIjo0+AovYOUHQeK6qvtIsiYBAaYbmV+HL+UjaWkPyVlaP36xhy7NnPW46YULPJO+ixE42itO//m
        8bI1pScMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGJRw-0006Yp-5k; Sat, 27 Oct 2018 07:56:00 +0000
Date:   Sat, 27 Oct 2018 00:55:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, david.abdurachmanov@gmail.com
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
Message-ID: <20181027075559.GB7868@infradead.org>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com>
 <20181024204036.8799-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024204036.8799-3-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know much about seccomp, so just a few general nitpicks:

On Wed, Oct 24, 2018 at 01:40:36PM -0700, Palmer Dabbelt wrote:
> +	bool "Enable seccomp to safely compute untrusted bytecode"
> +
> +	help

The empty line above is odd, please drop it.

> +++ b/arch/riscv/include/asm/seccomp.h
> @@ -0,0 +1,10 @@
> +/* Copyright 2018 SiFive, Inc. */
> +/* SPDX-License-Identifier: GPL-2.0 */

The SPDX tag should go into the first line.

> +#ifndef _ASM_RISCV_SECCOMP_H
> +#define _ASM_RISCV_SECCOMP_H
> +
> +#include <asm/unistd.h>
> +
> +#include <asm-generic/seccomp.h>

And while at it I'd drop this empty line as well.
