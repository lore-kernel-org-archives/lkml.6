Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF637C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F121C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xc3su7Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903F121C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeHIK02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:26:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C0LPNkV29zNVeKpwBYVnF3Exn8RbmaFDT0mSzH/vOIM=; b=Xc3su7UdxbqgNRJ1U8iU57Cy8
        LWWsN7YXVruksbeIvjz5qhV9Sfw3Y190y1LU7WKjGI68Dqo5I+BLDAPVAkPwi5zTGfO1JqjTNfPbo
        m7fTy49S+5thXvvKKzpC/HQXK2kSDzZyDYnn7q1xsa/8j3M7NgEpp/Tt9lvR/HFR3S7uHw4VMuqvf
        JCS2X2UkUCd6gB8X8PevzGSNBi3ZdV73Lgp30k1lgYlSpCuh6ommbxDr6CO6WKYluhuGqMJFv+EhF
        nHfZnDJ8CarCzwhNjkYrZ03BHU/5lnU9t5W/QceN9sx5Dy0sb9oUM2agbwTZd2Orwd+0uYe2g7wRO
        NDcXe3kUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnfuD-000202-2v; Thu, 09 Aug 2018 08:02:49 +0000
Date:   Thu, 9 Aug 2018 01:02:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        vincentc@andestech.com, zong@andestech.com, nickhu@andestech.com
Subject: Re: [PATCH v6 5/5] Auto-detect whether a FPU exists
Message-ID: <20180809080248.GA7600@infradead.org>
References: <1533800680-3653-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533800680-3653-1-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 03:44:40PM +0800, Alan Kao wrote:
> We expect that a kernel with CONFIG_FPU=y can still support no-FPU
> machines. To do so, the kernel should first examine the existence of a
> FPU, then do nothing if a FPU does exist; otherwise, it should
> disable/bypass all FPU-related functions.
> 
> In this patch, a new global variable, has_fpu, is created and determined
> when parsing the hardware capability from device tree during booting.
> This variable is used in those FPU-related functions.
> 
> Signed-off-by: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Zong Li <zong@andestech.com>
> Cc: Nick Hu <nickhu@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
