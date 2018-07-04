Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC33C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED10F2473F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED10F2473F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbeGDFZb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:25:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752975AbeGDFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:25:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w645OQnY002726
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 01:25:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0qsr8jjj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:25:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 4 Jul 2018 06:25:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 06:25:20 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w645PJHx39125004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 05:25:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB102AE045;
        Wed,  4 Jul 2018 08:25:21 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63BC9AE058;
        Wed,  4 Jul 2018 08:25:18 +0100 (BST)
Received: from [9.124.31.203] (unknown [9.124.31.203])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 08:25:18 +0100 (BST)
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
 <20180703171255.GB23144@redhat.com> <20180703182313.GA26120@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 4 Jul 2018 10:55:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703182313.GA26120@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070405-0016-0000-0000-000001E324E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070405-0017-0000-0000-000032378708
Message-Id: <cb360870-a618-9d5b-92ac-7052c70b3233@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/03/2018 11:53 PM, Oleg Nesterov wrote:
> forgot to mention...
> 
> Of course, I am not sure that UPROBE_KERN_CTR can actually work, there are a lot
> of details. But if it can, then we can also make ->ref_ctr_offset a consumer property.
> 
> On 07/03, Oleg Nesterov wrote:
>>
>> On 07/03, Ravi Bangoria wrote:
>>>
>>>> OK, and how exactly they update the counter? I mean, can we assume that, say,
>>>> bcc or systemtap can only increment or decrement it?
>>>
>>> I don't think we can assume anything here because this is all in user's
>>> control. User can even manually go and update the counter by directly
>>> hooking into the memory.
>>
>> Then how this all can work? I understand that user-space can do anything with
>> this counter, but we do not care if it does something wrong, say nullifies the
>> ctr incremented by kernel.
>>
>> I don't understand this. I think that if a user registers uprobe with
>> ->ref_ctr_offset != 0 we can safely assume that this is a counter, and we do
>> not care if userspace corrupts it.


Right, that's what I meant. We can't assume anything. Our(kernel) job
is just to:
 1. Increment / decrement counter in sync. No matter what is the value
    of counter before operation.
 2. Make sure that counter does not go negative by the kernel.
 3. Make sure that kernel is not harmed in any case.


>>
>>>> If yes, perhaps we can simplify the kernel code...
>>>
>>> Sure, let me know if you have any better idea.
>>
>> Can't we (ab)use the most significant bit in this counter?
>>
>> To simplify, lets suppose for the moment that 2 different uprobes can't have
>> the same ->ref_ctr_offset. Then we can do something like
>>
>> 	#define UPROBE_KERN_CTR		(SHRT_MAX + 1)	// MSB
>>
>> 	install_breakpoint:
>>
>> 		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
>> 			*ctr_ptr |= UPROBE_KERN_CTR;
>>
>> 		set_swbp();
>>
>> and
>>
>> 	remove_breakpoint:
>>
>> 		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
>> 			*ctr_ptr &= ~UPROBE_KERN_CTR;
>>
>> 		set_orig_insn();
>>
>> IOW, we increment/decrement by UPROBE_KERN_CTR, not by 1. But this way the
>> "increment" is idempotent, we do not care if "|=" or "&=" was applied more than
>> once, we do not need to record the fact that the counter was already incremented,
>> and inc/dec are always balanced.
>>
>>
>> Now, lets recall that multiple uprobes can share the same counter. install_breakpoint()
>> is still fine, and we only need to add the additional code into remove_breakpoint:
>>
>> 		for (each uprobe with the same inode and ref_ctr_offset)
>> 			if (filter_chain(uprobe))
>> 				goto keep_ctr;
>>
>> 		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
>> 			*ctr_ptr &= ~UPROBE_KERN_CTR;
>>
>> 	keep_ctr:
>> 		set_orig_insn();
>>
>>
>> Just an idea.
>>
>> What do you think?


This is really a cool idea. Let me explore that.

Thanks,
Ravi

