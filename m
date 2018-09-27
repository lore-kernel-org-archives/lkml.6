Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6BCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F6321533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F6321533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeI0UIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:08:43 -0400
Received: from foss.arm.com ([217.140.101.70]:34882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeI0UIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:08:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440887A9;
        Thu, 27 Sep 2018 06:50:22 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.emea.arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2080C3F5BD;
        Thu, 27 Sep 2018 06:50:20 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:50:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
Message-ID: <20180927135017.GC44459@arrakis.emea.arm.com>
References: <871s9j462u.fsf@xmission.com>
 <20180926173841.GD175719@arrakis.emea.arm.com>
 <87ftxvs2i0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftxvs2i0.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:39:35AM +0200, Eric W. Biederman wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Mon, Sep 24, 2018 at 11:07:05AM +0200, Eric W. Biederman wrote:
> >> After these patches have had a chance to be reviewed I plan to merge
> >> them by my siginfo tree.  If you would rather take them in the arm64
> >> tree let me know.   All of the prerequisites should have been merged
> >> through Linus's tree several releases ago.
> >
> > Either way works for me. There is a trivial conflict in
> > force_signal_inject() with the arm64 for-next/core tree so I could as
> > well put them on top of this branch and send them during the 4.20
> > merging window.
> 
> As long as there is a trivial conflict I would like to keep everything
> in one tree.
> 
> There is a following patchset that manages to reduce the size of struct
> siginfo in the kernel that I have also posted for review.    With
> everything in one tree I can make that change now, and just cross it off
> my list of things to worry about.

Fine by me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

The conflict will appear in -next but the resolution is simple:

diff --cc arch/arm64/kernel/traps.c
index 21689c6a985f,856b32aa03d8..adb0a32c1568
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@@ -353,12 -366,6 +368,9 @@@ void force_signal_inject(int signal, in
  	const char *desc;
  	struct pt_regs *regs = current_pt_regs();
  
 +	if (WARN_ON(!user_mode(regs)))
 +		return;
 +
- 	clear_siginfo(&info);
- 
  	switch (signal) {
  	case SIGILL:
  		desc = "undefined instruction";

-- 
Catalin
