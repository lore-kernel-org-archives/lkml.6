Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D6C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZ1Kh0GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F0E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeJWD1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:27:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeJWD1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:27:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MIx1HI120483;
        Mon, 22 Oct 2018 19:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R+F/FRKXna6YizA6zF3XuP2H/v28iQv34CkOuurfgY0=;
 b=lZ1Kh0GK+61eIr6ZpqZO0B3AQQSAKIzCcYXUlJn0xRiXT9zGtUtOfpaV9EMtZjIHya5D
 PA5GCjAc2lQvyS/np1t+oLVVoFRQ/XxYxIiLja7DXwOx1NH/fxJj6ZA5Uv80fM0cUpQy
 9jDp3ngoc5s9W4BRIv9rYU1xTwR1orq1BJGWdTKeoRYaftwTAuHeYbp8NSwTwsSBmDI1
 EBOhDIjEFlCUz0sB22Uq/3N32+2auTXdEngKufViT0iC5IKAd+xrIqdKfc1XPpntyVpN
 v0wLdXX8GjzlrUeWhbPIhucJqJh3dIuaXR3MvaxPDB4Y6zJzuEvsxBT+Wmw4Aq2rsnHP +w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0qghet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 19:07:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MJ7S5d005483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 19:07:28 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MJ7R1H031149;
        Mon, 22 Oct 2018 19:07:27 GMT
Received: from [10.39.206.107] (/10.39.206.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 12:07:27 -0700
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <20181022170421.GF3117@worktop.programming.kicks-ass.net>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
Date:   Mon, 22 Oct 2018 15:07:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022170421.GF3117@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 1:04 PM, Peter Zijlstra wrote:
> On Mon, Oct 22, 2018 at 07:59:31AM -0700, Steve Sistare wrote:
>> When a CPU has no more CFS tasks to run, and idle_balance() fails to
>> find a task, then attempt to steal a task from an overloaded CPU in the
>> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
>> identify candidates.  To minimize search time, steal the first migratable
>> task that is found when the bitmap is traversed.  For fairness, search
>> for migratable tasks on an overloaded CPU in order of next to run.
>>
>> This simple stealing yields a higher CPU utilization than idle_balance()
>> alone, because the search is cheap, so it may be called every time the CPU
>> is about to go idle.  idle_balance() does more work because it searches
>> widely for the busiest queue, so to limit its CPU consumption, it declines
>> to search if the system is too busy.  Simple stealing does not offload the
>> globally busiest queue, but it is much better than running nothing at all.
> 
> Why I don't dislike the idea; I feel it is unfortunate to have two
> different mechanisms to do effectively the same thing.
> 
> Can't we improve idle_balance() instead of building this parallel
> functionality?

We could delete idle_balance() and use stealing exclusively for handling
new idle.  For each sd level, stealing would look for an overloaded CPU
in the overloaded bitmap(s) that overlap that level.  I played with that
a little but it is not ready for prime time, and I did not want to hold
the patch series for it.  Also, I would like folks to get some production
experience with stealing on a variety of architectures before considering
a radical step like replacing idle_balance().

We could merge the stealing code into the idle_balance() code to get a
union of the two, but IMO that would be less readable.

We could remove the core and socket levels from idle_balance() and let
stealing handle those levels.  I think that makes sense after stealing
performance is validated on more architectures, but we would still have
two different mechanisms.

- Steve
