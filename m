Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1BB20870
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1BB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeICNKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:10:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbeICNKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:10:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEBD9ADE0;
        Mon,  3 Sep 2018 08:51:24 +0000 (UTC)
Date:   Mon, 3 Sep 2018 10:51:22 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/speculation: Enable cross-hyperthread spectre v2
 STIBP mitigation
In-Reply-To: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1809031047560.25787@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> STIBP is a feature provided by certain Intel ucodes / CPUs. This feature 
> (once enabled) prevents cross-hyperthread control of decisions made by 
> indirect branch predictors.
> 
> Enable this feature if
> 
> - the CPU is vulnerable to spectre v2
> - the CPU supports SMT
> - spectre_v2 mitigation autoselection is enabled (default)
> 
> After some previous discussion, this patch leaves STIBP on all the time, 
> as wrmsr on crossing kernel boundary is a no-no. This could perhaps later 
> be a bit more optimized (like disabling it in NOHZ, experiment with 
> disabling it in idle, etc) if needed.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> Let's add the most basic STIBP support, as it has been kind of lost in all 
> the previous noise.

After some discussions with Peter, this actually makes a little sense with 
the IBPB implementation we currently have upstream, as that's basically 
never used (I thought upstream had the same what distros had -- IBPB 
issued in cases where tasks can't ptrace each other, but that apparently 
got ditched in the process for some reason).

If the argument was that this is too expensive performance-wise, well, 
then there is nospectre_v2 for those who are fine with that.

Given the fact that the attack is real, I think we should default to 
STIBP+IBPB in the non-ptrace-capable case. Some distros (SUSE for example) 
do issue the IBPB in such a way.

I'll submit v2 with that later today.

-- 
Jiri Kosina
SUSE Labs

