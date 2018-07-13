Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272FAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE062147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE062147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeGMFw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:52:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbeGMFw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:52:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6D5cfMO064451
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:39:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k6ge529t4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:39:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 13 Jul 2018 06:39:26 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 06:39:21 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6D5dKtm41812210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 05:39:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A250942041;
        Fri, 13 Jul 2018 08:39:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 390DD42042;
        Fri, 13 Jul 2018 08:39:38 +0100 (BST)
Received: from [9.124.31.56] (unknown [9.124.31.56])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 08:39:38 +0100 (BST)
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
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
 <20180712145849.GB15265@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 13 Jul 2018 11:09:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712145849.GB15265@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071305-0016-0000-0000-000001E6526B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071305-0017-0000-0000-0000323AEA9C
Message-Id: <fb088370-ed2b-b9f7-04bb-c3b7bc946d71@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/12/2018 08:28 PM, Oleg Nesterov wrote:
> On 07/11, Ravi Bangoria wrote:
>>
>>> However, I still think it would be better to avoid uprobe exporting and modifying
>>> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>>> I'll re-check...
>>
>> Good that you bring this up. Actually, we can implement same logic
>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>> need to pass arch_uprobe object to uprobe_write_opcode().
> 
> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
> arg to uprobe_write_opcode(). OK, this is fine.
> 


We can probably kill set_swbp()/set_orig_insn() but with container_of()
tweak, we don't need to.


> 
>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>> or a consumer property, before posting v6:
>>
>> If we make it a consumer property, the design becomes flexible for
>> user. User will have an option to either depend on kernel to handle
>> reference counter or he can create normal uprobe and manipulate
>> reference counter on his own. This will not require any changes to
>> existing tools. With this approach we need to increment / decrement
>> reference counter for each consumer. But, because of the fact that our
>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>> to keep track of which reference counter have been updated in which
>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>> {uprobe, consumer, mm}.
> 
> Did you explore the UPROBE_KERN_CTR hack I tried to suggest?


Yes I tried to implement it. Seems it's not safe to use MSB. Let me explain
this at the end.


> 
> If it can work then, again, *ctr_ptr |= UPROBE_KERN_CTR from install_breakpoint()
> paths is always fine, the nontrivial part is remove_breakpoint() case, perhaps
> you can do something like
> 
> 		for (each uprobe in inode)
> 			for (each consumer)
> 				if (consumer_filter(consumer))
> 					goto keep_ctr;
> 
> 		for (each vma which maps this counter)
> 			*ctr_ptr &= ~UPROBE_KERN_CTR;
> 
> 	keep_ctr:
> 		set_orig_insn(...);
> 
> but again, I didn't even try to think about details, not sure this
> can really work.
> 
> And in any case:
> 
>> This will make kernel implementation quite
>> complex
> 
> Yes. So I personally won't insist on this feature.


Sure, thanks for giving your opinion.


> 
>> Third options: How about allowing 0 as a special value for reference
>> counter? I mean allow uprobe_register() and uprobe_register_refctr()
>> in parallel but do not allow two uprobe_register_refctr() with two
>> different reference counter.
> 
> I am not sure I understand how you can do this, and how much complications
> this needs, so I have no opinion.


Yes, it's quite possible. So the design will remain same as current set of
patches(v5). v5 basically forces to use only one reference counter for one
uprobe, the new design will allow 0 as a special value for reference counter
_offset_. But still two non-zero reference counter offset for same uprobe
won't be allowed. So there won't be any major changes in the code. Only few
tweaks are needed. I've initial draft ready and it seems working. I'll test
it properly and send it as v6.


> 
> 
> Cough, just noticed the final part below...
> 
>> PS: We can't abuse MSB with first approach because any userspace tool
>> can also abuse MSB in parallel.
> 
> For what?


Ok. With first approach, we wants to allow multiple reference counter by
making ref_ctr_offset a consumer property. Now let's say one application
rely on kernel to maintain reference counter and other wants to maintain
on his own, and if we use MSB, reference counter value can not be
consistent. For ex,

  step1.
   app1 calls uprobe_register(inode1, off1, consumer{ref_ctr_offset = 0x123});
   kernel will use MSB and thus reference counter is 0x8000

  step2.
   app2 calls uprobe_register(inode1, off1, consumer{ref_ctr_offset = 0x0});
   and modifies reference counter by changing MSB. So reference
   counter is still 0x8000

  step3.
   app2 calls uprobe_unregister();
   and modifies reference counter by resetting MSB. So reference
   counter becomes 0x0000

  ... which is wrong.


> 
>> Probably, we can abuse MSB in second
>> and third approach, though, there is no need to.
> 
> Confused... If userspace can change it, how we can use it in 2nd approach?


Now, with second approach, we are making uprobe_register_refctr()
and uprobe_register() mutually exclusive. So, step2 in above example
is not possible. i.e. Either kernel can use MSB or user can use
MSB, but both can't at the same time. So it's quite safe to use MSB
with this approach. BUT, as this is all userspace, we can't assume
anything. If user has totally different mechanism for tracing SDT
event, he can still use uprobe infrastructure(which will use MSB)
and his own mechanism which will use MSB as well and again we are
screwed! So, IMO, it's not safe to use MSB. Better to stick with
increment/decrement ABI. Please let me know if you disagree. Anyway,
if we go by second approach, increment/decrement are always balanced.
So no need to use MSB with second approach.

Hmm, but for third approach, we have same issue as first approach so
it's not safe to use MSB with third approach as well.

Thanks,
Ravi

