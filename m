Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA319C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D52075E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTpz1vcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9D52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeGEWVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:21:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbeGEWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0kV13GbU4m6TYxxmb46nPUPXlHBk/4DDiQe2I3rtoJY=; b=TTpz1vcU+06MjWljqZw4z0H2M
        WqM4wbvoX+CBHVb15QuGOA0ArD0pCBO73PYNk+H11X8s9O/dn2lyPv5uQeue+sruDcSIJPAKEbfM4
        lMGK937sCoHFSVhfxzPPAoibFJU2X+76piQ4YfqhCY7NzD3CNgV1dW3xHWe92xBAxwcmEobszeyfx
        kPcVBS+0GPD8XD7x4Abn9gj3BljCTis7mhmjkhWwmexGCD6H4FaM8bA/rT2OY2cybD6zWanY8HtMq
        wQbHjaTgCTl5j2M7W6khuxVERTZhFrqaHEUNGyPdpcBJTo5a7ogbyGkoA0e/WXHJmp2l0KDGGsSjD
        ulfTUWEdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbCcg-0006TI-Fk; Thu, 05 Jul 2018 22:21:10 +0000
Date:   Thu, 5 Jul 2018 15:21:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, arnd@arndb.de
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
Message-ID: <20180705222110.GA5698@infradead.org>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705213604.18883-4-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
> defconfig, allmodconfig and nomodconfig.
> And hence does not inlude definitions for compat data types.
> 
> Now that time syscalls are being reused in non CONFIG_COMPAT
> modes, include asm-generic definitions for riscv.
> 
> Alternative would be to make compat_time.h to be conditional on
> CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
> asm/compat.h include the generic version instead.

Two comments here:

First I think the current riscv compat.h is completely bogus.
As you mentioned riscv does not actually have a compat mode, so
having a compat.h makes no sensse at all, and the COMPAT_UTS_MACHINE
override which is the only thing implemented is included in that
statement.

Second I think abusing compat.h for old syscall compatibility of any
form is a really bad idea.  I think you need to split that part out,
and preferably not using compat in the name, but something like
old-time.h or time32.h for the name.
