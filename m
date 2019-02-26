Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C6720842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfBZDxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:53:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfBZDxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:53:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q3kFLG114789
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:53:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvux5md4e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:53:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 26 Feb 2019 03:53:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 03:53:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1Q3rN7O57868296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 03:53:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611B342041;
        Tue, 26 Feb 2019 03:53:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE9794203F;
        Tue, 26 Feb 2019 03:53:18 +0000 (GMT)
Received: from [9.85.74.127] (unknown [9.85.74.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 03:53:18 +0000 (GMT)
Subject: Re: [PATCH] Uprobes: Fix deadlock between delayed_uprobe_lock and
 fs_reclaim
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     Sherry Yang <sherryy@android.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>,
        srikar@linux.vnet.ibm.com, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com,
        syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
 <20190206133601.GA21522@redhat.com>
 <0f6683c9-50c8-f26f-02e0-4689eee8ea5d@linux.ibm.com>
Date:   Tue, 26 Feb 2019 09:23:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0f6683c9-50c8-f26f-02e0-4689eee8ea5d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022603-4275-0000-0000-00000313F188
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022603-4276-0000-0000-000038222F6F
Message-Id: <611d2ba9-c14b-4580-a7ec-8bcf0013cd6b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/19 2:03 PM, Ravi Bangoria wrote:
> 
> 
> On 2/6/19 7:06 PM, Oleg Nesterov wrote:
>> Ravi, I am on vacation till the end of this week, can't read your patch
>> carefully.
>>
>> I am not sure I fully understand the problem, but shouldn't we change
>> binder_alloc_free_page() to use mmput_async() ? Like it does if trylock
>> fails.
> 
> I don't understand binderfs code much so I'll let Sherry comment on this.

Sherry, Can you please comment on this.

Thanks,
Ravi

