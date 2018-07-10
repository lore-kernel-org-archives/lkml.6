Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E248E2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E248E2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeGJOs2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:48:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933374AbeGJOs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:48:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D10980D;
        Tue, 10 Jul 2018 07:48:26 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DB873F589;
        Tue, 10 Jul 2018 07:48:26 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id EAE9D1AE53F3; Tue, 10 Jul 2018 15:49:07 +0100 (BST)
Date:   Tue, 10 Jul 2018 15:49:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        peter maydell <peter.maydell@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Support rseq on arm64
Message-ID: <20180710144907.GD9022@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
 <20180709165307.GB4689@arm.com>
 <1187011512.2158.1531156674389.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1187011512.2158.1531156674389.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:17:54PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 9, 2018, at 12:53 PM, Will Deacon will.deacon@arm.com wrote:
> 
> > On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon@arm.com wrote:
> >> 
> >> > Hello,
> >> > 
> >> > This is version two of the patches previously posted here:
> >> > 
> >> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon@arm.com
> >> > 
> >> > Changes since v1 include:
> >> > 
> >> >  * Move abort handler in-line to avoid possibility of it being
> >> >    out-of-range for conditional branch instructions
> >> > 
> >> > I've tested both native and compat (little-endian only) with the selftests
> >> > and they pass successfully on my Seattle box.
> >> 
> >> For the whole series:
> >> 
> >> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
> > 4.19 once I have an Ack for the asm-generic change, or would you rather
> > this went via somewhere else?
> 
> Adding Thomas Gleixner in CC. He has been picking up the rseq bits for
> 4.18. I've noticed it was rather easier to gather rseq stuff through a
> single tree (less chances of confusion).

Whilst I can see that making some sense for the selftests (particularly
if the ABI is liable to further changes before 4.18 is released), I'd
prefer to take the arm64 bits via the arm64 tree, as they will conflict
with some ongoing work to rewrite the syscall entry path in C which I
plan to queue in the next week (pending final testing results).

> Also, support for additional architectures (e.g. MIPS) was added to rseq
> after rc1. Is it too late to merge arm64 support targeting 4.18 ?

Personally, I don't see the rush, but I won't stop anybody who wants to
try steam-rollering them into mainline ;)

Will
