Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F49BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BA627189
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BA627189
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935144AbeF1Jic (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:38:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43724 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933896AbeF1Jib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:38:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938DC80D;
        Thu, 28 Jun 2018 02:38:30 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD64D3F266;
        Thu, 28 Jun 2018 02:38:27 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        Joey Zheng <yu.zheng@hxt-semitech.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        catalin.marinas@arm.com
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
Date:   Thu, 28 Jun 2018 10:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunyong,

On 28/06/18 10:18, Shunyong Yang wrote:
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

Thanks for the patch, but Andrew Jones has also posted a patch[1] which
I had a look but was not sure what is the best approach to fix it yet.
I will think about it and respond to that.

--
Regards,
Sudeep

[1] https://patchwork.kernel.org/patch/10482261
