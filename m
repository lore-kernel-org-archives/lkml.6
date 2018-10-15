Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18FC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mBqWmEXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18FC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJPC6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:58:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42448 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:58:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FJ9V6d103683;
        Mon, 15 Oct 2018 19:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PGGtRlRfNP6a3RhwNgdkUGCVn4NE70S8u+xqtqELuhg=;
 b=mBqWmEXnZ0OtUywDH0cezZDnzj18w4J8ai9JJVYxQMoYkRiiW9Odgx24gaNkcBgdOQ6Z
 16BzO3/Ea3J/95UM5sbz/CSvjfAOX403kn9jiWSd/mFkKhrvff44xmFH4c0S7lftK6Oz
 kl1pV8faqIBJdMnddUSw8Vx7IwB2iPt7+2LKHjQJZUBS5t5PAD+2QGaSPmzSLSm93hQX
 qgbW/yTyYEeN/vhl2mHgBZv+3rf4/xB+/hAmaPxvobzxOVap8ZDS7PqZON71T3aE4hbn
 npvSZ6xioK20aZHzHcw1cCR8HztKmx7iW63/AVtDT16ez6I0TzZ4akjswAQ8dD0uaV9e Ow== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38npvcnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 19:10:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9FJAvNu021955
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 19:10:58 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9FJAsu9021700;
        Mon, 15 Oct 2018 19:10:54 GMT
Received: from [10.154.131.235] (/10.154.131.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 12:10:54 -0700
Subject: Re: [PATCH v13 01/11] cpuset: Enable cpuset controller in default
 hierarchy
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
 <1539366951-8498-2-git-send-email-longman@redhat.com>
 <bfa8d0a2-ce78-8a0b-2a2e-45b02d6a8239@oracle.com>
 <ebff503c-291c-345c-a0ab-e2a4ceb6ad0c@redhat.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <f461a6b4-fe95-ab7c-675a-734a02342a6d@oracle.com>
Date:   Mon, 15 Oct 2018 13:10:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ebff503c-291c-345c-a0ab-e2a4ceb6ad0c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2018 12:41 PM, Waiman Long wrote:
> On 10/15/2018 02:31 PM, Tom Hromatka wrote:
>>
>> On 10/12/2018 11:55 AM, Waiman Long wrote:
>>> Given the fact that thread mode had been merged into 4.14, it is now
>>> time to enable cpuset to be used in the default hierarchy (cgroup v2)
>>> as it is clearly threaded.
>>>
>>> The cpuset controller had experienced feature creep since its
>>> introduction more than a decade ago. Besides the core cpus and mems
>>> control files to limit cpus and memory nodes, there are a bunch of
>>> additional features that can be controlled from the userspace. Some of
>>> the features are of doubtful usefulness and may not be actively used.
>>>
>>> This patch enables cpuset controller in the default hierarchy with
>>> a minimal set of features, namely just the cpus and mems and their
>>> effective_* counterparts.  We can certainly add more features to the
>>> default hierarchy in the future if there is a real user need for them
>>> later on.
>> I really appreciate this simplification of the cpuset controller.
>>
>> I currently have an in-house customer that is unhappy with the
>> way cgroups cpuset v1 handles offlined CPUs.  This patchset makes two
>> significant improvements over current cpuset v1 behavior.  1) It allows
>> for offlined CPUs to be added to a cpuset (even though the CPU is
>> offline) and 2) it restores CPUs back to the requested cpuset when they
>> come back online.  This is more intuitive and secure for my customers.
>> Thank you!
>>
>> In part because of this patchset, I plan on proposing similar behavior
>> for offlined CPUs to cpuset v1.
>>
>> Thanks.
>>
>> Tom
> If you are just talking about the ability for cpuset to revert back to
> its original state when an offlined CPU becomes online again, that
> capability can be activated in v1 using the "cpuset_v2_mode" mount
> option when mounting the cpuset cgroup. However, that is not the default
> for v1.
>
> -Longman
>
>

Thanks!!!  I didn't realize cpuset_v2_mode exists.  (I see you
added it last year.  Thank you!)  I'll try it out and see if it
meets my customer's needs.

Tom



