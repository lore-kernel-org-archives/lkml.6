Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE021917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfBHIcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:32:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbfBHIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:32:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x188NqpO126492
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 03:32:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qh3n0pnrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 03:32:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 8 Feb 2019 08:32:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 08:32:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x188W71x31850566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 08:32:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64FE552051;
        Fri,  8 Feb 2019 08:32:07 +0000 (GMT)
Received: from [9.124.31.214] (unknown [9.124.31.214])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2759152052;
        Fri,  8 Feb 2019 08:32:05 +0000 (GMT)
Subject: Re: [PATCH] Uprobes: Fix deadlock between delayed_uprobe_lock and
 fs_reclaim
To:     Oleg Nesterov <oleg@redhat.com>, Sherry Yang <sherryy@android.com>
Cc:     Michal Hocko <mhocko@suse.com>, srikar@linux.vnet.ibm.com,
        songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
References: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
 <20190206133601.GA21522@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 8 Feb 2019 14:03:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206133601.GA21522@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020808-4275-0000-0000-0000030CFBA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020808-4276-0000-0000-0000381B06C6
Message-Id: <0f6683c9-50c8-f26f-02e0-4689eee8ea5d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/19 7:06 PM, Oleg Nesterov wrote:
> Ravi, I am on vacation till the end of this week, can't read your patch
> carefully.
> 
> I am not sure I fully understand the problem, but shouldn't we change
> binder_alloc_free_page() to use mmput_async() ? Like it does if trylock
> fails.

I don't understand binderfs code much so I'll let Sherry comment on this.

> 
> In any case, I don't think memalloc_nofs_save() is what we need, see below.
> 
> On 02/04, Ravi Bangoria wrote:
>>
>> There can be a deadlock between delayed_uprobe_lock and
>> fs_reclaim like:
>>
>>    CPU0                         CPU1
>>    ----                         ----
>>    lock(fs_reclaim);
>>                                 lock(delayed_uprobe_lock);
>>                                 lock(fs_reclaim);
>>    lock(delayed_uprobe_lock);
>>
>> Here CPU0 is a file system code path which results in
>> mmput()->__mmput()->uprobe_clear_state() with fs_reclaim
>> locked. And, CPU1 is a uprobe event creation path.
> 
> But this is false positive, right? if CPU1 calls update_ref_ctr() then
> either ->mm_users is already zero so binder_alloc_free_page()->mmget_not_zero()
> will fail, or the caller of update_ref_ctr() has a reference and thus
> binder_alloc_free_page()->mmput() can't trigger __mmput() ?

Yes, it seems so.

So, IIUC, even though the locking sequence are actually opposite, *actual*
instances of the locks will never be able to lock simultaneously on both
the code path as warned by lockdep. Please correct me if I misunderstood.

[...]

>> +	nofs_flags = memalloc_nofs_save();
>>  	mutex_lock(&delayed_uprobe_lock);
>>  	if (d > 0)
>>  		ret = delayed_uprobe_add(uprobe, mm);
>>  	else
>>  		delayed_uprobe_remove(uprobe, mm);
>>  	mutex_unlock(&delayed_uprobe_lock);
>> +	memalloc_nofs_restore(nofs_flags);
> 
> PF_MEMALLOC_NOFS is only needed when we are going to call delayed_uprobe_add()
> which does kzalloc(GFP_KERNEL). Can't we simply change it tuse use use GFP_NOFS
> instead?

Yes, I can use GFP_NOFS. (and same was suggested by Aneesh as well)

But from https://lwn.net/Articles/710545/, I found that community
is planning to deprecate the GFP_NOFS flag?

-Ravi

