Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1772C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754742077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjEoiTl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754742077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeICSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:55:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BQIG9jg+0RGduvfnHsYCganMS1PaKygXizdkr7t1Bz4=; b=rjEoiTl9Y2ZQ5BW7lawcv2j7Y
        i72PjIbFuXj6c9qtmK3rb4UNxWBWmNtNopljXW8ebK2CIAEItvaw20+ZAyzRGHtYeInIOWv1SILFt
        RdGafc63AlesUi545Jm3nvXf26ToGCywPNV87Dvon/HRLHMRLUt+wNSEElDbJ8ymdi2sSq9dTUz1F
        vhf1LbcAzPhFoidYdIJ5vol4SuDhEDOP0rO9plIRlEiGQ8XkUlkWteJZZQK7wyK20ZYZmWHTAAp2Z
        a83Q1vr4tVxc9xA+n/7xWi8rx5GJUHp+IT4YEIXWZQiCcYLsMkfreWGYHhRPvwnfbcu6AdT6yjvPb
        z3twCrh1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwpwE-0008Ut-Iz; Mon, 03 Sep 2018 14:34:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEB5B2018FA22; Mon,  3 Sep 2018 16:34:44 +0200 (CEST)
Date:   Mon, 3 Sep 2018 16:34:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
Message-ID: <20180903143444.GW24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809031444160.25787@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809031444160.25787@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 02:45:31PM +0200, Jiri Kosina wrote:

> +static bool __init stibp_needed(void)
> +{
> +	return (cpu_smt_control != CPU_SMT_NOT_SUPPORTED &&
> +			boot_cpu_has(X86_FEATURE_STIBP));
> +}

Should that not be:

	((cpu_smt_control != CPU_SMT_NOT_SUPPORTED) ||
	 (cpu_smt_control != CPU_SMT_FORCE_DISABLED)) &&
	boot_cpu_has(X86_FEATURE_STIBP);

instead?
