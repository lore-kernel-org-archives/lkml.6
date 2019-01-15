Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ACC20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+tSouGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfAONxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:53:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfAONxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ruTqpRc093/Tsy/nq1b0SR0HaMvkVpNPwPjDofr1YlQ=; b=I+tSouGmuDRBeWsuObGX17p/K
        Fm6sOHKwAfSIGNxUluIASgULl80gARr+nPncSGLDjO6ROBbpBJDXB1ZoEgP1ACAksuBk1XSIyFRoK
        MzGXDND4diFIB925GWbN2tf09vhqYhRzvC+KJDtho/kN/WiC7OqAeS8knF3d0HiXJUSrQLTpPlEBf
        baQOmMcpu6ZY+jByF7FC//njoXG4wVCqqyRtUQsoFWOUMeQVi8nhz9Zba6UBk3U6N3mP2nkf/Jt3W
        l/Z8ksNUcv0o21XRF0/WK9gzzzE1u3UP0aLamkPJEDhcgCOS5vQYwwRJro1Y2nyyYvzOOXy3RQBTL
        D93B7FqKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP9S-0001VD-AV; Tue, 15 Jan 2019 13:53:10 +0000
Date:   Tue, 15 Jan 2019 05:53:10 -0800
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
Subject: Re: [PATCH v2 4/8] RISC-V: Allow hartid-to-cpuid function to fail.
Message-ID: <20190115135310.GD28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-5-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-5-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:38:34AM -0800, Atish Patra wrote:
> It is perfectly okay to call riscv_hartid_to_cpuid for a
> hartid that is not mapped with an CPU id. It can happen
> if the calling functions retrieves the hartid from DT.
> However, that hartid was never brought online by the firmware
> or kernel for any reasons.
> 
> No need to BUG() in the above case. A negative error return
> is sufficient and the calling function should check for the
> return value always.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks fine (modulo the line length issues):

Reviewed-by: Christoph Hellwig <hch@lst.de>
