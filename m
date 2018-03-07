Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932930AbeCGIoE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:44:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751125AbeCGIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:44:03 -0500
Subject: Re: [RFC 3/4] trace_uprobe: Support SDT markers having semaphore
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180306115921.GD25201@hirez.programming.kicks-ass.net>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 14:16:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306115921.GD25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030708-0020-0000-0000-000003FFB6EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030708-0021-0000-0000-00004293F74F
Message-Id: <3a0f9efd-158e-08ba-ae01-38391f580133@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070102
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2018 05:29 PM, Peter Zijlstra wrote:
> On Wed, Feb 28, 2018 at 01:23:44PM +0530, Ravi Bangoria wrote:
>> Userspace Statically Defined Tracepoints[1] are dtrace style markers
>> inside userspace applications. These markers are added by developer at
>> important places in the code. Each marker source expands to a single
>> nop instruction in the compiled code but there may be additional
>> overhead for computing the marker arguments which expands to couple of
>> instructions. If this computaion is quite more, execution of it can be
>> ommited by runtime if() condition when no one is tracing on the marker:
>>
>>     if (semaphore > 0) {
>>         Execute marker instructions;
>>     }   
>>
>> Default value of semaphore is 0. Tracer has to increment the semaphore
>> before recording on a marker and decrement it at the end of tracing.
>>
>> Implement the semaphore flip logic in trace_uprobe, leaving core uprobe
>> infrastructure as is, except one new callback from uprobe_mmap() to
>> trace_uprobe.
> W.T.H. is that called a semaphore? afaict its just a usage-counter.

I totally agree with you. But it's not me who named it semaphore :)

Please refer to "Semaphore Handling" section at:
https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

We can surly name it differently in the kernel code and document it
properly in the Documents/tracing/

> There is no blocking, no releasing, nothing that would make it an actual
> semaphore.
>
> So please, remove all mention of semaphore from this code, because it,
> most emphatically, is not one.
>
> Also, would it not be much better to do userspace jump-labels for this?
> That completely avoids the dynamic branch at the SDT site.
>

Userspace jump-label is a good idea but...

Semaphore logic has already became a kinda ABI now. Tools like bcc,
gdb, systemtap etc. flip the semaphore while probing the marker.

Thanks,
Ravi
