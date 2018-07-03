Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923424BE6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8923424BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeGCHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:44:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754279AbeGCHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:44:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w637hqHe118970
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 03:44:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k00m5946s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:44:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 08:44:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 08:44:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w637i2CL22085716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 07:44:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83884AE053;
        Tue,  3 Jul 2018 10:44:05 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57CD9AE045;
        Tue,  3 Jul 2018 10:44:02 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 10:44:02 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, rostedt@goodmis.org,
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
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703061612.GG65296@linux.vnet.ibm.com>
Date:   Tue, 3 Jul 2018 13:13:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703061612.GG65296@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070307-0028-0000-0000-000002D79B81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070307-0029-0000-0000-0000238F1B17
Message-Id: <c21db380-7dc0-2165-8616-8dcb519aa787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On 07/03/2018 11:46 AM, Srikar Dronamraju wrote:
>> Current approach:
>>
>>     ------------
>>     register_for_each_vma() / uprobe_mmap()
>>       install_breakpoint()
>>         uprobe_write_opcode() {
>>                 if (instruction is not already patched) {
>>                         /* Gets called only _once_. */
>>                         increment the reference counter;
>>                         patch the instruction;
>>                 }
>>         }
>>     ------------
>>
> 
> Lets say a user just installs a breakpoint which is part of USDT (using
> either a trace or perf (or some other utility) 
> Since the semaphore is not updated, it never hits the probe.
> This is correct.
> 
> Now he toggles the semaphore and places a probe at the same spot using
> systemtap or bcc.
> The probes will now be active and we see hits.
> This is also correct.
> 
> If the user toggles the semaphore or deletes the probe using
> systemtap/bcc. The probes will still be active.
> Since the reference count is removed on the last consumer deletion. No?
> This may be wrong because, we may be unnecessarily hitting the probes.


I'm not sure if I get your concerns but let me try to explain what happens
in such cases. please let me know if I misunderstood your point.

1. Install a probe using perf.
  # ./perf probe sdt_tick:loop2

  This does not do anything. Just creates an entry in trace_uprobe.

2. Start record using perf:
  # ./perf record -a -e sdt_tick:loop2

  This will call uprobe_register_refctr(inode, offfset, ref_ctr_offset)
  and will create an object of struct uprobe.

3. Start target process
  # ./tick

  When we start 'tick', kernel will load the binary and start creating
  vmas, which will basically call uprobe_mmap(). First vma will be of
  text section and thus instruction will be patched. But vma holding
  reference counter is not present yet and thus the uprobe will be
  added to delayed_uprobe_list. Now kernel will map the data section
  holding reference counter and uprobe_mmap() will check for any
  delayed_uprobe. It will find the uprobe and thus it will increment
  the reference counter.

  So, Reference counter = 1, instruction is patched with trap.

4. For simplicity, I'm using kernel module instead of systemtap / bcc.
   User loads a kernel module that registers a probe on the same uprobe
   by calling uprobe_register_refctr(inode, offset, ref_ctr_offset).

  # insmod test-sdt.ko

  The sequence of function call here will be:
    uprobe_register_refctr()
      register_for_each_vma()
        install_breakpoint()
          set_swbp()
            uprobe_write_opcode()

  But uprobe_write_opcode will find instruction is already patched and
  thus return without doing anything.

  So, Reference counter = 1, instruction is patched.

5. Let's say user kills perf record started in step 2. Function call
   sequence here will be:

     uprobe_unregister()
       register_for_each_vma() {
         if (!filter_chain())
            remove_breakpoint();
       }

   Here filter_chain return true because other consumer is active on the
   same uprobe. so uprobe_unregister() will return without doing anything.

   So, Reference counter = 1, instruction is patched.

6. User unloads the kernel module.
   # rmmod test-sdt.ko

   Same function sequence as step 5 but this time filter_chain() will
   return false because there are no consumer left. And thus
   remove_breakpoint() will get called which will reset instruction and
   decrement the counter.

  So, Reference counter = 0, instruction is reset.


Does this explain your concerns?

Thanks,
Ravi

