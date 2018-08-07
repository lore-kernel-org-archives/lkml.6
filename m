Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DDAC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C16921775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C16921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbeHGMSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:18:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeHGMSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:18:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57FF80D;
        Tue,  7 Aug 2018 03:05:13 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78513F2EA;
        Tue,  7 Aug 2018 03:05:12 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:05:02 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Trap WFI executed in userspace
Message-ID: <20180807100437.GA9097@e103592.cambridge.arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807093326.5090-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
> It recently came to light that userspace can execute WFI, and that
> the arm64 kernel doesn trap this event. This sounds rather benign,
> but the kernel should decide when it wants to wait for an interrupt,
> and not userspace.
> 
> Let's trap WFI and treat it as a way to yield the CPU to another
> process.

This doesn't amount to a justification.

If the power controller is unexpectedly left in a bad state so that
WFI will do something nasty to a cpu that may enter userspace, then we
probably have bigger problems.

So, maybe it really is pretty harmless to let userspace execute this.

I can't think of a legitimate reason for userspace to execute WFI
however.  Userspace doesn't have interrupts under Linux, so it makes
no sense to wait for one.

Have we seen anybody using WFI in userspace?  It may be cleaner to
map this to SIGILL rather than be permissive and regret it later.

[...]

Cheers
---Dave
