Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F820C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5716021501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZL2eHd1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5716021501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeHBN0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:26:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbeHBN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kSqoI4KQ+x3q0ZaH4XnaeOTRbStpd3VdlD+moV8a19Y=; b=ZL2eHd1X5G5cyjNYi3b3AnGWb
        yuNW1m50yVSDUY9XHmjoZkCv/zqBo2pklFmUpwFqBbHoKAs6x3AMTjDgKGBjzOD1QnPdwgR00Q55B
        bVtafYs+I+64AUCp8CBy3otM20pVPKQftLLxt1x9r276QN9CFMpTUEsy3qFoJooXh5HJjdO6MGbeO
        YBMULPwOWdSNfwwro4TGmODW0Gcvsety8xcWX8VmsGwICunSGBCWpJNO+fzQttAeW4NKvLFkKaWxH
        jBS8/Tf2N7pIAHRdbMIasH672Uuc065DxNquJq/8nHuSwOOp28joImxTw54MW50WDuLtpxv90EVfT
        0a49XB4pQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flBtb-0005nt-7Z; Thu, 02 Aug 2018 11:35:55 +0000
Date:   Thu, 2 Aug 2018 04:35:55 -0700
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
Subject: Re: [PATCH v3 1/4] Extract FPU context operations from entry.S
Message-ID: <20180802113555.GA17108@infradead.org>
References: <1533188391-5932-1-git-send-email-alankao@andestech.com>
 <1533188391-5932-2-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533188391-5932-2-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
> new file mode 100644
> index 000000000000..3210ef502e55
> --- /dev/null
> +++ b/arch/riscv/kernel/fpu.S
> @@ -0,0 +1,105 @@
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */

It would be good to have SPDX headers fo every new file (and eventually
switch the other RISC-V code over).

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
