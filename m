Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA422561D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA422561D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeGBFRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:17:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753257AbeGBFRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:17:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w625DT6B031751
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:17:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jyaftwdch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:17:08 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 2 Jul 2018 06:17:05 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 06:17:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w625Gx4e41484532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 05:16:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56A2CA4055;
        Mon,  2 Jul 2018 06:16:43 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C187A404D;
        Mon,  2 Jul 2018 06:16:40 +0100 (BST)
Received: from [9.124.31.129] (unknown [9.124.31.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 06:16:39 +0100 (BST)
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
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 2 Jul 2018 10:46:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701210935.GA14404@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070205-0028-0000-0000-000002D71E42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070205-0029-0000-0000-0000238E981B
Message-Id: <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
> On 06/28, Ravi Bangoria wrote:
>>
>> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>>  	if (ret <= 0)
>>  		goto put_old;
>>  
>> +	/* Update the ref_ctr if we are going to replace instruction. */
>> +	if (!ref_ctr_updated) {
>> +		ret = update_ref_ctr(uprobe, mm, is_register);
>> +		if (ret)
>> +			goto put_old;
>> +
>> +		ref_ctr_updated = 1;
>> +	}
> 
> Why can't this code live in install_breakpoint() and remove_breakpoint() ?
> this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
> and the logic will be more simple.

IMO, it's more easier with current approach. Updating reference counter
inside uprobe_write_opcode() makes it tightly coupled with instruction
patching. Basically, reference counter gets incremented only when first
consumer gets activated and will get decremented only when last consumer
is going away.

Advantage is, we can get rid of sdt_mm_list patch*, because increment and
decrement are anyway happening in sync. This makes the implementation lot
more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
I've to reintroduce sdt_mm_list which makes code more complicated and ugly.

* https://lkml.org/lkml/2018/4/17/28

BTW, is there any harm in exporting struct uprobe outside of uprobe.c?

> 
> And let me ask again... May be you have already explained this, but I can't
> find the previous discussion.
> 
> So why do we need a counter but not a boolean? IIRC, because the counter can
> be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
> right?

Actually, it's by design. This counter keeps track of current tracers
tracing on a particular SDT marker. So only boolean can't work here.
Also, yes, multiple markers can share the same reference counter.

> 
> But who else can use this counter and how? Say, can userspace update it too?

There are many different ways user can change the reference counter.
Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
counter update logic is different in both of them. Systemtap records all
exec/mmap events and updates the counter when it finds interested process/
vma. bcc directly hooks into process's memory (/proc/pid/mem).

> If yes, why this can't race with __update_ref_ctr() ?

Right. But there is no synchronization mechanism provided by the SDT
infrastructure and this is all userspace so there are chances of race.
At least, this patch still tries to make sure that reference counter
does not go negative. If so, throw a warning and don't update it.

> 
> And btw, why does __update_ref_ctr() use FOLL_FORCE? This vma should be writeable
> or valid_ref_ctr_vma() should nack it?

I don't remember the exact reason but seem its unnecessary. Let me try to
recall the reason, otherwise will remove it in the next version.

> 
> And shouldn't valid_ref_ctr_vma() check VM_SHARED? IIUC we do not want to write
> to this file?

Hmm, I haven't seen reference counter shared across processes. But as this
is a generic infrastructure, I'll add a check there.

Thanks for the review,
Ravi

