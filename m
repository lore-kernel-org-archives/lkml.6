Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeDYOTi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:19:38 -0400
Received: from omr-a015e.mx.aol.com ([204.29.186.63]:40457 "EHLO
        omr-a015e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeDYOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:19:34 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
Date: Wed, 25 Apr 2018 10:19:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180412131012.GC9818@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1b02225ae080621c4e
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for any problems my patch may be causing.

I'm unclear on what is the proposed fix, other than reverting the commit.

In the problem scenario, is a --symfs option used? Is the debug info being obtained from the symfs directory?

Unfortunately, I've had to change my focus for the time being, so won't be able to investigate further for a while.

Arnaldo, I'm fine with you reverting this change for now.

Regards,

MV


On 04/12/18 09:10, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 12, 2018 at 10:19:59AM +0200, Thomas Richter escreveu:
>> perf test case 58 (record+probe_libc_inet_pton.sh)
>> executed on s390x using kernel 4.16.0rc3
>> displays this result:
>>   # ./perf trace --no-syscalls
>>             -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
>>       probe_libc:inet_pton: (3ffa0240448)
>> 	      __GI___inet_pton (/usr/lib64/libc-2.26.so)
>> 	      gaih_inet (inlined)
>> 	      __GI_getaddrinfo (inlined)
>> 	      main (/usr/bin/ping)
>> 	      __libc_start_main (/usr/lib64/libc-2.26.so)
>> 	     _start (/usr/bin/ping)
>>
>> After I installed kernel 4.16.0 the same tests uses
>> commands
>>   # perf record -e probe_libc:inet_pton/call-graph=dwarf/
>>        -o /tmp/perf.data.abc ping -6 -c 1 ::1
>>   # perf script -i /tmp/perf.data.abc
>> and displays:
>>   ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
>> 	       140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>> 	       fbde1 gaih_inet (inlined)
>> 	       fe2b9 __GI_getaddrinfo (inlined)
>> 	        398d main (/usr/bin/ping)
>>
>> Nothing else changed including glibc elfutils and other libraries
>> picked up by the build.
>> The entries for __libc_start_main and _start are missing.
>>
>> I bisected missing __libc_start_main and _start to commit
>> 3d20c6246690219881786de10d2dda93f616d0ac
>> ("perf unwind: Unwind with libdw doesn't take symfs into account")
> You forgot to add the author of that changeset to the CC list. Doing so
> will give him the chance to look at this unintended consequence of his
> work and maybe allow him to comment on your fix or provide an
> alternative solution.
>
> I've added him to the CC list now, Martin, can you please comment on
> this?
>
> - Arnaldo
>
>> When I undo this commit I get this call stack on s390:
>>   [root@s35lp76 perf]# ./perf script  -i /tmp/perf.data.abc
>>   ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
>> 	140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>> 	 fbde1 gaih_inet (inlined)
>> 	 fe2b9 __GI_getaddrinfo (inlined)
>> 	  398d main (/usr/bin/ping)
>> 	 22fbd __libc_start_main (/usr/lib64/libc-2.26.so)
>> 	  457b _start (/usr/bin/ping)
>>
>> Looks like dwarf functions dwfl_xxx  create different call back
>> stack trace when using file
>> /usr/lib/debug/usr/bin/ping-20161105-7.fc27.s390x.debug instead of
>> file /usr/bin/ping.
>>
>> Fix this test case on s390 and do not expect any call back stack
>> entry after the main() function. Also be more robust and accept a
>> leading __GI_ prefix in front of getaddrinfo.
>>
>> On x86 this test case shows the same call stack using
>> both kernel versions 4.16.0rc3 and 4.16.0 and also
>> stops at main:
>>
>> [root@f27 perf]# ./perf script -i /tmp/perf.data.tmr
>> ping  4446 [000]   172.027088: probe_libc:inet_pton: (7fdfa08c93c0)
>> 	           1393c0 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>> 	            fe60d getaddrinfo (/usr/lib64/libc-2.26.so)
>> 	             2f40 main (/usr/bin/ping)
>>
>> [root@f27 perf]#
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> ---
>>   tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> index 1ecc1f0ff84a..016882dbbc16 100755
>> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> @@ -19,12 +19,10 @@ trace_libc_inet_pton_backtrace() {
>>   	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
>>   	case "$(uname -m)" in
>>   	s390x)
>> -		eventattr='call-graph=dwarf'
>> +		eventattr='call-graph=dwarf,max-stack=4'
>>   		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
>> -		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
>> +		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
>>   		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
>> -		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
>> -		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
>>   		;;
>>   	*)
>>   		eventattr='max-stack=3'
>> -- 
>> 2.14.3
