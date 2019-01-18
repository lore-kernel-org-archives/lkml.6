Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D815C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D577D20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bqy0cdFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfARHUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:20:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfARHUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M0/OiNC9ecv0z60I4ZUNlIm8L/rcWMOBU38ZVDfxiG8=; b=bqy0cdFYLnVOFhtZAHSGm5Aud
        tQreOmoN3PM83is+L1iyRnihnu/BYH1YhnyNbre21u57ZEUgI4eMwRaTAx1oh14P0U4NqTsKshQbn
        SEYuUtrFJFzduckHcAKEvWwYAJSOB6HvQjI6FuiD/upbzBqzqqG73aRrRTqd2qOzIah0F/AnGfwJT
        +u0Gni9DZL/S8CFAOt8xNo+QOMHNuE7VPv7C1BvYZ8p7GQ0EofOS+D1gCficuZohYUL0s7VyzcRyr
        7jPKcEdD3mzXSQ4Ns6me7WKuqgeTiqxoVR1Os1uQCngiy3lOa1NC5Z7TCu2pXQk6ravkwSmjgDToc
        G6H+pA+/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkOSF-0003Lt-1t; Fri, 18 Jan 2019 07:20:39 +0000
Date:   Thu, 17 Jan 2019 23:20:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Clark <michaeljclark@mac.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: Re: [PATCH v2 1/8] RISC-V: Do not wait indefinitely in __cpu_up
Message-ID: <20190118072038.GA5171@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-2-git-send-email-atish.patra@wdc.com>
 <20190115135125.GA28946@infradead.org>
 <1995e941-a8cf-c12e-71ae-7b50cf6c0ca5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1995e941-a8cf-c12e-71ae-7b50cf6c0ca5@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:35:39PM -0800, Atish Patra wrote:
> On 1/15/19 5:51 AM, Christoph Hellwig wrote:
> > >   void *__cpu_up_stack_pointer[NR_CPUS];
> > >   void *__cpu_up_task_pointer[NR_CPUS];
> > > +static DECLARE_COMPLETION(cpu_running);
> > >   void __init smp_prepare_boot_cpu(void)
> > >   {
> > > @@ -81,6 +82,7 @@ void __init setup_smp(void)
> > >   int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > >   {
> > > +	int ret = 0;
> > >   	int hartid = cpuid_to_hartid_map(cpu);
> > >   	tidle->thread_info.cpu = cpu;
> > > @@ -96,10 +98,15 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > >   		  task_stack_page(tidle) + THREAD_SIZE);
> > >   	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > > -	while (!cpu_online(cpu))
> > > -		cpu_relax();
> > > +	wait_for_completion_timeout(&cpu_running,
> > > +					    msecs_to_jiffies(1000));
> > 
> > Having a global completion here worries me.  I bet we have some higher
> > level serialization, but can we comment or even better lockdep assert on
> > that?
> > 
> 
> Yes. It is serialized from smp.c in smp_init(). It brings one cpu online
> at a time for preset_cpu mask.
> 
> Do we still need a lockdep assert ?

I guess the real lock is through cpu_hotplug_lock.  And yes, a comment
or even better lockdep assert would be good.
