Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A8520866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IEyMbohQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfAON76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:59:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfAON75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PwkK6AUSqmWoNIPmqYC6uFQmS8ohsWtS5pFShA+pxxA=; b=IEyMbohQ4uif8z41f3BEVeFxT
        WWf0luBc4odSn8OW4WztFxqTkasdxd+Yc+c6Z/LP18v1M5BblwBklpb5UA+6OzvPrsf1ZMC9khiVl
        TtM3JLKEzv0XGKtsH98wQWiMdnn262fybtRmkRL/vXExVdwx1BAqFyMxy9WKAHwwe1u6cMV1JYoKP
        JYumTaP7X3SBJ/wZPrEXI98y7E9LgYnPQVSHTbmNxpE/Qrj7r0IGWxJDLxoVBqhOSvbMgyGRo8Kkq
        P1bUh1BRA0csqQc3Amgwlj8Dl+245qI/r2EMl7BVvCGJR1omsENjIozn4S7bPUMfNti3t9VUGCy+s
        UlYwW3QEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjPFz-0006w0-1w; Tue, 15 Jan 2019 13:59:55 +0000
Date:   Tue, 15 Jan 2019 05:59:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL
 early console
Message-ID: <20190115135954.GM28946@infradead.org>
References: <20181204135507.3706-1-anup@brainfault.org>
 <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de>
 <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
 <mvm7efcedop.fsf@suse.de>
 <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
 <mvmsgy0cu9g.fsf_-_@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmsgy0cu9g.fsf_-_@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:11:39PM +0100, Andreas Schwab wrote:
> This enables proper NLCR processing.
> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
