Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF008ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E70321476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zbjSuSWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeJRDJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:09:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJRDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RimuswRZGR/PCTBPc+HF+IqvFnyxsUATSGOFNHjbXyQ=; b=zbjSuSWfYzPeoMcZQAJJzYtclW
        988fWHIwmbXMrVWDLK7OghPUmCQuB2zXD88BY+huEitdfnwylkjsCT61KnoNcoCCD28WTCyiY7SPQ
        7QZpCQbgQ6DrfthQjGM0jldko2pPRXoKUUeJT1c3LTmggNX9R/GGSW3lzdMsacpsn4+m4qLXw5ZMH
        nXkeoCBGttOfxxKE30O1yvJq10jad0cQDBwQZpk6AvxwAZ2FPmuqaZ0kbi+9XqkiFXwTKMTo2nFCr
        hvy+aiV422+NhMFTwUVB4xKtqsoHk06KIdlTx2STYNYM99hS+UiWD5prOo1dNQ3gjnAfRPLct9CC7
        d3SBnuUg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCrFC-00044F-LO; Wed, 17 Oct 2018 19:12:35 +0000
Subject: Re: [Patch v3 13/13] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <a04ba925a19af6ad5eaad2bc5501b7ea1ece66a9.1539798901.git.tim.c.chen@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cff6ca63-3fce-75a1-8734-048d809d4260@infradead.org>
Date:   Wed, 17 Oct 2018 12:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a04ba925a19af6ad5eaad2bc5501b7ea1ece66a9.1539798901.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 10:59 AM, Tim Chen wrote:
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +-
>  Documentation/userspace-api/spec_ctrl.rst       | 10 +++
>  arch/x86/kernel/cpu/bugs.c                      | 85 ++++++++++++++++++++++++-
>  include/linux/sched.h                           | 11 ++++
>  include/uapi/linux/prctl.h                      |  1 +
>  tools/include/uapi/linux/prctl.h                |  1 +
>  6 files changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2feb6b2..9af11be 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4196,7 +4196,10 @@
>  			lite   - turn on mitigation for non-dumpable
>  				 processes (i.e. protect daemons and other
>  				 privileged processes that tend to be
> -				 non-dumpable).
> +				 non-dumpable), and processes that has indirect

				                                   have

> +				 branch speculation restricted via prctl's
> +				 PR_SET_SPECULATION_CTRL option
> +
>  			strict - protect against attacks for all user processes
>  			auto   - let kernel decide lite or strict mode
>  



-- 
~Randy
