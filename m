Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966042AbeCAFaG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:30:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965996AbeCAFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:30:05 -0500
Subject: Re: [RFC 0/4] trace_uprobe: Support SDT markers having semaphore
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        ananth@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, oleg@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228232551.5e99736b4b4fd209e492cd4d@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 11:02:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228232551.5e99736b4b4fd209e492cd4d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030105-0020-0000-0000-000003FD279C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030105-0021-0000-0000-000042915426
Message-Id: <0fdb07bd-fe66-5087-9740-1f87f14e4b60@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 07:55 PM, Masami Hiramatsu wrote:
> Hi Ravi,
>
> Thank you for your great work!

Thanks Masami.

> On Wed, 28 Feb 2018 13:23:41 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> Userspace Statically Defined Tracepoints[1] are dtrace style markers
>> inside userspace applications. These markers are added by developer at
>> important places in the code. Each marker source expands to a single
>> nop instruction in the compiled code but there may be additional
>> overhead for computing the marker arguments which expands to couple of
>> instructions. If this computaion is quite more, execution of it can be
>> ommited by runtime if() condition when no one is tracing on the marker:
...
>>
>> Semaphore offset is 0x10036. I don't have educated 'perf probe'
>> about semaphore. So instead of using 'perf probe' command, I'm
>> manually adding entry in the <tracefs>/uprobe_events file.
> Ok, it is easy to pass semaphore address via perf probe :)

Yes, it should be fairly easy to parse semaphore at buildid-cache time.
Will add a patch for that.

>
>> Special char * denotes semaphore offset.
>>
>>
>>   # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events
> IMHO, this syntax is no good, separate with space is only for arguments.
> Since the semaphore is per-probe-point based, that should be specified with probe point.
> (there are no 2 or more semaphores on 1 event, are there?)
> So something like
>
> # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4(0x10036)" > uprobe_events

This is great suggestion. Will change it.

Please review patch 3 and 4 which contains actual implementation.

Thanks for the review,
Ravi
