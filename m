Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3666E20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3666E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeIELLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:11:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbeIELLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:11:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9093DAE4F;
        Wed,  5 Sep 2018 06:42:54 +0000 (UTC)
Date:   Wed, 5 Sep 2018 08:42:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180905064252.GW14951@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-09-18 15:59:34, Shuah Khan wrote:
[...]
> This will support the following workload requirements:
> 
> - reserving one or more NUMA memory nodes for class of critical tasks that require
>   guaranteed memory availability.
> - isolate memory blocks with a guaranteed exclusive access.

How do you enforce kernel doesn't allocate from those reserved nodes?
They will be in a fallback zonelists so once the memory gets used on all
other ones then the kernel happily spills over to your reserved node.

> NUMA emulation to split the flat machine into "x" number of nodes, combined with
> cpuset cgroup with the following example configuration will make it possible to
> support the above workloads on non-NUMA platforms.
> 
> numa=fake=4
> 
> cpuset.mems=2
> cpuset.cpus=2
> cpuset.mem_exclusive=1 (enabling exclusive use of the memory nodes by a CPU set)
> cpuset.mem_hardwall=1  (separate the memory nodes that are allocated to different cgroups)

This will only enforce userspace to follow and I strongly suspect that
tasks in the root cgroup will be allowed to allocate as well.
-- 
Michal Hocko
SUSE Labs
