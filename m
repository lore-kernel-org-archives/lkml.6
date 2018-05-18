Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeERT2m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750763AbeERT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:28:41 -0400
Subject: Re: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        tmricht@linux.ibm.com
References: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
 <20180518192102.GB5001@kernel.org>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Sat, 19 May 2018 00:58:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180518192102.GB5001@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051819-0008-0000-0000-000004F80A20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051819-0009-0000-0000-00001E8C8996
Message-Id: <80d65e5c-40d7-b0a8-6f6f-c0ddb4cbb77c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 05/19/2018 12:51 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 18, 2018 at 12:54:17PM +0530, Sandipan Das escreveu:
>> This test currently fails because the regular expressions for
>> matching the output of perf script do not consider the symbol
>> offsets to be part of the output.
>>
>> The symbol offsets are seen because of the default behaviour
>> introduced by commit 4140d2ea74b3 ("perf script: Show symbol
>> offsets by default").
>>
>> Before applying this patch:
>>
>>   # perf test -v "probe libc's inet_pton & backtrace it with ping"
>>
>>   62: probe libc's inet_pton & backtrace it with ping       :
>>   --- start ---
>>   test child forked, pid 30389
>>   ping 30406 [002] 307144.280983: probe_libc:inet_pton: (7f4117adf220)
>>   7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
>>   FAIL: expected backtrace entry 1 ".*inet_pton[[:space:]]\(/usr/lib64/libc-2.25.so|inlined\)$" got "7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)"
>>   test child finished with -1
>>   ---- end ----
>>   probe libc's inet_pton & backtrace it with ping: FAILED!
>>
>> After applying this patch:
>>
>>   # perf test -v "probe libc's inet_pton & backtrace it with ping"
>>
>>   62: probe libc's inet_pton & backtrace it with ping       :
>>   --- start ---
>>   test child forked, pid 30539
>>   ping 30556 [003] 307254.313217: probe_libc:inet_pton: (7fe19ab10220)
>>   7fe19ab10220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
>>   7fe19aad5ebd getaddrinfo+0x11d (/usr/lib64/libc-2.25.so)
>>   56351e3c1c71 main+0x891 (/usr/bin/ping)
>>   test child finished with 0
>>   ---- end ----
>>   probe libc's inet_pton & backtrace it with ping: Ok
> 
> Here it went from failing with:
> 
> [root@seventh ~]# perf test -v pton
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 22590
> ping 22607 [001] 12782.425689: probe_libc:inet_pton: (7f8686da4e40)
> 7f8686da4e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)
> FAIL: expected backtrace entry 1 ".*inet_pton[[:space:]]\(/usr/lib64/libc-2.26.so|inlined\)$" got "7f8686da4e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)"
> test child finished with -1
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: FAILED!
> [root@seventh ~]# 
> 
> To failing with:
> 
> [root@seventh ~]# perf test -v pton
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 28954
> ping 28971 [002] 14277.711200: probe_libc:inet_pton: (7fc9d66e3e40)
> 7fc9d66e3e40 __GI___inet_pton+0x0 (/usr/lib64/libc-2.26.so)
> 7fc9d66b02b4 getaddrinfo+0x124 (/usr/lib64/libc-2.26.so)
> 56075cb98f40 [unknown] (/usr/bin/ping)
> FAIL: expected backtrace entry 3 ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" got "56075cb98f40 [unknown] (/usr/bin/ping)"
> test child finished with -1
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: FAILED!
> [root@seventh ~]# 
> 
> Trying to figure this out...
> 

Looks like perf failed to resolve the symbol's name for the last entry
in the callchain. I did not consider this case. So, if this happens, we
would be better off using the original regex for the last line:

expected[3]=".*\(.*/bin/ping.*\)$"

- Sandipan
