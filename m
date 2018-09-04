Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150D62073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeIEC0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:26:51 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46404 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeIEC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id EFF58C1400;
        Tue,  4 Sep 2018 21:59:46 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p2F_I7XyYyoH; Tue,  4 Sep 2018 21:59:46 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 44DA8C068B;
        Tue,  4 Sep 2018 21:59:34 +0000 (UTC)
Subject: Re: [PATCH] arm64: add NUMA emulation support
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
Date:   Tue, 4 Sep 2018 15:59:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829110802.GD10349@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Sorry for the delay in responding. I was traveling last week.

On 08/29/2018 05:08 AM, Michal Hocko wrote:
> On Tue 28-08-18 12:09:53, Shuah Khan wrote:
> [...]
>> The main intent is to use numa emulation in conjunction with cpusets for coarse
>> memory management similar to x86_64 use-case for the same.
> 
> Could you be more specific please? Why would you want a hack like this
> when you have a full featured memory cgroup controller to limit the
> amount of memory?
> 

I should have given more details about the nature of memory management use-case
this patch addresses.

Memory cgroup allows specifying memory limits and controls memory footprint of
tasks in a cgroup.

However, there are some limitations

- Memory isn't reserved for the cgroup and there is no guarantee that the memory will
  be available when it needs it.

- cgroups allocate from the same system memory pool and is shared with other cgroups.
  Since root cgroup doesn’t have limits, it could potentially impact performance on
  other cgroups in high memory pressure situations.

- Allocating entire memory blocks to a cgroup to ensure reservation and isolation isn't
  possible. Pages can be re-allocated to another processes.

With NUMA emulation, memory blocks can be split and assigned to emulated nodes, both
reservation and isolation can be supported.

This will support the following workload requirements:

- reserving one or more NUMA memory nodes for class of critical tasks that require
  guaranteed memory availability.
- isolate memory blocks with a guaranteed exclusive access.

NUMA emulation to split the flat machine into "x" number of nodes, combined with
cpuset cgroup with the following example configuration will make it possible to
support the above workloads on non-NUMA platforms.

numa=fake=4

cpuset.mems=2
cpuset.cpus=2
cpuset.mem_exclusive=1 (enabling exclusive use of the memory nodes by a CPU set)
cpuset.mem_hardwall=1  (separate the memory nodes that are allocated to different cgroups)

thanks,
-- Shuah
