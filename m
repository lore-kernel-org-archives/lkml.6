Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E59C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D82457E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2D82457E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeGDEtp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:49:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932667AbeGDEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:49:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w644miaG080625
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 00:49:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0k43rx5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:49:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 4 Jul 2018 05:49:41 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 05:49:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w644nYjK35520692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 04:49:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 395C6AE051;
        Wed,  4 Jul 2018 07:49:36 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB3D5AE04D;
        Wed,  4 Jul 2018 07:49:32 +0100 (BST)
Received: from [9.124.31.203] (unknown [9.124.31.203])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 07:49:32 +0100 (BST)
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
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 4 Jul 2018 10:19:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703163645.GA23144@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070404-0016-0000-0000-000001E321F3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070404-0017-0000-0000-0000323783EA
Message-Id: <69c83765-a2a5-c515-2d35-8a95d534f6e5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/03/2018 10:06 PM, Oleg Nesterov wrote:
> On 07/03, Ravi Bangoria wrote:
>>
>> Ok let me explain the difference.
>>
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
> 
> Yes I see. And I am not sure this all is correct. And I still hope we can do
> something better, I'll write another email.
> 
> For now, let's discuss your current approach.
> 
>> Now, if I put it inside install_breakpoint():
>>
>>     ------------
>>     uprobe_register()
>>       register_for_each_vma()
>>         install_breakpoint() {
>>                 /* Called _for each consumer_ */
> 
> How so? it is not called for each consumer. I think you misread this code.


Actually, I meant entire sequence

  uprobe_register()
    register_for_each_vma()
      install_breakpoint()

gets called for each consumer. Not just install_breakpoint(). Sorry
for a bit of ambiguity.


> 
>>                 increment the reference counter _once_;
>>                 uprobe_write_opcode()
>> 		...
>>         }
> 
> So. I meant that you can move the _same_ logic into install_breakpoint() and
> remove_breakpoint(). And note that ref_ctr_updated in uprobe_write_opcode() is
> only needed because it can retry the fault.
> 
> IOW, you can simply do update_ref_ctr(is_register => 1) at the start of
> install_breakpoint(), and update_ref_ctr(0) in remove_breakpoint(), there are
> no other callers of uprobe_write_opcode(). To clarify, it is indirectly called
> by set_swbp() and set_orig_insn(), but this doesn't matter.
> 
> Or you can kill update_ref_ctr() and (roughly) do
> 
> 	rc_vma = find_ref_ctr_vma(...);
> 	if (rc_vma)
> 		__update_ref_ctr(..., 1);
> 	else
> 		delayed_uprobe_add(...);
> 
> at the start of install_breakpoint() and
> 
> 	rc_vma = find_ref_ctr_vma(...);
> 	if (rc_vma)
> 		__update_ref_ctr(..., -1);
> 	delayed_uprobe_remove(...);
> 
> in remove_breakpoint().
> 
> 
>>     uprobe_mmap()
>>       install_breakpoint() {
>>                 increment the reference counter _for each consumer_;
> 
> Again, I do not understand where do you see the "for each consumer" thing.
> 
>>                 uprobe_write_opcode()
> 
> In short. There is a 1:1 relationship between uprobe_write_opcode(is_register => 1)
> and install_breakpoint(), and between uprobe_write_opcode(is_register => 0) and
> remove_breakpoint(). Whatever uprobe_write_opcode() can do if is_register == 1 can be
> done in install_breakpoint(), the same for is_register == 0 and remove_breakpont().
> 
> What have I missed?


Yes, the verify_opcode() stuff as you have mentioned in another reply.

Thanks,
Ravi

