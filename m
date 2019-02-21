Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345952084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aG47AKXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfBUSrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:47:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfBUSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:47:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LIXibo014322;
        Thu, 21 Feb 2019 18:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=X31UqoQlWhtMQ2SUdAKjBMYxCxHivK0kaJEvObzQiVo=;
 b=aG47AKXFOmvUUki/zRRPk/QJ7yuaxspax9c9am/pf/6sf/S5zvTpUWZTHGmm70doZEcQ
 P04YOFLq5VBX/HhfgwiuU/pMFpfgdhCBYss+QZC+WZFtqI5ghaQKqQHxXshWEGPO/1fd
 jbwnEBCgEukwNH9hA4Cbs2DJcC64DViP/4Hhx7zqwDcGwkR8GnVaQORrjOSy/LPzi0pj
 KaOLYEQaRJmLu3ygOKcTt1johVdemelMMM7YH6JlyPEx4EnVeMtLh6zNqyG4HY4CKW33
 nbmK3ttt8Nnvzd6Sc6UB7rLFeNoZtMVUvdbXECdsowfOTO5ygj3qxw5slBgVffDQZkYP Kw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81ej5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:46:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIkiJh023990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:46:44 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIkhf5029134;
        Thu, 21 Feb 2019 18:46:43 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 10:46:43 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <e73e1b19-5418-32c8-584c-823618de67ce@oracle.com>
 <20190221140348.GR32494@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <7795f178-37a1-0927-a356-c80d1b174423@oracle.com>
Date:   Thu, 21 Feb 2019 10:44:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221140348.GR32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/19 6:03 AM, Peter Zijlstra wrote:
> On Wed, Feb 20, 2019 at 06:53:08PM -0800, Subhra Mazumdar wrote:
>> On 2/18/19 9:49 AM, Linus Torvalds wrote:
>>> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>> However; whichever way around you turn this cookie; it is expensive and nasty.
>>> Do you (or anybody else) have numbers for real loads?
>>>
>>> Because performance is all that matters. If performance is bad, then
>>> it's pointless, since just turning off SMT is the answer.
>>>
>>>                     Linus
>> I tested 2 Oracle DB instances running OLTP on a 2 socket 44 cores system.
>> This is on baremetal, no virtualization.
> I'm thinking oracle schedules quite a bit, right? Then you get massive
> overhead (as shown).
Yes. In terms of idleness we have:

Users baseline core_sched
16    67% 70%
24    53% 59%
32    41% 49%

So there is more idleness with core sched which is understandable as there
can be forced idleness. The other part contributing to regression is most
likely overhead.
>
> The thing with virt workloads is that if they don't VMEXIT lots, they
> also don't schedule lots (the vCPU stays running, nested scheduler
> etc..).
I plan to run some VM workloads.
>
> Also; like I wrote, it is quite possible there is some sibling rivalry
> here, which can cause excessive rescheduling. Someone would have to
> trace a workload and check.
>
> My older patches had a condition that would not preempt a task for a
> little while, such that it might make _some_ progress, these patches
> don't have that (yet).
>
