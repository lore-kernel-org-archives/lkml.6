Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A5424C8D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A5424C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeGCG3m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:29:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932730AbeGCG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:29:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w636T6Xl118355
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 02:29:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k02d834b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:29:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 07:29:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 07:29:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w636TU2p43516074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:29:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB654AE051;
        Tue,  3 Jul 2018 09:29:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9122BAE045;
        Tue,  3 Jul 2018 09:29:30 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 09:29:30 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180702160158.GD65296@linux.vnet.ibm.com>
Date:   Tue, 3 Jul 2018 11:59:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702160158.GD65296@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070306-4275-0000-0000-000002948B95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070306-4276-0000-0000-0000379C085D
Message-Id: <ac5ab301-7df6-90fb-748b-3dc4624ea3c4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On 07/02/2018 09:31 PM, Srikar Dronamraju wrote:
>> Implement the reference counter logic in core uprobe. User will be
>> able to use it from trace_uprobe as well as from kernel module. New
>> trace_uprobe definition with reference counter will now be:
>>
>>     <path>:<offset>[(ref_ctr_offset)]
>>
>> where ref_ctr_offset is an optional field. For kernel module, new
>> variant of uprobe_register() has been introduced:
>>
>>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
>>
> 
> Sorry for bringing this again, but I would actually think the ref_ctr is
> a consumer property. i.e the ref_ctr_offset should be part of
> uprobe_consumer.


I agree that reference counter is a consumer property and that was the
main reason my initial draft was to change trace_uprobe. But there were
couple of issues with that approach too. I've already mentioned few of
them here: https://lkml.org/lkml/2018/6/6/129. Apart from these, if I
do it inside trace_uprobe, kernel module won't have a way to use
reference counter.

Now about adding ref_ctr_offset into uprobe_consumer. Actually, I
didn't want to change the uprobe_consumer definition because it's
already exported and tools like systemtap are using it. And thus, I
haven't explored how difficult or easy it will be to implement it that
way.


> 
> The advantages of doing that would be
> 1. Dont need to expose uprobe structure and just update our
> uprobe_consumer which is already an exported structure.
> - Exporting uprobe structure would expose some of our internal
>   implementation details, basically reduce the freedom of changing stuff
>   internally.


I agree. We will loose the freedom to change stuff by exporting uprobe.


> - we came up with uprobe_arch for the parts that we wanted to expose
>   to archs. exposing uprobe and uprobe_arch looks weird.


Hmm, how about this ...

  set_swbp(arch_uprobe, ...) {
    uprobe_write_opcode(arch_uprobe, ...) {
      uprobe = container_of(arch_uprobe);
      ...
    }
  }

Let me think on this. If this works, I won't need to export struct uprobe
outside.


> 
> 2. ref_ctr_offset is necessarily a consumer property, its not a uprobe
> property at all.


I agree.


> 
> 3. We dont need to change/add new uprobe_register functions.


Quite possible. I need to explore on that.


> 
> The way I look at it is.
> 
> Based on the ref_ctr_offset field in consumer, we update_ref_ctr()
> around install_breakpoint/remove_breakpoint.
> 
>> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +	struct delayed_uprobe *du;
>> +
>> +	if (delayed_uprobe_check(uprobe, mm))
>> +		return 0;
>> +
>> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
>> +	if (!du)
>> +		return -ENOMEM;
>> +
>> +	du->uprobe = uprobe;
>> +	du->mm = mm;
>> +	list_add(&du->list, &delayed_uprobe_list);
>> +	return 0;
>> +}
>> +
> 
> If I understood the delayed_uprobe stuff, its when we could insert a
> breakpoint but the vma that has the ref_ctr_offset is not loaded. Is
> that correct?


That's correct.

Thanks,
Ravi

