Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965800AbeEYK0j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:26:39 -0400
Received: from ozlabs.org ([203.11.71.1]:51963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965102AbeEYK0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:26:37 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] selftests/powerpc: Add ptrace tests for Protection Key registers
In-Reply-To: <874liwqy64.fsf@morokweng.localdomain>
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com> <87tvr6mlbe.fsf@concordia.ellerman.id.au> <874liwqy64.fsf@morokweng.localdomain>
Date: Fri, 25 May 2018 20:26:35 +1000
Message-ID: <87po1kqbdw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>>>  tools/testing/selftests/powerpc/include/reg.h      |   1 +
>>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>>>  tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++++
>>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++++++++
>>
>> This is failing on machines without pkeys:
>>
>>   test: ptrace_pkey
>>   tags: git_version:52e7d87
>>   [FAIL] Test FAILED on line 117
>>   [FAIL] Test FAILED on line 191
>>   failure: ptrace_pkey
>>
>>
>> I think the first fail is in the child here:
>>
>> int ptrace_read_regs(pid_t child, unsigned long type, unsigned long regs[],
>> 		     int n)
>> {
>> 	struct iovec iov;
>> 	long ret;
>>
>> 	FAIL_IF(start_trace(child));
>>
>> 	iov.iov_base = regs;
>> 	iov.iov_len = n * sizeof(unsigned long);
>>
>> 	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
>> 	FAIL_IF(ret != 0);
>>
>>
>> Which makes sense.
>
> Yes, that is indeed what is going on.
>
>> The test needs to skip if pkeys are not available/enabled. Using the
>> availability of the REGSET might actually be a nice way to detect that,
>> because it's read-only.
>
>  I forgot to consider the case of pkeys not available or not enabled,
>  sorry about that.

No worries.

> I just sent a v2 which implements your suggestion above.

Thanks.

cheers
