Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10936C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893E2438D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B893E2438D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeGCFbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:31:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753834AbeGCFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:31:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w635OPxA104128
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 01:31:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k02ec1790-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:31:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 06:31:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 06:31:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w635V2Xx36831322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 05:31:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBDEA4C04E;
        Tue,  3 Jul 2018 08:31:27 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 755CA4C040;
        Tue,  3 Jul 2018 08:31:24 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 08:31:24 +0100 (BST)
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 3 Jul 2018 11:00:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702180156.GA31400@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070305-0020-0000-0000-000002A2743B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070305-0021-0000-0000-000020EE891A
Message-Id: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/02/2018 11:31 PM, Oleg Nesterov wrote:
> On 07/02, Ravi Bangoria wrote:
>>
>> Hi Oleg,
>>
>> On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
>>> On 06/28, Ravi Bangoria wrote:
>>>>
>>>> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>>>>  	if (ret <= 0)
>>>>  		goto put_old;
>>>>
>>>> +	/* Update the ref_ctr if we are going to replace instruction. */
>>>> +	if (!ref_ctr_updated) {
>>>> +		ret = update_ref_ctr(uprobe, mm, is_register);
>>>> +		if (ret)
>>>> +			goto put_old;
>>>> +
>>>> +		ref_ctr_updated = 1;
>>>> +	}
>>>
>>> Why can't this code live in install_breakpoint() and remove_breakpoint() ?
>>> this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
>>> and the logic will be more simple.
>>
>> IMO, it's more easier with current approach. Updating reference counter
>> inside uprobe_write_opcode() makes it tightly coupled with instruction
>> patching. Basically, reference counter gets incremented only when first
>> consumer gets activated and will get decremented only when last consumer
>> is going away.
>>
>> Advantage is, we can get rid of sdt_mm_list patch*, because increment and
>> decrement are anyway happening in sync. This makes the implementation lot
>> more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
>> I've to reintroduce sdt_mm_list which makes code more complicated and ugly.
> 
> Why? I do not understand. Afaics you can have the same logic, but the resulting
> code will be simpler and more clear.


Ok let me explain the difference.

Current approach:

    ------------
    register_for_each_vma() / uprobe_mmap()
      install_breakpoint()
        uprobe_write_opcode() {
                if (instruction is not already patched) {
                        /* Gets called only _once_. */
                        increment the reference counter;
                        patch the instruction;
                }
        }
    ------------

Here, reference counter is updated only if we are going to patch the
instruction. No matter how many consumers are there, no matter how many
times install_breakpoint() gets called. Same case for decrement as well.
Reference counter will get decremented only when we are going to reset
the instruction.

Now, if I put it inside install_breakpoint():

    ------------
    uprobe_register()
      register_for_each_vma()
        install_breakpoint() {
                /* Called _for each consumer_ */
                increment the reference counter _once_;
                uprobe_write_opcode()
		...
        }

  OR

    uprobe_mmap()
      install_breakpoint() {
                increment the reference counter _for each consumer_;
                uprobe_write_opcode()
		...
      }
    ------------

By putting it inside install_breaopoint() / remove_breakpoint(), we
increment and decremnet the counter for each consumer.

Consider this python example:

    ------------
    # readelf -n /usr/lib64/libpython2.7.so.1.0 | grep -A2 Provider
      Provider: python
      Name: function__entry
      ... Semaphore: 0x00000000002899d8

    # sudo perf probe sdt_python:function__entry

    # strace python
      mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
      mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
      mprotect(0x7fff926a0000, 65536, PROT_READ) = 0
    ------------

The first mmap() maps the whole library into one region. Second mmap()
and third mprotect() split out the whole region into smaller vmas and
sets appropriate protection flags.

Now, in this case, install_breakpoint() will update reference counter
twice -- by second mmap() call and by third mprotect() call -- because
both regions contains the same reference counter. But, remove_brekpoint()
will decrement the reference counter only once, which will left counter
greater than 0 even when no one is tracing on that uprobe.

To solve this issue, I have to re-introduced sdt_mm_list, a list of
{consumer,mm} tuple for each uprobe. This tells us, for X consumer
we already have incremented the counter in Y mm so that we don't
increment same counter again. This additional complexity is to make
sure increment and decrement happen in sync.

Fortunately, we don't need to maintain this list with current approach,
because we know for sure that, increment and decrement will happen only
once when we patch/up-patch the instruction.

In short, if I put it inside install_breakpoint()/remove_breakpoint(),
I'll have to put the same logic there with more complication to
increment / decrement counter for each consumer. And additionally,
I've to maintain sdt_mm_list to make sure increment and decrement
happen in sync. With current approach, this all happens by default :)


> 
>> BTW, is there any harm in exporting struct uprobe outside of uprobe.c?
> 
> I think it is always better to avoid the exporting if possible (and avoid
> changing the arch-dependant set_swbp/set_orig_insn). But once again, I think
> this only complicates the code for no reason.> 
>>> So why do we need a counter but not a boolean? IIRC, because the counter can
>>> be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
>>> right?
>>
>> Actually, it's by design. This counter keeps track of current tracers
>> tracing on a particular SDT marker. So only boolean can't work here.
>> Also, yes, multiple markers can share the same reference counter.
> 
> markers or uprobes? OK, I'll assume that multiple uprobes can share the counter.


Yes, I meant uprobe.


> 
>>> But who else can use this counter and how? Say, can userspace update it too?
>>
>> There are many different ways user can change the reference counter.
>> Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
>> counter update logic is different in both of them. Systemtap records all
>> exec/mmap events and updates the counter when it finds interested process/
>> vma. bcc directly hooks into process's memory (/proc/pid/mem).
> 
> OK, and how exactly they update the counter? I mean, can we assume that, say,
> bcc or systemtap can only increment or decrement it?


I don't think we can assume anything here because this is all in user's
control. User can even manually go and update the counter by directly
hooking into the memory. Ex, Brendan Gregg's blog on USDT explains how
to change counter manually in "Hacking with Ftrace: Is-Enabled" section
of his blog:
  http://www.brendangregg.com/blog/2015-07-03/hacking-linux-usdt-ftrace.html


> 
> If yes, perhaps we can simplify the kernel code...


Sure, let me know if you have any better idea.

Thanks,
Ravi

