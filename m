Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDSGBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:01:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751474AbeDSGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:01:33 -0400
Subject: Re: [PATCH v2 0/3] perf: Fixes for callchain ip handling on powerpc
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, acme@kernel.org
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com, maynard@us.ibm.com
References: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Thu, 19 Apr 2018 11:31:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041906-0040-0000-0000-000004309F02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041906-0041-0000-0000-00002634B395
Message-Id: <8c0d4deb-9bbd-1f19-94a3-ce2cded4fa10@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190052
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2018 04:28 PM, Sandipan Das wrote:
> The first patch fixes the callchain ip filtering mechanism for powerpc
> from skipping entries in case the LR value is still valid and yet to
> be written to the stack frame. This was previously posted as an RFC
> here: https://lkml.org/lkml/2018/4/4/633
>
> The second patch fixes a crash caused by attempting to access an empty
> callchain.
>
> The third patch fixes a shell test which used to fail on powerpc as
> the back trace from perf output did not match the expected pattern.
> Also, because of the issue described in the first patch, some entries
> from the callchain were incorrectly skipped. So, this has also been
> readjusted to work with the fix in the first patch.
>
> v2:
>  - Consider case when return address is in R0 as pointed out by Ravi.
>  - Add another patch to fix crash when callchain is empty.

Looks good. For the series,

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

But there are few other cases, I've mentioned them in detail at the end,
which needs to be fixed. Arnaldo, if you are fine, can we push this series
and take care of other cases later on? No point in stretching this series.

I've used this simple test program to test it:

    int i = 10000000;
    void *ptr;

    while (i--) {
        ptr = malloc(i);
        free(ptr);
    }


Case 1:

Without Suka's and Sandipan's changes:

    perf  9207  3034.786828:   cycles:ppp:
                      10d66c power_pmu_enable (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      2e4f24 perf_event_exec (/lib/modules/4.17.0-rc1+/build/vmlinux)            <===== This one
                      4096cc setup_new_exec (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      494f38 load_elf_binary (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40842c search_binary_handler (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40924c do_execveat_common.isra.13 (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40981c sys_execve (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       1b9e0 system_call (/lib/modules/4.17.0-rc1+/build/vmlinux)
                7fff9855b448 [unknown] ([unknown])

With only Suka's changes:

    perf  9207  3034.786828:   cycles:ppp:
                      10d66c power_pmu_enable (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      4096cc setup_new_exec (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      494f38 load_elf_binary (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40842c search_binary_handler (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40924c do_execveat_common.isra.13 (/lib/modules/4.17.0-rc1+/build/vmlinux)
                      40981c sys_execve (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       1b9e0 system_call (/lib/modules/4.17.0-rc1+/build/vmlinux)
                7fff9855b448 [unknown] ([unknown])

With both Suka's and Sandipan's changes:

     perf  9207  3034.786828:   cycles:ppp:
                       10d66c power_pmu_enable (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       4096cc setup_new_exec (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       494f38 load_elf_binary (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       40842c search_binary_handler (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       40924c do_execveat_common.isra.13 (/lib/modules/4.17.0-rc1+/build/vmlinux)
                       40981c sys_execve (/lib/modules/4.17.0-rc1+/build/vmlinux)
                        1b9e0 system_call (/lib/modules/4.17.0-rc1+/build/vmlinux)
                 7fff9855b448 [unknown] ([unknown])
   
perf_event_exec() is a valid entry, which is missing in last two output.


Case 2:

Without Suka's and Sandipan's changes:

    1854.720942:     568814 cycles:ppp:
         9cf3c _int_malloc (/usr/lib64/libc-2.26.so)
         9f838 malloc (/usr/lib64/libc-2.26.so)            <===== This one
             0 [unknown] ([unknown])
           624 main (/home/ravi/Workspace/malloc)
         236a0 generic_start_main.isra.0 (/usr/lib64/libc-2.26.so)
         23898 __libc_start_main (/usr/lib64/libc-2.26.so)

With only Suka's changes:

    1854.720942:     568814 cycles:ppp:
         9cf3c _int_malloc (/usr/lib64/libc-2.26.so)
             0 [unknown] ([unknown])
           624 main (/home/ravi/Workspace/malloc)
         236a0 generic_start_main.isra.0 (/usr/lib64/libc-2.26.so)
         23898 __libc_start_main (/usr/lib64/libc-2.26.so)

With both Suka's and Sandipan's changes:

    1854.720942:     568814 cycles:ppp:
         9cf3c _int_malloc (/usr/lib64/libc-2.26.so)
             0 [unknown] ([unknown])
           624 main (/home/ravi/Workspace/malloc)
         236a0 generic_start_main.isra.0 (/usr/lib64/libc-2.26.so)
         23898 __libc_start_main (/usr/lib64/libc-2.26.so)

malloc() is missing in last two output. Also, the pattern I've observed is,
all samples where malloc() is missing is followed by  0 [unknown] ([unknown]).

Thanks,
Ravi
