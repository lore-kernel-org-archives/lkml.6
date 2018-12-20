Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8F21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545311095;
	bh=5Qn+mAzOHpgs+INk/STqdFvtxEGYiRhqkMCq+S1J4e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eVw8ZfYEaQl2FyG6/CUuVto8+xEvzlAhFIu36m6XKsWh1HlHgzeTNKhhrXh7eT3Rx
	 drLA77jBnudkdsq8DOgOlSeQrZmM/cUB/M4Nt8bfp2PeZCaWNlnvasCE4qcY9h+Vol
	 O6zjCIHeekYWOu8IzI8zM69iZQMTVwGWGE90L/+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbeLTNEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:04:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:34324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeLTNEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:04:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01377ADF3;
        Thu, 20 Dec 2018 13:04:52 +0000 (UTC)
Date:   Thu, 20 Dec 2018 14:04:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Message-ID: <20181220130450.GB17350@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 10:53:59, Vineet Gupta wrote:
> signal handling core calls ARCH show_regs() with preemption disabled
> which causes __might_sleep functions such as mmput leading to lockdep
> splat.  Workaround by re-enabling preemption temporarily.
> 
> This may not be as bad as it sounds since the preemption disabling
> itself was introduced for a supressing smp_processor_id() warning in x86
> code by commit 3a9f84d354ce ("signals, debug: fix BUG: using
> smp_processor_id() in preemptible code in print_fatal_signal()")

The commit you are referring to here sounds dubious in itself. We do not
want to stick a preempt_disable just to silence a warning. show_regs is
called from preemptible context at several places (e.g. __warn). Maybe
this was not the case in 2009 when the change was introduced but this
seems like a relict from the past. So can we fix the actual problem
rather than build on top of it instead?

Or maybe I am just missing something here.
-- 
Michal Hocko
SUSE Labs
