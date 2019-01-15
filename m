Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B84D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phEn8ijR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfAONys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:54:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfAONys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aRkE2XKwgx+US2i4/SZJa75bs+mE6Hzq8tUIKF//QYk=; b=phEn8ijRTNMnfjlmvXOcMJnGP
        QGmTDrdPTGw9nStwVNHwtOapmcffeIceTzT4cu37bSSIMbRUtMb8272ugiOdUrGdVLAeVSRBQtZhQ
        jcggw1rBrmztug3De3ePlRFK/edJjRLv+kO5RLq1brDwMNE2dL6P8c6+syJw6K7sumQR4BWoXdTN/
        5l7GY6QDhX6C3s7MJmjTqHUu6TrxDMOkCwZFhxqHlUKOHDdvFR43qyopWnFWwfrzUc9l296d/zV/H
        crEvJW4ioOIhVfg07Jlb7bNzLDcQmyRZ1TNZyaVGhfyrebSDQVtTurgGjqaz4M8EOMh3KhzbnFbkH
        ho7zLGYAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjPAv-0001yp-D7; Tue, 15 Jan 2019 13:54:41 +0000
Date:   Tue, 15 Jan 2019 05:54:41 -0800
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
Subject: Re: [PATCH v2 6/8] RISC-V: Add required checks during clock source
 init
Message-ID: <20190115135441.GF28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-7-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-7-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	hartid = riscv_of_processor_hartid(n);
> +	if (hartid < 0) {
> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +			n, hartid);
> +		return hartid;
> +	}
>  	cpuid = riscv_hartid_to_cpuid(hartid);
>  
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +		return cpuid;
> +	}
> +

No need for the empty line after the riscv_hartid_to_cpuid call.

> -	clocksource_register_hz(cs, riscv_timebase);
> +	error = clocksource_register_hz(cs, riscv_timebase);
>  
> +	if (error) {

Same here.
