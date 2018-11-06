Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC26720685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC26720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbeKFXjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:39:23 -0500
Received: from foss.arm.com ([217.140.101.70]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388477AbeKFXjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:39:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E018180D;
        Tue,  6 Nov 2018 06:13:57 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 649B03F5BD;
        Tue,  6 Nov 2018 06:13:55 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:13:49 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Message-ID: <20181106141331.GA28458@e107155-lin>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:58:39PM +0200, Nick Kossifidis wrote:
> Hello All,
> 
> Στις 2018-11-02 01:04, Atish Patra έγραψε:
> > This patch series adds the cpu topology for RISC-V. It contains
> > both the DT binding and actual source code. It has been tested on
> > QEMU & Unleashed board.
> > 
> > The idea is based on cpu-map in ARM with changes related to how
> > we define SMT systems. The reason for adopting a similar approach
> > to ARM as I feel it provides a very clear way of defining the
> > topology compared to parsing cache nodes to figure out which cpus
> > share the same package or core.  I am open to any other idea to
> > implement cpu-topology as well.
> > 
> 
> I was also about to start a discussion about CPU topology on RISC-V
> after the last swtools group meeting. The goal is to provide the
> scheduler with hints on how to distribute tasks more efficiently
> between harts, by populating the scheduling domain topology levels
> (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
> What we want to do is define cpu groups and assign them to
> scheduling domains with the appropriate SD_ flags
> (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
>

OK are we defining a CPU topology binding for Linux scheduler ?
NACK for all the approaches that assumes any knowledge of OS scheduler.

> So the cores that belong to a scheduling domain may share:
> CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
> Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
> Power domain (SD_SHARE_POWERDOMAIN)
> 

Too Linux kernel/scheduler specific to be part of $subject

> In this context I believe using words like "core", "package",
> "socket" etc can be misleading. For example the sample topology you
> use on the documentation says that there are 4 cores that are part
> of a package, however "package" has a different meaning to the
> scheduler. Also we don't say anything in case they share a power
> domain or if they have the same capacity or not. This mapping deals
> only with cache hierarchy or other shared resources.
>

{Un,}fortunately those are terms used by hardware people.

> How about defining a dt scheme to describe the scheduler domain
> topology levels instead ? e.g:
>

NACK as already mentioned above.

--
Regards,
Sudeep
