Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C0820651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9Ty2nEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfAONvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:51:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfAONvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pTszzpsysWlogqpVbwRZ0MRw3aAaKw13X2T4YolhPDg=; b=V9Ty2nEleew/4tK7bK7fr10at
        Nf5t1bbwsY0iL4AOl0qeHGPZYH6UooBo0BsEKwYB5Yb8HYZVRxal+GD/tdnkpV2VKI48u4vyOyN48
        olGiS1ob/4JP+vCA9+AxPn5Gk1AzFYIXhOsg7gRua75yqYrnT935Uuj8XZYFZpQ+Fkmk6M6nrARYL
        0TQuk8t2lNYXqKnhbc7m8mLqMErurCXqmGAyobsKFYk/RDCNeIvcvsRb/YJV7KKG+H3rvzt/+uCGM
        c7FG+g94p3whueVNm1msf4JXUb7D91CnnTBX7ZMOTxIK+jNcOoV5581vdOH1FKzpfvk6c6Cgq4Ajd
        tx+lwrpfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP7l-0000mc-Gl; Tue, 15 Jan 2019 13:51:25 +0000
Date:   Tue, 15 Jan 2019 05:51:25 -0800
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
Subject: Re: [PATCH v2 1/8] RISC-V: Do not wait indefinitely in __cpu_up
Message-ID: <20190115135125.GA28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  void *__cpu_up_stack_pointer[NR_CPUS];
>  void *__cpu_up_task_pointer[NR_CPUS];
> +static DECLARE_COMPLETION(cpu_running);
>  
>  void __init smp_prepare_boot_cpu(void)
>  {
> @@ -81,6 +82,7 @@ void __init setup_smp(void)
>  
>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
> +	int ret = 0;
>  	int hartid = cpuid_to_hartid_map(cpu);
>  	tidle->thread_info.cpu = cpu;
>  
> @@ -96,10 +98,15 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  		  task_stack_page(tidle) + THREAD_SIZE);
>  	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>  
> -	while (!cpu_online(cpu))
> -		cpu_relax();
> +	wait_for_completion_timeout(&cpu_running,
> +					    msecs_to_jiffies(1000));

Having a global completion here worries me.  I bet we have some higher
level serialization, but can we comment or even better lockdep assert on
that?

Also please use up your available lines (72 in commit logs, 80 in source
files) instead of adding spurious line wraps.
