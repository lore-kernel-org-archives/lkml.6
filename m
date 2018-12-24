Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D2C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552A12184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545678609;
	bh=F8JFcK2QV4V+oSdNZDjpYyWjneXMsl6lXpvlcolmU34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QCVGNiMIIOgxgRBjirANF1EGZTSXE5ija9d3qaJ9g1MfYcPEQ4RI2UkUD4uhu649S
	 k2bG+tz8bKJXMckSxuGZthsGI3QgJ0MalZ7IqZ7uFEn1+O2tSPPjNw7kz8b+x52VT7
	 ubJi8YHo0XldzE7RX8UGEkxRyTtoTrExLlxMMY/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLXTKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:10:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeLXTKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:10:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29CE9ACB1;
        Mon, 24 Dec 2018 19:10:06 +0000 (UTC)
Date:   Mon, 24 Dec 2018 20:10:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Message-ID: <20181224191004.GE16738@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
 <20181221130404.GF16107@dhcp22.suse.cz>
 <8b3739f1-a7d5-7253-362a-3a1c707b0f6d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3739f1-a7d5-7253-362a-3a1c707b0f6d@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-12-18 09:55:34, Vineet Gupta wrote:
> On 12/21/18 5:04 AM, Michal Hocko wrote:
[...]
> > Yes, the fix might be more involved but I would much rather prefer a
> > correct code which builds on solid assumptions.
> 
> Right so the first step is reverting the disabled semantics for ARC and do some
> heavy testing to make sure any fallouts are addressed etc. And if that works, then
> propagate this change to core itself. Low risk strategy IMO - agree ?

Yeah, I would simply remove the preempt_disable and see what falls out.
smp_processor_id could be converted to the raw version etc...
-- 
Michal Hocko
SUSE Labs
