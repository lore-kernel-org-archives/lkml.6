Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4420D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4420D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeG3Sdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:33:50 -0400
Received: from foss.arm.com ([217.140.101.70]:42694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeG3Sdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:33:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A6907A9;
        Mon, 30 Jul 2018 09:57:56 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B7903F5D0;
        Mon, 30 Jul 2018 09:57:56 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F0B261AE2F47; Mon, 30 Jul 2018 17:57:57 +0100 (BST)
Date:   Mon, 30 Jul 2018 17:57:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
Message-ID: <20180730165757.GF4276@arm.com>
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
 <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:46:24AM -0500, Dave Kleikamp wrote:
> On 07/30/2018 11:22 AM, Will Deacon wrote:
> > On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
> >> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
> >>> machine_kexec flushes the reboot_code_buffer from the icache
> >>> after stopping the other cpus.
> >>>
> >>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> >>> for kernel mappings") added an IPI call to flush_icache_range, which
> >>> causes a hang here, so replace the call with __flush_icache_range
> >>
> >> While machine_kexec() may be called with interrupts disabled (IIUC) and
> >> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
> >> there any other CPUs online at this point?
> > 
> > The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
> > this should only happen if we're kexec'ing a crash kernel and
> > smp_crash_stop_failed(). Is that something we need to care about?
> 
> I observed the hang trying to kexec a crash kernel and I did not see the
> warning that smp_crash_stop_failed(). I'm not exactly sure why
> flush_icache_range() hung (but it did), but I think that
> __flush_icache_range() makes more sense here anyway.

Yeah, I'll pick the patch up, but it would be nice to understand the
failure case you observed.

Will
