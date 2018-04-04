Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeDDGQt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:16:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751643AbeDDGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:16:48 -0400
Subject: Re: [PATCH v2] tools include: define READ_ONCE/WRITE_ONCE for C++
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, acme@redhat.com,
        philip.li@intel.com, mark.rutland@arm.com, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org
References: <1512005772-27112-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 11:46:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1512005772-27112-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040406-0044-0000-0000-000005433751
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040406-0045-0000-0000-000028834C3E
Message-Id: <ddeec38a-3843-b812-7219-7e4fef8f040f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040065
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/2017 07:06 AM, Li Zhijian wrote:
> since 6aa7de0, we failed to build perf with C++(clang)
> to fix the following compile errors
> --------------
> lizhijian@haswell-OptiPlex-9020:~/lkp/linux/tools/perf$ make LLVM_CONFIG=/usr/bin/llvm-config-3.9 LIBCLANGLLVM=1
> ...
>   CC       util/probe-finder.o
> In file included from /home/lizj/linux/tools/perf/util/util.h:13:0,
>                  from /home/lizj/linux/tools/perf/util/util-cxx.h:20,
>                  from util/c++/clang-c.h:5,
>                  from util/c++/clang-test.cpp:2:
> /home/lizj/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function ‘int atomic_read(const atomic_t*)’:
> /home/lizj/linux/tools/include/linux/compiler.h:157:45: error: use of deleted function ‘atomic_read(const atomic_t*)::<anonymous union>::<constructor>()’
>   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
>                                              ^
> /home/lizj/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:28:9: note: in expansion of macro ‘READ_ONCE’
>   return READ_ONCE((v)->counter);
>          ^
> /home/lizj/linux/tools/include/linux/compiler.h:157:11: note: ‘atomic_read(const atomic_t*)::<anonymous union>::<constructor>()’ is implicitly deleted because the default definition would be ill-formed:
>   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
>            ^
> /home/lizj/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:28:9: note: in expansion of macro ‘READ_ONCE’
>   return READ_ONCE((v)->counter);
>          ^
> /home/lizj/linux/tools/include/linux/compiler.h:157:11: error: uninitialized const member in ‘union atomic_read(const atomic_t*)::<anonymous>’
>   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
>            ^
> /home/lizj/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:28:9: note: in expansion of macro ‘READ_ONCE’
>   return READ_ONCE((v)->counter);
>          ^
> /home/lizj/linux/tools/include/linux/compiler.h:157:23: note: ‘const int atomic_read(const atomic_t*)::<anonymous union>::__val’ should be initialized
>   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
>                        ^
> /home/lizj/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:28:9: note: in expansion of macro ‘READ_ONCE’
>   return READ_ONCE((v)->counter);
>          ^
>   LD       tests/perf-in.o
> ...
> --------------
> 

I ran into the same problems while building perf with clang support.
If the solution proposed here is acceptable, can someone please pick
up this patch?

--
With Regards,
Sandipan
