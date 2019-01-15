Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2415220651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jy7Uxcsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfAONw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:52:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfAONw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8sr1r5ObxO7vvfceoW9g3835ZSw6o1wIsUTWV/nsb4M=; b=jy7UxcsqFHMotCMpkUHf2FKYQ
        Glz156T9lFODn8AItUCLVtCW4bLn28jxWTYhOSu5NyJdVWwT74StaVHOvRdZdGWlIj9ghJS37zkq9
        BbdG9B1ecRlRbTdradpbOnHNw5C1U6BFRYJZx6VtO7hnVD/7i/T3QDH/coKeLvtc3YArHoFIVEiqN
        W4ypnCPYwAImX91jbm/l6hnrNo1OvK1Ph7w6lVtBZgVoeoQ5sTmJ8BF2jCzigSksqJFYmbdVxyg+J
        /4TNxC3mXfP1U+TVYr7PRWIrjJNGPBGk56oKE10OtPcAOz6Y6tmVi+zcoeV0HuZwvX6PK7LRtY1O2
        RmF+C5Ttw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP98-0001Eq-F9; Tue, 15 Jan 2019 13:52:50 +0000
Date:   Tue, 15 Jan 2019 05:52:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: Re: [PATCH v2 3/8] RISC-V: Remove NR_CPUs check during hartid search
 from DT
Message-ID: <20190115135250.GC28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-4-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-4-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:38:33AM -0800, Atish Patra wrote:
> In non-smp configuration, hartid can be higher that NR_CPUS.
> riscv_of_processor_hartid should not be compared to hartid to
> NR_CPUS in that case. Moreover, this function checks all the
> DT properties of a hart node. NR_CPUS comparison seems out of
> place.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
