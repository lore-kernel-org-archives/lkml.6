Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvjH2F33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2649921501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeHBN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbeHBN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fmwyOJNr05AyIMw2VvGHlV6UBjJSxyK9cUyLxJCjH+4=; b=bvjH2F33PYTOe6dcoBerlhJTs
        paxwOjmOKfN4ZXtCe0k6SAHJpH7qciuHvyuHS8YrbWMM89Om/PIxwEhFhbBB0+J3UDitYz/8tD80S
        jR3CmoPQY6n8Cp9bmXvZ6AU/ouwXKIszmyLLTCom4VbqU8OfqKpWR0F93gCP+7Gp7QXrwYdvMkd1Z
        6eDeQKydaTe7LeBSr/goGJaYcYK4NpGqyLLDiXf0xyA8PkViuMQjRKLCEZ7hNUR+bOuWeYTyp43wa
        mxzGHj6B7hP/nXP4z/xULy11bOj+RZTu7+AiQxazXq/giekcmceflK/AYuyMIvTf/R89NJ7WW22f7
        1gBduc2xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flBv6-0006or-5L; Thu, 02 Aug 2018 11:37:28 +0000
Date:   Thu, 2 Aug 2018 04:37:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v3 2/4] Refactor FPU codes in signal setup/return
 procedures
Message-ID: <20180802113727.GB17108@infradead.org>
References: <1533188391-5932-1-git-send-email-alankao@andestech.com>
 <1533188391-5932-3-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533188391-5932-3-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/codes/code/ in the subject.  Also a little explanation of why
you refactor it in the patch description would be helpful.

> +static long restore_fp_state(struct pt_regs *regs,
> +	union __riscv_fp_state *sc_fpregs)

Please add another tab for the indentation here even if the original
code got it wrong.

> +static long save_fp_state(struct pt_regs *regs,
> +	union __riscv_fp_state *sc_fpregs)

Same here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
