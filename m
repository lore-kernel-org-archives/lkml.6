Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935261AbeEYCOw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:14:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754164AbeEYCOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:14:44 -0400
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com> <87tvr6mlbe.fsf@concordia.ellerman.id.au>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] selftests/powerpc: Add ptrace tests for Protection Key registers
In-reply-to: <87tvr6mlbe.fsf@concordia.ellerman.id.au>
Date: Thu, 24 May 2018 23:14:27 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052502-0056-0000-0000-00000454EF96
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-25 02:14:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052502-0057-0000-0000-000008990D38
Message-Id: <874liwqy64.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> This test exercises read and write access to the AMR, IAMR and UAMOR.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  tools/testing/selftests/powerpc/include/reg.h      |   1 +
>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>>  tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++++
>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++++++++
>
> This is failing on machines without pkeys:
>
>   test: ptrace_pkey
>   tags: git_version:52e7d87
>   [FAIL] Test FAILED on line 117
>   [FAIL] Test FAILED on line 191
>   failure: ptrace_pkey
>
>
> I think the first fail is in the child here:
>
> int ptrace_read_regs(pid_t child, unsigned long type, unsigned long regs[],
> 		     int n)
> {
> 	struct iovec iov;
> 	long ret;
>
> 	FAIL_IF(start_trace(child));
>
> 	iov.iov_base = regs;
> 	iov.iov_len = n * sizeof(unsigned long);
>
> 	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
> 	FAIL_IF(ret != 0);
>
>
> Which makes sense.

Yes, that is indeed what is going on.

> The test needs to skip if pkeys are not available/enabled. Using the
> availability of the REGSET might actually be a nice way to detect that,
> because it's read-only.

 I forgot to consider the case of pkeys not available or not enabled,
 sorry about that.

I just sent a v2 which implements your suggestion above.

--
Thiago Jung Bauermann
IBM Linux Technology Center
