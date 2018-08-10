Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F415C223E9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uy3n6/dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F415C223E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHJLHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:07:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=59vYGSqp53vULqZo4X7OD4dNafeZjhMgMpBbLOFpE9E=; b=Uy3n6/dpNiirwlWKEm//pIyqH
        1LSWPvPqPmJj4x1/q2gdvuJAvknvd5NMmkWuYCK4GY+xhsHsT80Azs0ERsM3KM8KEdz7W0ONTQLvB
        POGkzSf7tMwzgdLUw/ZRQFxNNi+Xp2PTNZrOcN3EquD7FIzEI2M4wRR51lBoyS95oJncj70P4ed5h
        Lp8J1hzOs0iHaZslA16EGftn48TIsTiIEDyiTzvu5HvbwmguZyFGcIhVXt7ni0kMdjcl2gnk44jd2
        ktCJxu+2cUQI2rztxSV0j+awkbPqYNkcjbanx/cmQMsJsFTaCwHrxvmoDRyryYxbKmDrNZxmVdlNv
        0+Wx+JGMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fo2vs-0001En-VP; Fri, 10 Aug 2018 08:38:04 +0000
Date:   Fri, 10 Aug 2018 01:38:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org, dan.carpenter@oracle.com
Subject: Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180810083804.GA20415@infradead.org>
References: <20180809221952.24260-1-palmer@sifive.com>
 <20180809221952.24260-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221952.24260-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 03:19:51PM -0700, Palmer Dabbelt wrote:
> This would be necessary to make non-SMP builds work, but there is
> another error in the implementation of our syscall linkage that actually
> just causes sys_riscv_flush_icache to never build.  I've build tested
> this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
> normal.

Would't it make sense to use COND_SYSCALL to stub out the syscall
for !SMP builds?
