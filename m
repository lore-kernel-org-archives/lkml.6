Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB63C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDF20644
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DDF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeH1WDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:03:03 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52647 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1WDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:03:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 488BCC0789;
        Tue, 28 Aug 2018 18:10:12 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BKL55wMDwa1W; Tue, 28 Aug 2018 18:10:12 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 85257C066A;
        Tue, 28 Aug 2018 18:10:00 +0000 (UTC)
Subject: Re: [PATCH] arm64: add NUMA emulation support
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com,
        ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
Date:   Tue, 28 Aug 2018 12:09:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828174011.GE20375@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 11:40 AM, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 05:05:59PM -0600, Shuah Khan (Samsung OSG) wrote:
>> Add NUMA emulation support to emulate NUMA on non-NUMA platforms. A new
>> CONFIG_NUMA_EMU option enables NUMA emulation and a new kernel command
>> line option "numa=fake=N" allows users to specify the configuration for
>> emulation.
>>
>> When NUMA emulation is enabled, a flat (non-NUMA) machine will be split
>> into virtual NUMA nodes when booted with "numa=fake=N", where N is the
>> number of nodes, the system RAM will be split into N equal chunks and
>> assigned to each node.
>>
>> Emulated nodes are bounded by MAX_NUMNODES and the number of memory block
>> count to avoid splitting memory blocks across NUMA nodes.
>>
>> If NUMA emulation init fails, it will fall back to dummy NUMA init.
>>
>> This is tested on Raspberry Pi3b+ with ltp NUMA test suite, numactl, and
>> numastat tools. In addition, tested in conjunction with cpuset cgroup to
>> verify cpuset.cpus and cpuset.mems assignments.
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>> ---
>>  arch/arm64/Kconfig            |   9 +++
>>  arch/arm64/include/asm/numa.h |   8 +++
>>  arch/arm64/mm/Makefile        |   1 +
>>  arch/arm64/mm/numa.c          |   4 ++
>>  arch/arm64/mm/numa_emu.c      | 109 ++++++++++++++++++++++++++++++++++
>>  5 files changed, 131 insertions(+)
>>  create mode 100644 arch/arm64/mm/numa_emu.c
> 
> Hmm, is this just for debugging and kernel development? If so, it's quite a
> lot of code just for that. Can't you achieve the same thing by faking up the
> firmware tables?
> 
> Will
> 

The main intent is to use numa emulation in conjunction with cpusets for coarse
memory management similar to x86_64 use-case for the same.

I verified the restricted/unrestricted using cpuset cgroup to verify cpuset.cpus
and cpuset.mems assignments. I could see the Restricted/Unrestricted case memory
usage differences. Using this it will be possible to restrict memory usage by a
class of processes or a workload or set aside memory for a workload.

This adds the same feature supported by x86_64 as described in

x86/x86_64/fake-numa-for-cpusets
Using numa=fake and CPUSets for Resource Management

I could see the Restricted/Unrestricted case memory usage differences with this
patch on Raspberry Pi3b+.

This can also be used to regression test higher level NUMA changes on non-NUMA
as well without firmware changes. This will also provide a way to expand NUMA
regression testing in kernel rings.

I was able to run ltp NUMA tests on this and verify NUMA policy code on non-NUMA
platform. Results below.

numa01 1 TINFO: The system contains 4 nodes: 
numa01 1 TPASS: NUMA local node and memory affinity
numa01 2 TPASS: NUMA preferred node policy
numa01 3 TPASS: NUMA share memory allocated in preferred node
numa01 4 TPASS: NUMA interleave policy
numa01 5 TPASS: NUMA interleave policy on shared memory
numa01 6 TPASS: NUMA phycpubind policy
numa01 7 TPASS: NUMA local node allocation
numa01 8 TPASS: NUMA MEMHOG policy
numa01 9 TPASS: NUMA policy on lib NUMA_NODE_SIZE API
numa01 10 TPASS: NUMA MIGRATEPAGES policy
numa01 11 TCONF: hugepage is not supported
grep: /sys/kernel/mm/transparent_hugepage/enabled: No such file or directory
numa01 12 TCONF: THP is not supported/enabled

Summary:
passed   10
failed   0
skipped  2
warnings 0

thanks,
-- Shuah
