Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B0ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3C21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RP39iibQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A3C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJSP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:57:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59950 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EtKCwHnLysgUzaTI4hoy2nKzepCbWBQgKD7G65lI364=; b=RP39iibQr4OtneTKIVsANQENd
        VWL7zpOJl5R3eIhDFqNu0UqaU4l9CYn72X5sQLUC76h45j+qeJz/ZqK7lvZk6lDaGGyxBRJFvpKu0
        FVknkpMGO/xGloBc8AfQLareLV6Fwa9PtJkndtdYG9r1x7/MDAEKcasF7xLVF3SOIh/nv8dmBxrnC
        oMZhZOdcqJT7ol3WEdeFpOgK8M4MrSCBv7dEYlx+oMAmHWG3yIRI345jN9wEUO9Vws9Sv6m9pMPhG
        CJVhgucEYeJBeoVvszLxO2Z9ooajL4RuQUVZRMDJUknl1xNqXWRPsjngbHH+Jnt/STU5aumQNDBBQ
        0ymxQI1fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDPZh-0002gp-Gt; Fri, 19 Oct 2018 07:52:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB7E02029856B; Fri, 19 Oct 2018 09:51:58 +0200 (CEST)
Date:   Fri, 19 Oct 2018 09:51:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 05/13] x86/smt: Create cpu_smt_enabled static key for
 SMT specific code
Message-ID: <20181019075158.GX3121@hirez.programming.kicks-ass.net>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <ed49c63227dcfa8fd6e53c492e38ce0e22a5b11f.1539798901.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed49c63227dcfa8fd6e53c492e38ce0e22a5b11f.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:59:33AM -0700, Tim Chen wrote:
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3adecda..ad28afc 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -349,6 +349,8 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
>  #ifdef CONFIG_HOTPLUG_SMT
>  enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
>  EXPORT_SYMBOL_GPL(cpu_smt_control);
> +DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
> +EXPORT_SYMBOL_GPL(cpu_smt_enabled);

We already have sched_smt_present; please merge the two. It is pointless
having this twice.
