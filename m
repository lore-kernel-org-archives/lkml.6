Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C4C20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v8VO8Wwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C4C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLFQIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:08:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59576 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLFQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:08:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6FwmKS081510;
        Thu, 6 Dec 2018 16:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=t39lbf8Y46YASlVsWVXQd3bHo+V+4WZx7XaFV0/P2RE=;
 b=v8VO8WwdStBL1y/fP28C3HaDPEEfV7HaaqcISZipHPo+uI6dELqgXvPqExDHST23ml9u
 pRfbL7A9PUUpcvMpWBmEoODJfSPieORG9mDqhzMprmUP0sq8IFzsDkESM1mFOONnVPKm
 gxjUCvNM1d41H5QDDN7YdlONFnnvFpsZu93wGNWp9GTREFg9v/FQJD61sfZjXPUHeFx6
 gqswy+seebWvfrD9AUw2oeL1keLAnP5gvokpEteuPAndkhKVn887tQwovKvYgceAsw8i
 WY8Ri/pLzgyLSC1kecUFqSNIYMykIhRWuXkl9y/Q4w/GYxEAkN77D4TJ8bNIpw2W5wVt Hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftfd3ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 16:07:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB6G7ukM005259
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 16:07:56 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB6G7tHL011113;
        Thu, 6 Dec 2018 16:07:55 GMT
Received: from [10.39.209.220] (/10.39.209.220)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 08:07:55 -0800
Subject: Re: [PATCH v3 01/10] sched: Provide sparsemask, a reduced contention
 bitmap
To:     Omar Sandoval <osandov@osandov.com>
Cc:     mingo@redhat.com, peterz@infradead.org, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-2-git-send-email-steven.sistare@oracle.com>
 <7a3e87ac-db63-27c5-8490-2330637e59b1@oracle.com>
 <20181128011904.GR846@vader>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <10d4b797-bb35-c93a-0514-1aaf738162a9@oracle.com>
Date:   Thu, 6 Dec 2018 11:07:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181128011904.GR846@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 8:19 PM, Omar Sandoval wrote:
> On Tue, Nov 27, 2018 at 10:16:56AM -0500, Steven Sistare wrote:
>> On 11/9/2018 7:50 AM, Steve Sistare wrote:
>>> From: Steve Sistare <steve.sistare@oracle.com>
>>>
>>> Provide struct sparsemask and functions to manipulate it.  A sparsemask is
>>> a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
>>> threads concurrently set, clear, and visit elements, by reducing the number
>>> of significant bits per cacheline.  For each 64 byte chunk of the mask,
>>> only the first K bits of the first word are used, and the remaining bits
>>> are ignored, where K is a creation time parameter.  Thus a sparsemask that
>>> can represent a set of N elements is approximately (N/K * 64) bytes in
>>> size.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  include/linux/sparsemask.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
>>>  lib/Makefile               |   2 +-
>>>  lib/sparsemask.c           | 142 +++++++++++++++++++++++++
>>>  3 files changed, 403 insertions(+), 1 deletion(-)
>>>  create mode 100644 include/linux/sparsemask.h
>>>  create mode 100644 lib/sparsemask.c
>>
>> Hi Peter and Ingo,
>>   I need your opinion: would you prefer that I keep the new sparsemask type, 
>> or fold it into the existing sbitmap type?  There is some overlap between the 
>> two, but mostly in trivial one line functions. The main differences are:
> 
> Adding Jens and myself.
> 
>>   * sparsemask defines iterators that allow an inline loop body, like cpumask,
>>   whereas the sbitmap iterator forces us to define a callback function for
>>   the body, which is awkward.
>>
>>   * sparsemask is slightly more efficient.  The struct and variable length
>>   bitmap are allocated contiguously,
> 
> That just means you have the pointer indirection elsewhere :) The users
> of sbitmap embed it in whatever structure they have.
 
Yes, the sparsemask can be embedded in one place, but in my use case I also cache
pointers to the mask from elsewhere, and those sites incur the cost of 2 indirections
to perform bitmap operations.

>>   and sbitmap uses an extra field "depth"
>>   per bitmap cacheline.
> 
> The depth field is memory which would otherwise be unused, and it's only
> used for sbitmap_get(), so it doesn't have any cost if you're using it
> like a cpumask.
> 
>>   * The order of arguments is different for the sparsemask accessors and
>>   sbitmap accessors.  sparsemask mimics cpumask which is used extensively
>>   in the sched code.
>>
>>   * Much of the sbitmap code supports queueing, sleeping, and waking on bit
>>   allocation, which is N/A for scheduler load load balancing.  However, we
>>   can call the basic functions which do not use queueing.
>>
>> I could add the sparsemask iterators to sbitmap (90 lines), and define
>> a thin layer to change the argument order to mimic cpumask, but that
>> essentially recreates sparsemask.
> 
> We only use sbitmap_for_each_set() in a few places. Maybe a for_each()
> style macro would be cleaner for those users, too, in which case I
> wouldn't be opposed to changing it. The cpumask argument order thing is
> a annoying, though.
> 
>> Also, pushing sparsemask into sbitmap would limit our freedom to evolve the
>> type to meet the future needs of sched, as sbitmap has its own maintainer,
>> and is used by drivers, so changes to its API and ABI will be frowned upon.
> 
> It's a generic data structure, so of course Jens and I have no problem
> with changing it to meet more needs :) Personally, I'd prefer to only
> have one datastructure for this, but I suppose it depends on whether
> Peter and Ingo think the argument order is important enough.

The argument order is a minor thing, not a blocker to adoption, but efficiency 
is important in the core scheduler code.  I actually did the work to write a
for_each macro with inline body to sbitmap, and converted my patches to use sbitmap.
But then I noticed your very recent patch adding the cleared word to each cacheline, 
which must be loaded and ANDed with each bitset word in the for_each traversal,
adding more overhead which we don't need for the scheduler use case, on top of the
extra indirection noted above. You might add more such things in the future (a
"deferred set" word?) to support the needs of the block drivers who are the 
intended clients of sbitmap.

Your sbitmap is more than a simple bitmap abstraction, and for the scheduler we
just need simple.  Therefore, I propose to trim sparsemask to the bare minimum,
and move it to kernel/sched for use 
by sched only.
  It was 400 lines, but will
be 200, and 80 of those are comments.

If anyone objects, please speak now.

- Steve

>> FWIW, here is the amount of code involved:
>>
>> include/linux/sbitmap.h
>>   250 lines basic operations
>>   284 lines for queueing
>>   ---
>>   534 lines total
>>
>> lib/sbitmap.c
>>   201 lines basic operations
>>   380 lines for queueing
>>   ---
>>   581 lines total
>>
>> include/linux/sparsemask.h
>>   260 lines total
>>   https://lkml.org/lkml/2018/11/9/1176
>>
>> lib/sparsemask.c
>>   142 lines total
>>   https://lkml.org/lkml/2018/11/9/1176
>>
>> - Steve
