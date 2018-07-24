Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AD3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F1220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbeGXEjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:39:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388107AbeGXEjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:39:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6O3Y7Xa194557
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:34:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kdqff1am0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:34:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 24 Jul 2018 04:34:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 04:34:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6O3YopF41222270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 03:34:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1593FAE055;
        Tue, 24 Jul 2018 06:35:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC17AE045;
        Tue, 24 Jul 2018 06:34:57 +0100 (BST)
Received: from [9.124.31.70] (unknown [9.124.31.70])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 06:34:57 +0100 (BST)
Subject: Re: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
 <20180723162629.GA8584@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 24 Jul 2018 09:04:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180723162629.GA8584@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072403-0012-0000-0000-0000028DDCE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072403-0013-0000-0000-000020BFBBBF
Message-Id: <e722ee62-eaba-3abd-7f34-bf38ba3d4f95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 07/23/2018 09:56 PM, Oleg Nesterov wrote:
> I have a mixed feeling about this series... I'll try to summarise my thinking
> tomorrow, but I do not see any obvious problem so far. Although I have some
> concerns about 5/6, I need to re-read it after sleep.

Sure.

> 
> 
> On 07/16, Ravi Bangoria wrote:
>>
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
>> +{
>> +	struct list_head *pos, *q;
>> +	struct delayed_uprobe *du;
>> +	unsigned long vaddr;
>> +	int ret = 0, err = 0;
>> +
>> +	mutex_lock(&delayed_uprobe_lock);
>> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +		du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +		if (!du->uprobe->ref_ctr_offset ||
> 
> Is it possible to see ->ref_ctr_offset == 0 in delayed_uprobe_list?

I'll remove this check.

> 
>> @@ -1072,7 +1282,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>  
>> -	if (no_uprobe_events() || !valid_vma(vma, true))
>> +	if (no_uprobe_events())
>> +		return 0;
>> +
>> +	if (vma->vm_flags & VM_WRITE)
>> +		delayed_uprobe_install(vma);
> 
> Obviously not nice performance-wise... OK, I do not know if it will actually
> hurt in practice and probably we can use the better data structures if necessary.
> But can't we check MMF_HAS_UPROBES at least? I mean,
> 
> 	if (vma->vm_flags & VM_WRITE && test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> 		delayed_uprobe_install(vma);
> 
> ?

Yes.

> 
> 
> Perhaps we can even add another flag later, MMF_HAS_DELAYED_UPROBES set by
> delayed_uprobe_add().

Yes, good idea.

Thanks for the review,
Ravi

