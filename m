Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A79C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74E820661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74E820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeLCRMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:12:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLCRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:12:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3780F1682;
        Mon,  3 Dec 2018 09:12:30 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8738F3F59C;
        Mon,  3 Dec 2018 09:12:26 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:12:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will.deacon@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20181203171223.GD17883@e107155-lin>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203165833.GA27796@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203165833.GA27796@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Fixed Juri Lelli's email)

On Mon, Dec 03, 2018 at 04:58:34PM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
> > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > their cpu topology. It's better to move the relevant code to
> > a common place instead of duplicate code.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/arm64/include/asm/topology.h |  22 ---
> >  arch/arm64/kernel/topology.c      | 303 +-------------------------------------
> >  drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
>
> Whilst I'm happy seeing this code moved out, I'd like to have an entry in
> MAINTAINERS so that somebody can review changes from the arm64 side without
> having to poll a load of different lists. I assume patches would still go
> via Rafael and Greg, but if we could have Sudeep added as Reviewer for this
> file, then I'd really appreciate it.
>

Thanks Will for pointing this. I agree with you and like to be added as
reviewer for this.

Since arch_topology.c was mostly added for ARM/ARM64 and by Juri Lelli 
(who is no longer with ARM) and I did review the initial version, I would
like to assume maintenance for this file if both Juri and Greg are OK
with it so that I can keep an eye on this as we expect more changes to
this both for ARM and RISC-V. I am fine if anyone who has contributed
more to this file wants to maintain.

--
Regards,
Sudeep
