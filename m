Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0320868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtbUtqKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfAON4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:56:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfAON4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MmEkTyogFwMsFqIrIZRoHcVG3q447p5uSVNXo6qK7Bc=; b=BtbUtqKpema7IuYlQpEvb39IH
        aBXKj3BvIvlBezKIjQ0PAluoHqtr7ZbfRy8L+GNThIqH+Arg67NKRrYsTuBkgG5xuHQx/wzFVDCoa
        oQcfdCpZlwihzC5n5faOB0d9i5fw18gbIARADRRvwZV7DMJEH1EXPhIM8mkY/F7ic7GeRNbp1L1b5
        mgyPP48sUcgjCLyPFztG3bcWNF25fspxmkgfPvX7O2txjsu6la3pYb0AVAPwjfKro4A14SVdu/zYY
        pvoutuR8lL/wN1vh/k0Pl2XutwfAkyzZ3PvPfv8wickfpjodXmjqH0tkwZUI3HU3SE/YxdW2mle2u
        vcwTCwx+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjPCp-00040y-Pk; Tue, 15 Jan 2019 13:56:39 +0000
Date:   Tue, 15 Jan 2019 05:56:39 -0800
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
Subject: Re: [PATCH v2 8/8] RISC-V: Assign hwcap only according to current
 cpu.
Message-ID: <20190115135639.GH28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:38:38AM -0800, Atish Patra wrote:
> Currently, we set hwcap based on first valid cpu from
> DT. This may not be correct always as that CPU might not
> be current booting cpu.
> 
> Set hwcap based on the current cpu instead of first
> valid CPU from DT.

This is generally the right thing to do.  But can the kernel even cope
with different hwcaps per hart?  I know arm land and I think x86 as well
don't, so we might want to add a sanity check that they match or reduce
them to the common subset.
