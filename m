Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E655C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21C12184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E5UwMToC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfA3UOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:14:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3UOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IAxl67UUajweenS+RqqsqKt9ooBaZ0TFo8mDUHMa8SM=; b=E5UwMToCrvwAsoT5YCJOivoCt
        1F8eElxTBRyfGgHpohsq3ue3VBcfsGt2KHE0lJX5CheWRkFRgoKsCJ+5w4HtJv4dPONwDkZw+N6mA
        tDSW2NlMKeXT/5HMcrYUeGFEUNxgwOtnrD6uuD8EJZEgSwskzy8Z+UoqXTu98yTrftFqbwIzkNPyG
        c14NHTPEiCMpRTN+pFBzgNw3XH445szbDQsBikv2qGkLyZ7LyUNMg0nP50dze+x4c31GOfuy2wtwn
        luPYydoX5+BN5Pl7Rszp6eSvDQD6JdLTJtYSdBTG0wfN+6vts727bO8yrmJGjx0aDAS+8L5+4pNot
        CjMcRTfIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gowFF-0007WB-Uo; Wed, 30 Jan 2019 20:14:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52DEB20179289; Wed, 30 Jan 2019 21:14:00 +0100 (CET)
Date:   Wed, 30 Jan 2019 21:14:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] sched/debug: initialize sd_sysctl_cpus if
 !CONFIG_CPUMASK_OFFSTACK
Message-ID: <20190130201400.GH2278@hirez.programming.kicks-ass.net>
References: <20190129151245.5073-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129151245.5073-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:12:45AM -0500, Masayoshi Mizuma wrote:
> From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> 
> register_sched_domain_sysctl() copies the cpu_possible_mask into
> sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
> allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
> CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left uninitialized
> (all zeroes) and the kernel may fail to initialize sched_domain sysctl
> entries for all possible cpus.
> 
> This is visible to the user if the kernel is booted with maxcpus=n, or
> if ACPI tables have been modified to leave cpus offline, and then
> checking for missing /proc/sys/kernel/sched_domain/cpu* entries.
> 
> Fix this by separating the allocataion and initialization, and adding
> a flag to initialize the possible cpu entries while system booting only.
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
> Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
> ---
>  kernel/sched/debug.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index de3de997e245..9c6637f3e21d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -310,6 +310,7 @@ static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
>  
>  static cpumask_var_t		sd_sysctl_cpus;
>  static struct ctl_table_header	*sd_sysctl_header;
> +static int register_sched_domain_sysctl_on_boot = 1;
>  
>  void register_sched_domain_sysctl(void)
>  {
> @@ -344,9 +345,12 @@ void register_sched_domain_sysctl(void)
>  	if (!cpumask_available(sd_sysctl_cpus)) {
>  		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>  			return;
> +	}
>  
> +	if (register_sched_domain_sysctl_on_boot) {
>  		/* init to possible to not have holes in @cpu_entries */
>  		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
> +		register_sched_domain_sysctl_on_boot = 0;
>  	}
>  
>  	for_each_cpu(i, sd_sysctl_cpus) {

I change it like the below. By keeping the initial value 0 it can go
into .bss instead of .data.

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -315,6 +315,7 @@ void register_sched_domain_sysctl(void)
 {
 	static struct ctl_table *cpu_entries;
 	static struct ctl_table **cpu_idx;
+	static bool init_done = false;
 	char buf[32];
 	int i;
 
@@ -344,7 +345,10 @@ void register_sched_domain_sysctl(void)
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
+	}
 
+	if (!init_done) {
+		init_done = true;
 		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
