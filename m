Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B66E20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCHvsXc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B66E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeIJS23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:28:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+I6/VnbkzcALLbtNYS6kdkIx7tfZfA6n3AWorPqSPSg=; b=sCHvsXc6FPErJMWjPUklYs5sw
        SuZbxFlWu/1OUdqrYYvohsT8KwLfgPuKVvbnE4R0kWTH9nYPSVPt25B2eg/tnujQCTmagesdeysNN
        DSQLOD8xaDitmlZkUKRN8hmhEIJc24kyEWIOvOf7qh9EjiKvwM/A7DgwqGTJo0SjFB/9VKC4RQbvG
        2oINfNkUIiAzf81iODVWiG8TZArkBZ35AsGodytOdAr3Cpvo4t3nIE7eaWS7L7xdhZ+hOryghaZfR
        ze2YmgSAgRddUopRY2wRJWVnqI25hpg4APwl5zcEiajgMBpNkmLknh/YYBxM0fjpPnNOvg/ClSqHP
        Laqq3/xvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMKY-000444-S0; Mon, 10 Sep 2018 13:34:18 +0000
Date:   Mon, 10 Sep 2018 06:34:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
Message-ID: <20180910133418.GA12330@infradead.org>
References: <20180904185001.GA25119@infradead.org>
 <mhng-ba039ed5-dcff-41d3-b237-0708b5e117b2@palmer-si-x1c4>
 <CAAhSdy3mOdxR9JpZyC9fCx5rphUBDxn2kbRpgtZp4h0_jYCxMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3mOdxR9JpZyC9fCx5rphUBDxn2kbRpgtZp4h0_jYCxMA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:15:14PM +0530, Anup Patel wrote:
> This patch is doing two things:
> 1. Allow IRQCHIP driver to provide IPI trigger mechanism

And the big questions is why do we want that?  The last thing we
want is for people to "innovate" on how they deliver IPIs.  RISC-V
has defined an SBI interface for it to hide all the details, and
we should not try to handle systems that are not SBI compliant.

Eventuall we might want to revisit the SBI to improve on shortcomings
if there are any, but we should not allow random irqchip drivers to
override this.

> 2. Have more generic IPI handler in arch/riscv so that IRQCHIP driver
> can call it

And that is rather irrelevant without 1) above.
