Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624FBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136792081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TA+66MPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136792081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeJ3Hng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:43:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55162 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeJ3Hng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:43:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9TMn7v2171186;
        Mon, 29 Oct 2018 22:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=u7NaTaeQxbnEG0iQy2qlxw2UUCg6egVNojtu2VcY9M0=;
 b=TA+66MPvJDM2HRRzIU2XZVnJCUcMQxqE4RzO1YxhT/7Msdnc7j6UupTaX6JaF3nyoZBx
 AA/4iwAEypySEnxd9JHvWf0QZ64QLn3wuRKJAdfk0ZJi5jka/EIiEUr8fgpl11KbUDHj
 0n1M+5xG0XYKjip5b/SA9hYZ7zkMZej8ujt+p++yMpDLvjrp6dW48gLwpAO9fQ4w4jNm
 4cTLR45x77cc70lUIdlHpGVsG+dZS9ZednWdDrGe97fx93p2mcwr6uFtMPLUfx9B6ZB7
 JXsZv3sgwVQujr0yxZ1+jNYRCEAFllUsL1r9lTz4wMeSaTkkw40PsGtF3CG8MifZ1zVP WA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nduckwcck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 22:52:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9TMqOS9019538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 22:52:24 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9TMqN8V021828;
        Mon, 29 Oct 2018 22:52:23 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 15:52:23 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <b80700f3-feda-ce05-75e2-7ab3566727fb@oracle.com>
 <50b88e33-110f-c67a-671a-47c67017a563@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <5dbc627c-15a7-1c48-cb88-cf60b445dd0b@oracle.com>
Date:   Mon, 29 Oct 2018 15:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <50b88e33-110f-c67a-671a-47c67017a563@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/18 4:44 PM, Jan H. Schönherr wrote:
> On 19/10/2018 02.26, Subhra Mazumdar wrote:
>> Hi Jan,
> Hi. Sorry for the delay.
>
>> On 9/7/18 2:39 PM, Jan H. Schönherr wrote:
>>> The collective context switch from one coscheduled set of tasks to another
>>> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
>>> that all tasks of the previous set have stopped executing before any task
>>> of the next set starts executing, an additional hand-shake/barrier needs to
>>> be added.
>>>
>> Do you know how much is the delay? i.e what is overlap time when a thread
>> of new group starts executing on one HT while there is still thread of
>> another group running on the other HT?
> The delay is roughly equivalent to the IPI latency, if we're just talking
> about coscheduling at SMT level: one sibling decides to schedule another
> group, sends an IPI to the other sibling(s), and may already start
> executing a task of that other group, before the IPI is received on the
> other end.
Can you point to where the leader is sending the IPI to other siblings?

I did some experiment and delay seems to be sub microsec. I ran 2 threads
that are just looping in one cosched group and affinitized to the 2 HTs of
a core. And another thread in a different cosched group starts running
affinitized to the first HT of the same core. I time stamped just before
context_switch() in __schedule() for the threads switching from one to
another and one to idle. Following is what I get on cpu 1 and 45 that are
siblings, cpu 1 is where the other thread preempts:

[  403.216625] cpu:45 sub1->idle:403216624579
[  403.238623] cpu:1 sub1->sub2:403238621585
[  403.238624] cpu:45 sub1->idle:403238621787
[  403.260619] cpu:1 sub1->sub2:403260619182
[  403.260620] cpu:45 sub1->idle:403260619413
[  403.282617] cpu:1 sub1->sub2:403282617157
[  403.282618] cpu:45 sub1->idle:403282617317
..

Not sure why the first switch on cpu to idle happened. But then onwards
the difference in timestamps is less than a microsec. This is just a crude
way to get a sense of the delay, may not be exact.

Thanks,
Subhra
>
> Now, there are some things that may delay processing an IPI, but in those
> cases the target CPU isn't executing user code.
>
> I've yet to produce some current numbers for SMT-only coscheduling. An
> older ballpark number I have is about 2 microseconds for the collective
> context switch of one hierarchy level, but take that with a grain of salt.
>
> Regards
> Jan
>
