Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7696C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEB120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIGCbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:31:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58240 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:31:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3ABCB41926;
        Thu,  6 Sep 2018 21:53:52 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id amGr8CKqesqz; Thu,  6 Sep 2018 21:53:52 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id C2F83418D6;
        Thu,  6 Sep 2018 21:53:41 +0000 (UTC)
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
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
Date:   Thu, 6 Sep 2018 15:53:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905064252.GW14951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 12:42 AM, Michal Hocko wrote:
> On Tue 04-09-18 15:59:34, Shuah Khan wrote:
> [...]
>> This will support the following workload requirements:
>>
>> - reserving one or more NUMA memory nodes for class of critical tasks that require
>>   guaranteed memory availability.
>> - isolate memory blocks with a guaranteed exclusive access.
> 
> How do you enforce kernel doesn't allocate from those reserved nodes?
> They will be in a fallback zonelists so once the memory gets used on all
> other ones then the kernel happily spills over to your reserved node.

I should have clarified the "isolate memory blocks with a guaranteed exclusive
access." scope.

Kernel does satisfy GFP_ATOMIC at the expense of cpuset exclusive/hardwall policies
to not stress the kernel.

It is not the intent to make sure kernel doesn't allocate from these reserved
nodes. The intent is to work within the constraints of cpuset mem.exclusive and
cpuset mem.hardwall policies.

> 
>> NUMA emulation to split the flat machine into "x" number of nodes, combined with
>> cpuset cgroup with the following example configuration will make it possible to
>> support the above workloads on non-NUMA platforms.
>>
>> numa=fake=4
>>
>> cpuset.mems=2
>> cpuset.cpus=2
>> cpuset.mem_exclusive=1 (enabling exclusive use of the memory nodes by a CPU set)
>> cpuset.mem_hardwall=1  (separate the memory nodes that are allocated to different cgroups)
> 
> This will only enforce userspace to follow and I strongly suspect that
> tasks in the root cgroup will be allowed to allocate as well.
> 

A few critical allocations could be satisfied and root cgroup prevails. It is not the
intent to have exclusivity at the expense of the kernel.

This feature will allow a way to configure cpusets on non-NUMA for workloads that can
benefit from the reservation and isolation that is available within the constraints of
exclusive cpuset policies.

thanks,
-- Shuah
