Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8447721924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ji3HtwzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBHJBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:01:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KpEKUy48nSJcr5EcluPqFub2tdd+NlNIyUYObg1lLKw=; b=ji3HtwzTD+WVYV6KRvMHxJd+0
        hHqAybfLs8AiDVgNWh3w/6Pyj5+zhO1WDABoveczGoDNeGwsgk1eRFdjMyWH8oRBz9udbSSg7QqqW
        13jF9RCwf6s9lv97eylkYHet/3cLcEDcl8mqW+fU7ZOroIPgNdCwUOKIAmHDWvWcqQqJgB/Zu+PZb
        b014XZmYBFoXHfbTjeG3Yj5O4sePNwLqShyzi+KNhZiNvP36ujcRhsQulXZQzdc893TIsY4J+Lk8B
        hXc16p/1sO95cpJyRnbP8eV4CpA0VFXeiJZdUfHqTOgIQx+LlIQmxUMnF25lxzLELcGfa9ptHK4XE
        5vz3IMlBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs22V-0004RE-EQ; Fri, 08 Feb 2019 09:01:39 +0000
Date:   Fri, 8 Feb 2019 01:01:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Zong Li <zongbox@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 1/8] RISC-V: Do not wait indefinitely in __cpu_up
Message-ID: <20190208090139.GA16932@infradead.org>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549590681-24125-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:51:14PM -0800, Atish Patra wrote:
> In SMP path, __cpu_up waits for other CPU to come online
> indefinitely. This is wrong as other CPU might be disabled
> in machine mode and possible CPU is set to the cpus present
> in DT.
> 
> Introduce a completion variable and waits only for a second.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
