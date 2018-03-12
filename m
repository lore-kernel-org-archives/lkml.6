Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeCLQxh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:53:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751723AbeCLQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:53:35 -0400
Subject: Re: [PATCH] perf test: Fix exit code for
 record+probe_libc_inet_pton.sh
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com
References: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
 <20180312130547.GD23111@krava>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 22:23:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180312130547.GD23111@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031216-0008-0000-0000-000004DB896E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031216-0009-0000-0000-00001E6EB871
Message-Id: <6cc6c692-2e54-d05f-5cd7-7301cfe6eebb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2018 06:35 PM, Jiri Olsa wrote:
> On Mon, Mar 12, 2018 at 06:14:50PM +0530, Sandipan Das wrote:
>> This fixes record+probe_libc_inet_pton.sh from always exiting
>> with code 0 and making the test pass even if the perf script
>> output does not match the expected pattern.
>>
>> The issue can be observed if this test is run with the verbose
>> flags as shown below:
>>
>> 60: probe libc's inet_pton & backtrace it with ping       :
>> ...
>> ping 19602 [006] 16988.413767: probe_libc:inet_pton: (7fff9a2c42e8)
>> 1842e8 __GI___inet_pton (/usr/lib64/libc-2.26.so)
>> 130db4 getaddrinfo (/usr/lib64/libc-2.26.so)
>>
>> FAIL: expected backtrace entry 3 ".*\(.*/bin/ping.*\)$" got ""
>> test child finished with 0
>> ...
>> probe libc's inet_pton & backtrace it with ping: Ok
>>
>> Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>> ---
>>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> index 52c3ee701a89..1ecc1f0ff84a 100755
>> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> @@ -47,7 +47,10 @@ trace_libc_inet_pton_backtrace() {
>>  		[ -z "${expected[$idx]}" ] && break
>>  	done
>>  
>> -	rm -f $file
>> +	# If any statements are executed from this point onwards,
>> +	# the exit code of the last among these will be reflected
>> +	# in err below. If the exit code is 0, the test will pass
>> +	# even if the perf script output does not match.
> 
> right :-\ but we still need to delete that $file.. I assume it will
> get delete by the 'rm -f ${file}' in the script main body?
> 
> thanks,
> jirka
> 
> 

Yes, that deletes $file.

--
With Regards,
Sandipan
