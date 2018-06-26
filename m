Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B14C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE33426EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE33426EAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeFZR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:27:17 -0400
Received: from foss.arm.com ([217.140.101.70]:50014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbeFZR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29062ED1;
        Tue, 26 Jun 2018 10:27:15 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A543F5AD;
        Tue, 26 Jun 2018 10:27:14 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <tnowicki@caviumnetworks.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>, <wanghuiqiang@huawei.com>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <20180622184223.00007bc3@huawei.com> (Jonathan Cameron's message
        of "Fri, 22 Jun 2018 18:42:23 +0100")
References: <20180619120714.GE13685@dhcp22.suse.cz>
        <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
        <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
        <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
        <20180619151425.GH13685@dhcp22.suse.cz>
        <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
        <20180619163256.GA18952@e107981-ln.cambridge.arm.com>
        <814205eb-ae86-a519-bed0-f09b8e2d3a02@huawei.com>
        <87602d3ccl.fsf@e105922-lin.cambridge.arm.com>
        <5c083c9c-473f-f504-848b-48506d0fd380@huawei.com>
        <20180622091153.GU10465@dhcp22.suse.cz>
        <87y3f7yv89.fsf@e105922-lin.cambridge.arm.com>
        <20180622184223.00007bc3@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Tue, 26 Jun 2018 18:27:13 +0100
Message-ID: <87lgb1wj9q.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

[...]

>
> I'll test it when back in the office, but I had a similar issue with
> memory only nodes when I moved the SRAT listing for cpus from the 4
> 4th mode to the 3rd node to fake some memory I could hot unplug.
> This gave a memory only node for the last node on the system.
>
> When I instead moved cpus from the 3rd node to the 4th (so the node
> with only memory was now in the middle, everything worked).
>
> Was odd, and I'd been meaning to chase it down but hadn't gotten to it
> yet.  If I get time I'll put together some test firmwares as see if there
> are any other nasty corner cases we aren't handling.

If you get a chance, it'd be really helpful to test reversing the
ordering of entries in the SRAT and booting with a restricted
NR_CPUS.

This issue was found through code inspection.

Please make sure to use the updated patch from Lorenzo for your
tests[0].

[0] https://marc.info/?l=linux-acpi&m=152998665713983&w=2

>
> Jonathan
>
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
