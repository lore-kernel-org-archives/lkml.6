Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeERLJ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:09:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752326AbeERLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:09:55 -0400
Subject: Re: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
References: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
 <be181700-57a5-e4c8-7cd4-88a88b7a51f1@linux.ibm.com>
 <764aa7ae-dcbe-6311-19fd-3d31b18f1645@linux.vnet.ibm.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 18 May 2018 13:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <764aa7ae-dcbe-6311-19fd-3d31b18f1645@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051811-0020-0000-0000-0000041E9DB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051811-0021-0000-0000-000042B3C62F
Message-Id: <c14a2313-28af-15ef-0989-2ab8544de51b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 12:29 PM, Sandipan Das wrote:
> Hi Thomas,
> 
> On 05/18/2018 03:51 PM, Thomas-Mich Richter wrote:
> [...]
>>
>> This patch fails on s390. I used 4.17.0rc5 + fedora 27 and I get this output:
>>
>>
>> [root@p23lp27 perf]# ./perf test 59
>> 59: probe libc's inet_pton & backtrace it with ping       : Ok
>> [root@p23lp27 linux]# cd ~/linux; patch -p1 < ../inet_pton1 
>> (Stripping trailing CRs from patch; use --binary to disable.)
>> patching file tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> [root@p23lp27 linux]# cd -; 
>> [root@p23lp27 perf]# ./perf test 59
>> 59: probe libc's inet_pton & backtrace it with ping       : FAILED!
>> [root@p23lp27 perf]#
>>
>> Debugging revealed this line as cause of failure:
>>
>>
>> FAIL: expected backtrace entry 2 "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc-2.26.so|inlined\)$" got "fdcb1 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)"
>>
>> Here is the output of the trace file
>>
>> [root@p23lp27 perf]# perf script 
>> ping 87291 [001] 96936.231618: probe_libc:inet_pton: (3ff96342378)
>>                   142378 __inet_pton (inlined)
>>                    fdcb1 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
>>                   100189 __GI_getaddrinfo (inlined)
>>                     398d main (/usr/bin/ping)
>>                    2303d __libc_start_main (/usr/lib64/libc-2.26.so)
>>                     457b [unknown] (/usr/bin/ping)
>>
>> [root@p23lp27 perf]# 
>>
>> Hope this helps
>>
> 
> Can you please apply these two patches as well and then re-test?
> 
> [1] https://lkml.org/lkml/2018/5/17/112
> [2] https://lkml.org/lkml/2018/5/17/113
> 
> - Sandipan
> 

Ahhh, yes that helped. Must have missed it. Thanks for the pointer.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
