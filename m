Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CCF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CCF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966725AbeFSPfo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:35:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52582 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966516AbeFSPfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:35:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA78F1596;
        Tue, 19 Jun 2018 08:35:42 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E43C3F557;
        Tue, 19 Jun 2018 08:35:42 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <tnowicki@caviumnetworks.com>, <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-mm@kvack.org>, <wanghuiqiang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
References: <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
        <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
        <20180611145330.GO13364@dhcp22.suse.cz>
        <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
        <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
        <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
        <20180619120714.GE13685@dhcp22.suse.cz>
        <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
        <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
        <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
        <20180619151425.GH13685@dhcp22.suse.cz>
Date:   Tue, 19 Jun 2018 16:35:40 +0100
In-Reply-To: <20180619151425.GH13685@dhcp22.suse.cz> (Michal Hocko's message
        of "Tue, 19 Jun 2018 17:14:25 +0200")
Message-ID: <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
> [...]
>> In terms of $SUBJECT, I wonder if it's worth taking the original patch
>> as a temporary fix (it'll also be easier to backport) while we work on
>> fixing these other issues and enabling memoryless nodes.
>
> Well, x86 already does that but copying this antipatern is not really
> nice. So it is good as a quick fix but it would be definitely much
> better to have a robust fix. Who knows how many other places might hit
> this. You certainly do not want to add a hack like this all over...

Completely agree! I was only suggesting it as a temporary measure,
especially as it looked like a proper fix might be invasive.

Another fix might be to change the node specific allocation to node
agnostic allocations. It isn't clear why the allocation is being
requested from a specific node. I think Lorenzo suggested this in one of
the threads.

I've started putting together a set fixing the issues identified in this
thread. It should give a better idea on the best course of action.
