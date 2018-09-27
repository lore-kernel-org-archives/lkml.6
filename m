Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767CDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE77204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wot6k6wN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE77204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeI1A45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:56:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54750 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeI1A45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:56:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RIXrmq015348;
        Thu, 27 Sep 2018 18:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yfgVCKrULQi5XXIigVgnvz1DgZDiWO3/lC3fi+WNWtM=;
 b=Wot6k6wNVMke6oX913JLXLxda69kdbKHrKLbFCqAevQpYiKxTCFnApVM95lyByIOJDdW
 awtcqJ1K+Fu5QNZLZ1PDP12YkvRjgqyud4ZCaChethG0kSqXJqM19rTn+TVa7lAxzCED
 bOywy98DqF5NxTqhEsFe0KHusKkp5Pe8Ghp01TGc1WmsiFvkESfLPawWE0oDgPlkOdMc
 fqWl+AdWptuxCkRD9oRijVotohJOddao4Jb20SfLpLUWfqT6QgkrwnEsM5yhL+O8UC2r
 KclNx5lY280bgZYgOpwI0bjxlJgZqkzsyfGjQxfw3mqzlhLqzONqylT0YxhC0nsOlWDM kQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mnd5tuy8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 18:36:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8RIag1h028043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 18:36:42 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8RIafEB022563;
        Thu, 27 Sep 2018 18:36:41 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 11:36:41 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <20180917122538.GT24124@hirez.programming.kicks-ass.net>
 <648176de-9ad4-a4b3-c542-bbaf250cd8cb@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <ca9fed2f-b15d-b148-2e3a-02da827faf18@oracle.com>
Date:   Thu, 27 Sep 2018 11:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <648176de-9ad4-a4b3-c542-bbaf250cd8cb@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/26/2018 02:58 AM, Jan H. Schönherr wrote:
> On 09/17/2018 02:25 PM, Peter Zijlstra wrote:
>> On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
>>
>>> Assuming, there is a cgroup-less solution that can prevent simultaneous
>>> execution of tasks on a core, when they're not supposed to. How would you
>>> tell the scheduler, which tasks these are?
>> Specifically for L1TF I hooked into/extended KVM's preempt_notifier
>> registration interface, which tells us which tasks are VCPUs and to
>> which VM they belong.
>>
>> But if we want to actually expose this to userspace, we can either do a
>> prctl() or extend struct sched_attr.
> Both, Peter and Subhra, seem to prefer an interface different than cgroups
> to specify what to coschedule.
>
> Can you provide some extra motivation for me, why you feel that way?
> (ignoring the current scalability issues with the cpu group controller)
>
>
> After all, cgroups where designed to create arbitrary groups of tasks and
> to attach functionality to those groups.
>
> If we were to introduce a different interface to control that, we'd need to
> introduce a whole new group concept, so that you make tasks part of some
> group while at the same time preventing unauthorized tasks from joining a
> group.
>
>
> I currently don't see any wins, just a loss in flexibility.
>
> Regards
> Jan
I think cgroups will the get the job done for any use case. But we have,
e.g. affinity control via both sched_setaffinity and cgroup cpusets. It
will be good to have an alternative way to specify co-scheduling too for
those who don't want to use cgroup for some reason. It can be added later
on though, only how one will override the other will need to be sorted out.
