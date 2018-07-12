Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A9E20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A9E20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeGLLOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:14:50 -0400
Received: from foss.arm.com ([217.140.101.70]:49738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeGLLOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:14:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0BC67A9;
        Thu, 12 Jul 2018 04:05:46 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9060C3F5B1;
        Thu, 12 Jul 2018 04:05:46 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DD0021AE53FB; Thu, 12 Jul 2018 12:06:28 +0100 (BST)
Date:   Thu, 12 Jul 2018 12:06:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     catalin.marinas@arm.com, jeremy.linton@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>, sudeep.holla@arm.com
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
Message-ID: <20180712110628.GA16043@arm.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:18:28PM +0800, Shunyong Yang wrote:
> As PPTT spec doesn't define the physical package id,
> find_acpi_cpu_topology_package() will return offset of the node with
> Physical package field set when querying physical package id. So, it
> returns 162(0xA2) in following example.
> 
> [0A2h 0162   1]                Subtable Type : 00 [Processor Hierarchy
> Node]
> [0A3h 0163   1]                       Length : 1C
> [0A4h 0164   2]                     Reserved : 0000
> [0A6h 0166   4]        Flags (decoded below) : 00000003
>                             Physical package : 1
>                      ACPI Processor ID valid : 1
> [0AAh 0170   4]                       Parent : 00000000
> [0AEh 0174   4]            ACPI Processor ID : 00001000
> [0B2h 0178   4]      Private Resource Number : 00000002
> [0B6h 0182   4]             Private Resource : 0000006C
> [0BAh 0186   4]             Private Resource : 00000084
> 
> So, when "cat physical_package" in /sys/devices/system/cpu/cpu0/topology/,
> it will output 162(0xA2). And if some items are added before the node
> above, the output will change to other value.
> 
> This patch maps the node offset to a logic package id. It maps the first
> node offset to 0, the second to 1, and so on.
> 
> Then, it will not output a big value, such as 162 above. And it will
> not change when some nodes(Physical package not set) are added.
> 
> And as long as the nodes with Physical package field set in PPTT keeps
> the real hardware order, the logic id can map to hardware package id to
> some extent.
> 
> Hope to get feedback from you.

I'm assuming this is no longer needed now that we have queued the series
from Sudeep?

Will
